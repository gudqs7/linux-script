sudo apt-get remove nodejs --purge 
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs
node -v
npm -v

