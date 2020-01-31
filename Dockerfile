FROM alpine:latest

ENV ENV /etc/profile

RUN apk update
RUN apk add vim tmux alpine-sdk musl-dbg valgrind man man-pages flex fcgi fcgi-dev libconfig libconfig-dev spawn-fcgi nginx lighttpd lighttpd-mod_auth

RUN mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh
RUN mkdir /data

COPY .vimrc /root/.vimrc

WORKDIR /data

EXPOSE 8080/tcp
