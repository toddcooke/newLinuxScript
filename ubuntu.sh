set -e

function install() {
  sudo apt-get -y install "$1"
}

echo installing things for ubuntu

# for steam
sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386

sudo apt-get update

install curl
install steam
install firefox
install git
install default-jre
install zsh

sudo apt-get -y remove docker docker-engine docker.io
install docker.io
if [[ $$ -ne 1 ]]; then
  sudo systemctl start docker
  sudo systemctl enable docker
fi

# https://github.com/nodesource/distributions/blob/master/README.md#deb
node --version || {
  curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
  install -y nodejs
}

ls ~/.oh-my-zsh || sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# https://docs.docker.com/compose/install/
docker-compose --version || {
  curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

# https://www.scala-sbt.org/download.html
sbt --version || {
  echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
  curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | sudo apt-key add
  sudo apt-get update
  install sbt
}