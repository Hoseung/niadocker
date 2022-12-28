FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime

#COPY . /ritnet
#COPY ./requirements.txt /install/requirements.txt
RUN DEBIAN_FRONTEND=noninteractive apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq python3-opencv git --no-install-recommends
RUN git clone -b dist --single-branch https://github.com/Deep-In-Sight/RITnet
RUN pip install -r /install/requirements.txt 

WORKDIR /ritnet
RUN pip install -e .

CMD ["bash", "initialize.sh"]
#CMD ["python", "ritnet_demo.py"]