FROM pytorch/pytorch:latest
WORKDIR /train
COPY requirements.txt requirements.txt
COPY setup.py setup.py
RUN pip install -r requirements.txt
RUN pip install xformers==0.0.16rc425
RUN apt update && apt install -y libx11-dev ffmpeg libsm6 libxext6
RUN apt-get install -y curl && curl -O https://raw.githubusercontent.com/derrian-distro/LoRA_Easy_Training_Scripts/main/lora_train_popup.py
RUN sed -i 's/self.use_8bit_adam: bool = True/self.use_8bit_adam: bool = False/' lora_train_popup.py
COPY . .
VOLUME [ "/root" ]
ENTRYPOINT [ "python", "lora_train_popup.py" ]
