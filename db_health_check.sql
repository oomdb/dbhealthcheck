Rem 
Rem    脚本名称： 
Rem        db_health_check.sql
Rem
Rem    脚本说明：
Rem        To check the db health,need have the select_catalog privileges.
Rem
Rem    联系方式：
Rem        Author：Created by wujianjian
Rem        Email：997702411@qq.com
Rem        Job：Oracle/MySQL DBA
Rem


PRO
PRO
PRO
PRO                          DB HEALTH CHECK 
PRO                           
PRO
PRO
PRO
PRO
PRO

set echo off verify off timing off feedback off trimspool on trimout on
set long 1000000 pagesize 0 linesize 200


SPO db_health_check.html;
PRO <!DOCTYPE html> 
PRO <html>
PRO <head>
PRO     <meta charset="utf-8">
PRO     <style type='text/css'> 
PRO         table
PRO             { font:9pt Arial,Helvetica,sans-serif; color:Black; background:#FFFFCC; padding:0px 0px 0px 0px; margin:0px 0px 0px 0px; border-collapse:collapse; } 
PRO     </style>
PRO     <title>Oracle数据库巡检报告</title>  
PRO </head>
PRO <body>
PRO     <div id="title" style="margin-top:30px;color:#FFA500;text-align:center;"><b><h1>数据库巡检报告</h1></b></div><hr>

PRO <br>
PRO <br/>
PRO <br>

PRO
PRO <div id="items">    
PRO     <table width="100%" border="1">
PRO
PRO     <thead><tr>
PRO         <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库系统</b></font></td>
PRO         <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库概况</b></font></td>
PRO         <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库对象</b></font></td>
PRO         <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库性能</b></font></td>
PRO         <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库安全</b></font></td>
PRO         <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库高可用</b></font></td>
PRO     </tr></thead>
PRO

PRO <tr>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(instanceinfo);" onblur="Hideinfo(instanceinfo)" ><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">实例基本状况</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(redocontent);" onblur="Hideinfo(redocontent)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">日志组信息</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(partition_cnt);" onblur="Hideinfo(partition_cnt)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">分区最多的前20个对象</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(tab_stats_info);" onblur="Hideinfo(tab_stats_info)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">统计信息过期(表)</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(userinfo);" onblur="Hideinfo(userinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">非系统用户信息</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(rman_backup_result);" onblur="Hideinfo(rman_backup_result)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">RMAN备份状况</font></a></td>
PRO </tr>
PRO

PRO <tr>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;"  onclick="ShowInfo(dbinfo);" onblur="Hideinfo(dbinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">库基本状况</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(tbsinfo);" onblur="Hideinfo(tbsinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">表空间信息</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(fk_unindex);" onblur="Hideinfo(fk_unindex)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">外键未建索引的表</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(ind_stats_info);" onblur="Hideinfo(ind_stats_info)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">统计信息过期(索引)</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(dba_priv_user);" onblur="Hideinfo(dba_priv_user)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">拥有DBA权限的用户</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(rman_configure);" onblur="Hideinfo(rman_configure)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">RMAN非默认配置</font></a></td>
PRO </tr>
PRO

PRO <tr>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(database_characterset);" onblur="Hideinfo(database_characterset)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">数据库字符集</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(diskgroup_info);" onblur="Hideinfo(diskgroup_info)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">磁盘组信息</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(tab_column_cnt);" onblur="Hideinfo(tab_column_cnt)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">列数大于40的表</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(tab_ind_degree);" onblur="Hideinfo(tab_ind_degree)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">并发数大于1对象</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(user_priv_info);" onblur="Hideinfo(user_priv_info)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">业务用户权限</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(adg_configure);" onblur="Hideinfo(adg_configure)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">ADG基本配置</font></a></td>
PRO </tr>
PRO  

PRO <tr>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(alert_log_info);" onblur="Hideinfo(alert_log_info)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">Alert日志告警信息</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(data_files);" onblur="Hideinfo(data_files)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">数据文件自动扩展</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(no_partitioned_table);" onblur="Hideinfo(no_partitioned_table)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">超过2G未分区的表</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(log_switchs);" onblur="Hideinfo(log_switchs)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">日志切换情况</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(user_info);" onblur="Hideinfo(user_info)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">用户信息</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>
PRO

PRO <tr>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(init_parameter);" onblur="Hideinfo(init_parameter)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">初始化参数</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(db_size);" onblur="Hideinfo(db_size)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">数据库大小</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(no_pk_tables);" onblur="Hideinfo(no_pk_tables)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">没有主键的表</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(auto_gather_statistics);" onblur="Hideinfo(auto_gather_statistics)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">统计信息是否自动收集</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(patch_applied);" onblur="Hideinfo(patch_applied)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">是否已打补丁</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>
PRO




                                                                                                                                       
      
PRO <tr>                                                                                                                                             
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(db_files);" onblur="Hideinfo(db_files)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">数据文件情况</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(lob_segments);" onblur="Hideinfo(lob_segments)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">LOB段</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(job_status);" onblur="Hideinfo(job_status)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">JOB运行情况</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(objects_on_system_tablespace);" onblur="Hideinfo(objects_on_system_tablespace)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">系统表空间上的用户对象</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>                                                                                                                                            
PRO      


PRO <tr>                                                                                                                                             
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(partition_table_global_index);" onblur="Hideinfo(partition_table_global_index)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">分区表GLOBAL索引</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(row_chain);" onblur="Hideinfo(row_chain)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">有行迁移行链接的表</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(top10_logic_reads_sql);" onblur="Hideinfo(top10_logic_reads_sql)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">逻辑读TOP10的SQL</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(SCN_headroom);" onblur="Hideinfo(SCN_headroom)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">数据库SCN_headroom检查</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>                                                                                                                                            
PRO      


PRO <tr>                                                                                                                                             
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo();" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"></font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(invilidate_objects);" onblur="Hideinfo(invilidate_objects)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">失效对象</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(top10_physical_reads_sql);" onblur="Hideinfo(top10_physical_reads_sql)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">物理读TOP10的SQL</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo();" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"></font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>                                                                                                                                            
PRO      


PRO <tr>                                                                                                                                             
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(index_pct);" onblur="Hideinfo(index_pct)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">索引与列比例</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(top10_sorts_sql);" onblur="Hideinfo(top10_sorts_sql)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">排序最多的10个SQL</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo();" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"></font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo()"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>                                                                                                                                            
PRO      





PRO <tr>                                                                                                                                             
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(bitmap_function_index);" onblur="Hideinfo(bitmap_function_index)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">位图索引和函数索引</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(sql_time_top10);" onblur="Hideinfo(sql_time_top10)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">执行时间TOP10的SQL</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>                                                                                                                                            
PRO      



PRO <tr>                                                                                                                                             
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(cache_lt_100);" onblur="Hideinfo(cache_lt_100)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">cache小于100的序列</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(lock_info);" onblur="Hideinfo(lock_info)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">锁情况</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>                                                                                                                                            
PRO    








PRO <tr>                                                                                                                                             
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(db_links);" onblur="Hideinfo(db_links)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">数据库链路</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(shared_memory_used);" onblur="Hideinfo(shared_memory_used)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">共享内存使用率</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>                                                                                                                                            
PRO  

PRO <tr>                                                                                                                                             
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(no_used_index);" onblur="Hideinfo(no_used_index)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">未使用的索引</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(hit_info);" onblur="Hideinfo(hit_info)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">命中率</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>                                                                                                                                            
PRO  






PRO <tr>                                                                                                                                             
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(partition_high_value);" onblur="Hideinfo(partition_high_value)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">分区最大值</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(wait_events_info);" onblur="Hideinfo(wait_events_info)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">等待事件</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo( );" onblur="Hideinfo(instanceinfo)"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699"> </font></a></td>
PRO </tr>                                                                                                                                            
PRO  



Rem
Rem ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 具体SQL语句实现 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Rem

PRO </table>
PRO </div>
PRO 

PRO <br>
PRO <br>
PRO <br>
PRO <hr>

-- Instance 
PRO <div id="instanceinfo" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库实例名称</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库实例号</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>线程号</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>主机名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库版本</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>实例启动时间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>运行时间(天)</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>RAC模式</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>实例状态</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>是否可登陆</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>是否可归档</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INSTANCE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INSTANCE_NUMBER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||THREAD#||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||HOST_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||VERSION||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STARTUP_TIME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||ROUND((SYSDATE - STARTUP_TIME),2)||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||(CASE WHEN (COUNT(*) OVER())>=2 THEN 'YES' ELSE 'NO' END)||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STATUS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LOGINS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||ARCHIVER||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM GV$INSTANCE
 ORDER BY INSTANCE_NUMBER;


PRO
PRO </table>
PRO </div>


-- DBINFO
PRO <div id="dbinfo" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>DBID</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>库Unique Name</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>创建时间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>平台名称</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>日志模式</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>库打开模式</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>强制Logging</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>闪回</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>控制文件状态</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>库角色</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>保护模式</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>切换状态</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>DG Broker</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>最小补充日志</b></font></td>
PRO </tr>


SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DBID||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DB_UNIQUE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CREATED||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PLATFORM_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LOG_MODE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OPEN_MODE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||FORCE_LOGGING||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||FLASHBACK_ON||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CONTROLFILE_TYPE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DATABASE_ROLE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PROTECTION_MODE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SWITCHOVER_STATUS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DATAGUARD_BROKER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SUPPLEMENTAL_LOG_DATA_MIN||'</font></td>'||CHR(10)||
			  '</tr>'
  FROM V$DATABASE;


PRO
PRO </table>
PRO </div>

-- Redo logs
PRO <div id="redocontent" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>组号</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>线程号</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>序列号</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>日志状态</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>是否归档</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>文件状态</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>日志成员</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>日志成员个数</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>日志大小(单位:G)</b></font></td>
PRO </tr>

PRO <!-- Please Wait -->
SELECT CHR(10)||'<tr>'||CHR(10)||
'<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LF.GROUP#||'</font></td>'||CHR(10)||
'<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||L.THREAD#||'</font></td>'||CHR(10)||
'<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||L.SEQUENCE#||'</font></td>'||CHR(10)||
'<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||L.STATUS||'</font></td>'||CHR(10)||
'<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||L.ARCHIVED||'</font></td>'||CHR(10)||
'<td class="r "nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LF.TYPE||'</font></td>'||CHR(10)||
'<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LF.MEMBER||'</font></td>'||CHR(10)||
'<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||L.MEMBERS||'</font></td>'||CHR(10)||
'<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||L.BYTES/1024/1024||'</font></td>'||CHR(10)||
'</tr>'
  FROM V$LOGFILE LF
  LEFT JOIN V$LOG L
    ON (LF.GROUP# = L.GROUP#)
ORDER BY LF.GROUP#;

PRO
PRO </table>
PRO </div>



-- Tbsinfo
PRO <div id="tbsinfo" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表空间名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>状态</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>类型</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>段管理方式</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>段空间管理方式</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表空间大小(G)</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>已使用空间(G)</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>空闲空间(G)</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>使用百分比(%)</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLESPACE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STATUS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CONTENTS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||EXTENT_MANAGEMENT||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SEGMENT_SPACE_MANAGEMENT||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TOT_GROOTTE_GB||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||USED_GB||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TOTAL_BYTES||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TBS_RATIO||'</font></td>'||CHR(10)||
       '</tr>'
FROM (SELECT   A.TABLESPACE_NAME,
               A.STATUS,
               A.CONTENTS,
               A.EXTENT_MANAGEMENT,
               A.SEGMENT_SPACE_MANAGEMENT,
               D.TOT_GROOTTE_GB,
               (D.TOT_GROOTTE_GB - F.TOTAL_BYTES) AS USED_GB,
               F.TOTAL_BYTES,
               ROUND(((D.TOT_GROOTTE_GB - F.TOTAL_BYTES) / D.TOT_GROOTTE_GB) * 100, 2) AS TBS_RATIO
          FROM (SELECT TABLESPACE_NAME,
                       ROUND((SUM(BYTES) /1024 / 1024 / 1024), 2) TOTAL_BYTES,
                       ROUND((MAX(BYTES) /1024 / 1024 / 1024), 2) MAX_BYTES
                  FROM SYS.DBA_FREE_SPACE
                 GROUP BY TABLESPACE_NAME) F,
               (SELECT DD.TABLESPACE_NAME,
                       ROUND((SUM(DD.BYTES) /1024 / 1024 / 1024), 2) TOT_GROOTTE_GB
                  FROM SYS.DBA_DATA_FILES DD
                 GROUP BY DD.TABLESPACE_NAME) D,
               DBA_TABLESPACES A
         WHERE D.TABLESPACE_NAME = F.TABLESPACE_NAME
           AND A.TABLESPACE_NAME = D.TABLESPACE_NAME
           AND A.TABLESPACE_NAME = F.TABLESPACE_NAME)
 ORDER BY TBS_RATIO DESC;


PRO
PRO </table>
PRO </div>


-- partition cnt 
PRO <div id="partition_cnt" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>编号</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>分区表名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>分区个数</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td  class="r"  nowrap=""  style="background-color:#FFCC00"   align="center"  width="18%"><font  size=+1  face="Arial,Helvetica,sans-serif"  color="#336699">'||RN||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CNT||'</font></td>'||CHR(10)||
       '</tr>'
        FROM (SELECT TABLE_OWNER, TABLE_NAME, CNT,RN
          FROM (SELECT A.TABLE_OWNER, A.TABLE_NAME, A.CNT, ROWNUM RN
                  FROM (SELECT TABLE_OWNER,
                               TABLE_NAME,
                               COUNT(PARTITION_NAME) CNT
                          FROM DBA_TAB_PARTITIONS
                         GROUP BY TABLE_OWNER, TABLE_NAME
                         ORDER BY CNT DESC) A)
         WHERE ROWNUM <= 20)
 WHERE RN >= 0;

PRO
PRO </table>
PRO </div>

-- FK without index
PRO <div id="fk_unindex" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>列名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>外键约束名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>状态</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||C.OWNER||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||C.TABLE_NAME||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CC.COLUMN_NAME||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||C.CONSTRAINT_NAME||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||C.STATUS||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM DBA_CONSTRAINTS C, DBA_CONS_COLUMNS CC
 WHERE C.CONSTRAINT_TYPE = 'R'
   AND C.OWNER NOT IN ('SYS',
                       'SYSTEM',
                       'SYSMAN',
                       'EXFSYS',
                       'WMSYS',
                       'OLAPSYS',
                       'OUTLN',
                       'DBSNMP',
                       'ORDSYS',
                       'ORDPLUGINS',
                       'MDSYS',
                       'CTXSYS',
                       'AURORA$ORB$UNAUTHENTICATED',
                       'XDB',
                       'FLOWS_030000',
                       'FLOWS_FILES')
   AND C.OWNER = CC.OWNER
   AND C.CONSTRAINT_NAME = CC.CONSTRAINT_NAME
   AND NOT EXISTS
 (SELECT 'x'
          FROM DBA_IND_COLUMNS IC
         WHERE CC.OWNER = IC.TABLE_OWNER
           AND CC.TABLE_NAME = IC.TABLE_NAME
           AND CC.COLUMN_NAME = IC.COLUMN_NAME
           AND CC.POSITION = IC.COLUMN_POSITION
           AND NOT EXISTS
         (SELECT OWNER, INDEX_NAME
                  FROM DBA_INDEXES I
                 WHERE I.TABLE_OWNER = C.OWNER
                   AND I.INDEX_NAME = IC.INDEX_NAME
                   AND I.OWNER = IC.INDEX_OWNER
                   AND (I.STATUS = 'UNUSABLE' OR
                       I.PARTITIONED = 'YES' AND EXISTS
                        (SELECT 'x'
                           FROM DBA_IND_PARTITIONS IP
                          WHERE STATUS = 'UNUSABLE'
                            AND IP. INDEX_OWNER = I. OWNER
                            AND IP. INDEX_NAME = I. INDEX_NAME
                         UNION ALL
                         SELECT 'x'
                           FROM DBA_IND_SUBPARTITIONS ISP
                          WHERE STATUS = 'UNUSABLE'
                            AND ISP. INDEX_OWNER = I. OWNER
                            AND ISP. INDEX_NAME = I. INDEX_NAME))))
 ORDER BY C.OWNER, C.TABLE_NAME;


PRO
PRO </table>
PRO </div>

-- TABLE STATISTICS INFO
PRO <div id="tab_stats_info" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>对象类型</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>最后分析时间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>统计信息状态</b></font></td>
PRO </tr>

EXEC DBMS_STATS.FLUSH_DATABASE_MONITORING_INFO; 
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OBJECT_TYPE||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LAST_ANALYZED||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STALE_STATS||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM (SELECT DISTINCT OWNER,
                        TABLE_NAME,
                        OBJECT_TYPE,
                        LAST_ANALYZED,
                        STALE_STATS
          FROM DBA_TAB_STATISTICS
         WHERE (STALE_STATS = 'YES' OR LAST_ANALYZED IS NULL)
           AND OWNER NOT IN ('SCOTT',
                             'SYSMAN',
                             'SYSTEM',
                             'SYS',
                             'MGMT_VIEW',
                             'DBSNMP',
                             'SPATIAL_WFS_ADMIN_USR',
                             'HR',
                             'DIP',
                             'SH',
                             'IX',
                             'MDDATA',
                             'ORACLE_OCM',
                             'SPATIAL_CSW_ADMIN_USR',
                             'APEX_PUBLIC_USER',
                             'OE',
                             'PM',
                             'BI',
                             'XS$NULL',
                             'OLAPSYS',
                             'OWBSYS',
                             'ORDPLUGINS',
                             'XDB',
                             'OWBSYS_AUDIT',
                             'APEX_030200',
                             'APPQOSSYS',
                             'EXFSYS',
                             'ORDSYS',
                             'SI_INFORMTN_SCHEMA',
                             'ANONYMOUS',
                             'CTXSYS',
                             'ORDDATA',
                             'WMSYS',
                             'MDSYS',
                             'FLOWS_FILES',
                             'OUTLN'))
 ORDER BY OWNER, OBJECT_TYPE;



PRO
PRO </table>
PRO </div>



-- INDEX STATISTICS INFO
PRO <div id="ind_stats_info" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>索引名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>对象类型</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>最后分析时间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>统计信息状态</b></font></td>
PRO </tr>

EXEC DBMS_STATS.FLUSH_DATABASE_MONITORING_INFO;
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INDEX_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OBJECT_TYPE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LAST_ANALYZED||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STALE_STATS||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM (SELECT DISTINCT OWNER,
                        INDEX_NAME,
                        TABLE_NAME,
                        OBJECT_TYPE,
                        LAST_ANALYZED,
                        STALE_STATS
          FROM DBA_IND_STATISTICS
         WHERE (STALE_STATS = 'YES' OR LAST_ANALYZED IS NULL)
           AND OWNER NOT IN ('SCOTT',
                             'SYSMAN',
                             'SYSTEM',
                             'SYS',
                             'MGMT_VIEW',
                             'DBSNMP',
                             'SPATIAL_WFS_ADMIN_USR',
                             'HR',
                             'DIP',
                             'SH',
                             'IX',
                             'MDDATA',
                             'ORACLE_OCM',
                             'SPATIAL_CSW_ADMIN_USR',
                             'APEX_PUBLIC_USER',
                             'OE',
                             'PM',
                             'BI',
                             'XS$NULL',
                             'OLAPSYS',
                             'OWBSYS',
                             'ORDPLUGINS',
                             'XDB',
                             'OWBSYS_AUDIT',
                             'APEX_030200',
                             'APPQOSSYS',
                             'EXFSYS',
                             'ORDSYS',
                             'SI_INFORMTN_SCHEMA',
                             'ANONYMOUS',
                             'CTXSYS',
                             'ORDDATA',
                             'WMSYS',
                             'MDSYS',
                             'FLOWS_FILES',
                             'OUTLN'))
 ORDER BY OWNER, OBJECT_TYPE, TABLE_NAME;


PRO
PRO </table>
PRO </div>


-- Userinfo
PRO <div id="userinfo" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>账户状态</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>默认表空间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>临时表空间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>创建时间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>锁定时间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>过期时间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>概要文件</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||USERNAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||ACCOUNT_STATUS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DEFAULT_TABLESPACE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TEMPORARY_TABLESPACE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CREATED||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LOCK_DATE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||EXPIRY_DATE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PROFILE||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM DBA_USERS
 WHERE USERNAME NOT IN ('SCOTT',
                        'SYSMAN',
                        'SYSTEM',
                        'SYS',
                        'MGMT_VIEW',
                        'DBSNMP',
                        'SPATIAL_WFS_ADMIN_USR',
                        'HR',
                        'DIP',
                        'SH',
                        'IX',
                        'MDDATA',
                        'ORACLE_OCM',
                        'SPATIAL_CSW_ADMIN_USR',
                        'APEX_PUBLIC_USER',
                        'OE',
                        'PM',
                        'BI',
                        'XS$NULL',
                        'OLAPSYS',
                        'OWBSYS',
                        'ORDPLUGINS',
                        'XDB',
                        'OWBSYS_AUDIT',
                        'APEX_030200',
                        'APPQOSSYS',
                        'EXFSYS',
                        'ORDSYS',
                        'SI_INFORMTN_SCHEMA',
                        'ANONYMOUS',
                        'CTXSYS',
                        'ORDDATA',
                        'WMSYS',
                        'MDSYS',
                        'FLOWS_FILES',
                        'OUTLN');


PRO
PRO </table>
PRO </div>


-- DBA PRIVILEGES USER
PRO <div id="dba_priv_user" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>DBA权限角色</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>级联赋权</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>默认角色</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||GRANTEE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||GRANTED_ROLE||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||ADMIN_OPTION||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DEFAULT_ROLE||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM DBA_ROLE_PRIVS
 WHERE GRANTED_ROLE = 'DBA';


PRO
PRO </table>
PRO </div>

-- RMAN BACKUP RESULT
PRO <div id="rman_backup_result" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>备份ID</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>开始时间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>结束时间</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>备份介质</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>备份状态</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>输入类型</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>输入大小</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>输出大小</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>备份时间</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SESSION_RECID||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||START_TIME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||END_TIME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OUTPUT_DEVICE_TYPE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STATUS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INPUT_TYPE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INPUT_BYTES_DISPLAY||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OUTPUT_BYTES_DISPLAY||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TIME_TAKEN_DISPLAY||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM (SELECT SESSION_RECID,
               START_TIME,
               END_TIME,
               OUTPUT_DEVICE_TYPE,
               STATUS,
               INPUT_TYPE,
               INPUT_BYTES_DISPLAY,
               OUTPUT_BYTES_DISPLAY,
               TIME_TAKEN_DISPLAY,
               RN
          FROM (SELECT TEMP.*, ROWNUM RN
                  FROM (SELECT SESSION_RECID,
                               START_TIME,
                               END_TIME,
                               OUTPUT_DEVICE_TYPE,
                               STATUS,
                               INPUT_TYPE,
                               INPUT_BYTES_DISPLAY,
                               OUTPUT_BYTES_DISPLAY,
                               TIME_TAKEN_DISPLAY
                          FROM V$RMAN_BACKUP_JOB_DETAILS
                         ORDER BY START_TIME DESC) TEMP)
         WHERE ROWNUM <= 7)
 WHERE RN >= 0;


PRO
PRO </table>
PRO </div>

-- RMAN CONFIGURE
PRO <div id="rman_configure" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>编号</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>名称</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>设定值</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)|| 
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CONF#||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||NAME||'</font></td>'||CHR(10)||
		   '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||VALUE||'</font></td>'||CHR(10)|| 
			 '</tr>'
  FROM V$RMAN_CONFIGURATION;


PRO
PRO </table>
PRO </div>

-- DATABASE CHARACTERSET
PRO <div id="database_characterset" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>参数名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>值</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PARAMETER||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||VALUE||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM NLS_DATABASE_PARAMETERS
 WHERE PARAMETER IN ('NLS_LANGUAGE',
                     'NLS_TERRITORY',
                     'NLS_CURRENCY',
                     'NLS_NUMERIC_CHARACTERS',
                     'NLS_CHARACTERSET',
                     'NLS_DATE_FORMAT',
                     'NLS_DATE_LANGUAGE',
                     'NLS_SORT',
                     'NLS_TIMESTAMP_FORMAT',
                     'NLS_COMP',
                     'NLS_NCHAR_CHARACTERSET',
                     'NLS_RDBMS_VERSION');


PRO
PRO </table>
PRO </div>



-- DISKGROUP INFO
PRO <div id="diskgroup_info" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>编号</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>名称</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>状态</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>冗余</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>总量</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>剩余量</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>百分比(单位:%)</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||GROUP_NUMBER||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||NAME||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STATE||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TYPE||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TOTAL_GB||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||FREE_GB||'</font></td>'||CHR(10)|| 
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PERCENT||'</font></td>'||CHR(10)||
			  '</tr>'
  FROM (SELECT GROUP_NUMBER,
               NAME,
               STATE,
               TYPE,
               TOTAL_MB / 1024 AS TOTAL_GB,
               FREE_MB / 1024 AS FREE_GB,
               ROUND((TOTAL_MB - FREE_MB) / TOTAL_MB * 100,2) AS PERCENT
          FROM V$ASM_DISKGROUP)
 ORDER BY GROUP_NUMBER;


PRO
PRO </table>
PRO </div>
        

-- TABLE COLUMN COUNT
PRO <div id="tab_column_cnt" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>列数</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
        '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
			  '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
			  '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||COUNT(COLUMN_NAME)||'</font></td>'||CHR(10)||
				'</tr>'
  FROM DBA_TAB_COLUMNS
 WHERE OWNER NOT IN ('SCOTT',
                     'SYSMAN',
                     'SYSTEM',
                     'SYS',
                     'MGMT_VIEW',
                     'DBSNMP',
                     'SPATIAL_WFS_ADMIN_USR',
                     'HR',
                     'DIP',
                     'SH',
                     'IX',
                     'MDDATA',
                     'ORACLE_OCM',
                     'SPATIAL_CSW_ADMIN_USR',
                     'APEX_PUBLIC_USER',
                     'OE',
                     'PM',
                     'BI',
                     'XS$NULL',
                     'OLAPSYS',
                     'OWBSYS',
                     'ORDPLUGINS',
                     'XDB',
                     'OWBSYS_AUDIT',
                     'APEX_030200',
                     'APPQOSSYS',
                     'EXFSYS',
                     'ORDSYS',
                     'SI_INFORMTN_SCHEMA',
                     'ANONYMOUS',
                     'CTXSYS',
                     'ORDDATA',
                     'WMSYS',
                     'MDSYS',
                     'FLOWS_FILES',
                     'OUTLN')
 GROUP BY OWNER, TABLE_NAME
HAVING COUNT(COLUMN_NAME) >= 40
ORDER BY COUNT(COLUMN_NAME) DESC,OWNER, TABLE_NAME;

PRO
PRO </table>
PRO </div>


-- TABLE INDEX DEGREE
PRO <div id="tab_ind_degree" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>索引名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表用户名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>索引并行度</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表并行度</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||I.OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||I.INDEX_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||I.TABLE_OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||I.TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||I.DEGREE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||T.DEGREE||'</font></td>'||CHR(10)||
			  '</tr>'
  FROM (SELECT OWNER, INDEX_NAME, TABLE_OWNER, TABLE_NAME, DEGREE
          FROM DBA_INDEXES
         WHERE DEGREE > '1') I
  LEFT JOIN (SELECT OWNER, TABLE_NAME, STATUS, DEGREE
               FROM DBA_TABLES
              WHERE DEGREE > '1') T
    ON (I.TABLE_OWNER = T.OWNER AND I.TABLE_NAME = T.TABLE_NAME);

PRO
PRO </table>
PRO </div>


-- USER PRIVILEGES
PRO <div id="user_priv_info" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>系统权限</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>对象权限</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>级联赋权</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>默认角色</b></font></td>
PRO </tr>


WITH TAB_UANME AS
 (SELECT /*+ materialize */
   USERNAME
    FROM DBA_USERS
   WHERE USERNAME NOT IN ('SCOTT',
                          'SYSMAN',
                          'SYSTEM',
                          'SYS',
                          'MGMT_VIEW',
                          'DBSNMP',
                          'SPATIAL_WFS_ADMIN_USR',
                          'HR',
                          'DIP',
                          'SH',
                          'IX',
                          'MDDATA',
                          'ORACLE_OCM',
                          'SPATIAL_CSW_ADMIN_USR',
                          'APEX_PUBLIC_USER',
                          'OE',
                          'PM',
                          'BI',
                          'XS$NULL',
                          'OLAPSYS',
                          'OWBSYS',
                          'ORDPLUGINS',
                          'XDB',
                          'OWBSYS_AUDIT',
                          'APEX_030200',
                          'APPQOSSYS',
                          'EXFSYS',
                          'ORDSYS',
                          'SI_INFORMTN_SCHEMA',
                          'ANONYMOUS',
                          'CTXSYS',
                          'ORDDATA',
                          'WMSYS',
                          'MDSYS',
                          'FLOWS_FILES',
                          'OUTLN',
                          'APP_TEST')
     AND ACCOUNT_STATUS = 'OPEN'),
TEMP AS
 (SELECT GRANTEE,
         DBMS_LOB.SUBSTR(STRAGG(PRIVILEGE)) AS SYS_PRIV,
         NULL AS OBJ_PRIV,
         ADMIN_OPTION,
         NULL AS DEFAULT_ROLE
    FROM DBA_SYS_PRIVS
   WHERE GRANTEE IN (SELECT USERNAME FROM TAB_UANME)
   GROUP BY GRANTEE, ADMIN_OPTION
  UNION ALL
  SELECT GRANTEE,
         DBMS_LOB.SUBSTR(STRAGG(GRANTED_ROLE)),
         NULL,
         ADMIN_OPTION,
         DEFAULT_ROLE
    FROM DBA_ROLE_PRIVS
   WHERE GRANTEE IN (SELECT USERNAME FROM TAB_UANME)
   GROUP BY GRANTEE, ADMIN_OPTION, DEFAULT_ROLE
  UNION ALL
  SELECT GRANTEE,
         PRIV,
         DBMS_LOB.SUBSTR(STRAGG(OBJ)) AS OBJ,
         NULL,
         NULL
    FROM (SELECT GRANTEE,
                 OWNER || '.' || TABLE_NAME AS OBJ,
                 DBMS_LOB.SUBSTR(STRAGG(PRIVILEGE)) AS PRIV
            FROM DBA_TAB_PRIVS
           WHERE GRANTEE IN (SELECT USERNAME FROM TAB_UANME)
           GROUP BY GRANTEE, OWNER || '.' || TABLE_NAME)
   GROUP BY GRANTEE, PRIV)
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||GRANTEE||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SYS_PRIV||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OBJ_PRIV||'</font></td>'||CHR(10)|| 
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||ADMIN_OPTION||'</font></td>'||CHR(10)|| 
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DEFAULT_ROLE||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM TEMP
 ORDER BY GRANTEE;

PRO
PRO </table>
PRO </div>

-- ADG CONFIGURE INFO
PRO <div id="adg_configure" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>参数值</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>值</b></font></td>
PRO </tr>

SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||NAME||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||VALUE||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM V$PARAMETER
 WHERE NAME IN ('db_name',
                'db_unique_name',
                'log_archive_config',
                'log_archive_dest_1',
                'log_archive_dest_2',
                'log_archive_dest_3',
                'log_archive_dest_state_1',
                'log_archive_dest_state_2',
                'log_archive_dest_state_3',
                'remote_login_passwordfile',
                'log_archive_format',
                'log_archive_max_processes',
                'fal_server',
                'fal_client',
                'db_file_name_convert',
                'log_file_name_convert',
                'standby_file_management');


PRO
PRO </table>
PRO </div>

-- ALERT LOG INFO
PRO <div id="alert_log_info" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>行号</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>日期</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>错误代码</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>信息内容</b></font></td>
PRO </tr>

col lineno noprint
col ora_error noprint
col msg_line format a132
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LINENO||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||THEDATE||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||ORA_ERROR||'</font></td>'||CHR(10)||
			 '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||MSG_LINE||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM (SELECT *
          FROM (SELECT LINENO,
                       MSG_LINE,
                       THEDATE,
                       MAX(CASE
                             WHEN (ORA_ERROR LIKE 'ORA-%' OR
                                  ORA_ERROR LIKE 'PLS-%') THEN
                              RTRIM(SUBSTR(ORA_ERROR, 1, INSTR(ORA_ERROR, ' ') - 1),
                                    ':')
                             ELSE
                              NULL
                           END) OVER(PARTITION BY THEDATE) ORA_ERROR
                  FROM (SELECT LINENO,
                               MSG_LINE,
                               MAX(THEDATE) OVER(ORDER BY LINENO) THEDATE,
                               LEAD(MSG_LINE) OVER(ORDER BY LINENO) ORA_ERROR
                          FROM (SELECT ROWNUM LINENO,
                                       SUBSTR(MSG_LINE, 1, 132) MSG_LINE,
                                       CASE
                                         WHEN MSG_LINE LIKE
                                              '___ ___ __ __:__:__ ____' THEN
                                          TO_DATE(MSG_LINE,
                                                  'Dy Mon DD hh24:mi:ss yyyy')
                                         ELSE
                                          NULL
                                       END THEDATE
                                  FROM ALERT_LOG_VIEW1))))
 WHERE ORA_ERROR IS NOT NULL
   AND THEDATE >= (TRUNC(SYSDATE) - 1)
 ORDER BY THEDATE;
clear breaks;


PRO
PRO </table>
PRO </div>


-- init_parameter INFO
PRO <div id="init_parameter" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>参数名</b></font></td>
PRO   <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>参数值</b></font></td>
PRO </tr>

col name noprint
col value noprint
col name  format a40
col value format a240
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||VALUE||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM (SELECT *
          FROM (
	SELECT NAME, VALUE
  	FROM V$PARAMETER
	 WHERE NAME IN ('cursor_sharing',
                'memory_target',
                'db_block_size',
                'log_archive_dest_1',
                'log_buffer',
                'open_cursors',
                'db_files',
                'pga_aggregate_target',
                'deferred_segment_creation',
                'processes',
                'audit_trail',
                'sessions',
                'sga_target')
 	UNION ALL
	SELECT 'FLASHBACK_ON',FLASHBACK_ON FROM V$DATABASE
 	UNION ALL
	SELECT 'SUPPLEMENTAL_LOG',SUPPLEMENTAL_LOG_DATA_MIN FROM V$DATABASE
	) );
clear breaks;


PRO
PRO </table>
PRO </div>





-- top20_tables INFO
PRO <div id="top20_tables" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO  <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO  <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO  <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表大小(G)</b></font></td>
PRO </tr>

col TABLE_OWNER noprint
col TABLE_NAME noprint
col TABLE_SIZE noprint
col TABLE_OWNER format a60
col TABLE_NAME format a60
col TABLE_SIZE format '99999999'
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_SIZE||'</font></td>'||CHR(10)||
			 '</tr>'
  FROM (SELECT *
          FROM (
		WITH TAB_USERS AS (SELECT USERNAME FROM DBA_USERS WHERE DEFAULT_TABLESPACE NOT IN ('USERS', 'GGS_DATA', 'SYSAUX', 'SYSTEM', 'GGS'))
		SELECT * FROM (SELECT A.TABLE_OWNER,A.TABLE_NAME,SUM(B.BYTES)/1024/1024/1024 TABLE_SIZE FROM 
		(SELECT TABLE_OWNER,TABLE_NAME,INDEX_NAME FROM DBA_INDEXES 
		WHERE OWNER IN (SELECT * FROM TAB_USERS)
		UNION ALL
		SELECT OWNER,TABLE_NAME,SEGMENT_NAME FROM DBA_LOBS 
		WHERE OWNER IN (SELECT * FROM TAB_USERS)
		union all
		select owner,table_name,table_name from dba_tables
		 WHERE OWNER IN (SELECT * FROM TAB_USERS)
		) A,DBA_SEGMENTS B
		WHERE A.INDEX_NAME=B.SEGMENT_NAME
		GROUP BY  A.TABLE_OWNER,A.TABLE_NAME
		ORDER BY  SUM(B.BYTES)/1024/1024/1024 DESC)
		WHERE ROWNUM<=20
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>





















-- resource_used INFO
PRO <div id="resource_used" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>资源名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>当前值</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>最大值</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>初始值</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>限制值</b></font></td>

PRO </tr>

col RESOURCE_NAME noprint
col CURRENT_UTILIZATION noprint
col MAX_UTILIZATION noprint
col INITIAL_ALLOCATION noprint
col LIMIT_VALUE noprint
col RESOURCE_NAME format a70
col CURRENT_UTILIZATION format a30
col MAX_UTILIZATION format a30
col INITIAL_ALLOCATION format a30
col LIMIT_VALUE format a30
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||RESOURCE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CURRENT_UTILIZATION||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||MAX_UTILIZATION||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INITIAL_ALLOCATION||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LIMIT_VALUE||'</font></td>'||CHR(10)||
	 '</tr>'
  FROM (SELECT *
          FROM (
		 select t.RESOURCE_NAME,t.CURRENT_UTILIZATION,t.MAX_UTILIZATION,t.INITIAL_ALLOCATION,t.LIMIT_VALUE from v$resource_limit t 
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>






-- SYS_ROLE_USER INFO
PRO <div id="SYS_ROLE_USER" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SYSDBA</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SYSOPER</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SYSASM</b></font></td>

PRO </tr>

col USERNAME noprint
col SYSDBA noprint
col SYSOPER noprint
col SYSASM noprint
col USERNAME format a50
col SYSDBA format a50
col SYSOPER format a50
col SYSASM format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||USERNAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SYSDBA||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SYSOPER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SYSASM||'</font></td>'||CHR(10)||
	'</tr>'
  FROM (SELECT *
          FROM (
		SELECT USERNAME,SYSDBA,SYSOPER,SYSASM FROM v$pwfile_users order by username
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>













-- data_files INFO
PRO <div id="data_files" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表空间名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>文件名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>文件大小(单位:G)</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>是否自动扩展</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>文件状态</b></font></td>
PRO </tr>

col TABLESPACE_NAME noprint
col FILE_NAME noprint
col FILE_SIZE noprint
col AUTOEXTENSIBLE noprint
col ONLINE_STATUS noprint
col TABLESPACE_NAME format a40
col FILE_NAME format a100
col FILE_SIZE format a20
col AUTOEXTENSIBLE format a30
col ONLINE_STATUS format a30
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLESPACE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||FILE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||FILE_SIZE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||AUTOEXTENSIBLE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||ONLINE_STATUS||'</font></td>'||CHR(10)||
	'</tr>'
  FROM (SELECT *
          FROM (
		SELECT  TABLESPACE_NAME,FILE_NAME,round(BYTES/1024/1024/1024) FILE_SIZE,AUTOEXTENSIBLE,ONLINE_STATUS FROM DBA_DATA_FILES WHERE AUTOEXTENSIBLE='YES' 
		UNION ALL
		SELECT TABLESPACE_NAME,FILE_NAME,round(BYTES/1024/1024/1024) FILE_SIZE,AUTOEXTENSIBLE,null  FROM DBA_TEMP_FILES WHERE AUTOEXTENSIBLE='YES'
	));
clear breaks;

PRO
PRO </table>
PRO </div>






-- db_size INFO
PRO <div id="db_size" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库大小</b></font></td>
PRO </tr>
col DB_NAME noprint
col DB_SIZE_GB noprint
col DB_NAME format a50
col DB_SIZE_GB format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DB_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DB_SIZE_GB||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
		SELECT (SELECT NAME FROM V$DATABASE) AS DB_NAME,( SELECT ROUND(SUM(BYTES)/1024/1024/1024)||'G' FROM DBA_SEGMENTS) AS DB_SIZE_GB FROM DUAL
	));
clear breaks;

PRO
PRO </table>
PRO </div>












-- no_partitioned_table INFO
PRO <div id="no_partitioned_table" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表空间名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表大小(G)</b></font></td>
PRO </tr>

col OWNER noprint
col TABLE_NAME noprint
col TABLESPACE_NAME noprint
col TABLE_SIZE noprint
col OWNER format a50
col TABLE_NAME format a50
col TABLESPACE_NAME format a50
col TABLE_SIZE format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLESPACE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_SIZE||'</font></td>'||CHR(10)||
	'</tr>'
  FROM (SELECT *
          FROM (
	SELECT OWNER,SEGMENT_NAME TABLE_NAME,TABLESPACE_NAME,ROUND(BYTES/1024/1024/1024,2) TABLE_SIZE FROM DBA_SEGMENTS WHERE SEGMENT_TYPE='TABLE' AND ROUND(BYTES/1024/1024/1024,2)>2 ORDER BY TABLE_SIZE DESC
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>















-- no_pk_tables INFO
PRO <div id="no_pk_tables" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO </tr>

col OWNER noprint
col TABLE_NAME noprint
col OWNER format a50
col TABLE_NAME format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
	'</tr>'
  FROM (SELECT *
          FROM (
		SELECT OWNER,TABLE_NAME FROM DBA_TABLES WHERE OWNER  IN (
			SELECT USERNAME FROM DBA_USERS WHERE ACCOUNT_STATUS='OPEN' 
							AND DEFAULT_TABLESPACE!='SYSTEM'
							AND DEFAULT_TABLESPACE!='USERS')
		MINUS
		SELECT OWNER,TABLE_NAME FROM DBA_CONSTRAINTS WHERE CONSTRAINT_TYPE='P'
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>










-- lob_segments INFO
PRO <div id="lob_segments" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>段名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>列名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>段类型</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表空间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>段大小(M)</b></font></td>
PRO </tr>

col OWNER noprint
col SEGMENT_NAME noprint
col SEGMENT_TYPE noprint
col TABLE_NAME noprint
col COLUMN_NAME noprint
col TABLESPACE_NAME noprint
col SEGMENT_SIZE noprint
col OWNER format a30
col SEGMENT_NAME format a50
col SEGMENT_TYPE format a50
col TABLE_NAME format a50
col COLUMN_NAME format a50
col TABLESPACE_NAME format a50
col SEGMENT_SIZE format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SEGMENT_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||COLUMN_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SEGMENT_TYPE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLESPACE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SEGMENT_SIZE||'</font></td>'||CHR(10)||
	'</tr>'
  FROM (SELECT *
          FROM (
		SELECT  D.OWNER, D.SEGMENT_NAME, L.TABLE_NAME,L.COLUMN_NAME, D.SEGMENT_TYPE,D.TABLESPACE_NAME, D.BYTES/1024/1024 SEGMENT_SIZE
		FROM DBA_SEGMENTS D LEFT JOIN dba_lobs L
		ON D.SEGMENT_NAME=L.SEGMENT_NAME
		 WHERE  D.SEGMENT_TYPE LIKE 'LOB%'
		   AND  D.OWNER NOT IN ('SYS', 'SYSTEM', 'XDB', 'SYSMAN', 'OUTLN', 'WMSYS')
		   AND  D.TABLESPACE_NAME NOT IN ('SYSAUX', 'USERS')
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>


















-- row_chain INFO
PRO <div id="row_chain" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>迁移行数</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>状态</b></font></td>
PRO </tr>

col OWNER noprint
col TABLE_NAME noprint
col CHAIN_CNT noprint
col STATUS noprint
col OWNER format a30
col TABLE_NAME format a50
col CHAIN_CNT format a50
col STATUS format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CHAIN_CNT||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STATUS||'</font></td>'||CHR(10)||
	'</tr>'
  FROM (SELECT *
          FROM (
		SELECT OWNER,TABLE_NAME,CHAIN_CNT,STATUS FROM DBA_TABLES WHERE CHAIN_CNT>0
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>










-- partition_gt_100 INFO
PRO <div id="partition_gt_100" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>分区数</b></font></td>
PRO </tr>

col TABLE_OWNER noprint
col TABLE_NAME noprint
col P_NUMBER noprint
col TABLE_OWNER format a30
col TABLE_NAME format a50
col P_NUMBER format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||P_NUMBER||'</font></td>'||CHR(10)||
	'</tr>'
  FROM (SELECT *
          FROM (
		select TABLE_OWNER,TABLE_NAME,COUNT(PARTITION_NAME) P_NUMBER from dba_tab_partitions group by TABLE_OWNER,table_name having count(partition_name)>=40
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>




PRO <div id="invilidate_objects" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>对象名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>对象类型</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>对象状态</b></font></td>
PRO </tr>

col OWNER noprint
col OBJECT_NAME noprint
col OBJECT_TYPE noprint
col STATUS noprint
col OWNER format a30
col OBJECT_NAME format a50
col OBJECT_TYPE format a50
col STATUS format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OBJECT_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OBJECT_TYPE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STATUS||'</font></td>'||CHR(10)||
	'</tr>'
  FROM (SELECT *
          FROM (
		select OWNER,OBJECT_NAME,OBJECT_TYPE,STATUS from dba_objects where status!='VALID' order by 1,3
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>





-- index_pct INFO
PRO <div id="index_pct" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>列个数</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>索引个数</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>比例</b></font></td>
PRO </tr>

col OWNER noprint
col TABLE_NAME noprint
col TOT_COL noprint
col TOT_IDX noprint
col PCT noprint
col OWNER for a50
col TABLE_NAME  for a50
col TOT_COL  for a50
col TOT_IDX  for a50
col PCT  for a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TOT_COL||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TOT_IDX||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PCT||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	WITH TAB_USERS AS (SELECT USERNAME FROM DBA_USERS WHERE DEFAULT_TABLESPACE NOT IN ('USERS', 'GGS_DATA', 'SYSAUX', 'SYSTEM', 'GGS'))  
	SELECT * FROM (SELECT A.OWNER,A.TABLE_NAME,A.TOT_COL,B.TOT_IDX, TRUNC(B.TOT_IDX/A.TOT_COL,2) PCT FROM (SELECT OWNER,TABLE_NAME,COUNT(COLUMN_NAME) TOT_COL FROM DBA_TAB_COLUMNS 
	WHERE OWNER IN (SELECT USERNAME FROM TAB_USERS)
	GROUP BY OWNER,TABLE_NAME) A,
	(SELECT OWNER, TABLE_NAME, COUNT(INDEX_NAME) TOT_IDX
	FROM DBA_INDEXES
	WHERE OWNER IN (SELECT USERNAME FROM TAB_USERS)
	GROUP BY OWNER, TABLE_NAME) B
	WHERE A.OWNER=B.OWNER
	AND   A.TABLE_NAME=B.TABLE_NAME)
	WHERE PCT >= 0.5 OR TOT_IDX>5
	));
clear breaks;

PRO
PRO </table>
PRO </div>















-- auto_gather_statistics INFO
PRO <div id="auto_gather_statistics" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>任务名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>状态</b></font></td>
PRO </tr>

col client_name noprint
col status noprint
col client_name format a50
col status format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||client_name||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||status||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	select client_name,status from dba_autotask_client
	));
clear breaks;

PRO
PRO </table>
PRO </div>













-- bitmap_function_index INFO
PRO <div id="bitmap_function_index" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>索引名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>索引类型</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>索引状态</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>BLEVEL</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>叶子块</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>集群因子</b></font></td>
PRO </tr>

col OWNER noprint
col TABLE_NAME noprint
col INDEX_NAME noprint
col INDEX_TYPE noprint
col STATUS noprint
col BLEVEL noprint
col LEAF_BLOCKS noprint
col clustering_factor noprint
col OWNER format a50
col TABLE_NAME format a50
col INDEX_NAME format a50
col INDEX_TYPE format a50
col STATUS format a50
col BLEVEL format a50
col LEAF_BLOCKS format a50
col clustering_factor format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INDEX_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INDEX_TYPE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STATUS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||BLEVEL||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LEAF_BLOCKS||'</font></td>'||CHR(10)||
      '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CLUSTERING_FACTOR||'</font></td>'||CHR(10)||
	'</tr>'
  FROM (SELECT *
          FROM (
		SELECT OWNER,TABLE_NAME,INDEX_NAME,INDEX_TYPE,STATUS,BLEVEL,LEAF_BLOCKS,clustering_factor FROM DBA_INDEXES WHERE OWNER IN
       (SELECT USERNAME
          FROM DBA_USERS
         WHERE DEFAULT_TABLESPACE NOT IN
               ('USERS', 'GGS_DATA', 'SYSAUX', 'SYSTEM', 'GGS'))
	AND( INDEX_TYPE='BITMAP' OR INDEX_TYPE LIKE 'FUNCTION-BASED%')
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>












-- cache_lt_100 INFO
PRO <div id="cache_lt_100" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>序列名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>最大值</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>cache值</b></font></td>
PRO </tr>

col SEQUENCE_OWNER noprint
col SEQUENCE_NAME noprint
col MAX_VALUE noprint
col CACHE_SIZE noprint
col SEQUENCE_OWNER format a50
col SEQUENCE_NAME format a50
col MAX_VALUE format a50
col CACHE_SIZE format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SEQUENCE_OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SEQUENCE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||MAX_VALUE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||CACHE_SIZE||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (
		SELECT SEQUENCE_OWNER,SEQUENCE_NAME,MAX_VALUE,CACHE_SIZE FROM DBA_SEQUENCES WHERE
		SEQUENCE_OWNER IN
		(SELECT USERNAME
		FROM DBA_USERS
		 WHERE DEFAULT_TABLESPACE NOT IN
               ('USERS', 'GGS_DATA', 'SYSAUX', 'SYSTEM', 'GGS'))
		AND CACHE_SIZE <100
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>








-- db_links INFO
PRO <div id="db_links" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>DB_LINK</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>主机</b></font></td>
PRO </tr>

col OWNER noprint
col DB_LINK noprint
col USERNAME noprint
col HOST noprint
col OWNER format a50
col DB_LINK format a50
col USERNAME format a50
col HOST format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DB_LINK||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||USERNAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||HOST||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (
		SELECT OWNER,DB_LINK,USERNAME,HOST FROM Dba_Db_Links
	  ));
clear breaks;

PRO
PRO </table>
PRO </div>






-- no_used_index INFO
PRO <div id="no_used_index" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>索引名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>是否监控</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>是否使用</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>开始监控时间</b></font></td>
PRO </tr>

col OWNER noprint
col INDEX_NAME noprint
col TABLE_NAME noprint
col MONITORING noprint
col USED noprint
col START_MONITORING noprint
col OWNER format a50
col TABLE_NAME format a50
col INDEX_NAME format a50
col MONITORING format a50
col USED format a50
col START_MONITORING format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INDEX_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||MONITORING||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||USED||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||START_MONITORING||'</font></td>'||CHR(10)||
       '</tr>'
  FROM (SELECT *
          FROM (
		WITH TAB_USERS AS (SELECT USERNAME FROM DBA_USERS WHERE DEFAULT_TABLESPACE NOT IN ('USERS', 'GGS_DATA', 'SYSAUX', 'SYSTEM', 'GGS'))
	SELECT * FROM (
	SELECT U.NAME OWNER,
               IO.NAME INDEX_NAME,
               T.NAME TABLE_NAME,
               DECODE(BITAND(I.FLAGS, 65536), 0, 'NO', 'YES') MONITORING,
               DECODE(BITAND(OU.FLAGS, 1), 0, 'NO', 'YES') USED,
               OU.START_MONITORING START_MONITORING
          FROM SYS.USER$        U,
               SYS.OBJ$         IO,
               SYS.OBJ$         T,
               SYS.IND$         I,
               SYS.OBJECT_USAGE OU
         WHERE I.OBJ# = OU.OBJ#
           AND IO.OBJ# = OU.OBJ#
           AND T.OBJ# = I.BO#
           AND U.USER# = IO.OWNER#
	)
           WHERE USED='NO'
           AND (OWNER,INDEX_NAME) NOT IN
           (SELECT OWNER,CONSTRAINT_NAME  FROM DBA_CONSTRAINTS WHERE OWNER IN (SELECT USERNAME FROM TAB_USERS))
	   ));
clear breaks;

PRO
PRO </table>
PRO </div>















-- partition_high_value INFO
PRO <div id="partition_high_value" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>分区名</b></font></td>
PRO </tr>

col TABLE_OWNER noprint
col TABLE_NAME noprint
col PARTITION_NAME noprint
col TABLE_OWNER format a50
col TABLE_NAME format a50
col PARTITION_NAME format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PARTITION_NAME||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (
                 WITH TAB_USERS AS (SELECT USERNAME FROM DBA_USERS WHERE DEFAULT_TABLESPACE NOT IN ('USERS', 'GGS_DATA', 'SYSAUX', 'SYSTEM', 'GGS'))                                                                                    
         SELECT TABLE_OWNER, TABLE_NAME, PARTITION_NAME FROM DBA_TAB_PARTITIONS                                                                                                              
	  WHERE (TABLE_OWNER, TABLE_NAME, PARTITION_POSITION) IN                                                                                          
           (SELECT TABLE_OWNER, TABLE_NAME, MAX(PARTITION_POSITION) FROM DBA_TAB_PARTITIONS                                                                                                                
		WHERE TABLE_OWNER IN (SELECT USERNAME FROM TAB_USERS)                                                                                   
                     AND (TABLE_OWNER, TABLE_NAME) NOT IN (SELECT DISTINCT TABLE_OWNER, TABLE_NAME FROM DBA_TAB_PARTITIONS WHERE PARTITION_NAME LIKE 'SYS%')                                                                                               
		    AND PARTITION_NAME NOT LIKE '%MAX%'                                                                                                   
             GROUP BY TABLE_OWNER, TABLE_NAME)                                                                                                       
        ORDER BY TABLE_OWNER, TABLE_NAME             
	));
clear breaks;

PRO
PRO </table>
PRO </div>
















-- no_index_table INFO
PRO <div id="no_index_table" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表空间名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>状态</b></font></td>
PRO </tr>

col OWNER noprint
col TABLE_NAME noprint
col TABLESPACE_NAME noprint
col STATUS noprint
col OWNER format a50
col TABLE_NAME format a50
col TABLESPACE_NAME format a50
col STATUS format a100
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLESPACE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STATUS||'</font></td>'||CHR(10)||
       '</tr>'
  FROM (SELECT *
          FROM (	
	WITH T_USERNAME AS (SELECT USERNAME FROM DBA_USERS WHERE DEFAULT_TABLESPACE NOT IN ('USERS', 'GGS_DATA', 'SYSAUX', 'SYSTEM', 'GGS'))
	SELECT OWNER, TABLE_NAME, TABLESPACE_NAME, STATUS FROM DBA_TABLES
	WHERE OWNER IN (SELECT USERNAME FROM T_USERNAME)
	  AND TABLE_NAME NOT IN (SELECT TABLE_NAME FROM DBA_INDEXES WHERE OWNER IN (SELECT USERNAME FROM T_USERNAME))
	  AND TABLE_NAME IN (SELECT SEGMENT_NAME FROM DBA_SEGMENTS  WHERE OWNER IN (SELECT USERNAME FROM T_USERNAME) AND SEGMENT_TYPE = 'TABLE' AND BYTES / 1024 / 1024 > 500)
	));
clear breaks;

PRO
PRO </table>
PRO </div>











-- wait_events_info INFO
PRO <div id="wait_events_info" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>等待事件</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>等待事件类型</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>等待次数</b></font></td>
PRO </tr>

col wait_counts noprint
col EVENT noprint
col WAIT_CLASS noprint
col wait_counts format a50
col EVENT format a50
col WAIT_CLASS format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||EVENT||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||WAIT_CLASS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||wait_counts||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	select event, wait_class, count(*) as wait_counts
	from v$active_session_history
	where sample_time >= sysdate - 3
	and event is not null
	and wait_class is not null
	group by event, wait_class
	order by count(*) desc
	));
clear breaks;

PRO
PRO </table>
PRO </div>




































-- job_status INFO
PRO <div id="job_status" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>JOB编号</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>上次执行时间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>时间间隔</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>下次时间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>总共花费时间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>失败次数</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>是否终止</b></font></td>
PRO </tr>

col JOB noprint
col LOG_USER noprint
col LAST_DATE noprint
col INTERVAL noprint
col NEXT_DATE noprint
col TOTAL_TIME noprint
col FAILURES noprint
col BROKEN noprint

col JOB format '9999999'
col LOG_USER format a50
col LAST_DATE format a50
col INTERVAL format a50
col TOTAL_TIME format '9999999'
col NEXT_DATE format a50
col FAILURES format '99999999'
col BROKEN format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||JOB||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LOG_USER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||LAST_DATE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INTERVAL||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||NEXT_DATE||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TOTAL_TIME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||FAILURES||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||BROKEN||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	SELECT JOB,LOG_USER,LAST_DATE,INTERVAL,NEXT_DATE,trunc(TOTAL_TIME) TOTAL_TIME ,FAILURES,BROKEN FROM DBA_JOBS
	));
clear breaks;

PRO
PRO </table>
PRO </div>





-- deferred_segment_creation INFO
PRO <div id="deferred_segment_creation" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>参数名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>是否延迟分配</b></font></td>
PRO </tr>

col NAME noprint
col VALUE noprint
col NAME format a50
col VALUE format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||VALUE||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	SELECT NAME,VALUE FROM V$PARAMETER WHERE  name='deferred_segment_creation'
	));
clear breaks;

PRO
PRO </table>
PRO </div>








-- log_switchs INFO
PRO <div id="log_switchs" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>时间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>大小(M)</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>实例名</b></font></td>
PRO </tr>

col HOUR_END_TIME noprint
col SIZE_MB noprint
col INSTANCE_NAME noprint
col HOUR_END_TIME format a50
col SIZE_MB format a50
col INSTANCE_NAME format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||HOUR_END_TIME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SIZE_MB||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INSTANCE_NAME||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	WITH TIMES AS
	(SELECT /*+ MATERIALIZE */
	 HOUR_END_TIME
	 FROM (SELECT (TRUNC(SYSDATE, 'HH') + (2 / 24)) - (ROWNUM / 24) HOUR_END_TIME
            FROM DUAL
          CONNECT BY ROWNUM <= (1 * 24) + 3),
         V$DATABASE
	 WHERE LOG_MODE = 'ARCHIVELOG')
	SELECT HOUR_END_TIME,
       NVL(ROUND(SUM(SIZE_MB), 3), 0) SIZE_MB,
       I.INSTANCE_NAME
	 FROM (SELECT HOUR_END_TIME,
               CASE
                 WHEN (HOUR_END_TIME - (1 / 24)) > LAG_NEXT_TIME THEN
                  (NEXT_TIME + (1 / 24) - HOUR_END_TIME) *
                  (SIZE_MB / (NEXT_TIME - LAG_NEXT_TIME))
                 ELSE
                  0
               END + CASE
                 WHEN HOUR_END_TIME < LEAD_NEXT_TIME THEN
                  (HOUR_END_TIME - NEXT_TIME) *
                  (LEAD_SIZE_MB / (LEAD_NEXT_TIME - NEXT_TIME))
                 ELSE
                  0
               END + CASE
                 WHEN LAG_NEXT_TIME > (HOUR_END_TIME - (1 / 24)) THEN
                  SIZE_MB
                 ELSE
                  0
               END + CASE
                 WHEN NEXT_TIME IS NULL THEN
                  (1 / 24) * LAST_VALUE(CASE
                                          WHEN NEXT_TIME IS NOT NULL AND LAG_NEXT_TIME IS NULL THEN
                                           0
                                          ELSE
                                           (SIZE_MB / (NEXT_TIME - LAG_NEXT_TIME))
                                        END IGNORE NULLS)
                  OVER(ORDER BY HOUR_END_TIME DESC, NEXT_TIME DESC)
                 ELSE
                  0
               END SIZE_MB
          FROM (SELECT T.HOUR_END_TIME,
                       ARC.NEXT_TIME,
                       ARC.LAG_NEXT_TIME,
                       LEAD(ARC.NEXT_TIME) OVER(ORDER BY ARC.NEXT_TIME ASC) LEAD_NEXT_TIME,
                       ARC.SIZE_MB,
                       LEAD(ARC.SIZE_MB) OVER(ORDER BY ARC.NEXT_TIME ASC) LEAD_SIZE_MB
                  FROM TIMES T,
                       (SELECT NEXT_TIME,
                               SIZE_MB,
                               LAG(NEXT_TIME) OVER(ORDER BY NEXT_TIME) LAG_NEXT_TIME
                          FROM (SELECT NEXT_TIME, SUM(SIZE_MB) SIZE_MB
                                  FROM (SELECT DISTINCT A.SEQUENCE#,
                                                        A.NEXT_TIME,
                                                        ROUND(A.BLOCKS *
                                                              A.BLOCK_SIZE / 1024 / 1024) SIZE_MB
                                          FROM V$ARCHIVED_LOG A,
                                               (SELECT /*+ no_merge */
                                                 CASE
                                                   WHEN TO_NUMBER(PT.VALUE) = 0 THEN
                                                    1
                                                   ELSE
                                                    TO_NUMBER(PT.VALUE)
                                                 END VALUE
                                                  FROM V$PARAMETER PT
                                                 WHERE PT.NAME = 'thread') PT
                                         WHERE A.NEXT_TIME > SYSDATE - 3
                                           AND A.THREAD# = PT.VALUE
                                           AND ROUND(A.BLOCKS * A.BLOCK_SIZE / 1024 / 1024) > 0)
                                 GROUP BY NEXT_TIME)) ARC
                 WHERE T.HOUR_END_TIME =
                       (TRUNC(ARC.NEXT_TIME(+), 'HH') + (1 / 24)))
         WHERE HOUR_END_TIME > TRUNC(SYSDATE, 'HH') - 1 - (1 / 24)),
       V$INSTANCE I
	WHERE HOUR_END_TIME <= TRUNC(SYSDATE, 'HH')
	GROUP BY HOUR_END_TIME, I.INSTANCE_NAME
	ORDER BY HOUR_END_TIME
	));
clear breaks;

PRO
PRO </table>
PRO </div>















-- pga_used_info INFO
PRO <div id="pga_used_info" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SID</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SERIAL#</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>状态</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>分配内存</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>OSUSER</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>PROGRAM</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SQL_ID</b></font></td>

PRO </tr>

col SID noprint
col SERIAL# noprint
col STATUS noprint
col PGA_ALLOC_MEM noprint
col USERNAME noprint
col OSUSER noprint
col PROGRAM noprint
col SQL_ID noprint
col SID format a20
col SERIAL# format a20
col STATUS format a30
col PGA_ALLOC_MEM format a30
col USERNAME format a30
col OSUSER format a30
col PROGRAM format a30
col SQL_ID format a30
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SID||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SERIAL#||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||STATUS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PGA_ALLOC_MEM||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||USERNAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OSUSER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PROGRAM||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SQL_ID||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	select * from (  SELECT A.SID,A.SERIAL#,A.STATUS,B.PGA_ALLOC_MEM,A.USERNAME,A.OSUSER,A.PROGRAM,A.SQL_ID FROM V$SESSION A,V$PROCESS B
		WHERE  A.PADDR=B.ADDR
		ORDER BY B.PGA_ALLOC_MEM DESC)
		where rownum<=100
	));
clear breaks;

PRO
PRO </table>
PRO </div>







-- user_info INFO
PRO <div id="user_info" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>状态</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>PROFILE</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>密码过期时间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>密码复杂度校验</b></font></td>
PRO </tr>

col username noprint
col account_status noprint
col profile noprint
col PASSWORD_LIFE_TIME noprint
col PASSWORD_VERIFY_FUNCTION noprint
col username format a50
col account_status format a50
col profile format a50
col PASSWORD_LIFE_TIME format a50
col PASSWORD_VERIFY_FUNCTION format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||username||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||account_status||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||profile||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PASSWORD_LIFE_TIME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||PASSWORD_VERIFY_FUNCTION||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	SELECT U.username,
	       U.account_status,
	       U.profile,
		P.PASSWORD_LIFE_TIME,
		 P.PASSWORD_VERIFY_FUNCTION
	 FROM DBA_USERS U,
	(SELECT *
		 FROM (SELECT PROFILE, P.resource_name, P.limit
                  FROM DBA_PROFILES P
		  WHERE P.resource_type = 'PASSWORD'
                   AND PROFILE = 'DEFAULT'
                   AND P.resource_name IN
	                ('PASSWORD_LIFE_TIME', 'PASSWORD_VERIFY_FUNCTION'))
		PIVOT(max(limit)
		 FOR resource_name in('PASSWORD_LIFE_TIME' as PASSWORD_LIFE_TIME,
                               'PASSWORD_VERIFY_FUNCTION' as
                               PASSWORD_VERIFY_FUNCTION))) P
	WHERE U.profile = P.profile
	 AND U.ACCOUNT_STATUS = 'OPEN'
	AND U.DEFAULT_TABLESPACE NOT IN ('SYSTEM', 'SYSAUX')
		));
clear breaks;

PRO
PRO </table>
PRO </div>


















-- user_size INFO
PRO <div id="user_size" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>大小</b></font></td>
PRO </tr>

col owner noprint
col owner_size noprint
col owner format a50
col owner_size format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||owner||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||owner_size||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	select owner,sum(bytes)/1024/1024 OWNER_SIZE from dba_segments group by owner
	));
