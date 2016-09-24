FROM alpine:3.4
MAINTAINER Fletcher Nichol <fnichol@nichol.ca>

ENV USER root
ENV HOME /root

RUN set -ex \
  && apk add --no-cache --virtual .build-deps wget \
  && apk add --no-cache ca-certificates \
  \
  && cd /tmp \
  && wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip \
  && unzip ngrok-stable-linux-amd64.zip \
  && install -v -D ngrok /bin/ngrok \
  && rm -f ngrok-stable-linux-amd64.zip ngrok \
  \
  && apk del .build-deps

ADD ngrok.yml $HOME/ngrok.yml
ADD ngrok_discover /bin/ngrok_discover

EXPOSE 4040

ENTRYPOINT ["/bin/ngrok_discover"]
