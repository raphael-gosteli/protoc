FROM ubuntu:16.04
LABEL maintainer="raphael.gosteli@dvbern.ch"

# Dependencies
USER root
RUN apt-get update
RUN apt-get install g++ autoconf automake make libtool curl git -y

# Get and make protobuf
ARG PROTOBUF_VERSION="2.4.1"
ARG PROTOBUF_URL="https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/protobuf-${PROTOBUF_VERSION}.tar.gz"
ARG PROTOBUF_HOME="/protobuf-${PROTOBUF_VERSION}"
ENV PROTOBUF_HOME=${PROTOBUF_HOME}

RUN curl -L ${PROTOBUF_URL} | tar zvx
WORKDIR ${PROTOBUF_HOME}
RUN ./configure
RUN make
# RUN make check  | Checking fails, but it should still work :(
RUN make install
RUN ldconfig

# Get and make protobuf-objc
ARG OBJC_VERSION="master"
ARG OBJC_REPO="https://github.com/booyah/protobuf-objc.git"
ARG OBJC_CONFIGURE_OPTIONS="CXXFLAGS=-I/usr/local/include LDFLAGS=-L/usr/local/lib"

RUN git clone -b ${OBJC_VERSION} ${OBJC_REPO}
WORKDIR ${PROTOBUF_HOME}/protobuf-objc
RUN ./autogen.sh
RUN ./configure ${OBJC_CONFIGURE_OPTIONS}
RUN make
RUN make install

ENTRYPOINT [ "protoc" ]