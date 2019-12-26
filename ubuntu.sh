function install() {
  sudo apt-get -y install "$1"
}

echo installing things for ubuntu

sudo apt-get update

install curl
install firefox
install git
install docker.io
install default-jre

# OhMyZsh
zsh --version || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# docker-compose
# https://docs.docker.com/compose/install/
docker-compose --version || {
  curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

# node-js
# https://github.com/nodesource/distributions/blob/master/README.md#deb
node --version || {
  curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
  install -y nodejs
}

# sbt
# https://www.scala-sbt.org/download.html
which sbt || {
  echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
  curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
  sudo apt-get update
  install sbt
}

curl --version &&
  firefox --version &&
  git --version &&
  docker --version &&
  java --version &&
  zsh --version &&
  docker-compose --version &&
  node --version &&
  npm --version &&
  sbt --version

EXIT_CODE=$?

echo script finished with status code "$EXIT_CODE"

exit "$EXIT_CODE"
