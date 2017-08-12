--表添加备注
comment on table table_name is '这是一个表备注';
--修改表名
alter table table_name rename to table_name2;

--修改列类型
alter table table_name modify column_name varchar2(30);
alter table table_name modify (c1 type1,c2 type2...); --修改多列
--修改列名称
alter table table_name rename column column_name to column_name2;
--添加列
alter table table_name add column_name varchar2(20);
alter table table_name add(c1 type1,c2,type2...); --修改多列
--列名添加备注
comment on cloumn table_name.cloumn_name is '这是一个列备注';
--删除列
alter table table_name drop column column_name;

--查询约束名
select table_name,index_name from user_indexs where table_name = 'table_name';
--禁用主键
alter table table_name disable primary key;
--启用主键
alter talbe table_name enable primary key;
--禁用约束
alter table table_name disable constraint ct_name;
--启用约束
alter table table_name enable constraint ct_name;
--删除约束
alter table table_name drop constraint index_name;--删除约束



