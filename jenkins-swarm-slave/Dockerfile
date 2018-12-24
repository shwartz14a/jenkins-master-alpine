FROM openjdk:8u102-jdk

ENV JENKINS_SWARM_VERSION 3.14
ENV HOME /home/jenkins-slave

RUN apt-get update && apt-get install -y net-tools git supervisor openssh-client zip unzip wget bzip2 nodejs npm gitstats python-yaml python-jinja2 rsync mariadb-client iproute2 python-pip \
  && python -m pip install --upgrade pip \
  && pip install setuptools \
  && pip install boto3 \
  && pip install awscli \
  && rm -rf /var/lib/apt/lists/*

RUN useradd -c "JenkinsSlave" -d $HOME -m jenkins-slave
RUN curl --create-dirs -sSLo /usr/share/jenkins/swarm-client-$JENKINS_SWARM_VERSION.jar https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_VERSION/swarm-client-$JENKINS_SWARM_VERSION.jar \
  && chmod 755 /usr/share/jenkins

COPY jenkins-slave.sh /usr/local/bin/jenkins-slave.sh

# USER jenkins-slave
VOLUME /home/jenkins-slave

ENTRYPOINT ["/usr/local/bin/jenkins-slave.sh"]
