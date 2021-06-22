# gitops

在Kubernetes上基于GitLab和Jenkins的CICD测试环境

- [参考docker-gitlab](https://github.com/sameersbn/docker-gitlab)

## 部署步骤

Jenkins和GitLab之间没有依赖关系，可分别按需部署。

### k8s基于nfs的共享存储

#### nfs-client

NFS默认不支持 StorageClass 动态存储，使用第三方插件使用PVC自动创建NFS存储类型的PV，Jenkins和GitLab使用此[nfs-client插件](https://github.com/kubernetes-retired/external-storage/tree/master/nfs-client/deploy)实现StorageClass的共享存储方案。

- 系统安装NFS并映射共享目录；
- 部署nfs-client插件；

### 部署GitLab

- 使用`nodeSelector`将服务固定再`k8s-node01`节点；
- redis、postgresql和gitlab都使用了`hostPath`类型的存储卷，该方式并**不适用于生产环境**，应用于生产环境之前，请按需要修改为可用的PVC资源后再进行部署；
- GitLab目录下的配置清单文件名被依次编制了序号，建议按序号依次进行部署，且应该在redis和postgresql服务均就绪后再部署GitLab；
- 它们默认均部署于gitlab名称空间下；
- GitLab Service默认通过NodePort向外暴露，它固定使用`31080`的端口；SSH Service默认通过`NodePort`向外暴露，它固定使用`31022`的端口；

### 部署Jenkins

- Jenkins使用了基于NFS共享存储，自动创建释放PV资源；
- Jenkins目录下的配置清单文件名被依次编制了序号，建议按序号依次进行部署；
- 它默认均部署于jenkins名称空间下；
- Jenkins Service默认通过NodePort向外暴露，它固定使用32080的端口；
- 部署完成后，可使用类似如下命令获取Jenkins的解锁密钥；

```bash
kubectl logs $(kubectl get pods -n jenkins | awk '{print $1}' | grep jenkins) -n jenkins
```
