-- 关联多表进行更新（注意：不是用一条 SQL 语句同时更新多张表）
--
-- You can also perform UPDATE operations covering multiple tables. However, you cannot use ORDER BY or LIMIT with
-- a multiple-table UPDATE. The table_references clause lists the tables involved in the join. Its syntax is described
-- in Section 13.2.9.2, “JOIN Clause”. Here is an example:
--
--   UPDATE items,month SET items.price=month.price WHERE items.id=month.id;
--
-- The preceding example shows an inner join that uses the comma operator, but multiple-table UPDATE statements can
-- use any type of join permitted in SELECT statements, such as LEFT JOIN.
--
-- @see https://dev.mysql.com/doc/refman/5.7/en/update.html
use test;

drop temporary table if exists test_user, test_user_ext;

create temporary table test_user
(
    id  int(11) primary key,
    age int(3)
);

create temporary table test_user_ext
(
    uid int(11),
    age int(3)
);

insert into test_user
values (1, 10),
       (2, 20),
       (3, 30);

insert into test_user_ext
values (1, 11),
       (2, 22),
       (3, 33);

-- 1、默认采用 inner join 关联多表进行更新
-- == 关键语句 ===============================
update test_user a, test_user_ext b
set a.age = b.age + 1 # 用关联表中的字段值更新主表的字段
where a.id = b.uid;
-- ==========================================

select *
from test_user;

select *
from test_user_ext;

-- 2、也可以使用 left join 关联多表进行更新
-- == 关键语句 ===============================
-- 注：执行 update 更新语句之前，最好先用等价的 select 语句先查询确认一下，看看待更新的记录是否确实是想要更新的。
select *
from test_user a
         left join test_user_ext b on a.id = b.uid
where a.id is not null;

update test_user a left join test_user_ext b on a.id = b.uid
set a.age = b.age + 1
where a.id is not null;
-- ==========================================

select *
from test_user;

select *
from test_user_ext;
