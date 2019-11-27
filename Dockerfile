FROM alpine AS fetch

RUN apk add --update openssl
RUN wget -q https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-80-g6c4433a-5.2.0.tar.gz

FROM python

ENTRYPOINT /bin/bash
COPY --from=fetch /xtensa-esp32-elf*.tar.gz /
RUN cd /opt && tar xzf /xtensa-esp32-elf*.tar.gz && rm /xtensa-esp32-elf*.tar.gz
ENV PATH /opt/xtensa-esp32-elf/bin:$PATH

RUN apt update -y && apt install -y \
        gcc \
        git \
        cmake \
        ninja-build \
        make \
        libncurses-dev \
        flex \
        bison \
        gperf

RUN pip install click pyserial cryptography 'pyparsing<2.4.0' future pyelftools
