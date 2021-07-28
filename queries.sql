--- 2. Queries for Project

--SELECT query showing all bills greater than 100

SELECT * from bill where total >= 100;


--INSERT Statement inserting a new appointment into appointment table

INSERT INTO `appointment` (`AppID`, `Time`, `Date`, `followUp`, `PatientID`) VALUES (NULL, '09:00:00', '2021-04-29', '0', '1');


--UPDATE statement updating a bill to paid

UPDATE bill SET paid = 1 WHERE PatientID=8;


--DELETE statement deleting a payment made

DELETE FROM payment WHERE PaymentNo=8;

