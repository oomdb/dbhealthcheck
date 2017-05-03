-- ORA-01489: result of string concatenation is too long
-- 需要注意的是listagg函数只能返回VARCHAR2和rac类型的值.
-- THE return data type is RAW if the measure column is RAW; otherwise the return value is VARCHAR2.(以上内容摘自官方文档)
-- varcahr2 最多可以容纳4000个字符

-- 1、创建函数 STRAGG
CREATE OR REPLACE TYPE STRING_AGG_TYPE AS OBJECT
(
  RES CLOB,

  STATIC FUNCTION ODCIAGGREGATEINITIALIZE(SCTX IN OUT STRING_AGG_TYPE)
    RETURN NUMBER,

  MEMBER FUNCTION ODCIAGGREGATEITERATE(SELF  IN OUT STRING_AGG_TYPE,
                                       VALUE IN VARCHAR2) RETURN NUMBER,

  MEMBER FUNCTION ODCIAGGREGATETERMINATE(SELF        IN STRING_AGG_TYPE,
                                         RETURNVALUE OUT CLOB,
                                         FLAGS       IN NUMBER)
    RETURN NUMBER,

  MEMBER FUNCTION ODCIAGGREGATEMERGE(SELF IN OUT STRING_AGG_TYPE,
                                     CTX2 IN STRING_AGG_TYPE) 
    RETURN NUMBER
)


CREATE OR REPLACE TYPE BODY STRING_AGG_TYPE IS

  STATIC FUNCTION ODCIAGGREGATEINITIALIZE(SCTX IN OUT STRING_AGG_TYPE)
  
   RETURN NUMBER IS
  
  BEGIN
    SCTX := STRING_AGG_TYPE(NULL);
    RETURN ODCICONST.SUCCESS;
  END;

  MEMBER FUNCTION ODCIAGGREGATEITERATE(SELF  IN OUT STRING_AGG_TYPE,
                                       VALUE IN VARCHAR2) RETURN NUMBER IS
  
  BEGIN
    SELF.RES := SELF.RES || ',' || VALUE;
    RETURN ODCICONST.SUCCESS;
  END;

  MEMBER FUNCTION ODCIAGGREGATETERMINATE(SELF        IN STRING_AGG_TYPE,
                                         RETURNVALUE OUT CLOB,
                                         FLAGS       IN NUMBER) RETURN NUMBER IS
  
  BEGIN
  
    RETURNVALUE := LTRIM(SELF.RES, ',');
  
    RETURN ODCICONST.SUCCESS;
  
  END;

  MEMBER FUNCTION ODCIAGGREGATEMERGE(SELF IN OUT STRING_AGG_TYPE,
                                     CTX2 IN STRING_AGG_TYPE) RETURN NUMBER IS
  
  BEGIN
    NULL;
    --self.total := self.total || ctx2.total; 
    RETURN ODCICONST.SUCCESS;
  END;

END;
/


CREATE OR REPLACE FUNCTION STRAGG(INPUT VARCHAR2) RETURN CLOB
  PARALLEL_ENABLE
  AGGREGATE USING STRING_AGG_TYPE;

-- 2、赋权限
grant execute on STRAGG to public ;
create public synonym STRAGG FOR WUJJ.STRAGG;

-- 3、案例
select deptno,STRAGG(ename)
  from scott.emp
group by deptno;






