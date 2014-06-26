FROM        progrium/busybox
MAINTAINER  Fletcher Nichol <fnichol@nichol.ca>

RUN opkg-install curl
RUN curl -Lk 'https://api.equinox.io/1/Applications/ap_pJSFC5wQYkAyI0FIVwKYs9h1hW/Updates/Asset/ngrok.zip?os=linux&arch=amd64&channel=stable' > ngrok.zip
RUN unzip ngrok.zip -d /bin && rm -f ngrok.zip
RUN echo 'inspect_addr: 0.0.0.0:4040' > /.ngrok
ADD ngrok_discover /bin/ngrok_discover
RUN chmod +x /bin/ngrok_discover

EXPOSE 4040

ENTRYPOINT ["/bin/ngrok_discover"]
