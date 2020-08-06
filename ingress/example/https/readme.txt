创建ssl证书 secret
  kubectl create secret tls www-example-com --key tls.key --cert tls.crt -n default

nginx.ingress.kubernetes.io/ssl-redirect 默认为 true，启用 TLS 时，http请求会 308 重定向到https

