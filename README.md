# CloudXNS DDNS on bash with curl
看到很多CloudXNS的DDNS客户端都是基于官方的Python SDK做的，于是根据官方的API文档撸了个bash下的一个轮子。

### 特点
1. 系统需支持curl命令，适合在闪存容量小，不能安装Python的路由器上运行。
2. 在CloudXNS[申请API Key](https://www.cloudxns.net/AccountManage/apimanage.html)，只需要在脚本中填写API Key，不需要提供账号密码，绿色安全。
3. 不像DNSPod那样繁琐，需要先通过客户端查询域名ID、记录ID，只需提供需要DDNS的域名。

### 用法
1. `wget https://raw.githubusercontent.com/kuretru/CloudXNS-DDNS/master/CloudXNS-ddns.sh`
2. 在[CloudXNS](https://www.cloudxns.net/AccountManage/apimanage.html)获得API Key后，将API Key、Secret Key填入脚本。
3. 在CloudXNS添加需要DDNS的域名，并在脚本填写该域名。  
`domain="www.cloudxns.net."`
4. 设置好具有公网IP的网卡
        interface=""     #留空时，CloudXNS则会自动获取你的公网IP
        interface="ppp0" #tomato路由器使用ppp0作为网卡名
        interface="wan1" #OpenWRT路由器使用wan1作为网卡名
5. 脚本会在执行过后自动在当前目录下生成名为*cloudxns-ddns.log*的日志文件，方便日后查看，如果不需要此功能，将最后一行注释即可。  
`#echo "${result} ${time} ${data}" >> $(pwd)/cloudxns-ddns.log`
5. 执行`sh CloudXNS-ddns.sh`。

### 路由器设置
##### tomato
在*当WAN联机时*事件中添加本脚本。  
##### OpenWRT
* 方法1：安装ddns-scripts和luci-app-ddns，在DDNS服务下添加本脚本。
* 方法2：将99-ddns放至/etc/hotplug.d/iface下，网卡启动时将自动运行本脚本，*注意修改脚本中网卡名和你放置脚本的路径*。

### LICENSE
GNU General Public License v3.0

### 参考资料 :paperclip:
1. https://www.cloudxns.net/Support/detail/id/1361.html -- CloudXNS 官方 API 文档
