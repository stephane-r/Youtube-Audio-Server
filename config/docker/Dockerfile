FROM jrottenberg/ffmpeg:3.4-alpine
FROM node:16

# copy ffmpeg bins from first image
COPY --from=0 / /

RUN apt-get install git dpkg dpkg-dev

# ENV VARIABLES
ENV GOSU_VERSION=1.10 \
    HOME=/app

# GOSU
WORKDIR $HOME
RUN chmod a+rwx $HOME

ENV GOSU_VERSION $GOSU_VERSION
RUN arch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && echo $arch \
    && wget -O gosu "https://github.com/tianon/gosu/releases/download/1.10/gosu-$arch" \
    && mv ./gosu /usr/local/bin/gosu \
    && chmod +x /usr/local/bin/gosu

RUN git config --global user.name yas

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod a+x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# VOLUMES
VOLUME ["/app"]

# REACT APP PORT
WORKDIR /app

EXPOSE 3000

# COMMAND
CMD ["npm"]
