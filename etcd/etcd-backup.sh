#!/bin/bash

etcd_cert_dir=/etc/kubernetes/pki/etcd
etcd_backup_dir=/var/lib/docker/backup/etcd
[ -d ${etcd_backup_dir} ] || mkdir -p ${etcd_backup_dir} && mkdir -p ${etcd_backup_dir}/kubernetes


#备份etcd库
ETCDCTL_API=3
etcdctl --cert=/etc/kubernetes/pki/etcd/server.crt \
        --key=/etc/kubernetes/pki/etcd/server.key \
        --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    snapshot save $etcd_backup_dir/etcd-snapshot-$(date '+%Y%m%dT%H%M%S').db

#备份/etc/kubernetes
filelist=`ls /etc/kubernetes |grep -v backup`
cd /etc/kubernetes
for file in $filelist
do
   cp -r $file ${etcd_backup_dir}/kubernetes/
done
cp -r /var/lib/kubelet ${etcd_backup_dir}/

# 备份保留30天
find $etcd_backup_dir/ -name *.db -mtime +30 -exec rm -f {} \;