clear breaks;

PRO
PRO </table>
PRO </div>









-- default_tablespace_sys_user INFO
PRO <div id="default_tablespace_sys_user" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>默认表空间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>临时表空间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>创建时间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户状态</b></font></td>
PRO </tr>

col username noprint
col default_tablespace noprint
col temporary_tablespace noprint
col created noprint
col account_status noprint
col username format a50
col default_tablespace format a50
col temporary_tablespace format a50
col created format a50
col account_status format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||username||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||temporary_tablespace||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||created||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||account_status||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	select username,
	default_tablespace,
	temporary_tablespace,
        created,
        account_status
	from dba_users
	where  (default_tablespace = 'SYSTEM'
		or default_tablespace = 'SYSAUX')
	    and temporary_tablespace = 'TEMP'
	    AND ACCOUNT_STATUS='OPEN'
	));
clear breaks;

PRO
PRO </table>
PRO </div>








-- objects_on_system_tablespace INFO
PRO <div id="objects_on_system_tablespace" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>对象名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>对象类型</b></font></td>
PRO </tr>

col OWNER noprint
col SEGMENT_NAME noprint
col SEGMENT_TYPE noprint
col OWNER format a50
col SEGMENT_NAME format a50
col SEGMENT_TYPE format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SEGMENT_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SEGMENT_TYPE||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	select OWNER, SEGMENT_NAME, SEGMENT_TYPE
	from dba_segments
	where tablespace_name in  ('SYSTEM','SYSAUX')
	and owner NOT IN
       (SELECT USERNAME
          FROM DBA_USERS
         WHERE DEFAULT_TABLESPACE IN ('SYSTEM', 'SYSAUX'))
	));
