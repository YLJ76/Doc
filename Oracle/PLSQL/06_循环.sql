declare
  v_i number;
begin
  v_i := 1;
  --loop循环
  loop
    dbms_output.put_line(v_i);
    v_i := v_i + 1;
    --退出循环
    --if v_i > 100 then
    --  exit;
    --end if;
  
    exit when v_i > 100;
  
  end loop;

  --while循环
  v_i := 1;

  while v_i <= 100 loop
    dbms_output.put_line('while ' || v_i);
    v_i := v_i + 2;
  end loop;

  --for循环
  --默认步长加1.而且不能控制步长。
  --变量不需要定义。
  --for循环中，可以直接为一个结果集。
  v_i := 1;
  for v_i in 1 .. 100 loop
    dbms_output.put_line('for ' || v_i);
  end loop;

  for v_j in 1 .. 10 loop
    dbms_output.put_line('for ' || v_j);
  end loop;

  for v_userRow in (Select * From T_userinfo order by userid) loop
  
    dbms_output.put_line(v_userRow.userid || '   ' || v_userRow.username);
  end loop;
end;

