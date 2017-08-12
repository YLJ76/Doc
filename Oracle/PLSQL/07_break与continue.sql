/*
 * 使用GoTo/return/null来模拟break与continue
 */
declare
begin
  for v_j in 1 .. 10 loop
    if v_j =5 then
      --break;
      --return;
      GOTO next_code;
    end if;
    dbms_output.put_line('break' || v_j);
  end loop;
  
  
  <<next_code>>
  for v_j in 1 .. 10 loop
    if v_j =5 then
       NULL;
    else
       dbms_output.put_line('continue ' || v_j);  
    end if;
  end loop;  
end;

