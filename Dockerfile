ARG LOGSTASH_VERSION
FROM docker.elastic.co/logstash/logstash-oss:${LOGSTASH_VERSION}-amd64
ARG IMAGE_VERSION
ARG LOGSTASH_VERSION
COPY --chown=logstash image /
USER root
RUN /build/root.sh
USER logstash
ENV PATH="/usr/share/logstash/jdk/bin:${PATH}"
ENV JAVA_HOME="/usr/share/logstash/jdk"
RUN /build/logstash.sh
