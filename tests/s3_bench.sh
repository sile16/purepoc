OBJECT_IP=10.55.84.248
user=pureuser
ID=PSFBIAZFEAAAMDDK
SECRET=AE5F00004+51b182CDF781ff641af3+KAPGDCEKJMFCCECG


yum install -y git docker wget
mkdir -p /purepoc_s3_perf
cd /purepoc_s3_perf


systemctl disable firewalld
systemctl stop firewalld
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0


oecho "Starting services"

for x in "docker"; do
  echo "Starting $1"
  systemctl enable $x
  systemctl start $x
done

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-io
service docker start

##Driver
docker run -d --name worker1 -p 18088:18088 -e ip=$OBJECT_IP -e t=driver  nexenta/cosbench
docker run -d --name worker2 -p 18089:18088 -e ip=$OBJECT_IP -e t=driver  nexenta/cosbench

## Controller
docker run -d --name con1 -p 19088:19088 -e ip=127.0.0.1 -e t=controller nexenta/cosbench