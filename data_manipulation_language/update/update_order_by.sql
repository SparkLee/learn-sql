-- 更新表时，指定排序字段 order by 有啥用？
--
-- If an UPDATE statement includes an ORDER BY clause, the rows are updated in the order specified
-- by the clause. This can be useful in certain situations that might otherwise result in an error.
--
-- @see https://dev.mysql.com/doc/refman/5.7/en/update.html
--
use test;

drop temporary table if exists test_t1;

create temporary table test_t1
(
    id int(11) primary key
);

insert into test_t1(id)
values (1),
       (2),
       (3);

-- 下面的更新语句会报错：Duplicate entry '2' for key 'PRIMARY'。
-- 因为 id 是主键，不允许重复；当按升序先更新第一条记录的id为2时，就与第二条记录的id产生冲突了，从而导致更新失败。
-- == 关键语句 ===============================
# update test_t1 set id = id + 1 where id > 0;
-- == 关键语句 ===============================

-- 如果按降序更新的话，总是先将最大的id更新为一个更大的id，就不会产生索引重复冲突了
-- == 关键语句 ===============================
update test_t1
set id = id + 1
where id > 0
# 降序更新
order by id desc;
-- == 关键语句 ===============================

select *
from test_t1;