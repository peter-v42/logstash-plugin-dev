# Building the container image
 
The [`build.sh`](build.sh) script contains the commands to build the image:
- [`versions`](versions) is parsed to determine the version of the [logstash container image](https://www.docker.elastic.co/r/logstash) to be used.
  - The contents of the [`image`](image) directory are copied into this logstash container image.
- The [`build/root.sh`](image/build/root.sh) script is executed as `root` (in the container image):
  - This script updates the image's OS and installs `git`.
- The [`build/logstash.sh`](image/build/logstash.sh) script is executed as `logstash` (in the container image):
  - As the official logstash container image is missing two source files needed for Java plugin development, the matching logstash sources are retrieved, the missing files are copied to the required locations. Once done, the logstash sources are deleted.
  - The (Java input plugin example)[https://github.com/logstash-plugins/logstash-input-java_input_example] is retrieved, build, installed and tested to test whether the `logstash-plugin-dev` container image is functioning correctly.
- The resulting image is pushed into my [`docker.io` container registry](https://hub.docker.com/repository/docker/v42net/logstash-plugin-dev/general).

If you want to build the image yourself, you'll have to change the `IMAGE_NAME` in [`build.sh`](build.sh) as it currently references my [`docker.io` container registry](https://hub.docker.com/repository/docker/v42net/logstash-plugin-dev/general): replace the `v42.net` part by your own `docker.io` container registry.
