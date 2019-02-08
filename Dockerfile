FROM eclipse/stack-base:ubuntu
EXPOSE 4403 25565 25575 9876 22

LABEL che:server:25565:ref=minecraft che:server:25565:protocol=http che:server:8000:ref=tomcat8-debug che:server:8000:protocol=http che:server:9876:ref=codeserver che:server:9876:protocol=http

ENV MAVEN_VERSION=3.3.9 \
    JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 \
    MC_HOME=/home/user/minecraft \
    TERM=xterm
ENV M2_HOME=/home/user/apache-maven-$MAVEN_VERSION
ENV PATH=$JAVA_HOME/bin:$M2_HOME/bin:$PATH

ENV SPONGE_VERSION 1.11.2-6.1.0-BETA-6
ENV SPONGE_URL http://draconium.rf.gd/minecraft_server.jar

RUN mkdir -p ${MC_HOME}/mods ${M2_HOME} && \
    wget -qO- "http://apache.ip-connect.vn.ua/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz" | tar -zx --strip-components=1 -C ${M2_HOME} && \
    wget -q -O "${MC_HOME}/sponge.jar" ${SPONGE_URL} && \
    echo "eula=true" > "${MC_HOME}/eula.txt" && \
    echo "export MAVEN_OPTS=\$JAVA_OPTS" >> /home/user/.bashrc
