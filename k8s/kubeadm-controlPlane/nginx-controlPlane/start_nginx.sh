docker run --restart=always \
    -v /etc/kubernetes/nginx.conf:/etc/nginx/nginx.conf \
    -v /etc/localtime:/etc/localtime:ro \
    --name k8s-ha \
    --net host \
    -d \
    nginx
