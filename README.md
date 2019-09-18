## 使用方法

### step 1 下载脚本文件
```
git clone git@git.dev.tencent.com:guddqs/project-script.git
cd project-script # 项目文件放 script 下
```

### step 2 下载项目文件
```
git clone git@git.dev.tencent.com:guddqs/xxx-api.git
git clone git@git.dev.tencent.com:guddqs/xxx-admin.git
```

### step 3 设置环境变量
变量含义:  
> scriptDir: 脚本文件所在位置  
API_DIR: java 项目目录名称
ADMIN_DIR: 后台管理页面项目目录名称
JAR_NAME: java 项目 `pom.xml` 中配置的 `build.finalName`, 生成 jar 包后的名称, 用于命名
JAR_NAME: 最好与 `application.yml` 中的 `server.servlet.context-path` 相同, 用于配置 nginx 反向代理

```bash
sudo tee /etc/environment <<-'EOF'
LANG=en_US.utf8
scriptDir=/root/project-script
API_DIR=xxx-api
ADMIN_DIR=xxx-admin
JAR_NAME=xxx-api
EOF
```

### step 4 初始化项目
```
./init.sh
```
> 然后, 就可以允许 `./update.sh` 试试升级效果了

### step 5 配置 nginx
`./copy` 可携带一个参数, 用于替换 `JAR_NAME`, 参数值是 `server.servlet.context-path` 的值   
若不携带参数, 则默认为 JAR_NAME, 请确保 `JAR_NAME` 与  `server.servlet.context-path` 相同  
另外, 需配置 ssl 时, 将crt 和key 文件放到  `/etc/nginx/cert/` 下, 并都重命名为 `server.servlet.context-path` 的值
```
cd admin
./copy.sh
``` 

### setup 6 配置 web hook
```
cd hook
./centos-node.sh #安装 node, 自行选择对应系统
./install     #安装 koa 和 koa-router
./run.sh      #运行
./status.sh   #查看日志
``` 

用 curl 测试, 如域名为 m.gudqs.cn:9080 (端口指向 nginx)
```
curl -X POST m.gudqs.cn:9080/hook/nginx-update
curl -X POST m.gudqs.cn:9080/hook/api-update
```

> 同时可将地址配置到 腾讯开发平台 git 项目的 hook   
腾讯 hook 的响应速度.... 耐心等待几分钟


## 目录结构
```
.
├── admin              #后台管理页面
│   ├── api.conf       #nginx 配置模板
│   └── copy.sh        #将配置文件放入 nginx 配置目录
├── api-jvm.conf       #jvm 配置及 覆盖 spring 配置
├── db-install.sh      #安装数据库脚本
├── error-log.sh       #打印日中的错误
├── hook               #web hook
│   ├── centos-node.sh #centos 安装 nodejs
│   ├── install.sh     #安装依赖(koa,koa-router)
│   ├── node-stable.sh #更新最新版本 nodejs(前提安装了 nodejs)
│   ├── run.sh         #后台运行 hook 程序
│   ├── status.sh      #查看日志
│   ├── ubuntu-node.sh #Ubuntu 安装 nodejs
│   └── update.js      #hook 程序代码(nodejs实现)
├── init.sh           #初始化脚本, 初始化 java 项目及添加定时处理日志crontab记录
├── jnmg-install.sh   #java-nginx-maven-git 环境安装, 支持 Ubuntu centos
├── mvlogs.sh         #日志处理脚本, 每日定时移动日志
├── nginx-update.sh   #后台管理网页代码更新部署
├── status.sh         #当前java 程序状态
└── update.sh         #后台 java 代码更新部署

```















