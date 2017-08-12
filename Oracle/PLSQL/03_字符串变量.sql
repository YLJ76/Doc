declare

  v_sql      varchar2(100);
  v_username t_userinfo.username%type;
begin
  v_username := 'a';
  --单引号转义：2个单引号，代表1个单引号。
  v_sql := 'Select * From T_Userinfo where 1 = 1 and username like ''%'||v_username ||'%''';

  dbms_output.put_line(v_sql);

  --oracle中引用变量 '||变量名||'
  v_sql := 'Select * From T_Userinfo where 1 = 1 and username like ''%'||v_username||'%''';
           
    dbms_output.put_line(v_sql);
end;
