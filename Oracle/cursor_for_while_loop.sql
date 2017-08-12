循环结构
	1loop
	set serveroutput on	--有输出语句时 应用
		declare 
			i int:= 1;
			s int:= 0;
		begin 
			loop
				s := s + i;
				exit when i = 10;
				i := i + 1;
			end loop;
			dbms_output.put_line(s);
	end;
	2while
	set serveroutput on 
		declare 
			i int:= 1;
			s int:= 0;
		begin	
			while i <= 10 loop
				s := s + i;
			end loop;
			dbns_output.put_line(s);
		end;
	3for
	set serveroutput on 
		declare 
			i int:= 0;
			s innt:= 0;
		begin
			for i in 1..10 loop
				s := s + i;
			end loop;
		dbns_output.put_line(s);
		end;
游标：
	1使用游标查询单条数据
	set serveroutput on	
		declare 
			v_name t_user%type;
			cursor myCursor is select uname from t_user where uid = 1;	
		begin 
			open myCursor;
			fetch myCursor into v_name;
			dbns_output.put_line(v_name);
		end;
		--有数据传入时
		declare
			v_name t_user%type;
			inputDate t_user%type;
			cursor myCursor is select uname from t_user where uid = inputData;
		begin 
			inputData := '&inputData';
			fetch myCursor into v_name;
			dbms_output.put_line(v_name);
			close myCursor;
		end;
	2使用游标查询多条数据
	set serveroutput on	
		declare
			v_name t_user%type;
			type rec is record (uname varchar2(100));	--记录类型 用于for
			myRec rec;	--记录类型
			cursor myCursor is select uname from t_user ;--有用于修改或删除数据时后边加 for update
		begin 
			open myCursor;
			--while
			while myCursor%FOUND loop
				fetch myCursor into v_name;
				dbms_output.put_line(v_name);
			end loop;
			close myCursor;
			--loop
			open myCursor;
			loop
				exit when myCursor%NOTFOUND;
				fetch myCursor into v_name;
				dbns_output.put_line(v_name);
			end loop;
			close myCursor;
			--for
			open myCursor;
			for myRec in myCursor loop 
				dbms_output.put_line(myRec.uname);
			end loop;
		end;
		3带参游标
		set serveroutput on
			declare 
				v_name t_user.uname%type;
				id t_user.uid%type;
				cursor myCursor(id t_user%type) is select uname where uid = id;
			begin
				id := &id;
				open myCursor(id);
				loop
					exit when myCursor%NOTFOUND;
					fetch myCursor into v_name;
					dbns_output.put_line(v_name);
				end loop;
				close myCursor;
			end;
			
		
				
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			