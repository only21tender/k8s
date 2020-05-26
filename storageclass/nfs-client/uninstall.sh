kubectl delete -f rbac.yaml
kubectl delete -f deployment.yaml
kubectl delete sc nfs-client

sleep 2
echo ----------------------------
kubectl get pvc -n monitoring
echo ------pvc-------------------
kubectl get pod -n monitoring

