--查看示例表的数据
select * from dept;
select * from emp;
select * from salgrade;

--复制表(复制表结构)
create table n_emp 
as
select * from emp where 1=2;

drop table n_emp;

select * from n_emp;

--distinct
select distinct * from emp;

--alias
select empno as 编号,ename 姓名 from emp  e;

--insert
insert into emp(ename) values(8000,'张三','clerk',7369,to_date('2012-1-1','yyyy/MM/dd'),1000.00,0,20);
rollback;
commit;


select * from n_emp;

insert into n_emp
select * from emp where sal>=3000;

drop table n_emp;

create table n_emp 
as
select empno,ename from emp where 1=2;


select * from n_emp;

insert into n_emp
select sal,empno from emp;


--save point

create table n_emp 
as
select empno from emp where 1=2;

select * from n_emp;


insert into n_emp values(1);
savepoint sp1;
insert into n_emp values(2);
savepoint sp2;
insert into n_emp values(3);
savepoint sp3;

rollback to savepoint sp2;

commit;

--between...and
select * from emp where sal between 1500 and 3000;
--in
select * from emp where empno=7499 or empno=7566 or empno=7902;
select * from emp where empno not in(7499,7566,7902);


--is null
select * from emp where comm is null;

--运算
select ename,sal+100 as 国庆福利 from emp; 

--创建测试用的数据
create table a_emp (emp int);
insert into a_emp values(1);
insert into a_emp values(11);
insert into a_emp values(111);


create table b_emp (emp int);
insert into b_emp values(2);
insert into b_emp values(22);
insert into b_emp values(222);


create table c_emp (emp int);
insert into c_emp values(3);
insert into c_emp values(33);
insert into c_emp values(333);
--union
select * from a_emp
union
select * from b_emp
union
select * from c_emp


--连接符
select 'Mr.' || ename from emp;

--日期运算函数
select sysdate from dual;
select add_months(sysdate,1)from dual;

--min
select min(sal) from emp;

--max
select max(sal) from emp;

--sum

select sum(sal) from emp;

--avg

select avg(sal) from emp;

--count

select count(*) from emp;


select * from emp;

--请统计各部门平均工资
select deptno, avg(sal) from emp 
group by deptno
order by avg(sal) desc
;

--请统计各部门平均工资(大于2000)
select deptno, avg(sal) from emp 
group by deptno having avg(sal)>2000;