#!/bin/bash
ETCDCTL_API=3
etcdctl snapshot \
    --endpoints=10.15.4.251:2379 \
    save /tmp/etcd-snapshot-$(date '+%Y%m%dT%H%M%S').db \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
    --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt
