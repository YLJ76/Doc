���ݿ���ļ��ṹ��

	����ṹ
		CTL
		LOG
		DBF
	�߼��ṹ
		��ռ䣺�߼������е�����ṹ��һ����յ����Զ�Ӧ1�����߶���������ļ���
			create tablespace java1411 
				datafile 'C:\oracle\product\10.1.0\oradata\orcl\java1411.dbf'
				size 100M

		�û���
			create user xx identified by yy default tablespace java1411;

		��
			create table 
		��
		    ����������ɡ�
			���ݶ�
			������
			��ʱ��
			�ع���

		���������Ŀ�����ݣ����һ������
		
		�飺���ݵ���С�洢��λ��


��
	�ֶ�
	�ֶ����ͣ�
		
		�����ͣ�Number
		�ַ��ͣ�Varchar/Char
		ʱ�����ͣ�datatime/timestamp
		���ֶ����ͣ�blob/clob

	Լ����
		�ǿ�Լ��		������Ϊ��
		Ψһ��Լ��		��ֵΨһ������1��Ϊ�ա�һ�ű�����ж��Ψһ��Լ��
		����Լ��		��ֵΨһ������Ϊ�գ�һ�ű�ֻ����һ������Լ��
		���Լ��		�����е�ֵ��Ӧ��һ�ű��������ֵ��
		���Լ��		������ֶ�ֵ�Ƿ���ĳһ����Χ֮�ڡ��Ա��У�Ů��������(18,20)

	
	�ֶμ�Լ��������ʱ����Լ��
	��Լ����
		A������ʱ����Լ��
		B�������֮�󣬴���Լ��
	

�ۺϺ��������

	�ۺϺ�����Count/Max/Min/Sum/Avg

	Group Byע���
		1���ۺϺ������Բ�������Group By����С�

			Select usersex From T_Userinfo group by usersex;
			Select usersex,count(1) From T_Userinfo group by usersex;

		2��Group by����У�select�����ֶΣ�group�ͱ����Ǽ����ֶΡ�

			select deptid,usersex,count(1) from T_userinfo group by deptid,usersex;

		3��Group by�������䣬����������where���������й��ˡ���where��������group by֮ǰ��

			Group by֮ǰʹ��where
			select deptid,usersex,count(1) from T_userinfo 
			where deptid not in (5,6)
			group by deptid,usersex

			Group by֮��ʹ��having,����having ������ֶ�ֻ����Select֮�е��ֶΡ�
			select deptid,usersex,count(1) from T_userinfo 
			group by deptid,usersex

			having deptid not in (5,6);

			ʹ���Ӳ�ѯ
			Select * From (
				select deptid,usersex,count(1) from T_userinfo 
				group by deptid,usersex 
			        ) t
			where t.deptid not in (5,6)


�Ӳ�ѯ��

	��ѯ�Ӳ�ѯ
			1��Select * From (
				select deptid,usersex,count(1) from T_userinfo 
				group by deptid,usersex 
			        ) t
			where t.deptid not in (5,6)
			
			2��oracle�ķ�ҳ��䡣

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

	����/ɾ���Ӳ�ѯ

			--�ظ�������1��
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

			--�ظ�������2��
			Select *
			  From T_userinfo a
			 inner join T_userinfo b
			    on a.username = b.username
			   and a.password = b.password
			   and a.truename = b.truename
			   and a.usersex = b.usersex
			   and a.userid != b.userid
			 order by a.username asc, a.userid asc
			 
			--ɾ���ظ������ݣ���һ����

			Delete From T_userinfo a
			where a.userid != (
			      Select min(userid) From T_userinfo b 
			      where a.username = b.username
			   and a.password = b.password
			   and a.truename = b.truename
			   and a.usersex = b.usersex
			)

	

��ת��
	
	Case Statement����Select��䣬����if/else���жϲ�����

	Select t.*,
	       CASE usersex
		 WHEN '1' THEN
		  '��'
		 WHEN '0' THEN
		  'Ů'
		 ELSE
		  'δ֪'
	       END usersex_str
	  From T_userinfo t;


	Select t.*,
	       CASE 
		 WHEN t.usersex = '1' THEN
		  '��'
		 WHEN t.usersex = '0' THEN
		  'Ů'
		 ELSE
		  'δ֪'
	       END usersex_str
	  From T_userinfo t;

	decode��oracle��ר�к���������ʵ��case��Ч����


	 select decode(usersex, '1', '��', '0', 'Ů', 'δ֪') as usersex, t.*
		From T_userinfo t;

		

		
select t.*, t.rowid from CJ t;

Select *
  From (Select stu_name,
               sum(case
                     when stu_subject = '����' then
                      round(stu_score, 2)
                     else
                      0
                   end) as ����,
               sum(case
                     when stu_subject = '��ѧ' then
                      round(stu_score, 2)
                     else
                      0
                   end) as ��ѧ,
               
               sum(case
                     when stu_subject = 'Ӣ��' then
                      round(stu_score, 2)
                     else
                      0
                   end) as Ӣ��,
               sum(round(stu_score, 2)) as �ϼ�
          from cj
         group by stu_name
        union
        select '�ϼ�' as stu_name,
               (select sum(stu_score) from cj where stu_subject = '����') as ����,
               (select sum(stu_score) from cj where stu_subject = '��ѧ') as ��ѧ,
               (select sum(stu_score) from cj where stu_subject = 'Ӣ��') as Ӣ��,
               (select sum(stu_score) from cj ) as �ܳɼ�
          from dual) t
 order by t.�ϼ� asc
    

