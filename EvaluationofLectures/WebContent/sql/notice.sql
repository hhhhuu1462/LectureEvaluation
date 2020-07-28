create database LectureEvaluation;

use LectureEvaluation;

ALTER TABLE user MODIFY username MEDIUMTEXT;

create table noticeBoard (
	noticeID int,
    noticeTitle varchar(50),
    managerID varchar(20),
    noticeDate dateTime,
    noticeContent varchar(2048),
    noticeAvailable int,
    primary key(noticeID)
);

create table manager (
	managerID varchar(20) not null,
    managerPassword varchar(64),
    managerPhoneNumber int,
    managerEmail varchar(50),
    managerEmailHash varchar(64),
    managerEmailChecked boolean,
    primary key (managerId)
);
select * from manager;
drop table manager;
insert into manager values ('manager', '', '' , '' , '', false);

create table user ( 
	userId varchar(20) not null ,
	userPassword varchar(64) ,	
    userName varchar(10) ,
    userGender varchar(10),
    userEmail varchar(50) ,
    phoneNumber int ,
	userEmailHash varchar(64),
	userEmailChecked boolean,
	primary key (userID)
);
update user set userID= trim('hhhhuu1462  '), userPassword='lhs9988', userName='lhs', userGender='남자', userEmail='hhhhuu1462@gmail.com', phoneNumber='1022824338' where userID='hhhhuu1462';
select * from user;
drop table user;
insert into user values ('a', 'a', 'a', '남', 'hsdfh@fhsdh', '010684765', 'dsg6sd5f74g6sd', false);
insert into user values('a', 'a', 'a', '남', 'a@a', '01022824338', 'asgs46d58g35sd46gsd', true);

create table EVALUATION (
	evaluationID int primary key auto_increment,
	userID varchar(20),
	lectureName varchar(50),
	professorName varchar(20),
	lectureYear int,
	semesterDivice varchar(20),
	lectureDivide varchar(10),
	evaluationTitle varchar(50),
	evaluationContent varchar(2048),
	totalScore varchar(5),
	creditScore varchar(5),
	comfortableScore varchar(5),
	lectureScore varchar(5),
	likeCount int
);

drop table evaluation;

create table LIKEY (
	userID varchar(20),
	evaluationID int,
	userIP varchar(50)
);

show tables;
evaluationevaluation
use webmarketdb;


commit;


show databases;

create table if not exists member (
	id varchar(20) not null,
	passwd varchar(20),
	name varchar(30),
	primary key (id)
);


create database BBS;

use bbs;

create table user (
	userID varchar(20),
    userPassword varchar(20),
    userName varchar(20),
    userGender varchar(20),
    userEmail varchar(50),
    primary key(userID)
);

show tables;

desc user;

insert into user values ('gildong', '123456', '홍길동', '남자', 'gildong@naver.com');

select * from user;
drop table user;

commit;

desc user;

create table BBS (
	bbsID int,
    bbsTitle varchar(50),
    userID varchar(20),
    bbsDate datetime,
    bbsContent varchar(2048),
    bbsAvailable int,
    primary key (bbsID)
);

delete from user;

select * from manager;

create table manager ( 
	managerID varchar(20) NOT NULL,
	managerPassword varchar(64),
    managerName varchar(20),
    managerGender varchar(20),
	managerEmail varchar(50),
    phoneNumber int,
	managerEmailHash varchar(64),
	managerEmailChecked boolean,
	primary key (managerID)
);
drop table manager;

alter table notice auto_increment =1;

set global max_connections = 500;

ALTER TABLE notice MODIFY noticeID MEDIUMTEXT;

create table notice (
	noticeID int auto_increment,
    noticeTitle varchar(50),
    userID varchar(20),
    noticeDate datetime,
    noticeContent varchar(2048),
    noticeAvailable int,
    primary key (noticeID)
);

create table EVALUATION (
	evaluationID int primary key auto_increment,
	userID varchar(20),
	lectureName varchar(50),
	professorName varchar(20),
	lectureYear int,
	semesterDivide varchar(20),
	lectureDivide varchar(10),
	evaluationTitle varchar(50),
    evaluationDate datetime,
	evaluationContent varchar(2048),
	totalScore varchar(5),
	creditScore varchar(5),
	comfortableScore varchar(5),
	lectureScore varchar(5),
	likeCount int,
    evaluationAvailable int
);
select * from evaluation;
drop table evaluation;

set @cnt = 0;
update notice set noticeID=@cnt:=@cnt+1;
alter table notice auto_increment =1;
select * from notice where noticeID < 2 and noticeAvailable = 1 order by noticeID desc limit 10  ;
select * from notice;
drop table notice; 
delete from notice where noticeID=4;