FROM        progrium/busybox
MAINTAINER  Fletcher Nichol <fnichol@nichol.ca>

ENV HOME /root

ADD https://dl.ngrok.com/ngrok_2.0.19_linux_amd64.zip $HOME/ngrok.zip
RUN unzip $HOME/ngrok.zip -d /bin && rm -f $HOME/ngrok.zip
ADD ngrok.yml $HOME/ngrok.yml
ADD ngrok_discover /bin/ngrok_discover

EXPOSE 4040

ENTRYPOINT ["/bin/ngrok_discover"]
