# dbhealthcheck
  A SQL Scripts to check oracle db.
  
  ### PS：这只是个脚本的DEMO,有需要的可以自己对脚本进行扩展，我后期也会慢慢进行扩展，逐渐将其丰富起来，有问题和好的建议，也请欢迎咨询我。
  
# examples
## 1、准备工作


## 2、执行脚本
```
chown -R oracle:oinstall  db_health_check.sql
chmod +x  db_health_check.sql 
su - oracle 

$ sqlplus / as sysdba
SQL*Plus: Release 11.2.0.3.0 Production on Wed May 3 18:00:45 2017

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> @db_health_check.sql


```


## 3、示例图片：
![image](https://github.com/DragonWujj/dbhealthcheck/blob/master/examples.png)


## 4、联系方式
#####电子邮箱：997702411@qq.com
#####QQ号：997702411（水平欠佳）
#####微信号：
![image](https://github.com/DragonWujj/dbhealthcheck/blob/master/weixin.jpg)

