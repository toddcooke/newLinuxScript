FROM ubuntu:18.04
RUN apt-get update && apt-get install -y vim nano sudo gnupg2 software-properties-common
COPY . /
CMD ["/bin/bash", "-c", "./ubuntu.sh"]
