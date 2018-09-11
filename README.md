The uid of your user must be 1000

sudo apt-get install git
sudo apt-get install docker docker-compose
sudo usermod -aG docker [your user]

logout and login again

git clone https://github.com/sebk69/SmallKering-docker.git
cd SmallKering-docker
./install-dev.sh
