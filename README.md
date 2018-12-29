# shadowsocksR with net-speeder
这是一个ShadowsocksR Docker
## 启动方式

```
docker run -d --name ssr-with-net-speeder -p 995:995 uncia/ssr-with-net-speeder -s 0.0.0.0 -p 995 -k gov.hk -m rc4-md5 -o http_simple -O auth_sha1

```


## **Arukas.io 启动**
```
镜像 ：uncia/ssr-with-net-speeder
启动命令(CMD) ：-s 0.0.0.0 -p 995 -k gov.hk -m rc4-md5 -o http_simple -O auth_sha1
```