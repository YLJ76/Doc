declare

  v_sql      varchar2(100);
  v_username t_userinfo.username%type;
begin
  v_username := 'a';
  --������ת�壺2�������ţ�����1�������š�
  v_sql := 'Select * From T_Userinfo where 1 = 1 and username like ''%'||v_username ||'%''';

  dbms_output.put_line(v_sql);

  --oracle�����ñ��� '||������||'
  v_sql := 'Select * From T_Userinfo where 1 = 1 and username like ''%'||v_username||'%''';
           
    dbms_output.put_line(v_sql);
end;
