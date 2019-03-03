下载
HaProxy 已经被墙

http://www.haproxy.org/

使用截止目前最新稳定版本 1.8.15

haproxy-1.8.15.tar.gz
(2.08 MB)

相关帮助文档 http://cbonte.github.io/haproxy-dconv/1.8/intro.html
https://www.cnblogs.com/xiangsikai/p/8915629.html



安装
参考 https://upcloud.com/community/tutorials/haproxy-load-balancer-centos/

创建 /data/haproxy 后 依次执行如下命令

sudo yum info haproxy

sudo yum install gcc pcre-static pcre-devel -y

wget https://www.haproxy.org/download/1.8/src/haproxy-1.8.15.tar.gz -O /data/haproxy/haproxy-1.8.15.tar.gz

tar xzvf /data/haproxy/haproxy-1.8.15.tar.gz -C /data/haproxy/

cd /data/haproxy/haproxy-1.8.15

make TARGET=linux2628

sudo make install
配置
参考 https://upcloud.com/community/tutorials/haproxy-load-balancer-centos/

依次执行如下命令

sudo mkdir -p /etc/haproxy

sudo mkdir -p /var/lib/haproxy

sudo touch /var/lib/haproxy/stats

sudo ln -s /usr/local/sbin/haproxy /usr/sbin/haproxy

sudo cp /data/haproxy/haproxy-1.8.15/examples/haproxy.init /etc/init.d/haproxy

sudo chmod 755 /etc/init.d/haproxy

sudo systemctl daemon-reload

sudo chkconfig haproxy on

sudo useradd -r haproxy

haproxy -v


创建文件 /etc/haproxy/haproxy.cfg 用于配置负载均衡



TCP长连接负载均衡
参考

https://ryanclouser.com/2015/10/30/haproxy-Basic-TCP-Proxy/

https://stackoverflow.com/questions/39016291/haproxy-loadbalancing-tcp-traffic

https://upcloud.com/community/tutorials/haproxy-load-balancer-centos/



修改 /etc/haproxy/haproxy.cfg 内容后 需要执行以下命令 使其生效

sudo systemctl daemon-reload

sudo chkconfig haproxy on


/etc/haproxy/haproxy.cfg 内容如下

###########全局配置#########
global
    chroot /var/lib/haproxy
    daemon
    nbproc 1
    group haproxy
    user haproxy
    #pidfile /opt/haproxy/logs/haproxy.pid
    ulimit-n 65536
    #spread-checks 5m
    #stats timeout 5m
    #stats maxconn 100
 
########默认配置############
defaults
    mode tcp               #默认的模式mode { tcp|http|health }，tcp是4层，http是7层，health只会返回OK
    retries 3              #两次连接失败就认为是服务器不可用，也可以通过后面设置
    option redispatch      #当serverId对应的服务器挂掉后，强制定向到其他健康的服务器
    option abortonclose    #当服务器负载很高的时候，自动结束掉当前队列处理比较久的链接
    #maxconn 32000          #默认的最大连接数
    timeout connect 5000ms #连接超时
    timeout client 30000ms #客户端超时
    timeout server 30000ms #服务器超时
    #timeout check 2000    #心跳检测超
    log 127.0.0.1 local0 info
 
########test1配置#################
listen sserver
    bind 0.0.0.0:8888
    mode tcp
    balance roundrobin
    # server server_1319 218.3.146.108:8889 weight 1 check
    # server server_189 101.89.149.217:8888 weight 1 check
    server server_haikang 47.99.130.151:8888 weight 1 check
 
########test2配置#################
#listen test2
 #   bind 0.0.0.0:8007
  #  mode tcp
 #   balance roundrobin
#    server s1 192.168.1.88:8888 weight 1 check inter 10s
#    server s2 192.168.1.88:8888 weight 1 check inter 10s
########统计页面配置########
listen admin_stats
    bind 0.0.0.0:7618 #监听端口
    mode http         #http的7层模式
    option httplog    #采用http日志格式
    #log 127.0.0.1 local0 err
    maxconn 10
    stats refresh 30s #统计页面自动刷新时间
    stats uri /stats  #</span><span style="color:#ff0000;"><strong>统计页面url:port/stats</strong></span><pre name="code" class="cpp" style="color: rgb(80, 80, 80); font-size: 14px; line-height: 28px;"><span style="font-family: 宋体, 'Arial Narrow', arial, serif;">stats realm XingCloud\ Haproxy #统计页面密码框上提示文本</span>


开启日志
参考 https://www.cnblogs.com/yangxiaoyi/p/6919163.html

创建记录日志文件
mkdir /var/log/haproxy
chmod a+w /var/log/haproxy
开启rsyslog记录haproxy日志功能
# 编辑“/etc/rsyslog.conf”打开如下配置项：
# Provides UDP syslog reception
$ModLoad imudp
$UDPServerRun 514

# 添加如下内容：
# Save haproxy log
local0.* /var/log/haproxy/haproxy.log
修改“/etc/sysconfig/rsyslog”文件，内容如下
# Options for rsyslogd
# Syslogd options are deprecated since rsyslog v3.
# If you want to use them, switch to compatibility mode 2 by "-c 2"
# See rsyslogd(8) for more details
SYSLOGD_OPTIONS="-r -m 0 -c 2"
配置haproxy
log 127.0.0.1 local0 info
重启服务
systemctl restart haproxy
service rsyslog restart






重启
sudo systemctl restart haproxy
Centos7 防火墙
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-port=8888/tcp
sudo firewall-cmd --reload


