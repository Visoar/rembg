FROM nvidia/cuda:11.6.0-runtime-ubuntu18.04

ENV DEBIAN_FRONTEND noninteractive

RUN rm /etc/apt/sources.list.d/cuda.list || true
RUN rm /etc/apt/sources.list.d/nvidia-ml.list || true
RUN apt-key del 7fa2af80
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

RUN apt update -y
RUN apt upgrade -y
RUN apt install -y curl software-properties-common wget
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install -y python3.9 python3.9-distutils
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.9

WORKDIR /rembg

COPY . .
RUN python3.9 -m pip install .[gpu]

RUN mkdir -p ~/.u2net
RUN wget -P ~/.u2net https://pix-sg.oss-ap-southeast-1.aliyuncs.com/u2netp.onnx
RUN wget -P ~/.u2net https://pix-sg.oss-ap-southeast-1.aliyuncs.com/u2net.onnx
RUN wget -P ~/.u2net https://pix-sg.oss-ap-southeast-1.aliyuncs.com/u2net_human_seg.onnx

EXPOSE 5000
ENTRYPOINT ["rembg"]
CMD ["--help"]
