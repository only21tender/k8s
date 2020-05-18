#!/bin/bash

backup_dir=/data/backup/kubernetes
etcd_backup_dir=${backup_dir}/etcd
kubernetes_backup_dir=${backup_dir}/kubernetes
kubelet_backup_dir=${backup_dir}/kubelet

[ -d ${etcd_backup_dir} ] || mkdir -p ${etcd_backup_dir}
[ -d ${kubernetes_backup_dir} ] || mkdir -p ${kubernetes_backup_dir}
[ -d ${kubelet_backup_dir} ] || mkdir -p ${kubelet_backup_dir}

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
   cp -r $file ${kubernetes_backup_dir}/
done

#备份/var/lib/kubelet
cp -r /var/lib/kubelet/* ${kubelet_backup_dir}/

# 备份保留30天
find $etcd_backup_dir/ -name *.db -mtime +30 -exec rm -f {} \;

ls ${etcd_backup_dir} 
