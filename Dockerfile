FROM python:3.9

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt install wget

WORKDIR /rembg

COPY . .
RUN pip install rembg

RUN mkdir -p ~/.u2net
RUN wget -P ~/.u2net https://pix-sg.oss-ap-southeast-1.aliyuncs.com/u2net.onnx
RUN wget -P ~/.u2net https://pix-sg.oss-ap-southeast-1.aliyuncs.com/u2netp.onnx
RUN wget -P ~/.u2net https://pix-sg.oss-ap-southeast-1.aliyuncs.com/u2net_human_seg.onnx

EXPOSE 5000
ENTRYPOINT ["rembg s"]