clear breaks;

PRO
PRO </table>
PRO </div>







-- flashback_on INFO
PRO <div id="flashback_on" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>数据库名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>是否开启闪回</b></font></td>
PRO </tr>

col dbname noprint
col flashback_on noprint
col dbname format a50
col flashback_on format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||dbname||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||flashback_on||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	 select (select name from v$database) as dbname,(select flashback_on from v$database) as flashback_on from dual
	));
clear breaks;

PRO
PRO </table>
PRO </div>










-- SCN_headroom INFO
PRO <div id="SCN_headroom" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>当前SCN</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>允许SCN</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SCN_HEADROOM</b></font></td>
PRO </tr>

col current_scn noprint
col allow_scn noprint
col SCN_HEADROOM noprint
col current_scn format a50
col allow_scn format a50
col SCN_HEADROOM format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||current_scn||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||allow_scn||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SCN_HEADROOM||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	 SELECT current_scn,trunc(allow_scn) as allow_scn,round(current_scn/allow_scn,5)*100||'%'  AS SCN_HEADROOM FROM (
		select (select current_scn from v$database) as current_scn,
		(select (sysdate-to_date('1988-01-01 00:00:00','yyyy/mm/dd hh24:mi:ss'))*24*3600*16384  from dual ) as allow_scn from dual)
	));
