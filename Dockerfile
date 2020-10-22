FROM alpine AS fetch

RUN apk add --update openssl
RUN wget -q https://dl.espressif.com/dl/xtensa-esp32-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz
RUN wget -q https://dl.espressif.com/dl/xtensa-esp32s2-elf-gcc8_4_0-esp-2020r3-linux-amd64.tar.gz
RUN wget -q https://dl.espressif.com/dl/binutils-esp32ulp-linux-amd64-2.28.51-esp-20191205.tar.gz
RUN wget -q https://dl.espressif.com/dl/binutils-esp32s2ulp-linux-amd64-2.28.51-esp-20191205.tar.gz
RUN tar xzf /xtensa-esp32-elf*.tar.gz
RUN tar xzf /xtensa-esp32s2-elf*.tar.gz
RUN tar xzf /binutils-esp32ulp*.tar.gz
RUN tar xzf /binutils-esp32s2ulp*.tar.gz

FROM python

CMD /bin/bash
COPY --from=fetch /xtensa-esp32-elf /opt/xtensa-esp32-elf
ENV PATH /opt/xtensa-esp32-elf/bin:$PATH
COPY --from=fetch /xtensa-esp32s2-elf /opt/xtensa-esp32s2-elf
ENV PATH /opt/xtensa-esp32s2-elf/bin:$PATH
COPY --from=fetch /esp32ulp-elf-binutils /opt/esp32ulp-elf-binutils
ENV PATH /opt/esp32ulp-elf-binutils/bin:$PATH
COPY --from=fetch /esp32s2ulp-elf-binutils /opt/esp32s2ulp-elf-binutils
ENV PATH /opt/esp32s2ulp-elf-binutils/bin:$PATH

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
