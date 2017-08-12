-----------�����򵥱�
 create table t_test(a1 int);
 
 create table t_test1(a1 int) tablespace system;
 
 
 --������a2
 alter table t_test
 add a2 char(10);
 
 --�޸�����
 alter table t_test
 rename column a2 to a3;
 
 --�޸��е���������
 alter table t_test
 modify a3 int;
 
 select * from test;
 
 --ɾ����
 alter table t_test
 drop column a3;
 
 --�޸ı���
 alter table t_test
 rename to test;
 
 --ɾ����
drop table t_test;
drop table t_test1;


---------------------Լ����ʹ��------------------------
create table T_Student 
(
       sid varchar2(20),
       sex char(2),
       birthday date
);

--����������
alter table t_student add name char(10);

select * from t_student;

insert into t_student(sid,name,birthday,sex) values('s002','����',to_date('1990/1/1','yyyy/MM/dd'),'��');

--ɾ������
delete from t_student;
truncate table t_student;

--��������Ϊ��
alter table t_student modify name char(10) not null;

--����Sex�е�Ĭ��ֵ
alter table t_student modify sex char(2) default '��';
--����Sex�еļ��Լ��
alter table t_student 
add constraint ck_student_sex
check (sex in('��','Ů','m','f'));


--���������������ڵ�Լ��(1980/1/1--2010/12/30)
alter table t_student modify birthday not null;

alter table t_student 
add constraint ck_student_birthday 
check (birthday between to_date('1980/1/1','yyyy/MM/dd') and to_date('2010/12/30','yyyy/MM/dd'));

--��sid���ϴ�������
alter table t_student 
add constraint pk_student_sid
primary key (sid);

--��name���ϴ���Ψһ��Լ��
alter table t_student 
add constraint un_student_name
unique (name);


--ѧ���ɼ���
create table t_score 
(
       id int primary key,
       sid varchar2(20),
       math int,
       english int,
       foreign key (sid) references t_student(sid) on delete cascade
);

drop table t_score;

--�ɼ����������
insert into t_score values(1,'s002',20,20);

select * from t_score;