clear breaks;

PRO
PRO </table>
PRO </div>








-- patch_applied INFO
PRO <div id="patch_applied" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>是否应用</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>补丁号</b></font></td>
PRO </tr>
col action noprint
col comments noprint
col action format a50
col comments format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||action||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||comments||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
		select action,comments from registry$history
	));
clear breaks;

PRO
PRO </table>
PRO </div>









-- top10_logic_reads_sql INFO
PRO <div id="top10_logic_reads_sql" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SQL_ID</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>平均逻辑读</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>总逻辑读</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>执行次数</b></font></td>

PRO </tr>
col SQL_ID noprint
col AVG_GETS noprint
col buffer_gets noprint
col executions noprint
col SQL_ID format a50
col AVG_GETS format a50
col buffer_gets format a50
col executions format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SQL_ID||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||AVG_GETS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||buffer_gets||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||executions||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
		SELECT *
		FROM (
		SELECT SQL_ID,TRUNC(buffer_gets / executions) AS AVG_GETS,buffer_gets, executions
		FROM V$SQLAREA WHERE buffer_gets > 10000 ORDER BY AVG_GETS DESC)
		WHERE rownum <= 10
	));
clear breaks;

PRO
PRO </table>
PRO </div>








-- top10_physical_reads_sql INFO
PRO <div id="top10_physical_reads_sql" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SQL_ID</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>平均物理读</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>总物理读</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>执行次数</b></font></td>

