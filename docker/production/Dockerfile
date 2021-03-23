FROM madnight/docker-alpine-wkhtmltopdf as wkhtmltopdf_image

FROM alpine:3.13
ENV APP_PATH /var/www/fgiski
ENV PHANTOM_JS_VERSION "2.1.1"
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US.UTF-8"

RUN apk update \
&& apk upgrade \
&& apk add --update --no-cache \
alpine-sdk gcc gnupg build-base curl-dev git postgresql-dev \
yaml-dev bash zlib-dev nodejs npm yarn \
mysql-client mariadb-dev \
curl openssl-dev chrpath libxft-dev \
freetype-dev fontconfig-dev wget \
imagemagick imagemagick-dev ttf-liberation \
msttcorefonts-installer \
vim zsh zsh-vcs \
gcc g++ make busybox ctags \
tzdata wkhtmltopdf sqlite-dev python2 openssl

RUN adduser -D -g '' deploy

USER deploy
RUN cd ~ && curl -sSL https://github.com/rvm/rvm/tarball/stable -o rvm-stable.tar.gz \
  && echo 'export rvm_prefix="$HOME"' > ~/.rvmrc \
  && echo 'export rvm_path="$HOME/.rvm"' >> ~/.rvmrc \
  && mkdir rvm && cd rvm \
  && tar --strip-components=1 -xzf ../rvm-stable.tar.gz \
  && ./install --auto-dotfiles --autolibs=0 \
  && cd ../ && rm -rf rvm-stable stable.tar.gz rvm
  
RUN bash -c 'source ~/.rvm/scripts/rvm'

RUN rvm install 2.5.3

# USER root
# 
# RUN apk del alpine-sdk gcc gnupg musl-dev make linux-headers zlib-dev openssl-dev musl-dev \
#   && rm -rf /var/cache/apk/*
# 
# 
# RUN update-ms-fonts && fc-cache -f
# 
# RUN cp /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
#   echo "Europe/Moscow" >  /etc/timezone
# 
# ENV TZ Europe/Moscow
# ENV LANG ru_RU.UTF-8
# ENV LANGUAGE ru_RU.UTF-8
# ENV LC_ALL ru_RU.UTF-8
# 
# RUN cd /tmp && curl -Ls https://github.com/dustinblackman/phantomized/releases/download/${PHANTOM_JS_VERSION}/dockerized-phantomjs.tar.gz | tar xz &&\
#     cp -R lib lib64 / &&\
#     cp -R usr/lib/x86_64-linux-gnu /usr/lib &&\
#     cp -R usr/share /usr/share &&\
#     cp -R etc/fonts /etc &&\
#     curl -k -Ls https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOM_JS_VERSION}-linux-x86_64.tar.bz2 | tar -jxf - &&\
#     cp phantomjs-${PHANTOM_JS_VERSION}-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
# 
# COPY --from=wkhtmltopdf_image /bin/wkhtmltopdf /usr/bin
# 
# USER root

