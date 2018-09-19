# Version: 0.1

FROM alpine:latest
MAINTAINER Dmytro Chernetskyi <dchernetskiy@gmail.com>

ARG image_version=0.1
ENV image_version $image_version

ENV LANG en_US.utf8
ENV ENV="/etc/profile"

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG http_port=8080
ARG agent_port=50000
ARG JENKINS_HOME=/var/jenkins_home
ARG JENKINS_VOLUME=/srv/data/jenkins
ARG JENKINS_PLUGDIR=/usr/share/jenkins/ref/plugins/
ARG JENKINS_VERSION

ENV JENKINS_VERSION ${JENKINS_VERSION:-2.121.1}
ARG JENKINS_SHA=5bb075b81a3929ceada4e960049e37df5f15a1e3cfc9dc24d749858e70b48919
ARG JENKINS_URL=https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/${JENKINS_VERSION}/jenkins-war-${JENKINS_VERSION}.war
ENV JENKINS_URL $JENKINS_URL
ENV JENKINS_HOME $JENKINS_HOME
ENV JENKINS_PLUGDIR $JENKINS_PLUGDIR
ENV JENKINS_VOLUME $JENKINS_VOLUME
ENV JENKINS_SLAVE_AGENT_PORT ${agent_port}
ENV COPY_REFERENCE_FILE_LOG $JENKINS_HOME/copy_reference_file.log
ENV JENKINS_UC https://updates.jenkins.io
ENV JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
ENV JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals

RUN echo "alias ll='ls -alF'" >> /etc/profile
RUN apk upgrade --update \
  && apk add --virtual .tz-deps tzdata \
  && cp /usr/share/zoneinfo/Europe/Kiev /etc/localtime \
  && echo "Europe/Kiev" > /etc/timezone \
  && apk del .tz-deps

RUN apk upgrade --update \
  && apk add --no-cache tini openssh-client git unzip curl shadow bash busybox fontconfig freetype openjdk8 openjdk8-jre openjdk8-jre-base ttf-dejavu xvfb \ 
  && rm -rf /tmp/* /var/cache/apk/*

RUN mkdir -p $JENKINS_PLUGDIR \
  && groupadd -g ${gid} ${group} \
  && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user} \
  && chown ${uid}:${gid} $JENKINS_HOME

VOLUME $JENKINS_HOME

COPY plugins.txt /usr/share/jenkins/ref/
COPY plugins.sh install-plugins.sh jenkins-support jenkins.sh /usr/local/bin/

RUN curl -fsSL ${JENKINS_URL} -o /usr/share/jenkins/jenkins.war \
  && echo "${JENKINS_SHA}  /usr/share/jenkins/jenkins.war" | sha256sum -c -

RUN ln -s /usr/lib/jvm/java-1.8-openjdk/bin/jar /usr/bin/jar
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

EXPOSE ${http_port}
EXPOSE ${agent_port}

