-- 如何用一条 SQL 语句快速创建一个与现有表结构完全一样的新表
--
-- Use CREATE TABLE ... LIKE to create an empty table based on the definition of
-- another table, including any column attributes and indexes defined in the original table。
--
-- @see https://dev.mysql.com/doc/refman/5.7/en/create-table-like.html
--
use test;

drop temporary table if exists test_t1,test_t2;

create temporary table test_t1
(
    id      int(11) auto_increment primary key,
    name    varchar(10),
    age     int(3),
    address varchar(50),
    unique index idx_name (name)
);

-- == 关键语句 ===============================
create temporary table test_t2 like test_t1;
-- ==========================================

show create table test_t2;