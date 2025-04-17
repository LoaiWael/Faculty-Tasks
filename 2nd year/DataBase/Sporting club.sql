USE Sporting_Club;
GO

CREATE TABLE Members(
	ID BIGINT PRIMARY KEY IDENTITY(1,1),
	F_name VARCHAR(25) NOT NULL,
	L_name VARCHAR(25) NOT NULL,
	Annual_fee DECIMAL(10,2) DEFAULT 0
);

CREATE TABLE Sports(
	ID BIGINT PRIMARY KEY IDENTITY(1,1),
	category VARCHAR(50),
	sport_name VARCHAR(50) UNIQUE NOT NULL,
	cost DECIMAL(5,2) DEFAULT 0,
);

CREATE TABLE Coaches(
	ID BIGINT PRIMARY KEY IDENTITY(1,1),
	F_name VARCHAR(25) NOT NULL,
	L_name VARCHAR(25) NOT NULL,
	sport_ID BIGINT NOT NULL,
	CONSTRAINT fk_sport_in_coaches FOREIGN KEY(sport_ID) REFERENCES Sports(ID)
);

CREATE TABLE Traning(
	member_ID BIGINT NOT NULL,
	coach_ID BIGINT NOT NULL,
	PRIMARY KEY (member_ID,coach_ID),
	CONSTRAINT fk_member_in_traning FOREIGN KEY(member_ID) REFERENCES Members(ID),
	CONSTRAINT fk_coach_in_traning FOREIGN KEY(coach_ID) REFERENCES Coaches(ID)
);

ALTER TABLE Traning 
ADD sport_ID BIGINT,
CONSTRAINT fk_sport_id_in_traning 
FOREIGN KEY (sport_ID) REFERENCES Sports(ID);

CREATE TABLE Payments(
	payment_NUM BIGINT PRIMARY KEY IDENTITY(1,1),
	member_ID BIGINT NOT NULL,
	sport_ID BIGINT,
	pay_date DATE DEFAULT getdate(),
	CONSTRAINT fk_member_in_payments FOREIGN KEY(member_ID) REFERENCES Members(ID),
	CONSTRAINT fk_sport_in_payments FOREIGN KEY(sport_ID) REFERENCES Sports(ID)
);

INSERT INTO Members(F_name,L_name,Annual_fee)
VALUES  ('Loai','Wael',100000),
		('Lina','Wael',100000),
		('Mohamed','Gamel',100000),
		('Mazen','Saad',100000),
		('Mohamed','Ibrahim',100000),
		('Yousif','Zidan',100000);

INSERT INTO Sports(category,sport_name,cost)
VALUES  ('strategy','Chess',500),
		('strategy','Domino`s',350),
		('Racket','Tennis',800),
		('Racket','Badminton',750),
		('Racket','Squash',600),
		('Racket','Padel',850),
		('Soccer','American football',1300),
		('Soccer','Canadian football',800),
		(NULL,'Swimming',1000);

INSERT INTO Coaches(F_name,L_name,sport_ID)
VALUES  ('Mohamed','Samy',8),
		('Ahmed','Hamdy',8),
		('Ali','Ayman',9),
		('Abdullah','Bahaa',9),
		('Zein','Fathy',6),
		('Yousif','Loai',6),
		('Mark','Elion',7),
		('Lotfy','Mohamed',5),
		('Ahmed','Hassan',4),
		('Yassin','Samy',3),
		('Sara','Ahmed',3),
		('Mohamed','Ali',3),
		('Mostafa','Badr',2),
		('Shahd','Hassan',1);

INSERT INTO Traning(member_ID,coach_ID,sport_ID)
VALUES  (1,11,3),
		(2,11,3),
		(3,1,8),
		(3,14,1),
		(6,2,8);

INSERT INTO Payments(member_ID,sport_ID)
VALUES  (1,3),
		(2,3),
		(3,8),
		(3,1),
		(6,8);