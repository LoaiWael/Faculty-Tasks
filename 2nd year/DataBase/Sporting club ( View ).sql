USE Sporting_Club;
GO
---------------------------------------------------
--Requierments

--1- Display name and address of coaches for each sport
SELECT CONCAT(F_name,' ',L_name) [Full name], c_address AS Address,sport_name AS Sport
FROM Coaches
INNER JOIN Sports ON sport_ID=Sports.ID;

--2- display members and their membership finish date
SELECT CONCAT(F_name,' ',L_name) [Full name],end_date [Finish date]
FROM Members;

--3- Display the members whom their membership finishes after one week from current date.
SELECT CONCAT(F_name,' ',L_name) [Full name],end_date [Finish date]
FROM Members
WHERE end_date <= DATEADD(WEEK,1,GETDATE());

--4- Perform a report that shows the members name and their sports name
SELECT CONCAT(Members.F_name,' ',Members.L_name) [Full name],Sports.sport_name
FROM Members
INNER JOIN Traning ON Members.ID=Traning.member_ID
INNER JOIN Sports ON Sports.ID=Traning.sport_ID;

--5- Perform a report that shows the member’s name the number of sports he is participates in it.
SELECT CONCAT(Members.F_name,' ',Members.L_name) [Full name],COUNT(Traning.sport_ID) AS Sports
FROM Members
INNER JOIN Traning ON Members.ID=Traning.member_ID
INNER JOIN Sports ON Sports.ID=Traning.sport_ID
GROUP BY Members.F_name, Members.L_name;

--6- Perform a report that shows the members name the name of his coaches whom train him.
SELECT CONCAT(Members.F_name,' ',Members.L_name) [Full name],CONCAT(Coaches.F_name,' ',Coaches.L_name) [Coache name]
FROM Members
INNER JOIN TRANING ON Traning.member_ID=Members.ID
INNER JOIN Coaches ON Coaches.ID=Traning.coach_ID;

--7- Perform a report that display details of each member and his membership information( start date an finish date)
SELECT * FROM Members;

--8- Perform a report that count (ﺪﻌﯾ(the members for each sport.
SELECT sport_name AS [Sport Name],COUNT(Traning.sport_ID) [Num of people]
FROM Sports
INNER JOIN TRANING ON Sports.ID=Traning.sport_ID
GROUP BY sport_name;

--9- Perform a report that display the name of members whose total payment is greater than 100000 Pound
SELECT CONCAT(Members.F_name,' ',Members.L_name) [Full name], SUM(Sports.cost) + Members.Annual_fee [Total payments]
FROM Members
LEFT JOIN Payments ON Members.ID=Payments.member_ID
LEFT JOIN Sports ON Sports.ID=Payments.sport_ID
GROUP BY Members.F_name, Members.L_name, Members.Annual_fee
HAVING SUM(Sports.cost) + Members.Annual_fee > 100000;

--10- Perform a report that display the name of members who is participant in sports that greater than 1 sports
SELECT CONCAT(Members.F_name,' ',Members.L_name) [Full name],COUNT(Traning.sport_ID) [Number of sports]
FROM Members
INNER JOIN TRANING ON Members.ID=Traning.member_ID
GROUP BY Members.F_name, Members.L_name
HAVING COUNT(Traning.sport_ID) > 1 ;