insert into t_score values(1,'s001',20,20);


--����

create sequence seq_score
start with 1
increment by 1;


--ʹ������

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

---����ѯ

--���Ӳ�������
delete from t_student;
insert into t_student(sid,name,birthday,sex) values('s001','����',to_date('1980/1/1','yyyy/MM/dd'),'��');
insert into t_student(sid,name,birthday,sex) values('s002','����',to_date('1999/1/1','yyyy/MM/dd'),'Ů');
insert into t_student(sid,name,birthday,sex) values('s003','����',to_date('1992/1/1','yyyy/MM/dd'),'��');
insert into t_student(sid,name,birthday,sex) values('s004','����',to_date('1988/1/1','yyyy/MM/dd'),'Ů');

delete from t_score; 
insert into t_score values(seq_score.nextval,'s001',20,80);
insert into t_score values(seq_score.nextval,'s003',60,50);
insert into t_score values(seq_score.nextval,'s004',40,90);

select * from t_student;
select * from t_Score;

--����ѯ
select name,english 
from t_student t ,t_Score  s
where t.sid=s.sid

--inner join��ʽ����
select name,english 
from t_student  t
inner join t_score s
on  t.sid = s.sid;

--left join��ʽ����
select name,english 
from t_student  t
left join t_score s
on  t.sid = s.sid;

--right join��ʽ����
select name,english 
from t_student  t
right join t_score s
on  t.sid = s.sid;

--full join��ʽ����
select name,english 
from t_student  t
full join t_score s
on  t.sid = s.sid;

--cross join��ʽ����
select name,english 
from t_student  t
cross join t_score s;

--ͨ��scott�û���emp���salgrade����ѯԱ���Ĺ��ʵȼ���
select * from emp;
select * from salgrade;
select * from dept;

--empno.ename,job,grade,
select empno,ename,job,grade
from emp
inner join salgrade
on emp.sal between salgrade.losal and salgrade.hisal;

--empno.ename,job,grade,�������ڵ�
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


--����Ӳ�ѯ
--��ѯ���������У���ЩԱ���Ĺ��ʵ��������ڲ��ŵ�ƽ������
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

--�����вμӿ��Ե�ѧ����Ϣ��ӡ����
select * from t_student ps
where exists (select * from t_score where t_score.sid = ps.sid);


--Ƕ���Ӳ�ѯ
--��֪�����ص���NEW YORK��CHICAGO���������ţ�
--Ҫ��������������ŵ�ƽ�������е����ֵ��
--��ȡ���ʴ���������ֵ�ĵ�Ա����Ϣ

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





