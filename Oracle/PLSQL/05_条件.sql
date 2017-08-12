declare
  v_age number;
begin
  v_age := 43;
  --使用if/else
  if v_age < 10 then
    dbms_output.put_line('小于10');
  
  elsif v_age > 10 and v_age <= 20 then
    dbms_output.put_line('大于10并且小于20');
  
  elsif v_age > 20 and v_age <= 40 then
    dbms_output.put_line('大于20并且小于40');
  else
    dbms_output.put_line('大于40');
  end if;

  --使用case语句。
  v_age := 13;
  case
    when v_age < 10 then
      dbms_output.put_line('小于10');
    
    when v_age > 10 and v_age <= 20 then
      dbms_output.put_line('大于10并且小于20');
    
    when v_age > 20 and v_age <= 40 then
      dbms_output.put_line('大于20并且小于40');
    else
      dbms_output.put_line('大于40');
  end case;
end;
