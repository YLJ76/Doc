create table stu(
       id number primary key,
       name varchar2(20)
);
insert into stu(id,name) values(1,'小明');
insert into stu(id,name) values(2,'小红');

create table t_user(
       id number primary key,
       iden number,
       name varchar2(20)
);
insert into t_user values(1,2,'小明2');

create table identity(
    id number primary key,
    name varchar2(20)
);
insert into identity values(1,'普通用户');
insert into identity values(2,'会员');
insert into identity values(3,'管理员');

select * from t_user right join identity on t_user.iden = identity.id;


select * from t_user,identity where t_user.iden(+) = identity.id;

select * from t_user,identity where t_user.iden = identity.id;
