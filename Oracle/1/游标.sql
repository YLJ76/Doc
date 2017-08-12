--游标

1、步骤
  A、声明游标
  B、打开游标
  C、读取数据
  D、关闭游标
 
2、属性
  A、%ISOPEN：布尔型，游标是否打开。
  B、%FOUND: 布尔型，是否读取到数据。
  C、%NOTFOUND:与%FOUND相反。
  D、%ROWCOUNT:数值型，返回到目前为止已经从游标缓冲区中提取数据的行数。
  
3、游标应用
  A、浏览数据
select * from t_user for update;
--loop
set serveroutput on
declare
  uname t_user.name%type;
  cursor myCur is  --定义游标
   select name from t_user;
begin
  if not myCur%ISOPEN then 
    open myCur;  --打开游标
  end if;
  loop
     fetch myCur into uname;  --读取数据
     exit when myCur%notfound;
     dbms_output.put_line(uname);
   end loop;
   close myCur;  --关闭游标
   exception --异常
     when no_data_found then
       dbms_output.put_line('数据不存在！');
end;
/
--for 会自动打开游标，遍历完数据时，退出循环并关闭游标
set serveroutput on
declare
  cursor myCur is  --定义游标
   select name from t_user;
begin
  for user in myCur loop
     dbms_output.put_line(user.name);
   end loop;
  exception --异常
     when no_data_found then
       dbms_output.put_line('数据不存在！');
end;
/
   B、修改数据（修改姓名中含'a'的数据修改）

declare
  uid t_user.id%type;
  cursor myCur is 
    select u.id 
    from t_user u 
    where u.name like '%a%' 
    for update; --for update在游标结果集上加行共享锁
begin
   if not myCur%ISOPEN then 
      open myCur;  --打开游标
   end if; 
   loop 
     fetch myCur into uid;
     exit when myCur%notfound;
     case uid 
       when 1 then 
         update t_user u set u.name = 'Array' 
         where current of myCur;  --对游标当前指向的数据进行修改
       else
         update t_user u set u.name = 'vector' 
         where current of myCur;
      end case;
   end loop;
   close myCur;
end;
/
   C、删除数据
declare
uid t_user.id%type;
cursor myCur is
  select u.id 
  from t_user u 
  where u.name like '%a%'
  for update;
begin
 if not myCur%ISOPEN then 
   open myCur;  --打开游标
 end if;
 fetch myCur into uid;--先获取一条记录
 while myCur%found loop
   if uid = 1 then --条件，若ID为1删除
     delete from t_user where current of myCur;
   end if;
   fetch myCur into uid;--遍历一条记录
 end loop;
 close myCur;
end;
/
     
   
     
   
       
  
