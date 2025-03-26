--CODE CHALLENGE	
CREATE DATABASE PetPals 

CREATE TABLE Pets
(
PetID int PRIMARY KEY IDENTITY(001,1),
Name VARCHAR(255),
Age int,
Breed VARCHAR(255),
Type VARCHAR(255),
AvailableForAdoption bit,
)
CREATE TABLE Shelters
(
ShelterID int Primary Key IDENTITY(501,1),
Name VARCHAR(255),
Location VARCHAR(255)
)
CREATE TABLE Donations
(
DonationID INT Primary Key identity(1001,1),
DonorName VARCHAR(255),
DonationType VARCHAR(255), -- (e.g., "Cash," "Item").
DonationAmount decimal,
DonationItem VARCHAR(255),
DonationDate datetime,
ShelterID INT
CONSTRAINT fk_sid FOREIGN KEY(ShelterID) REFERENCES Shelters(ShelterID) ON DELETE CASCADE
)
CREATE TABLE AdoptionEvents
(
EventID INT Primary Key identity(3001,1),
EventName VARCHAR(255),
EventDate datetime,
Location VARCHAR(255)
)
CREATE TABLE Participants
(
ParticipantID INT Primary Key identity(5001,1),
ParticipantName VARCHAR(255), --(shelter or adopter).
ParticipantType VARCHAR(255), --(e.g., "Shelter," "Adopter").
EventID int
CONSTRAINT fk_id FOREIGN KEY(EventID) References AdoptionEvents(EventID) ON DELETE CASCADE
)
INSERT INTO Pets VALUES('Blacky',2,'Pomeranian','Dog',1)
INSERT INTO Pets VALUES('Whity',3,'Chihuahua','Dog',0)
INSERT INTO Pets VALUES('George',5,'Pug','Dog',1)
INSERT INTO Pets VALUES('Shiro',6,'Pomeranian','Dog',0)
INSERT INTO Pets VALUES('Stuart',2,'Sphynx','Cat',1)
INSERT INTO Pets VALUES('Lily',1,'Basset Hound','Dog',1)
INSERT INTO Pets VALUES('Hank',7,'Golden Retriever','Dog',0)
INSERT INTO Pets VALUES('Pinky',5,'Persian','Cat',0)
INSERT INTO Pets VALUES('Ronald',3,'German Shepherd','Dog',1)
INSERT INTO Pets VALUES('Rex',2,'Himalayan','Cat',1)

INSERT INTO Shelters VALUES('Paw Haven','Mumbai, Maharashtra')
INSERT INTO Shelters VALUES('Furry Home','Bengaluru, Karnataka')
INSERT INTO Shelters VALUES('Happy Tails','Chennai, Tamil Nadu')
INSERT INTO Shelters VALUES('Paw Rescue','Kolkata, West Bengal')
INSERT INTO Shelters VALUES('Wag Shelter','Hyderabad, Telangana')
INSERT INTO Shelters VALUES('Purr & Paw','Mumbai, Maharashtra')
INSERT INTO Shelters VALUES('Safe Paws','Pune, Maharashtra')
INSERT INTO Shelters VALUES('Hope Paws','Jaipur, Rajasthan')
INSERT INTO Shelters VALUES('Kind Tails','Lucknow, Uttar Pradesh')
INSERT INTO Shelters VALUES('NewPaw','Bhopal, Madhya Pradesh')

INSERT INTO Donations (DonorName, DonationType, DonationAmount, DonationItem, DonationDate,ShelterID) VALUES
('Rahul Sharma', 'Cash', 5000.00, NULL, '2024-01-10 10:30:00',501),
('Priya Verma', 'Item', NULL, 'Dog Food Pack', '2024-02-15 14:20:00',502),
('Amit Khanna', 'Cash', 7500.50, NULL, '2024-03-08 09:45:00',503),
('Neha Kapoor', 'Item', NULL, 'Cat Toys', '2024-04-20 16:10:00',503),
('Rohan Singh', 'Cash', 2000.00, NULL, '2024-05-05 12:05:00',504),
('Anjali Mehta', 'Item', NULL, 'Pet Bedding', '2024-06-18 11:30:00',505),
('Suresh Patel', 'Cash', 10000.00, NULL, '2024-07-22 17:15:00',505),
('Kavita Joshi', 'Item', NULL, 'Collars', '2024-08-09 13:50:00',506),
('Vikram Malhotra', 'Cash', 3000.75, NULL, '2024-09-14 08:20:00',507),
('Simran Kaur', 'Item', NULL, 'Cat Food Pack', '2024-10-01 15:40:00',508);