1��PLSQL

	ʲô��PLSQL
	
2��PLSQL���ŵ�
	��֧��ֱ�ӱ�дDDL��DCL��䡣������ͨ����̬��SQL��ִ����������䡣

	���ѵ����ܣ�PL/SQL ��������ִ��



3��PLSQL��ִ�й���

	PLSQL��䷢�͵�����ˣ�PLSQL���潫PLSQL������SQL��䣬�ٽ�SQL�ŵ�SQL�����������С�
	
	�����еĽ�����͸��ͻ���
	
	ֻ�д洢�����̡�������������������PLSQL�Ż�洢�����ݿ��ڿ��С�PL/SQL����.


4�������볣��������

5�������ĸ�ֵ��
	
	A������ʱֱ�Ӹ�ֵ��  var_i number := 100;
	
	B���ڳ��������ڼ丳ֵ��
		Begin��
		
			(1)����̬��ֵ
			(2)����̬��ֵ��

6��PLSQL�������
	���������
		+ - * / mod(10,3)
		
	���������
		=  ���
		<> !=  ���ȡ�
		
	�߼������
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
    dbms_output.put_line('ֵΪtest');
  elsif v_str = 'admin' then
    dbms_output.put_line('ֵΪadmin');
  else
    dbms_output.put_line('�����');
  end if;

  v_itemname := '��Ʒ';
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
      v_sexName := '��';
    when '0' then
      v_sexName := 'Ů';
    else
      v_sexName := 'δ֪';
    
  end case;

  dbms_output.put_line(v_sexName);

  case
    when v_salary > 500 and v_salary < 1000 then
      v_salaryName := '������';
    when v_salary > 1000 and v_salary < 3000 then
      v_salaryName := '�е�����';
    when v_salary > 3000 and v_salary < 7000 then
      v_salaryName := '������';
    else
      v_salaryName := 'XX����';
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
    --dbms_output.put_line('i��ֵ = ' || v_i);
  end loop;

  v_i := 0;
  loop
    v_i := v_i + 1;
    exit when v_i > 100;
    --dbms_output.put_line('i��ֵ = ' || v_i);
  end loop;

  v_i := 0;
  while v_i < 100 loop
    v_i := v_i + 1;
    --dbms_output.put_line('i��ֵ = ' || v_i);
  end loop;
  
  v_i := 0;
  for v_i in 1..100 loop
    dbms_output.put_line('i��ֵ = ' || v_i);
  end loop;
end;


declare
  v_i number;
begin
  --ģ��break;
  v_i := 0;
  for v_i in 1 .. 100 loop
    --dbms_output.put_line('i��ֵ = ' || v_i);
    if v_i = 50 then
      exit;
    end if;
  end loop;

  --ģ��continue;
  v_i := 0;
  for v_i in 1 .. 100 loop
  
    if v_i = 50 then
      NULL;
    else
      dbms_output.put_line('i��ֵ = ' || v_i);
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
    --����������  
  end;
  <<quit>>
  NULL;
END;


/*
* ϵͳ�쳣

  A��С���쳣����Ҫд�ڴ���쳣֮ǰ��
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
      dbms_output.put_line(SQLCode || SQLERRM || '������Ϊ0���쳣');
      raise_application_error(-20001, SQLCode || SQLERRM || '������Ϊ0���쳣');
    end;
  */
  when others then
    begin
      --dbms_output.put_line(SQLCode || SQLERRM || '�����쳣');
      --raise_application_error(-20001, SQLCode || SQLERRM || '������Ϊ0���쳣');
    
      v_message := SQLERRM;
      v_message := TRIM(v_message);
      dbms_output.put_line(v_message);
      Insert into T_Error_Log
        (Log_Id, Log_Modalname, Log_Time, Log_User, Log_Message)
      values
        (seq_log.nextval, '�쳣ģ��', sysdate, user, v_message);
      commit;
    end;
    
    --��ȷ���쳣���������쳣�Ĵ洢���̡�
    
end;


/*
 A�������Զ����쳣
 
 B�������Զ����쳣
 
 C�������Զ����쳣
*/

declare
  v_salary number;
  v_exception exception;
  v_getSalary number;
begin

  v_getSalary := 4000;
  select salary into v_salary from T_Userinfo where userid = 4;

  if v_getSalary > v_salary then
    dbms_output.put_line('С��');
    raise v_exception;
  end if;
exception
  when v_exception then
    raise_application_error(-20001, '���������');
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
    dbms_output.put_line('ɾ����');
    execute immediate 'drop table ' || v_tableName || '';
  end if;

  v_createSQL := 'create Table ' || v_tableName ||
                 ' (id number primary key,name varchar2(10))';

  execute immediate v_createSQL;

  --д������
  for i in 1 .. 100 loop
    --insert into T_Test(Id,Name) values(i,'ֵ='||i);
    v_insertSQL := 'insert into ' || v_tableName ||
                   '(id,name) values('||i||',''ֵΪ'||i||''')';
    execute immediate v_insertSQL;
    commit;
  
  end loop;

end;

--select * From User_TAbles;
