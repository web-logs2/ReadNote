create table userInfo(
	id int auto_increment not null,
	name varchar(32) not null,
	gender varchar(8),
	age int,
	native varchar(32),
	qq varchar(32),
	email varchar(32),
	primary key(id)
);

insert into userInfo(name, gender, age, native, qq) values('曹操', '男', 66, '谯县', '1234567');
insert into userInfo(name, gender, age, native, qq) values('刘备', '男', 61, '涿县', '1234568');
insert into userInfo(name, gender, age, native, qq) values('董卓', '男', 78, '西凉', '1234566');
