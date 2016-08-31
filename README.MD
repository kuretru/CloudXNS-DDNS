# CloudXNS DDNS on bash with curl
看到很多CloudXNS的DDNS客户端都是基于官方的Python SDK做的，于是根据官方的API文档撸了一个轮子。

### 特点
1. 只需系统含有curl命令，适合在闪存容量小，不能安装curl的路由器上运行。
2. 在CloudXNS[申请API Key](https://www.cloudxns.net/AccountManage/apimanage.html)，不需要提供账号密码，绿色安全。
3. 不需要像DNSPod那样，先通过客户端查询域名ID、记录ID，只需提供需要DDNS的域名。

### 用法
在CloudXNS获得API Key后，将API Key、Secret Key填入脚本，并设置好需要DDNS的域名及网卡。执行以下命令：  
`sh CloudXNS-ddns.sh`

如果需要在DDNS成功后记录日志，可以参考以下代码。  
```
curl …… >> /path/cloudxns-ddns.log  
echo "${i_time} ${i_data}" >> /path/cloudxns-ddns.log
```
