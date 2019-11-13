FROM debian AS fetch

RUN apt update -y && apt install -y wget
RUN wget -q -N -c https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz

FROM python

ENTRYPOINT /bin/bash
COPY --from=fetch /xtensa-esp32-elf*.tar.gz /
RUN cd /opt && tar xzf /xtensa-esp32-elf*.tar.gz && rm /xtensa-esp32-elf*.tar.gz
ENV PATH /opt/xtensa-esp32-elf/bin:$PATH

RUN apt update -y && apt install -y \
        gcc \
        git \
        make \
        libncurses-dev \
        flex \
        bison \
        gperf

RUN pip install pyserial cryptography pyparsing future
