declare
  v_i number;
begin
  v_i := 1;
  --loopѭ��
  loop
    dbms_output.put_line(v_i);
    v_i := v_i + 1;
    --�˳�ѭ��
    --if v_i > 100 then
    --  exit;
    --end if;
  
    exit when v_i > 100;
  
  end loop;

  --whileѭ��
  v_i := 1;

  while v_i <= 100 loop
    dbms_output.put_line('while ' || v_i);
    v_i := v_i + 2;
  end loop;

  --forѭ��
  --Ĭ�ϲ�����1.���Ҳ��ܿ��Ʋ�����
  --��������Ҫ���塣
  --forѭ���У�����ֱ��Ϊһ���������
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

