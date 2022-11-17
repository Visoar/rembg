FROM python:3.9.15-alpine

RUN apk update
RUN apk add wget

WORKDIR /rembg

COPY . .
RUN python3.9 -m pip install .

RUN mkdir -p ~/.u2net
RUN wget -P ~/.u2net https://pix-sg.oss-ap-southeast-1.aliyuncs.com/u2netp.onnx
RUN wget -P ~/.u2net https://pix-sg.oss-ap-southeast-1.aliyuncs.com/u2net.onnx
RUN wget -P ~/.u2net https://pix-sg.oss-ap-southeast-1.aliyuncs.com/u2net_human_seg.onnx

EXPOSE 5000
ENTRYPOINT ["rembg"]
CMD ["--help"]
