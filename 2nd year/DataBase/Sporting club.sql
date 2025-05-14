USE Sporting_Club;
GO

CREATE TABLE Members(
	ID BIGINT PRIMARY KEY IDENTITY(1,1),
	F_name VARCHAR(25) NOT NULL,
	L_name VARCHAR(25) NOT NULL,
	Annual_fee DECIMAL(10,2) DEFAULT 0
);

ALTER TABLE Members
ADD start_date DATE DEFAULT GETDATE();

ALTER TABLE Members
ADD end_date DATE DEFAULT DATEADD(YEAR,1,GETDATE());

CREATE TABLE Sports(
	ID BIGINT PRIMARY KEY IDENTITY(1,1),
	category BIGINT FOREIGN KEY REFERENCES Sport_Categories(ID),
	sport_name VARCHAR(50) UNIQUE NOT NULL,
	cost DECIMAL(7,2) DEFAULT 0,
);

--Normalization to sports table
CREATE TABLE Sport_Categories(
	ID BIGINT PRIMARY KEY IDENTITY(1,1),
	categ_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Coaches(
	ID BIGINT PRIMARY KEY IDENTITY(1,1),
	F_name VARCHAR(25) NOT NULL,
	L_name VARCHAR(25) NOT NULL,
	c_address VARCHAR(50),
	sport_ID BIGINT NOT NULL FOREIGN KEY REFERENCES Sports(ID),
);

CREATE TABLE Traning(
	member_ID BIGINT NOT NULL FOREIGN KEY REFERENCES Members(ID),
	coach_ID BIGINT NOT NULL FOREIGN KEY REFERENCES Coaches(ID),
	PRIMARY KEY (member_ID,coach_ID)
);

ALTER TABLE Traning 
ADD sport_ID BIGINT FOREIGN KEY REFERENCES Sports(ID);

CREATE TABLE Payments(
	payment_NUM BIGINT PRIMARY KEY IDENTITY(1,1),
	member_ID BIGINT NOT NULL FOREIGN KEY REFERENCES Members(ID),
	sport_ID BIGINT FOREIGN KEY REFERENCES Sports(ID),
	pay_date DATE DEFAULT getdate()
);

INSERT INTO Members(F_name,L_name,Annual_fee)
VALUES  ('Loai','Wael',100000),
		('Lina','Wael',100000),
		('Mohamed','Gamel',100000),
		('Mazen','Saad',100000),
		('Mohamed','Ibrahim',100000),
		('Yousif','Zidan',100000);

UPDATE Members SET end_date=DATEADD(YEAR,1,GETDATE())

INSERT INTO Sport_Categories
VALUES	('strategy'),
		('Racket'),
		('Soccer')

INSERT INTO Sports(category,sport_name,cost)
VALUES  (1,'Chess',500),
		(1,'Domino`s',350),
		(2,'Tennis',800),
		(2,'Badminton',750),
		(2,'Squash',600),
		(2,'Padel',850),
		(3,'American football',1300),
		(3,'Canadian football',800),
		(NULL,'Swimming',1000);

INSERT INTO Coaches(F_name,L_name,c_address,sport_ID)
VALUES  ('Mohamed','Samy','Toriel-Gedela',8),
		('Ahmed','Hamdy','Belqase-Dakahlia',8),
		('Ali','Ayman','Toriel-Gedela',9),
		('Abdullah','Bahaa','Dekernes',9),
		('Zein','Fathy','Samanod',6),
		('Yousif','Loai','Teraa',6),
		('Mark','Elion','Cairo',7),
		('Lotfy','Mohamed','Alex',5),
		('Ahmed','Hassan','Port saaid',4),
		('Yassin','Samy','Mansoura',3),
		('Sara','Ahmed','Belqas',3),
		('Mohamed','Ali','Talkha',3),
		('Mostafa','Badr','Cairo',2),
		('Shahd','Hassan','Alex',1);

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

---------------------------------------------------
--Requierments

--1
SELECT CONCAT(F_name,' ',L_name) [Full name], c_address AS Address,sport_name AS Sport
FROM Coaches
INNER JOIN Sports ON sport_ID=Sports.ID;

--2
SELECT CONCAT(F_name,' ',L_name) [Full name],end_date [Finish date]
FROM Members;

--3
SELECT CONCAT(F_name,' ',L_name) [Full name],end_date [Finish date]
FROM Members
WHERE end_date = DATEADD(WEEK,1,GETDATE());

--4
SELECT CONCAT(Members.F_name,' ',Members.L_name) [Full name],Sports.sport_name
FROM Members
INNER JOIN Traning ON Members.ID=Traning.member_ID
INNER JOIN Sports ON Sports.ID=Traning.sport_ID;

--5
SELECT CONCAT(Members.F_name,' ',Members.L_name) [Full name],COUNT(Traning.sport_ID) AS Sports
FROM Members
INNER JOIN Traning ON Members.ID=Traning.member_ID
INNER JOIN Sports ON Sports.ID=Traning.sport_ID
GROUP BY Members.F_name, Members.L_name;

--6
SELECT CONCAT(Members.F_name,' ',Members.L_name) [Full name],CONCAT(Coaches.F_name,' ',Coaches.L_name) [Coache name]
FROM Members
INNER JOIN TRANING ON Traning.member_ID=Members.ID
INNER JOIN Coaches ON Coaches.ID=Traning.coach_ID;

--7
SELECT * FROM Members;

--8
SELECT sport_name AS [Sport Name],COUNT(Traning.sport_ID) [Num of people]
FROM Sports
INNER JOIN TRANING ON Sports.ID=Traning.sport_ID
GROUP BY sport_name;

--9
SELECT CONCAT(Members.F_name,' ',Members.L_name) [Full name], SUM(Sports.cost) + Members.Annual_fee [Total payments]
FROM Members
LEFT JOIN Payments ON Members.ID=Payments.member_ID
LEFT JOIN Sports ON Sports.ID=Payments.sport_ID
GROUP BY Members.F_name, Members.L_name, Members.Annual_fee
HAVING SUM(Sports.cost) + Members.Annual_fee > 100000;

--10
SELECT CONCAT(Members.F_name,' ',Members.L_name) [Full name],COUNT(Traning.sport_ID) [Number of sports]
FROM Members
INNER JOIN TRANING ON Members.ID=Traning.member_ID
GROUP BY Members.F_name, Members.L_name
HAVING COUNT(Traning.sport_ID) > 1 ;