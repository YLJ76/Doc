declare
  v_age number;
begin
  v_age := 43;
  --ʹ��if/else
  if v_age < 10 then
    dbms_output.put_line('С��10');
  
  elsif v_age > 10 and v_age <= 20 then
    dbms_output.put_line('����10����С��20');
  
  elsif v_age > 20 and v_age <= 40 then
    dbms_output.put_line('����20����С��40');
  else
    dbms_output.put_line('����40');
  end if;

  --ʹ��case��䡣
  v_age := 13;
  case
    when v_age < 10 then
      dbms_output.put_line('С��10');
    
    when v_age > 10 and v_age <= 20 then
      dbms_output.put_line('����10����С��20');
    
    when v_age > 20 and v_age <= 40 then
      dbms_output.put_line('����20����С��40');
    else
      dbms_output.put_line('����40');
  end case;
end;
