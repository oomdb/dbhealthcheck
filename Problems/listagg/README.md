
## Q1、Listagg拼接字符串时，报ORA-01489: result of string concatenation is too long 错误 

这是oracle11g版本的一个BUG，在12.1.0.2版本中得到修复。<br>
解决办法：<br>
a、升级oracle数据库版本到12.1.0.2+（此方法基本不可用，你懂的，嘿嘿）。<br>
b、创建个类型转换函数STRAGG，转换为clob数据类型。 详见脚本：<br>

