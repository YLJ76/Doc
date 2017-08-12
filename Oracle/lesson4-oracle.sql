insert into t_score values(1,'s001',20,20);


--序列

create sequence seq_score
start with 1
increment by 1;


--使用序列

select seq_score.nextval from dual;
select seq_score.currval from dual;

insert into t_score values(seq_score.nextval,'s001',20,20);


select * from t_score;

select * from v$tablespace;



select * from t_score;

create or replace view v_score
as
select sid,english from t_score where english>60 with check option;


create or replace view v_score_all
as
select sid,english+math as total from t_score order by total desc;

select * from v_score_all;

--grant select on v_score to somebody

insert into v_score values('s001',30);

---多表查询

--增加测试数据
delete from t_student;
insert into t_student(sid,name,birthday,sex) values('s001','张三',to_date('1980/1/1','yyyy/MM/dd'),'男');
insert into t_student(sid,name,birthday,sex) values('s002','李四',to_date('1999/1/1','yyyy/MM/dd'),'女');
insert into t_student(sid,name,birthday,sex) values('s003','王五',to_date('1992/1/1','yyyy/MM/dd'),'男');
insert into t_student(sid,name,birthday,sex) values('s004','赵六',to_date('1988/1/1','yyyy/MM/dd'),'女');

delete from t_score; 
insert into t_score values(seq_score.nextval,'s001',20,80);
insert into t_score values(seq_score.nextval,'s003',60,50);
insert into t_score values(seq_score.nextval,'s004',40,90);

select * from t_student;
select * from t_Score;

--多表查询
select name,english 
from t_student t ,t_Score  s
where t.sid=s.sid

--inner join方式连接
select name,english 
from t_student  t
inner join t_score s
on  t.sid = s.sid;

--left join方式连接
select name,english 
from t_student  t
left join t_score s
on  t.sid = s.sid;

--right join方式连接
select name,english 
from t_student  t
right join t_score s
on  t.sid = s.sid;

--full join方式连接
select name,english 
from t_student  t
full join t_score s
on  t.sid = s.sid;

--cross join方式连接
select name,english 
from t_student  t
cross join t_score s;

--通过scott用户的emp表和salgrade表，查询员工的工资等级。
select * from emp;
select * from salgrade;
select * from dept;

--empno.ename,job,grade,
select empno,ename,job,grade
from emp
inner join salgrade
on emp.sal between salgrade.losal and salgrade.hisal;

--empno.ename,job,grade,工作所在地
select empno,ename,job,grade,loc
from
(
  select empno,ename,job,grade,deptno
  from emp
  inner join salgrade
  on emp.sal between salgrade.losal and salgrade.hisal
) tmp
inner join dept
on tmp.deptno = dept.deptno;


--相关子查询
--查询各个部门中，哪些员工的工资低于其所在部门的平均工资
select empno,ename,job,sal,deptno
from emp pemp
where sal< 
(
      select avg(sal) from emp where emp.deptno=pemp.deptno
)
order by deptno ;


select deptno,avg(sal) from emp group by deptno;

select * from emp
where not exists (select * from emp where empno=1);

--把所有参加考试的学生信息打印出来
select * from t_student ps
where exists (select * from t_score where t_score.sid = ps.sid);


--嵌套子查询
--已知工作地点在NEW YORK和CHICAGO的两个部门，
--要求根据这两个部门的平均工资中的最大值，
--获取工资大于这个最大值的的员工信息

select * from emp
where sal>
(
select max(avgsal)
from
(
select * from
(
 select deptno, avg(sal) as avgsal from emp group by deptno
) tmp where deptno in(
  select deptno from dept 
where loc in('NEW YORK','CHICAGO')
))
 tmp1);





