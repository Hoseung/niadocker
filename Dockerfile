FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime

RUN DEBIAN_FRONTEND=noninteractive apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq python3-opencv git --no-install-recommends
RUN git clone https://github.com/Hoseung/RIT-Net_check /RITnet
RUN git clone https://github.com/Hoseung/L2CS-Net_check /L2CS-Net
RUN git clone https://github.com/Hoseung/Former-DFER_check /Former-DFER

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt 

WORKDIR /RITnet
RUN pip install -e .

WORKDIR /L2CS-Net
RUN pip install -e .
RUN pip install git+https://github.com/elliottzheng/face-detection.git@master
COPY ./initialize.sh /usr/local/bin/initialize.sh
RUN ["chmod", "+x", "/usr/local/bin/initialize.sh"]

COPY former_trained.pth /Former-DFER/checkpoint/trained.pth
COPY l2cs_trained.pkl /L2CS-Net/models/trained.pkl
#ADD initialize.sh /usr/local/bin/initialize.sh
ENTRYPOINT ["/usr/local/bin/initialize.sh"]

CMD ["/bin/bash"]