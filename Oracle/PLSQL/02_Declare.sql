declare
  /*变量的声明：声明格式
  
   identifier [CONSTANT] datatype [NOT NULL] [:= | DEFAULT expr];
  */
  v_number number(5, 2) := 100.34;
  v_str    varchar2(20);
  v_sex    char(2);
  v_flag   boolean;
  v_date   date;

  /*type和rowtype类型*/
  v_username t_userinfo.username%type;

  v_userRow t_userinfo%RowType;

  /*Record类型*/

  type Student is Record(
    stu_id   number,
    stu_name varchar2(20),
    stu_age  number(2)
    
    );

  v_stu_1 Student;

  /*常量的定义*/

  PI constant number := 3.1415926;

  /*动态赋值定义的变量*/
  v_userCount number;

  v_test1 t_userinfo.userid%type;
  v_test2 t_userinfo.username%type;

begin
  /*为变量赋值
     
     A：declare块定义时，直接赋值。
     
     B：begin块中静态赋值。
     
     C：begin块中动态赋值
  */

  v_str  := '字符串变量';
  v_sex  := '男';
  v_flag := false;
  v_date := sysdate;

  v_username := 'admin';

  v_userRow.userid   := 11;
  v_userRow.username := 'test';
  v_userRow.password := '123';
  v_userRow.truename := '真实姓名';

  v_stu_1.stu_id   := 100;
  v_stu_1.stu_name := '学生名称';
  v_stu_1.stu_age  := 20;

  /*输出变量值*/
  dbms_output.put_line(v_str);
  dbms_output.put_line(v_sex);
  --布尔值是不能输出
  --dbms_output.put_line(v_flag);
  dbms_output.put_line(v_date);
  dbms_output.put_line(v_username);

  dbms_output.put_line(v_userRow.username);
  dbms_output.put_line(v_stu_1.stu_name);

  /*动态赋值：将Select的结果赋到变量中
                   
     1：Select的结果只能是一行多列。不可以返回多行。
     
     2：Select的结果必须要有记录。
  */

  select count(1) into v_userCount from T_userinfo;
  dbms_output.put_line(v_userCount);

  Select userid, username
    into v_test1, v_test2
    From T_userinfo
   where userid = 50;
   
   dbms_output.put_line(v_test1 || '    ' || v_test2);
end;
