#!/bin/bash
#by chinaboy007 

CURRENT_HOST_IP=192.168.227.130
etcd_backup_dir=/etc/kubernetes/backup/etcd

mv /var/lib/etcd /var/lib/etcd.bak
mv /var/lib/kubelet /var/lib/kubelet.bak


 ETCDCTL_API=3 etcdctl snapshot restore ${etcd_backup_dir}/etcd-snapshot-20200515T173218.db \
  --name etcd-0 \
  --initial-cluster="etcd-0=https://${CURRENT_HOST_IP}:2380" \
  --initial-cluster-token=etcd-cluster-token \
  --initial-advertise-peer-urls=https://${CURRENT_HOST_IP}:2380 \
  --data-dir=/var/lib/etcd

cp -r ${etcd_backup_dir}/kubelet /var/lib/ 

systemctl restart kubelet
