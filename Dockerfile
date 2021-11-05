FROM ubuntu:20.04
FROM python:3.9

RUN mkdir ./app
RUN chmod 777 ./app
WORKDIR /app

ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata

COPY . .

RUN apt -qq update --fix-missing && \
    apt -qq install -y git \
    aria2 \
    wget \
    curl \
    busybox \
    tar \
    python3 \
    ffmpeg \
    python3-pip \

RUN wget https://rclone.org/install.sh
RUN bash install.sh
RUN bash start.sh

RUN mkdir /app/gautam
RUN wget -O /app/gautam/gclone.gz https://git.io/JJMSG
RUN gzip -d /app/gautam/gclone.gz
RUN chmod 0775 /app/gautam/gclone

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
RUN chmod +x extract
CMD ["bash","start.sh"]
ENTRYPOINT ["python3", "-m", "main_startup"]