PRO </tr>
col SQL_ID noprint
col AVG_READS noprint
col disk_reads noprint
col executions noprint
col SQL_ID format a50
col AVG_READS format a50
col disk_reads format a50
col executions format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SQL_ID||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||AVG_READS||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||disk_reads||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||executions||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
		SELECT *
		FROM (
		  SELECT  SQL_ID,trunc(disk_reads / executions) AS AVG_READS,disk_reads, executions 
		  FROM V$SQLAREA WHERE disk_reads > 10  AND   EXECUTIONS>0
		  ORDER BY AVG_READS DESC
		)
		WHERE rownum <= 10
	));
clear breaks;

PRO
PRO </table>
PRO </div>









-- lock_info INFO
PRO <div id="lock_info" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SID</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SERIAL</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>oracle_username</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>machine</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>object_name</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>logon_time</b></font></td>
PRO </tr>
col sid noprint
col serial noprint
col oracle_username noprint
col machine noprint
col object_name noprint
col logon_time noprint
col sid format a50
col serial format a50
col oracle_username format a50
col machine format a50
col object_name format a50
col logon_time format a50

set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||sid||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||serial||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||oracle_username||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||machine||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||object_name||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||logon_time||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
	SELECT l.session_id sid, s.serial# as serial , l.oracle_username ,s.machine, o.object_name, s.logon_time FROM v$locked_object l , all_objects o , v$session s WHERE l.object_id = o.object_id AND l.session_id = s.sid
	));
