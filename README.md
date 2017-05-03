# dbhealthcheck
  A SQL Scripts to check oracle db.
  
# examples
## 1、执行脚本
```
 chown -R oracle:oinstall  db_health_check.sql <br>
 chmod +x  db_health_check.sql <br>
 su - oracle <br>
$ sqlplus / as sysdba
SQL*Plus: Release 11.2.0.3.0 Production on Wed May 3 18:00:45 2017

Copyright (c) 1982, 2011, Oracle.  All rights reserved.


Connected to:
Oracle Database 11g Enterprise Edition Release 11.2.0.3.0 - 64bit Production
With the Partitioning, OLAP, Data Mining and Real Application Testing options

SQL> @db_health_check.sql

···


## 2、示例图片：
![image](https://github.com/DragonWujj/dbhealthcheck/blob/master/examples.png)


