### chart用法
* 添加chart仓库</br>
  $ helm repo add solomonlinux https://github.com/solomonlinux/kubernetes_cluster/tree/master/charts/solomonlinux</br>
  $ helm fetch solomonlinux/fluent-bit</br>
  $ helm install --name kibana --namespace logging solomonlinux/kibana

* 将chart文件转换为yaml文件</br>
  $ helm fetch stable/fluent-bit</br>
  $ tar xf fluent-bit-1.9.1.tgz</br>
  $ vim fluent-bit/value.yaml</br>
  $ helm template --name fluent-bit --namespace logging fluent-bit -f fluent-bit/values.yaml > fluent-bit.yaml</br>
  or</br>
  $ helm template --name fluent-bit --namespace logging fluent-bit-1.9.1.tgz -f fluent-bit/values.yaml > fluent-bit.yaml

### chart参考
* https://github.com/helm/charts