clear breaks;

PRO
PRO </table>
PRO </div>











-- hit_info INFO
PRO <div id="hit_info" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>名字</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>命中率</b></font></td>

PRO </tr>
col name noprint
col hit_ratio noprint
col name format a50
col hit_ratio format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||name||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||hit_ratio||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (
		select 'latch' as name ,round(sum(gets)/(sum(gets)+sum(misses)),4)*100||'%' as hit_ratio  from  v$latch
		union all
		select 'buffer_cache',trunc(1 - (sum(decode(name, 'physical reads', value, 0)) /
			(sum(decode(name, 'db block gets', value, 0)) +
			(sum(decode(name, 'consistent gets', value, 0))))),5)*100||'%'  "Buffer Hit Ratio"  from v$sysstat
		union all
		SELECT 'row_cache', trunc(1-sum(getmisses)/sum(gets),5)*100||'%' as "row_cache hitratio"  from v$rowcache
		union all
		SELECT 'library_cache' ,trunc(SUM(pinhits)/sum(pins),5)*100||'%'  FROM V$LIBRARYCACHE	
	));
clear breaks;

PRO
PRO </table>
PRO </div>











-- top10_sorts_sql INFO
PRO <div id="top10_sorts_sql" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>用户名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SQL_TEXT</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>排序块数</b></font></td>
PRO </tr>
col username noprint
col sql_text noprint
col blocks noprint
col username format a50
col sql_text format a50
col blocks format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||username||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||sql_text||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||blocks||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
		SELECT * FROM (
		select sess.username username, sql.sql_text sql_text, sort1.blocks blocks
		from v$session sess, v$sqlarea sql, v$sort_usage sort1 
		where sess.serial# = sort1.session_num and sort1.sqladdr = sql.address and sort1.sqlhash = sql.hash_value and sort1.blocks > 200
		ORDER BY sort1.blocks DESC) WHERE ROWNUM<=10
	));
