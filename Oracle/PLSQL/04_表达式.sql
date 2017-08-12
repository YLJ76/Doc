declare

  v_sql      varchar2(100);
  v_username t_userinfo.username%type;
  v_truename t_userinfo.truename%Type;
  
begin
  --v_username := 'a';
  --v_truename := 'уе';
  
  v_sql := 'Select * From T_userinfo where 1 = 1';
  if v_username is not null and v_username != ' ' then
    v_sql := v_sql || ' and username like ''%'||v_username||'%''';
  end if;
  
  if v_truename is not null and v_truename != ' ' then
    v_sql := v_sql || ' and truename like ''%'||v_truename||'%''';
  end if;  
  
  dbms_output.put_line(v_sql);
end;
