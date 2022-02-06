FROM python:3.8
RUN git clone https://github.com/xinntao/Real-ESRGAN.git app

WORKDIR /app
RUN ls

RUN pip install torchvision
RUN pip install basicsr
RUN pip install facexlib
RUN pip install gfpgan
RUN pip install -r requirements.txt
RUN python setup.py develop
RUN wget https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth -P experiments/pretrained_models
RUN wget https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.3/RealESRGAN_x4plus_netD.pth -P experiments/pretrained_models
RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y