clear breaks;

PRO
PRO </table>
PRO </div>












-- db_files INFO
PRO <div id="db_files" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>已用文件数</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>最大文件数</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>使用比</b></font></td>
PRO </tr>
col DB_FILES noprint
col TOTAL_FILES noprint
col USED_PCT noprint
col DB_FILES format a50
col TOTAL_FILES format a50
col USED_PCT format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||DB_FILES||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TOTAL_FILES||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||USED_PCT||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
		SELECT DB_FILES,TOTAL_FILES,TRUNC(DB_FILES/TOTAL_FILES,4)*100||'%' USED_PCT FROM (
		SELECT (SELECT COUNT(*) FROM DBA_DATA_FILES) DB_FILES,(SELECT VALUE FROM V$PARAMETER WHERE NAME='db_files') TOTAL_FILES FROM DUAL)
	));
clear breaks;

PRO
PRO </table>
PRO </div>








-- partition_table_global_index INFO
PRO <div id="partition_table_global_index" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>所有者</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>表名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>索引名</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>索引类型</b></font></td>
PRO </tr>
col OWNER noprint
col TABLE_NAME noprint
col INDEX_NAME noprint
col INDEX_TYPE noprint
col OWNER format a50
col TABLE_NAME format a50
col INDEX_NAME format a50
col INDEX_TYPE format a50  
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||OWNER||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TABLE_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INDEX_NAME||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||INDEX_TYPE||'</font></td>'||CHR(10)||
	'</tr>'
  FROM (SELECT *
          FROM (	
		SELECT OWNER,TABLE_NAME,INDEX_NAME,INDEX_TYPE FROM DBA_INDEXES WHERE (OWNER,TABLE_NAME,INDEX_NAME) IN (
 			SELECT OWNER,TABLE_NAME,INDEX_NAME FROM DBA_INDEXES WHERE TABLE_NAME IN (                                                            
                		SELECT DISTINCT TABLE_NAME FROM DBA_TAB_PARTITIONS                                                                                   
                		WHERE TABLE_OWNER IN (SELECT USERNAME FROM DBA_USERS WHERE DEFAULT_TABLESPACE NOT IN ('USERS', 'GGS_DATA', 'SYSAUX', 'SYSTEM', 'GGS')))
                	MINUS                                                                                                                                
                	SELECT OWNER,TABLE_NAME ,INDEX_NAME                                                                                               
                	FROM DBA_PART_INDEXES WHERE OWNER IN (SELECT USERNAME FROM DBA_USERS WHERE DEFAULT_TABLESPACE NOT IN ('USERS', 'GGS_DATA', 'SYSAUX', 'SYSTEM', 'GGS')))
	));
