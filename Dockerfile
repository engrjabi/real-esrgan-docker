FROM python:3.8

RUN apt-get update \
    && apt-get install --no-install-recommends -y sudo

ARG USERNAME=esrgan
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER ${UID}:${GID}
WORKDIR /home/${USERNAME}/app
RUN git clone https://github.com/xinntao/Real-ESRGAN.git app
WORKDIR /home/${USERNAME}/app/app
RUN ls

RUN pip install torchvision
RUN pip install basicsr
RUN pip install facexlib
RUN pip install gfpgan
RUN pip install -r requirements.txt
RUN python setup.py develop
RUN wget https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth -P experiments/pretrained_models
RUN wget https://github.com/xinntao/Real-ESRGAN/releases/download/v0.2.2.3/RealESRGAN_x4plus_netD.pth -P experiments/pretrained_models
RUN wget https://github.com/xinntao/facexlib/releases/download/v0.1.0/detection_Resnet50_Final.pth -P experiments/pretrained_models
RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y
