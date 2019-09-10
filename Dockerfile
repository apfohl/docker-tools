FROM alpine:latest

ENV ENV /etc/profile

RUN apk update
RUN apk add vim tmux alpine-sdk flex fcgi fcgi-dev spawn-fcgi nginx lighttpd

RUN mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh
RUN mkdir /data

COPY .vimrc /root/.vimrc

ADD https://github.com/apfohl/jzon/archive/v1.0.0.tar.gz /
RUN tar xf v1.0.0.tar.gz
RUN make -C jzon-1.0.0 CFLAGS='-std=gnu11 -Os -Wall -Wextra -Wpedantic -Wstrict-overflow' install
RUN rm -r jzon-1.0.0 v1.0.0.tar.gz

WORKDIR /data

EXPOSE 8080/tcp