INSERT INTO AdoptionEvents (EventName, EventDate, Location) VALUES
('Summer Adoption Drive', '2024-03-05 10:00:00', 'Mumbai'),
('Pet Lovers Meet', '2024-04-12 11:30:00', 'Bengaluru'),
('Rescue & Adopt Fair', '2024-05-18 09:00:00', 'Chennai'),
('Furry Friends Fest', '2024-06-25 13:45:00', 'Kolkata'),
('Shelter Open Day', '2024-07-09 12:00:00', 'Pune'),
('National Pet Week', '2024-08-15 14:30:00', 'Hyderabad'),
('Animal Welfare Drive', '2024-09-20 16:00:00', 'Jaipur'),
('Happy Homes Adoption', '2024-10-10 11:00:00', 'Delhi'),
('Stray Love Campaign', '2024-11-22 15:00:00', 'Ahmedabad'),
('Rescue & Rehome', '2024-12-05 10:45:00', 'Chandigarh');

INSERT INTO Participants (ParticipantName, ParticipantType, EventID) VALUES
('Paw Haven', 'Shelter', 3001),
('Ramesh Agarwal', 'Adopter', 3001),
('Happy Tails', 'Shelter', 3002),
('Sneha Malik', 'Adopter', 3002),
('Paw Rescue', 'Shelter', 3003),
('Arjun Patel', 'Adopter', 3004),
('Hope Paws', 'Shelter', 3005),
('Priyanka Sharma', 'Adopter', 3006),
('Wag Shelter', 'Shelter', 3007),
('Ankit Verma', 'Adopter', 3007);

--5.Write an SQL query that retrieves a list of available pets 
SELECT PetID, Name, Age, Breed, Type FROM Pets WHERE AvailableForAdoption=1

--6.Write an SQL query that retrieves the names of participants (shelters and adopters) registered for a specific adoption event.
SELECT a.EventID, EventName, ParticipantID, ParticipantName, ParticipantType FROM AdoptionEvents a
JOIN Participants p ON a.EventID = p.EventID

--8.Write an SQL query that calculates and retrieves the total donation amount for each shelter
SELECT s.ShelterID,s.Name,SUM(d.DonationAmount) AS total_donation FROM Donations d
RIGHT JOIN Shelters s ON d.ShelterID = s.ShelterID
GROUP BY s.ShelterID, s.Name

--9.Write an SQL query that retrieves the names of pets from the "Pets" table that do not have an owner
ALTER TABLE Pets
ADD OwnerID VARCHAR(255)

SELECT PetID, Name, Age, Breed, Type FROM Pets WHERE OwnerID is null

--10.Write an SQL query that retrieves the total donation amount for each month and year (e.g.,January 2023) from the "Donations" table
INSERT INTO Donations (DonorName, DonationType, DonationAmount, DonationItem, DonationDate,ShelterID) VALUES
('Krithika', 'Cash', 5000.00, NULL, '2024-01-20 10:30:00',508),
('Samson Jeba', 'Cash', 2500.00, NULL, '2024-07-15 14:20:00',509);

SELECT CONCAT(DATENAME(month, d.DonationDate),' ', YEAR(d.DonationDate)) AS Month_Year, SUM(d.DonationAmount) AS TotalDonations
FROM Donations d
JOIN Shelters s ON d.ShelterID = s.ShelterID
GROUP BY YEAR(d.DonationDate), MONTH(d.DonationDate)
ORDER BY YEAR(d.DonationDate), MONTH(d.DonationDate)

--11.Retrieve a list of distinct breeds for all pets that are either aged between 1 and 3 years or older than 5 years.
SELECT DISTINCT(Breed),Age FROM Pets WHERE (Age BETWEEN 1 AND 3) OR (Age > 5)

