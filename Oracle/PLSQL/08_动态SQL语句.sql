

declare
  v_count number;
  v_sql varchar2(100);
  v_deptid t_dept.deptid%type;
  v_deptname t_dept.deptname%type;
begin
  /*编译SQL,只能执行DML和Select语句,不能执行DDL与DCL*/
  insert into T_userinfo
    (userid, username, password)
  values
    (200, 'aa', 'bb');
  rollback;
  Select count(1) into v_count From T_userinfo;

  --drop table t_a;
  
  /*动态SQL,可以执行DDL语名
    SQL语句必须是标准的SQL语句，不能带有into等符号。
   */
  v_sql := 'drop table t_a';
  
  --execute immediate v_sql;
  
  v_sql := 'Select count(1) From T_Dept';
  execute immediate v_sql into v_count;
  
  dbms_output.put_line('v_count = ' || v_count);
  
  
  v_sql := 'Select deptid,deptname From T_dept where deptid = 1';
  execute immediate v_sql into v_deptid,v_deptname;
  
  dbms_output.put_line('v_deptid = ' || v_deptid);
  dbms_output.put_line('v_deptname = ' || v_deptname);
  
end;
