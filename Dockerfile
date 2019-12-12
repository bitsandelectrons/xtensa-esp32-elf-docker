FROM alpine AS fetch

RUN apk add --update openssl
RUN wget -q https://dl.espressif.com/dl/xtensa-esp32-elf-gcc8_2_0-esp-2019r2-linux-amd64.tar.gz
RUN tar xzf /xtensa-esp32-elf*.tar.gz

FROM python

CMD /bin/bash
COPY --from=fetch /xtensa-esp32-elf /opt/xtensa-esp32-elf
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
