FROM anapsix/alpine-java:jdk

# Configuration variables
ENV BITBUCKET_HOME     /var/atlassian/bitbucket
ENV BITBUCKET_INSTALL  /opt/atlassian/bitbucket
ENV BITBUCKET_VERSION  4.7.1

# Install Atlassian BitBucket and helper tools

RUN	apk --update add curl tar git perl \
	&& mkdir -p ${BITBUCKET_HOME} \
	&& mkdir -p ${BITBUCKET_INSTALL} \
	&& curl -Ls "https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-${BITBUCKET_VERSION}.tar.gz" | tar -xz --directory "${BITBUCKET_INSTALL}" --strip-components=1 --no-same-owner \
	&& curl -Ls "https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.36.tar.gz" | tar -xz --directory "${BITBUCKET_INSTALL}/lib" --strip-components=1 --no-same-owner "mysql-connector-java-5.1.36/mysql-connector-java-5.1.36-bin.jar"

EXPOSE 7990

VOLUME ${BITBUCKET_HOME}

WORKDIR ${BITBUCKET_HOME}

CMD ["sh", "-c", "${BITBUCKET_INSTALL}/bin/start-bitbucket.sh -fg"]
