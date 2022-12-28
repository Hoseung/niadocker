FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime

#COPY . /ritnet

RUN DEBIAN_FRONTEND=noninteractive apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq python3-opencv git --no-install-recommends
RUN git clone -b dist --single-branch https://github.com/Deep-In-Sight/RITnet /RITnet
RUN git clone -b dist --single-branch https://github.com/Deep-In-Sight/L2CS-Net /L2CS-Net
RUN git clone -b dist --single-branch https://github.com/Deep-In-Sight/Former-DFER /Former-DFER

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt 

WORKDIR /RITnet
RUN pip install -e .

WORKDIR /L2CS-Net
RUN pip install -e .

#WORKDIR /Former-DFER
#RUN pip install -e .

COPY ./initialize.sh /usr/local/bin/initialize.sh
RUN ["chmod", "+x", "/usr/local/bin/initialize.sh"]

#ADD initialize.sh /usr/local/bin/initialize.sh
ENTRYPOINT ["/usr/local/bin/initialize.sh"]

CMD ["/bin/bash"]