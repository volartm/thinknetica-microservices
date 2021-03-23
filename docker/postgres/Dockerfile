FROM postgres:9.6
RUN apt-get update && apt-get install -y --allow-downgrades git build-essential \
 libpq-dev=9.6.17-0+deb9u1 \
 libpq5=9.6.17-0+deb9u1 postgresql-server-dev-9.6=9.6.17-0+deb9u1
RUN cd /tmp && git clone https://github.com/postgrespro/rum.git
RUN cd /tmp/rum && make USE_PGXS=1 && make USE_PGXS=1 install
RUN cd /tmp && git clone https://github.com/postgrespro/hunspell_dicts.git
RUN cd /tmp/hunspell_dicts/hunspell_ru_ru_aot && make USE_PGXS=1 install