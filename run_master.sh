
if [ ! -L "/purepoc" ]; then
    echo "Requires sudo password to setup link"
    sudo ln -s `pwd` /purepoc
fi

docker run --privileged -h purepoc --rm -v /purepoc:/purepoc -p 4505:4505 -p 4506:4506 -it purepoc
