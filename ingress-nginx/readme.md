##Ingress-nginx
### 1.直接部署在namespace ingress-controller  
```bash
kubectl apply -f ingress-nginx.yaml
```

### 2.修改values.yaml
```bash
helm repo add  ingress-nginx   https://kubernetes.github.io/ingress-nginx 
helm repo update
helm install ingress-nginx ingress-nginx -f values.yaml -n kueb-system
```
