

declare
  v_count number;
  v_sql varchar2(100);
  v_deptid t_dept.deptid%type;
  v_deptname t_dept.deptname%type;
begin
  /*����SQL,ֻ��ִ��DML��Select���,����ִ��DDL��DCL*/
  insert into T_userinfo
    (userid, username, password)
  values
    (200, 'aa', 'bb');
  rollback;
  Select count(1) into v_count From T_userinfo;

  --drop table t_a;
  
  /*��̬SQL,����ִ��DDL����
    SQL�������Ǳ�׼��SQL��䣬���ܴ���into�ȷ��š�
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
