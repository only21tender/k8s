#!/bin/bash
#by chinaboy007 


TIME=`date +%Y%m%d%H%M%S`
CURRENT_HOST_IP=192.168.227.130
backup_dir=/data/backup/kubernetes
etcd_backup_dir=${backup_dir}/etcd
etcd_db_name=$1

cd ${etcd_backup_dir};ls

if [ $# -ne 1 ];then
   echo "usage:$0 {etcd_db_name}"
   echo "eg: $0etcd-snapshot-20200515T030001.db"
   exit 1
fi


mv /var/lib/etcd /var/lib/etcd-${TIME}.bak
mv /etc/kubernetes/manifests /etc/kubernetes/manifests.bak
sleep 8
echo "please wait"

 ETCDCTL_API=3 etcdctl snapshot restore ${etcd_backup_dir}/${etcd_db_name} \
  --name etcd-0 \
  --initial-cluster="etcd-0=https://${CURRENT_HOST_IP}:2380" \
  --initial-cluster-token=etcd-cluster-token \
  --initial-advertise-peer-urls=https://${CURRENT_HOST_IP}:2380 \
  --data-dir=/var/lib/etcd

cp -r ${backup_dir}/kubelet /var/lib/ 
cp -r ${backup_dir}/kubernetes /etc/

mv /etc/kubernetes/manifests.bak /etc/kubernetes/manifests
systemctl restart kubelet
systemctl status kubelet
kubectl get node
