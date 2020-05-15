# 1 From Apline Linux
FROM alpine:3.11

# 2 Maintainer name
LABEL maintainer="antonio@flood.io"

# 3 Set JMeter version 5.2.1 for downloading and some ENV variables
ENV JMETER_VERSION 5.2.1
ENV JMETER_FOLDER /home/jmeter/
ENV JMETER_HOME /home/jmeter/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_BIN ${JMETER_HOME}/bin
ENV JMETER_DOWNLOAD https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

# 4 Update, upgrade, download Java JRE and JMeter then decompress it
RUN apk update \
	&& apk upgrade \
	&& apk add ca-certificates \
	&& update-ca-certificates \
	&& apk add --update openjdk8-jre tzdata curl unzip bash \
	&& apk add --no-cache nss \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /tmp/jmeter/ \
	&& curl -L --silent ${JMETER_DOWNLOAD} > /tmp/jmeter/apache-jmeter-${JMETER_VERSION}.tgz \
	&& mkdir -p ${JMETER_FOLDER} \
	&& tar -xzf /tmp/jmeter/apache-jmeter-${JMETER_VERSION}.tgz -C ${JMETER_FOLDER}  \
	&& rm -rf /tmp/jmeter

# 5 Copy entrypoint to the container 
COPY entrypoint.sh /

# 6 Set environment variables
ENV PATH $PATH:$JMETER_BIN

# 7 Set Working Dir
WORKDIR ${JMETER_HOME}

# 8 Launch entrypoint
ENTRYPOINT ["/entrypoint.sh"]