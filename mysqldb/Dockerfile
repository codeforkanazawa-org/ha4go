FROM mysql:5.7

ENV MYSQL_ROOT_PASSWORD 1234
ENV MYSQL_PASSWORD ha4goha4go
ENV MYSQL_DATABASE ha4go

# this need to stay the same for script to work
ENV MYSQL_USER ha4go

COPY ./mysql.sh /
RUN chmod 755 /mysql.sh

ENTRYPOINT ["/mysql.sh"]
