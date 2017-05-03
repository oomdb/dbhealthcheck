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
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(instanceinfo);" ><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">实例基本状况</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(redocontent);" ><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">日志组信息</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(partition_cnt);" ><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">分区最多的前20个对象</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(tab_stats_info);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">统计信息过期(表)</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(userinfo);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">非系统用户信息</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(rman_backup_result);" ><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">RMAN备份状况</font></a></td>
PRO </tr>
PRO

PRO <tr>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;"  onclick="ShowInfo(dbinfo);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">库基本状况</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(tbsinfo);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">表空间信息</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(fk_unindex);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">外键未建索引的表</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(ind_stats_info);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">统计信息过期(索引)</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(dba_priv_user);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">拥有DBA权限的用户</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(rman_configure);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">RMAN非默认配置</font></a></td>
PRO </tr>
PRO

PRO <tr>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(database_characterset);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">数据库字符集</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(diskgroup_info);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">磁盘组信息</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(tab_column_cnt);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">列数大于40的表</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(tab_ind_degree);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">并发数大于1对象</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(user_priv_info);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">业务用户权限</font></a></td>
PRO <td nowrap="" align="center" width="18%"><a href="#"  style="color:blue;text-decoration:none;" onclick="ShowInfo(adg_configure);"><font size=+1 face="Arial,Helvetica,sans-serif" color="#336699">ADG基本配置</font></a></td>
PRO </tr>
PRO  


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



PRO <script type="text/javascript">
PRO function ShowInfo(objcontent){
PRO         if (objcontent.style.display=="block"){
PRO             objcontent.style.display="none";
PRO         } else {
PRO             objcontent.style.display="block";
PRO        }
PRO }
PRO </script>


PRO </body>
PRO </html>

SPO OFF;
