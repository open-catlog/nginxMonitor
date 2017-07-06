# NginxMonitor

## 1. 项目结构

- conf/nginx.conf：Nginx 配置文件
- general.lua：筛选域名，获取特定 URI 的请求次数，响应时间，平均响应式；解析 IP，计算 PV 量。将获取到的信息存入共享内存中
- statistics.lua：从共享内存中读取数据并返回
- del_statistics.lua：删除共享内存中的数据

## 2. 扩展 - Nginx 执行步骤

1. post-read：获取请求内容，Nginx 读取并解析完请求头后就立即开始运行
2. server-rewrite：server 请求地址重写阶段，当 ngx_rewrite 模块的 set 指令直接书写在 server 配置块中
3. find-config：由 Nginx 核心来完成当前请求与 location 配置块之间的配对工作
4. rewrite：location 请求地址重写阶段
5. post-rewrite：请求地址重写提交阶段
6. preaccess：访问权限检查准备阶段
7. access：访问权限检查阶段
8. post-access：访问权限检查提交阶段
9. try-files：配置项try_files处理阶段
10. content：内容产生阶段，这个阶段的指令通常是用来生成 HTTP 响应内容并输出 HTTP 响应的使命
11. log：日志处理阶段