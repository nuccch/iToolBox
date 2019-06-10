SET NAMES 'utf8';

-- MySQL脚本工具 --

--------------------------------------------------------------------------------------------
-- 数据库访问工具:
-- Navicat for MySQL
-- MySQL Workbench
--------------------------------------------------------------------------------------------

-- 01.创建数据库
-- 创建数据库: gbk编码
mysql> create database db_test DEFAULT CHARACTER SET gbk COLLATE gbk_chinese_ci;

-- 创建数据库: utf8编码
mysql> create database db_test DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

-- 对于需要存储4字节字符的特殊场景，如需要存储表情等字符，需要使用utf8mb4字符集
-- 创建数据库: utf8mb4编码
mysql> create database db_test DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


-- 02.创建表
drop table if exists `test`;
create table `test` (
	`id`          bigint(20)  NOT NULL AUTO_INCREMENT COMMENT 'ID',
	`name`        varchar(50) NOT NULL default '',
	`create_time` timestamp   NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  	`update_time` timestamp   COMMENT '编辑时间',
  	`descr`       text        NOT NULL default '',
  	`url`         varchar(50) NOT NULL default '',
  	PRIMARY KEY (`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 03. 创建数据库用户, 需要root权限
[root@~]# mysql -uroot -p
/* 新建用户: phplamp, 密码: 1234 **/
mysql> insert into mysql.user(Host,User,Password) values("localhost","phplamp",password("1234"));
mysql> flush privileges;


-- 04. 为用户授权:如果用户不存在,同时创建用户
[root@~]# mysql -uroot -p
/* 授权所有权限: 为用户`username`授权访问对数据库`dbname`在`host`上的访问权限 **/
mysql> grant all privileges on `dbname`.* to `username`@`host` identified by 'pwd';
mysql> flush privileges;

e.g:
/* 为用户zhangsan授权在任何机器登录能访问数据库test下的所有数据库表,通过密码`123`访问 **/
mysql> grant all privileges on test.* to zhangsan@`%` identified by '123';
mysql> flush privileges;

/* 指定部分权限 **/
mysql> grant select,update on `dbname`.* to `username`@`host` identified by 'pwd'; 
mysql> flush privileges;

/* 允许zhangsan用于给其他用户分配权限. 这个操作一般不使用,权限通常通过DBA统一分配 **/
mysql> grant all privileges on *.* to 'zhangsan'@'%' identified by 'pwq' with grant option; 
mysql> flush privileges;


-- 05. 删除用户
[root@~]# mysql -uroot -p
mysql> DELETE FROM user WHERE User="zhangsan" and Host="localhost";
mysql> flush privileges;


-- 06. 修改用户密码
[root@~]# mysql -uroot -p
mysql> update mysql.user set password=password('新密码') where User="zhangsan" and Host="localhost";
mysql> flush privileges; 


-- 07. 登录数据库
msyql> mysql -uusername -p
e.g: mysql> mysql -uroot -p /* 登录root用户 **/
-- 关于mysql修改root密码和设置权限参考： http://www.cnblogs.com/wangs/p/3346767.html


-- 08. 索引
-- （1）创建普通索引
mysql> create index index_name on table_name (index_col_name,...)

-- （2）创建唯一索引
mysql> create unique index index_name on table_name (index_col_name,...)

-- （3）查看索引
-- 查看指定表上的索引
mysql> show index from table_name

-- 关于创建索引信息详细参考官方文档：https://dev.mysql.com/doc/refman/5.6/en/create-index.html


-- 09. 修改表结构
-- （1）添加新列
mysql> ALTER TABLE tbl_name ADD COLUMN col_name column_definition [FIRST | AFTER col_name]
-- e.g: 在name字段之后添加age字段
mysql> ALTER TABLE test ADD COLUMN age INT NOT NULL DEFAULT 0 COMMENT '年龄' AFTER name;

-- （2）删除列
mysql> ALTER TABLE tbl_name DROP COLUMN col_name

-- （3）删除索引
mysql> ALTER TABLE tbl_name DROP INDEX index_name

-- 关于表结构修改详细参考官方手册：https://dev.mysql.com/doc/refman/5.6/en/sql-syntax-data-definition.html


