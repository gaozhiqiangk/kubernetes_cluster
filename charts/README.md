### chart用法
* 添加chart仓库</br>
  $ helm repo add solomonlinux https://github.com/solomonlinux/kubernetes_cluster/tree/master/charts/solomonlinux</br>
  $ helm fetch solomonlinux/kibana</br>
  $ helm install --name kibana --namespace logging solomonlinux/kibana

* 将chart文件转换为yaml文件</br>
  $ helm fetch stable/kibana</br>
  $ tar xf kibana-2.1.0.tgz</br>
  $ vim kibana/valume.yaml</br>
  $ helm template --name kibana --namespace logging kibana -f kibana/values.yaml > kibana.yaml

### chart参考
* https://github.com/helm/charts
