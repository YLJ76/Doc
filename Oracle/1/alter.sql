--����ӱ�ע
comment on table table_name is '����һ����ע';
--�޸ı���
alter table table_name rename to table_name2;

--�޸�������
alter table table_name modify column_name varchar2(30);
alter table table_name modify (c1 type1,c2 type2...); --�޸Ķ���
--�޸�������
alter table table_name rename column column_name to column_name2;
--�����
alter table table_name add column_name varchar2(20);
alter table table_name add(c1 type1,c2,type2...); --�޸Ķ���
--������ӱ�ע
comment on cloumn table_name.cloumn_name is '����һ���б�ע';
--ɾ����
alter table table_name drop column column_name;

--��ѯԼ����
select table_name,index_name from user_indexs where table_name = 'table_name';
--��������
alter table table_name disable primary key;
--��������
alter talbe table_name enable primary key;
--����Լ��
alter table table_name disable constraint ct_name;
--����Լ��
alter table table_name enable constraint ct_name;
--ɾ��Լ��
alter table table_name drop constraint index_name;--ɾ��Լ��



