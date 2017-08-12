数据库的文件结构：

	物理结构
		CTL
		LOG
		DBF
	逻辑结构
		表空间：逻辑意义中的物理结构。一个表空单可以对应1个或者多个的物理文件。
			create tablespace java1411 
				datafile 'C:\oracle\product\10.1.0\oradata\orcl\java1411.dbf'
				size 100M

		用户：
			create user xx identified by yy default tablespace java1411;

		表
			create table 
		段
		    段是由区组成。
			数据段
			索引段
			临时段
			回滚段

		区：连续的块的数据，组成一个区。
		
		块：数据的最小存储单位。


表：
	字段
	字段类型：
		
		数字型：Number
		字符型：Varchar/Char
		时间类型：datatime/timestamp
		大字段类型：blob/clob

	约束：
		非空约束		：不能为空
		唯一性约束		：值唯一，允许1个为空。一张表可以有多个唯一性约束
		主键约束		：值唯一，不能为空，一张表只能有一个主键约束
		外键约束		：表中的值对应另一张表的主键的值。
		检查约束		：检查字段值是否处于某一个范围之内。性别（男，女），年龄(18,20)

	
	字段级约束：建表时建立约束
	表级约束：
		A：建表时创建约束
		B：建完表之后，创建约束
	

聚合函数与分组

	聚合函数：Count/Max/Min/Sum/Avg

	Group By注意点
		1：聚合函数可以不出现在Group By语句中。

			Select usersex From T_Userinfo group by usersex;
			Select usersex,count(1) From T_Userinfo group by usersex;

		2：Group by语句中，select几个字段，group就必须是几个字段。

			select deptid,usersex,count(1) from T_userinfo group by deptid,usersex;

		3：Group by后面的语句，不可以再用where语名来进行过滤。但where可以用在group by之前。

			Group by之前使用where
			select deptid,usersex,count(1) from T_userinfo 
			where deptid not in (5,6)
			group by deptid,usersex

			Group by之后使用having,而且having 后面的字段只能是Select之中的字段。
			select deptid,usersex,count(1) from T_userinfo 
			group by deptid,usersex

			having deptid not in (5,6);

			使用子查询
			Select * From (
				select deptid,usersex,count(1) from T_userinfo 
				group by deptid,usersex 
			        ) t
			where t.deptid not in (5,6)


子查询：

	查询子查询
			1：Select * From (
				select deptid,usersex,count(1) from T_userinfo 
				group by deptid,usersex 
			        ) t
			where t.deptid not in (5,6)
			
			2：oracle的分页语句。

			Select *
			  From (Select rownum rn, t.*
				  From (Select * From T_userinfo order by userid asc) t
				 where rownum <= 10) temp
			 where temp.rn > 0;
					 
			Select *
			  From (Select rownum rn, t.*
				  From (Select * From T_userinfo order by userid asc) t
				 where rownum <= 20) temp
			 where temp.rn > 10; 

	更新/删除子查询

			--重复的数据1：
			Select *
			  From T_Userinfo
			 where username in
			       (Select username
				  from (Select username, password, truename, usersex, count(1)
					  From T_Userinfo
					 group by username, password, truename, usersex
					having count(1) > 1
					 order by count(1) desc) t)
			order by username asc,userid asc

			--重复的数据2：
			Select *
			  From T_userinfo a
			 inner join T_userinfo b
			    on a.username = b.username
			   and a.password = b.password
			   and a.truename = b.truename
			   and a.usersex = b.usersex
			   and a.userid != b.userid
			 order by a.username asc, a.userid asc
			 
			--删除重复的数据，留一条。

			Delete From T_userinfo a
			where a.userid != (
			      Select min(userid) From T_userinfo b 
			      where a.username = b.username
			   and a.password = b.password
			   and a.truename = b.truename
			   and a.usersex = b.usersex
			)

	

行转列
	
	Case Statement：在Select语句，产生if/else的判断操作。

	Select t.*,
	       CASE usersex
		 WHEN '1' THEN
		  '男'
		 WHEN '0' THEN
		  '女'
		 ELSE
		  '未知'
	       END usersex_str
	  From T_userinfo t;


	Select t.*,
	       CASE 
		 WHEN t.usersex = '1' THEN
		  '男'
		 WHEN t.usersex = '0' THEN
		  '女'
		 ELSE
		  '未知'
	       END usersex_str
	  From T_userinfo t;

	decode：oracle中专有函数：用于实现case的效果。


	 select decode(usersex, '1', '男', '0', '女', '未知') as usersex, t.*
		From T_userinfo t;

		

		
select t.*, t.rowid from CJ t;

Select *
  From (Select stu_name,
               sum(case
                     when stu_subject = '语文' then
                      round(stu_score, 2)
                     else
                      0
                   end) as 语文,
               sum(case
                     when stu_subject = '数学' then
                      round(stu_score, 2)
                     else
                      0
                   end) as 数学,
               
               sum(case
                     when stu_subject = '英语' then
                      round(stu_score, 2)
                     else
                      0
                   end) as 英语,
               sum(round(stu_score, 2)) as 合计
          from cj
         group by stu_name
        union
        select '合计' as stu_name,
               (select sum(stu_score) from cj where stu_subject = '语文') as 语文,
               (select sum(stu_score) from cj where stu_subject = '数学') as 数学,
               (select sum(stu_score) from cj where stu_subject = '英语') as 英语,
               (select sum(stu_score) from cj ) as 总成绩
          from dual) t
 order by t.合计 asc
    

1：PLSQL

	什么是PLSQL
	
2：PLSQL的优点
	不支持直接编写DDL和DCL语句。但可以通过动态的SQL来执行这两种语句。

	更佳的性能，PL/SQL 经过编译执行



3：PLSQL的执行过程

	PLSQL语句发送到服务端，PLSQL引擎将PLSQL解析成SQL语句，再将SQL放到SQL解析器中运行。
	
	再运行的结果发送给客户。
	
	只有存储过过程、函数、触发器、包等PLSQL才会存储在数据库内库中。PL/SQL程序.


4：变量与常量的声明

5：变量的赋值。
	
	A：定义时直接赋值。  var_i number := 100;
	
	B：在程序运行期间赋值。
		Begin。
		
			(1)：静态赋值
			(2)：动态赋值。

6：PLSQL的运算符
	算术运算符
		+ - * / mod(10,3)
		
	条件运算符
		=  相等
		<> !=  不等。
		
	逻辑运算符
		&& || !				java
		and or not			pl/sql
	
		

declare
  v_str      varchar2(20);
  v_itemname t_item.itemname%type;
  v_price    t_item.itemprice%type;

  v_sql varchar2(1000);

begin
  v_str := 'admin';

  if v_str = 'test' then
    dbms_output.put_line('值为test');
  elsif v_str = 'admin' then
    dbms_output.put_line('值为admin');
  else
    dbms_output.put_line('不相等');
  end if;

  v_itemname := '商品';
  v_price    := 20;
  v_sql      := 'Select * From T_Item where 1 = 1';

  if v_itemname is not null and v_itemname != ' ' then
    v_sql := v_sql || ' and itemname like '' %' || v_itemname || '% '' ';
  end if;

  if v_price is not null then
    v_sql := v_sql || ' and itemprice>=' || v_price ||
             '  and itemprice <=' || v_price || '';
  end if;

  dbms_output.put_line(v_sql);
end;



declare
  v_salary     T_Userinfo.Salary%type;
  v_salaryName varchar2(100);
  v_usersex    T_Userinfo.Usersex%type;
  v_sexName    varchar2(100);

begin
  select usersex, salary
    into v_usersex, v_salary
    from T_Userinfo
   where userid = '4';

  case v_usersex
    when '1' then
      v_sexName := '男';
    when '0' then
      v_sexName := '女';
    else
      v_sexName := '未知';
    
  end case;

  dbms_output.put_line(v_sexName);

  case
    when v_salary > 500 and v_salary < 1000 then
      v_salaryName := '低收入';
    when v_salary > 1000 and v_salary < 3000 then
      v_salaryName := '中等收入';
    when v_salary > 3000 and v_salary < 7000 then
      v_salaryName := '高收入';
    else
      v_salaryName := 'XX收入';
  end case;
  
  dbms_output.put_line(v_salary || v_salaryName);
end;


declare
  v_i number;
begin
  v_i := 0;
  loop
    v_i := v_i + 1;
    if v_i > 100 then
      exit;
    end if;
    --dbms_output.put_line('i的值 = ' || v_i);
  end loop;

  v_i := 0;
  loop
    v_i := v_i + 1;
    exit when v_i > 100;
    --dbms_output.put_line('i的值 = ' || v_i);
  end loop;

  v_i := 0;
  while v_i < 100 loop
    v_i := v_i + 1;
    --dbms_output.put_line('i的值 = ' || v_i);
  end loop;
  
  v_i := 0;
  for v_i in 1..100 loop
    dbms_output.put_line('i的值 = ' || v_i);
  end loop;
end;


declare
  v_i number;
begin
  --模拟break;
  v_i := 0;
  for v_i in 1 .. 100 loop
    --dbms_output.put_line('i的值 = ' || v_i);
    if v_i = 50 then
      exit;
    end if;
  end loop;

  --模拟continue;
  v_i := 0;
  for v_i in 1 .. 100 loop
  
    if v_i = 50 then
      NULL;
    else
      dbms_output.put_line('i的值 = ' || v_i);
    end if;
  end loop;

end;



DECLARE
  qtyhand itemfile.qty_hand%type;
  relevel itemfile.re_level%type;
BEGIN
  SELECT qty_hand, re_level
    INTO qtyhand, relevel
    FROM itemfile
   WHERE itemcode = 'i201';
  IF qtyhand < relevel THEN
    GOTO updation;
  ELSE
    GOTO quit;
  END IF;
  <<updation>>
  begin
    UPDATE itemfile
       SET qty_hand = qty_hand + re_level
     WHERE itemcode = 'i201';
    --其它的事情  
  end;
  <<quit>>
  NULL;
END;


/*
* 系统异常

  A：小的异常必须要写在大的异常之前。
*/
declare
  v_i       number;
  v_message varchar2(200);
begin
  v_i := 10 / 0;
exception
  /*
  when Zero_divide then
    begin
      dbms_output.put_line(SQLCode || SQLERRM || '被除数为0的异常');
      raise_application_error(-20001, SQLCode || SQLERRM || '被除数为0的异常');
    end;
  */
  when others then
    begin
      --dbms_output.put_line(SQLCode || SQLERRM || '其它异常');
      --raise_application_error(-20001, SQLCode || SQLERRM || '被除数为0的异常');
    
      v_message := SQLERRM;
      v_message := TRIM(v_message);
      dbms_output.put_line(v_message);
      Insert into T_Error_Log
        (Log_Id, Log_Modalname, Log_Time, Log_User, Log_Message)
      values
        (seq_log.nextval, '异常模块', sysdate, user, v_message);
      commit;
    end;
    
    --正确的异常处理：调用异常的存储过程。
    
end;


/*
 A：定义自定义异常
 
 B：触发自定义异常
 
 C：捕获自定义异常
*/

declare
  v_salary number;
  v_exception exception;
  v_getSalary number;
begin

  v_getSalary := 4000;
  select salary into v_salary from T_Userinfo where userid = 4;

  if v_getSalary > v_salary then
    dbms_output.put_line('小于');
    raise v_exception;
  end if;
exception
  when v_exception then
    raise_application_error(-20001, '超出金额数');
  when others then
    raise_application_error(-20001, SQLErrm);
end;


declare
  v_userid number;
begin
  begin
    select userid into v_userid from T_Userinfo where userid = 11111;
  
    if v_userid is not null and v_userid != ' ' then
      null;
    
    end if;
  
  exception
    when others then
      begin
        v_userid := 20;
      end;
  end;
  
  dbms_output.put_line('userid = ' || v_userid);

exception
  when others then
    dbms_output.put_line(sqlErrm);
  
end;


declare

begin
   execute immediate 'drop table t_a';
end;


declare
  v_tableName varchar2(100);
  v_count     number;
  v_createSQL varchar2(300);
  v_insertSQL varchar2(200);
begin
  v_tableName := 'T_Test';
  v_tableName := upper(v_tableName);
  select count(1)
    into v_count
    From User_Tables
   where Table_Name = v_tableName;

  dbms_output.put_line(v_count);
  if v_count > 0 then
    dbms_output.put_line('删除表');
    execute immediate 'drop table ' || v_tableName || '';
  end if;

  v_createSQL := 'create Table ' || v_tableName ||
                 ' (id number primary key,name varchar2(10))';

  execute immediate v_createSQL;

  --写入数据
  for i in 1 .. 100 loop
    --insert into T_Test(Id,Name) values(i,'值='||i);
    v_insertSQL := 'insert into ' || v_tableName ||
                   '(id,name) values('||i||',''值为'||i||''')';
    execute immediate v_insertSQL;
    commit;
  
  end loop;

end;

--select * From User_TAbles;
