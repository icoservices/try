TMP_FOLDER=$(mktemp -d)
CONFIG_FILE="VersatileVisioncoin.conf"
BINARY_FILE="/usr/local/bin/VersatileVisioncoind"
REPO="https://github.com/icoservices/try.git"
apt-get update -y
apt-get install vim git build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common libgmp3-dev  -y
apt-get install libboost-all-dev -y
add-apt-repository ppa:bitcoin/bitcoin -y
apt-get update -y
apt-get install libdb4.8-dev libdb4.8++-dev -y
apt-get install libminiupnpc-dev -y
export EXIP=`wget -qO- eth0.me`
apt-get install -y pwgen
export RPC_PASSWORD=`pwgen -1 20 -n`
mkdir $HOME/.VersatileVisioncoin
printf "rpcuser=user\nrpcpassword=$RPC_PASSWORD\nrpcport=16791\ndaemon=1\nlisten=1\nserver=1\nmaxconnections=256\nrpcallowip=127.0.0.1\nexternalip=$EXIP:16790\n" > $HOME/.VersatileVisioncoin/$CONFIG_FILE
git clone $REPO $TMP_FOLDER
cd $TMP_FOLDER/src/secp256k1
chmod +x autogen.sh
./autogen.sh
./configure --enable-module-recovery
make
cd ..
mkdir obj/support
mkdir obj/crypto
make -f makefile.unix
cp -a VersatileVisioncoind $BINARY_FILE
clear
