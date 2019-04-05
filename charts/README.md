# chart用法
* 添加chart仓库</br>
  $ helm repo add solomonlinux https://github.com/solomonlinux/kubernetes_cluster/tree/master/charts/solomonlinux</br>
  $ helm fetch solomonlinux/kibana</br>
  $ helm install --name kibana --namespace logging solomonlinux/kibana

* 将chart文件转换为yaml文件
  $ helm fetch stable/kibana
  $ tar xf kibana-2.1.0.tgz
  $ vim kibana/valume.yaml
  $ helm template --name kibana --namespace logging kibana -f kibana/values.yaml > kibana.yaml
