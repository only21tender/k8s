apiVersion: networking.k8s.io/v1beta1
kind: Ingress
metadata:
  name: demo-ingress
  namespace: default
  annotations:
    kubernetes.io/ingress.class: "nginx" # 绑定ingress-class
    nginx.ingress.kubernetes.io/limit-rps: '100'
    nginx.ingress.kubernetes.io/limit-whitelist: 10.0.0.0/24,172.10.0.1
spec:
  rules:
  - host: www.example.com
    http:
      paths:
      - path: /login
        backend:
          serviceName: demo-svc
          servicePort: 8080
