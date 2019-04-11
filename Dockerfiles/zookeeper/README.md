### 创建镜像
$ docker build -t solomonlinux/zookeeper:3.4.14 ./</br>
$ docker run -it --rm solomonlinux/zookeeper:3.4.14</br>

### 测试镜像是否运行正常
$ kubectl exec -it zookeeper-1 -n logging -- bash</br>
\# zkServer.sh status
