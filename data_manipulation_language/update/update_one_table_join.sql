-- 同一数据表，针对指定字段值（一个或多个字段）相同的多条记录，更新其中记录id值最大或最小的记录的数据。
--
-- 比如：对于用户表，针对昵称和年龄都相同的多个用户，将其中最先注册的用户标记为“is_register_first”
-- 注：可以用记录id区别注册先后顺序，id越小表明越先注册。
use test;

drop table if exists test_user;

create table test_user
(
    id                int(11) primary key,
    age               tinyint(3),
    nickname          varchar(100),
    is_register_first tinyint(1) default 0
);

insert into test_user
values (1, 18, 'lily', 0),
       (2, 18, 'lily', 0),
       (3, 32, 'spark', 0),
       (4, 32, 'spark', 0),
       (5, 18, 'lily', 0),
       (6, 32, 'spark', 0);

select *
from test_user;

-- 注：本实验的 test_user 不能创建为临时表（temporary table），
-- 否则执行下述查询语句会报错：[HY000][1137] Can't reopen table: 'a'
select *
from test_user a
         inner join test_user b on a.age = b.age and a.nickname = b.nickname
where a.id > b.id;

-- 更新 is_register_first 字段值
-- == 关键语句 ===============================
update test_user
set is_register_first = 1
where id is not null;

update test_user a
    inner join test_user b on a.age = b.age and a.nickname = b.nickname
set a.is_register_first = 0
# 关键where ，通过对id字段值的大小比较，筛选出“非首次注册”的用户，并更新其 is_register_first 字段值。
where a.id > b.id;
-- ==========================================

select *
from test_user;