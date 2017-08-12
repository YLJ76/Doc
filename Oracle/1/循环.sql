create table t_number(
       num number
);
select * from t_number for update;
truncate table t_number;
declare
  i int:= 1;  --变量声明
begin 
  loop    --循环开始
    insert into t_number values(i); --操作数据
    exit when i = 10;    --判定是否跳出循环
    i := i + 1; --条件参数变更
  end loop;  --循环结束
end;
/

declare
  i int:= 1;
begin 
  while i < 11 loop      --循环开始
    insert into t_number values(i); --操作
    i := i + 1; --条件参数变更
  end loop;  --循环结束
end;
/

declare
  i int:= 1;
begin 
  for i in 1 .. 10 loop  --循环开始
    insert into t_number values (i);  --操作
  end loop;  --循环结束
end;
/
  


    
