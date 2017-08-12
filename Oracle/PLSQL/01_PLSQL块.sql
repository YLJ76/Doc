/*
 * declare块可以不写
   
   exception块可以写。
   
   如果没有程序块，使用NULL来处理。
 */
declare

begin
  null;
exception
  when others then
    null;
end;
