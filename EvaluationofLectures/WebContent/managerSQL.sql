create table user ( 
	userId varchar(20) NOT NULL,
	userPassword varchar(64),
    userName varchar(20),
    userGender varchar(20),
	userEmail varchar(50),
    phoneNumber varchar(50),
	userEmailHash varchar(64),
	userEmailChecked boolean,
	primary key (userID)
);

create table notice (
	noticeID int,
    noticeTitle varchar(50),
    userID varchar(20),
    noticeDate datetime,
    noticeContent varchar(2048),
    noticeAvailable int,
    primary key (noticeID)
);