clear breaks;

PRO
PRO </table>
PRO </div>







-- sql_time_top10 INFO
PRO <div id="sql_time_top10" style="display:none;">
PRO <table width="100%" border="1">
PRO <tr>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>SQL_ID</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>平均执行时间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>总执行时间</b></font></td>
PRO <td nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#000000"><b>执行次数</b></font></td>

PRO </tr>
col SQL_ID noprint
col TIME_PER_EXEC noprint
col elapsed_time noprint
col executions noprint
col SQL_ID format a50
col TIME_PER_EXEC format a50
col elapsed_time format a50
col executions format a50
set pages 0 lines 300 trimspool on trim on
alter session set nls_date_language = 'american';
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter session set sql_trace=false;
break on thedate
SELECT CHR(10)||'<tr>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||SQL_ID||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||TIME_PER_EXEC||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||elapsed_time||'</font></td>'||CHR(10)||
       '<td class="r" nowrap="" style="background-color:#FFCC00"  align="center" width="18%"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">'||executions||'</font></td>'||CHR(10)||
      '</tr>'
  FROM (SELECT *
          FROM (	
		SELECT *
		FROM (
		SELECT  SQL_ID,round(elapsed_time/executions/1000000) AS TIME_PER_EXEC,ROUND(elapsed_time/1000000) AS elapsed_time, executions FROM V$SQLAREA 
		wHERE executions > 0  ORDER BY TIME_PER_EXEC DESC)
		WHERE rownum <= 10
	));
clear breaks;

PRO
PRO </table>
PRO </div>

























PRO <script type="text/javascript">
PRO var tid
PRO function ShowInfo(objcontent){
PRO         clearTimeout(tid);tid = setTimeout(function(){ }, 25);
PRO         if (objcontent.style.display=="block"){
PRO             objcontent.style.display="none";
PRO         } else {
PRO             objcontent.style.display="block";
PRO        }
PRO }

PRO function Hideinfo(objcontent){
PRO         clearTimeout(tid);             
PRO         objcontent.style.display="none";
PRO }

PRO </script>


PRO </body>
PRO </html>

SPO OFF;





















