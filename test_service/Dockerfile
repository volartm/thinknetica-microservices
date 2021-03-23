FROM ruby:2.5.3-alpine
ENV APP_PATH /var/www/test_service
ENV PHANTOM_JS_VERSION "2.1.1"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

RUN apk update \
&& apk upgrade \
&& apk add --update --no-cache \
build-base curl-dev git postgresql-dev \
yaml-dev zlib-dev nodejs npm yarn \
curl openssl-dev chrpath libxft-dev \
freetype-dev fontconfig-dev wget \
imagemagick imagemagick-dev ttf-liberation \
msttcorefonts-installer \
vim zsh zsh-vcs \
tzdata gcc g++ make busybox ctags python2 openssl

RUN update-ms-fonts && fc-cache -f

RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
  echo "Europe/Moscow" >  /etc/timezone

ENV TZ Europe/Moscow
ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU.UTF-8
ENV LC_ALL ru_RU.UTF-8
    

RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

COPY Gemfile $APP_PATH/Gemfile
COPY Gemfile.lock $APP_PATH/Gemfile.lock

RUN bundle install

