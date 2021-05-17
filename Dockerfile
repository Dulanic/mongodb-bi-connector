# Start from fresh debian stretch & add some tools
# note: rsyslog & curl (openssl,etc) needed as dependencies too
FROM debian:stretch
RUN apt-get update
RUN apt-get install -y rsyslog nano curl wget

# Download BI Connector to /mongosqld
WORKDIR /tmp
RUN wget https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-debian10-v2.14.3.tgz -O bi-connector.tgz && \
    tar -xvzf bi-connector.tgz && rm bi-connector.tgz && \
    mv /tmp/mongodb-bi-linux-x86_64-debian10-v2.14.3 /mongosqld

# Setup default environment variables
ENV MONGODB_HOST mongodb
ENV MONGODB_PORT 27017
ENV LISTEN_PORT 3307

# Start Everything
# note: we need to use sh -c "command" to make rsyslog running as deamon too
RUN service rsyslog start
CMD sh -c "/mongosqld/bin/mongosqld --logPath /var/log/mongosqld.log --mongo-uri mongodb://$MONGODB_HOST:$MONGODB_PORT/?connect=direct --addr 0.0.0.0:$LISTEN_PORT"
