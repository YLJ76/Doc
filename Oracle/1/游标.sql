--�α�

1������
  A�������α�
  B�����α�
  C����ȡ����
  D���ر��α�
 
2������
  A��%ISOPEN�������ͣ��α��Ƿ�򿪡�
  B��%FOUND: �����ͣ��Ƿ��ȡ�����ݡ�
  C��%NOTFOUND:��%FOUND�෴��
  D��%ROWCOUNT:��ֵ�ͣ����ص�ĿǰΪֹ�Ѿ����α껺��������ȡ���ݵ�������
  
3���α�Ӧ��
  A���������
select * from t_user for update;
--loop
set serveroutput on
declare
  uname t_user.name%type;
  cursor myCur is  --�����α�
   select name from t_user;
begin
  if not myCur%ISOPEN then 
    open myCur;  --���α�
  end if;
  loop
     fetch myCur into uname;  --��ȡ����
     exit when myCur%notfound;
     dbms_output.put_line(uname);
   end loop;
   close myCur;  --�ر��α�
   exception --�쳣
     when no_data_found then
       dbms_output.put_line('���ݲ����ڣ�');
end;
/
--for ���Զ����α꣬����������ʱ���˳�ѭ�����ر��α�
set serveroutput on
declare
  cursor myCur is  --�����α�
   select name from t_user;
begin
  for user in myCur loop
     dbms_output.put_line(user.name);
   end loop;
  exception --�쳣
     when no_data_found then
       dbms_output.put_line('���ݲ����ڣ�');
end;
/
   B���޸����ݣ��޸������к�'a'�������޸ģ�

declare
  uid t_user.id%type;
  cursor myCur is 
    select u.id 
    from t_user u 
    where u.name like '%a%' 
    for update; --for update���α������ϼ��й�����
begin
   if not myCur%ISOPEN then 
      open myCur;  --���α�
   end if; 
   loop 
     fetch myCur into uid;
     exit when myCur%notfound;
     case uid 
       when 1 then 
         update t_user u set u.name = 'Array' 
         where current of myCur;  --���α굱ǰָ������ݽ����޸�
       else
         update t_user u set u.name = 'vector' 
         where current of myCur;
      end case;
   end loop;
   close myCur;
end;
/
   C��ɾ������
declare
uid t_user.id%type;
cursor myCur is
  select u.id 
  from t_user u 
  where u.name like '%a%'
  for update;
begin
 if not myCur%ISOPEN then 
   open myCur;  --���α�
 end if;
 fetch myCur into uid;--�Ȼ�ȡһ����¼
 while myCur%found loop
   if uid = 1 then --��������IDΪ1ɾ��
     delete from t_user where current of myCur;
   end if;
   fetch myCur into uid;--����һ����¼
 end loop;
 close myCur;
end;
/
     
   
     
   
       
  