--12.Retrieve a list of pets and their respective shelters where the pets are currently available for adoption.
ALTER TABLE Pets
ADD ShelterID int 
ADD CONSTRAINT fk_pid FOREIGN KEY (ShelterID) REFERENCES Shelters(ShelterID)
UPDATE Pets SET ShelterID = 501 WHERE PetID = 001
UPDATE Pets SET ShelterID = 501 WHERE PetID = 002
UPDATE Pets SET ShelterID = 503 WHERE PetID = 003
UPDATE Pets SET ShelterID = 504 WHERE PetID = 004
UPDATE Pets SET ShelterID = 504 WHERE PetID = 005
UPDATE Pets SET ShelterID = 505 WHERE PetID = 006
UPDATE Pets SET ShelterID = 506 WHERE PetID = 007
UPDATE Pets SET ShelterID = 507 WHERE PetID = 008
UPDATE Pets SET ShelterID = 507 WHERE PetID = 009
UPDATE Pets SET ShelterID = 509 WHERE PetID = 010
SELECT * FROM Pets

SELECT p.PetID, p.Name,s.Name AS Shelter_Name FROM Pets p
JOIN Shelters s ON p.ShelterID = s.ShelterID
WHERE p.AvailableForAdoption = 1

--13.Find the total number of participants in events organized by shelters located in specific city.
SELECT a.Location AS City, COUNT(p.ParticipantID) AS no_of_participants FROM AdoptionEvents a
JOIN Participants p ON a.EventID = p.EventID
GROUP BY a.Location

--14.Retrieve a list of unique breeds for pets with ages between 1 and 5 years.
SELECT DISTINCT(Breed),Age FROM Pets WHERE (Age BETWEEN 1 AND 5)

--15.Find the pets that have not been adopted by selecting their information from the 'Pet' table.
SELECT PetID, Name, Age, Breed, Type FROM Pets WHERE AvailableForAdoption=1

--16.Retrieve the names of all adopted pets along with the adopter's name 
CREATE TABLE Users
(
UserID VARCHAR(255),
UserName VARCHAR(255),
PetID int
CONSTRAINT fk_uid FOREIGN KEY(PetID) REFERENCES Pets(PetID)
)
INSERT INTO Users VALUES('U01','Rajesh',005)
INSERT INTO Users VALUES('U02','Mahesh',006)
UPDATE Pets SET AvailableForAdoption=0 WHERE PetID = 005
UPDATE Pets SET AvailableForAdoption=0 WHERE PetID = 006

SELECT p.Name AS PetName, u.UserName FROM Pets p
JOIN Users u ON p.PetID = u.PetID

--17.Retrieve a list of all shelters along with the count of pets currently available for adoption in each shelter.
SELECT s.ShelterID, s.Name, COUNT(p.PetID) AS available_pets FROM Shelters s
LEFT JOIN Pets p ON s.ShelterID = p.ShelterID 
WHERE p.AvailableForAdoption = 1 GROUP BY s.ShelterID, s.Name

--18.Retrieve a list of all shelters along with the count of pets currently available for adoption in each shelter.
SELECT p1.Name AS Pet1_Name,p2.Name AS Pet2_Name, p1.Breed, p1.ShelterID FROM Pets p1
JOIN Pets p2 ON p1.ShelterID = p2.ShelterID  
WHERE p1.Breed = p2.Breed AND p1.PetID < p2.PetID  

--19.List all possible combinations of shelters and adoption events.
SELECT s.Name AS ShelterName, a.EventName FROM Participants p
JOIN AdoptionEvents a ON p.EventID = a.EventID
JOIN Shelters s ON p.ParticipantName = s.Name

--20.Determine the shelter that has the highest number of adopted pets.
SELECT Top 3 s.ShelterID, s.Name, COUNT(p.PetID) AS COUNT_PETS FROM Pets p
JOIN Shelters s ON p.ShelterID = s.ShelterID
WHERE p.AvailableForAdoption = 0
GROUP BY s.ShelterID, s.Name
ORDER BY COUNT_PETS DESC 
