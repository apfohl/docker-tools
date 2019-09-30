FROM alpine:latest

ENV ENV /etc/profile

RUN apk update
RUN apk add vim tmux alpine-sdk musl-dbg valgrind man man-pages flex fcgi fcgi-dev libconfig libconfig-dev spawn-fcgi nginx lighttpd lighttpd-mod_auth

RUN mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh
RUN mkdir /data

COPY .vimrc /root/.vimrc

# JZON
ADD https://github.com/apfohl/jzon/archive/v1.0.0.tar.gz /
RUN tar xf v1.0.0.tar.gz
RUN make -C jzon-1.0.0 CFLAGS='-std=gnu11 -Os -Wall -Wextra -Wpedantic -Wstrict-overflow' install
RUN rm -r jzon-1.0.0 v1.0.0.tar.gz

# C HTML Template Library
ADD https://github.com/apfohl/ctemplate/archive/v1.0.0.tar.gz /
RUN tar xf v1.0.0.tar.gz
RUN make -C ctemplate-1.0.0 install
RUN rm -r ctemplate-1.0.0 v1.0.0.tar.gz

WORKDIR /data

EXPOSE 8088/tcp
