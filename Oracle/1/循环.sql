create table t_number(
       num number
);
select * from t_number for update;
truncate table t_number;
declare
  i int:= 1;  --��������
begin 
  loop    --ѭ����ʼ
    insert into t_number values(i); --��������
    exit when i = 10;    --�ж��Ƿ�����ѭ��
    i := i + 1; --�����������
  end loop;  --ѭ������
end;
/

declare
  i int:= 1;
begin 
  while i < 11 loop      --ѭ����ʼ
    insert into t_number values(i); --����
    i := i + 1; --�����������
  end loop;  --ѭ������
end;
/

declare
  i int:= 1;
begin 
  for i in 1 .. 10 loop  --ѭ����ʼ
    insert into t_number values (i);  --����
  end loop;  --ѭ������
end;
/
  


    
