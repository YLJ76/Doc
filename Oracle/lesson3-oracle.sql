-----------创建简单表
 create table t_test(a1 int);
 
 create table t_test1(a1 int) tablespace system;
 
 
 --增加列a2
 alter table t_test
 add a2 char(10);
 
 --修改列名
 alter table t_test
 rename column a2 to a3;
 
 --修改列的数据类型
 alter table t_test
 modify a3 int;
 
 select * from test;
 
 --删除列
 alter table t_test
 drop column a3;
 
 --修改表名
 alter table t_test
 rename to test;
 
 --删除表
drop table t_test;
drop table t_test1;


---------------------约束的使用------------------------
create table T_Student 
(
       sid varchar2(20),
       sex char(2),
       birthday date
);

--增加姓名列
alter table t_student add name char(10);

select * from t_student;

insert into t_student(sid,name,birthday,sex) values('s002','张三',to_date('1990/1/1','yyyy/MM/dd'),'男');

--删除数据
delete from t_student;
truncate table t_student;

--姓名不能为空
alter table t_student modify name char(10) not null;

--增加Sex列的默认值
alter table t_student modify sex char(2) default '男';
--增加Sex列的检查约束
alter table t_student 
add constraint ck_student_sex
check (sex in('男','女','m','f'));


--出生日期增加日期的约束(1980/1/1--2010/12/30)
alter table t_student modify birthday not null;

alter table t_student 
add constraint ck_student_birthday 
check (birthday between to_date('1980/1/1','yyyy/MM/dd') and to_date('2010/12/30','yyyy/MM/dd'));

--在sid列上创建主键
alter table t_student 
add constraint pk_student_sid
primary key (sid);

--在name列上创建唯一性约束
alter table t_student 
add constraint un_student_name
unique (name);


--学生成绩表
create table t_score 
(
       id int primary key,
       sid varchar2(20),
       math int,
       english int,
       foreign key (sid) references t_student(sid) on delete cascade
);

drop table t_score;

--成绩表插入数据
insert into t_score values(1,'s002',20,20);

select * from t_score;