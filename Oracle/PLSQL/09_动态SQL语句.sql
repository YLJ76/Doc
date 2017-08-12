/*动态建表，动态插数据，动态计算，删除*/
declare
  v_createSQL varchar2(1000);
  v_isExist   number;
  v_insertSQL varchar2(1000);
begin
  select count(1)
    into v_isExist
    From User_tables
   where table_name = 'T_TEMP';
  if v_isExist > 0 then
    dbms_output.put_line('表存在，执行删除的操作');
    execute immediate 'drop table T_Temp';
  end if;
  v_createSQL := 'create table T_temp(';
  v_createSQL := v_createSQL || ' temp_id number primary key,';
  v_createSQL := v_createSQL || ' temp_name varchar2(100),';
  v_createSQL := v_createSQL || ' temp_count number';
  v_createSQL := v_createSQL || ' )';

  execute immediate v_createSQL;

  --插入数据
  for v_i in 1 .. 100 loop
  
    v_insertSQL := 'insert into T_Temp (Temp_Id, Temp_Name, Temp_Count)';
    v_insertSQL := v_insertSQL || 'values (';
    v_insertSQL := v_insertSQL || ' ' || v_i || ',''名称_' || v_i || ''', ' ||
                   v_i * 10 || ') ';
                   
    execute immediate v_insertSQL;
  end loop;
 commit;
 --逻辑业务(游标)
 
 --删除
 
end;
