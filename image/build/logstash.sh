#!/bin/bash
set -e

cd /build
git config --global advice.detachedHead false
git clone --depth 1 -b v${LOGSTASH_VERSION} --single-branch https://github.com/elastic/logstash.git 
# we only need two files from this logstash repository ...
cp /build/logstash/rubyUtils.gradle /usr/share/logstash/
cp /build/logstash/versions.yml /usr/share/logstash/
rm -rf /build/logstash

cd /build
git clone https://github.com/logstash-plugins/logstash-codec-java_codec_example.git
git clone https://github.com/logstash-plugins/logstash-filter-java_filter_example.git
git clone https://github.com/logstash-plugins/logstash-input-java_input_example.git
git clone https://github.com/logstash-plugins/logstash-output-java_output_example.git
rm -rf */.git */.gitignore */README.md */gradlew.bat

mkdir /build/test
cd /build/test
git clone https://github.com/logstash-plugins/logstash-input-java_input_example.git
rm -rf logstash-input-java_input_example/.git
cd /build/test/logstash-input-java_input_example/
echo "LOGSTASH_CORE_PATH=/usr/share/logstash/logstash-core" >gradle.properties
./gradlew gem

logstash-plugin install --no-verify --local /build/test/logstash-input-java_input_example/logstash-input-java_input_example-1.0.3.gem
echo "input {
  java_input_example {}
}
output {
  stdout { codec => rubydebug }
}" >java_input.conf
logstash -f /build/test/logstash-input-java_input_example/java_input.conf
