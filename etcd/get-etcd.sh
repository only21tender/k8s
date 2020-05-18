#!/bin/bash
echo "查看etcd版本"
ETCDCTL_API=3 etcdctl  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key --cacert=/etc/kubernetes/pki/etcd/ca.crt version

echo
echo "列出etcd成员"
ETCDCTL_API=3 etcdctl  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key --cacert=/etc/kubernetes/pki/etcd/ca.crt member list

echo
echo "列出etcd集群状态"
ETCDCTL_API=3 etcdctl  --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt  --key=/etc/kubernetes/pki/etcd/healthcheck-client.key --cacert=/etc/kubernetes/pki/etcd/ca.crt endpoint health

