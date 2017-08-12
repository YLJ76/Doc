declare
  /*������������������ʽ
  
   identifier [CONSTANT] datatype [NOT NULL] [:= | DEFAULT expr];
  */
  v_number number(5, 2) := 100.34;
  v_str    varchar2(20);
  v_sex    char(2);
  v_flag   boolean;
  v_date   date;

  /*type��rowtype����*/
  v_username t_userinfo.username%type;

  v_userRow t_userinfo%RowType;

  /*Record����*/

  type Student is Record(
    stu_id   number,
    stu_name varchar2(20),
    stu_age  number(2)
    
    );

  v_stu_1 Student;

  /*�����Ķ���*/

  PI constant number := 3.1415926;

  /*��̬��ֵ����ı���*/
  v_userCount number;

  v_test1 t_userinfo.userid%type;
  v_test2 t_userinfo.username%type;

begin
  /*Ϊ������ֵ
     
     A��declare�鶨��ʱ��ֱ�Ӹ�ֵ��
     
     B��begin���о�̬��ֵ��
     
     C��begin���ж�̬��ֵ
  */

  v_str  := '�ַ�������';
  v_sex  := '��';
  v_flag := false;
  v_date := sysdate;

  v_username := 'admin';

  v_userRow.userid   := 11;
  v_userRow.username := 'test';
  v_userRow.password := '123';
  v_userRow.truename := '��ʵ����';

  v_stu_1.stu_id   := 100;
  v_stu_1.stu_name := 'ѧ������';
  v_stu_1.stu_age  := 20;

  /*�������ֵ*/
  dbms_output.put_line(v_str);
  dbms_output.put_line(v_sex);
  --����ֵ�ǲ������
  --dbms_output.put_line(v_flag);
  dbms_output.put_line(v_date);
  dbms_output.put_line(v_username);

  dbms_output.put_line(v_userRow.username);
  dbms_output.put_line(v_stu_1.stu_name);

  /*��̬��ֵ����Select�Ľ������������
                   
     1��Select�Ľ��ֻ����һ�ж��С������Է��ض��С�
     
     2��Select�Ľ������Ҫ�м�¼��
  */

  select count(1) into v_userCount from T_userinfo;
  dbms_output.put_line(v_userCount);

  Select userid, username
    into v_test1, v_test2
    From T_userinfo
   where userid = 50;
   
   dbms_output.put_line(v_test1 || '    ' || v_test2);
end;
