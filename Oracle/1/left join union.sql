create table stu(
       id number primary key,
       name varchar2(20)
);
insert into stu(id,name) values(1,'С��');
insert into stu(id,name) values(2,'С��');

create table t_user(
       id number primary key,
       iden number,
       name varchar2(20)
);
insert into t_user values(1,2,'С��2');

create table identity(
    id number primary key,
    name varchar2(20)
);
insert into identity values(1,'��ͨ�û�');
insert into identity values(2,'��Ա');
insert into identity values(3,'����Ա');

select * from t_user right join identity on t_user.iden = identity.id;


select * from t_user,identity where t_user.iden(+) = identity.id;

select * from t_user,identity where t_user.iden = identity.id;
