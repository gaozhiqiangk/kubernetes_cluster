# 第三章、日志系统文档

## 3.1 fluent-bit
### 3.1.1 fluentd与fluent-bit的比较
![blockchain](https://github.com/solomonlinux/kubernetes_cluster/blob/master/images/fluentd-fluent-bit.png "fluentd与fluent-bit比较")

### 3.1.2 fluent-bit的工作流程
![blockchain](https://github.com/solomonlinux/kubernetes_cluster/blob/master/images/fluent-bit-workflow.png "fluent-bit工作流")
1. INPUT: 读取原始日志,input插件有许多,最常见的就是读磁盘上的文件
2. PARSER: 将原始日志格式化为结构日志
3. FILTER: 对结构化日志进行处理
4. BUFFER: 来自FILTER的日志在输出值OUTPUT之前需要在BUFFER中缓冲一下,比如打包发送
5. ROUTING: INPUT时可以对日志打tag(比如kube.*),然后OUTPUT的时候可以Match匹配对应tag,Match支持通配
6. OUTPUT: 将日志发送至某个位置,如ES，kafka

### 3.1.3 fluent-bit reference
* 官方文档: https://docs.fluentbit.io/manual/
* 示例仓库: https://github.com/fluent/fluent-bit-kubernetes-logging

## 3.2 elasticsearch

参考:
* https://github.com/helm/charts/tree/master/stable/elasticsearch

## 3.3 kibana

参考:
* https://github.com/helm/charts/tree/master/stable/kibana


# REFERENCE
https://github.com/upmc-enterprises/elasticsearch-operator

https://akomljen.com/get-kubernetes-logs-with-efk-stack-in-5-minutes/

https://github.com/kubernetes/kubernetes/tree/master/cluster/addons/fluentd-elasticsearch

https://www.jianshu.com/p/1000ae80a493

https://github.com/fluent/fluent-bit-kubernetes-logging
