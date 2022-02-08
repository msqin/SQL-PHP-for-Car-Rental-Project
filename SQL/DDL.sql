--------------------------
-- Create Database rental_cars
--------------------------

DROP DATABASE IF EXISTS  rental_cars;

CREATE DATABASE rental_cars;


USE rental_cars;

--------------------------
-- Create Table Customer
--------------------------

CREATE TABLE Customer 
(
  Customer_Id       Int           NOT NULL ,
  Customer_FName    Varchar(50)   NOT NULL ,
  Customer_LName    VarChar(50)   NOT NULL ,
  Customer_DOB      Date          NOT NULL ,
  Customer_Street   Varchar(50)   NOT NULL ,
  Customer_City     Varchar(50)   NOT NULL ,
  Customer_State    Varchar(50)   NOT NULL ,
  Customer_Zip_Code Int           NOT NULL ,
  Customer_Phone    Varchar(50)   NULL ,
  Cusomer_Email     Varchar(50)   NULL ,
  License_Number    Varchar(50)   NOT NULL 
  
  );
 
--------------------------
-- Create Table License
--------------------------
CREATE TABLE License 
(
  License_Number    Varchar(50)   NOT NULL ,
  License_Validity  DATE    NULL 
  );
  
--------------------------
-- Create Table Card_Detail
--------------------------

CREATE TABLE Card_Detail 
(
  Card_ID               Varchar(20)   NOT NULL ,
  Card_Number           Bigint        NOT NULL ,
  Card_Type             VarChar(20)   NOT NULL ,
  Card_Expiration_Date  Date          NOT NULL ,
  Customer_Id           Int           NOT NULL 
  );

--------------------------
-- Create Table Rental
--------------------------


CREATE TABLE Rental 
(
  Rental_ID                  Int          NOT NULL ,
  Rental_Pickup_Date         Date         NOT NULL ,
  Rental_Dropoff_Date        Date         NOT NULL ,
  Rental_Pickup_Time         Time         NULL,
  Rental_Dropoff_Time        Time         NULL,
  Pickup_Mileage             Int          NULL,
  Dropoff_Mileage            Int          NULL,
  Rental_Car_ReturnTanklevel  Varchar(10)      NULL,
  Rental_Deposit_Paid_Status VarChar (10)     NULL,
  Rental_Tax                 Float        NULL,
  Rental_Days                Int          NULL ,
  Rental_Charge              Int          NULL ,
  Pickup_Location_ID         Int          NOT NULL,
  Dropoff_Location_ID        Int          NOT NULL,
  Customer_Id                Int          NOT NULL ,
  Vehicle_ID                 VARCHAR(50)  NOT NULL ,
  Insurance_ID               Int          NOT NULL
  
  );
  
--------------------------
-- Create Table Insurance
--------------------------

CREATE TABLE Insurance
(
  Insurance_ID             Int          NOT NULL ,
  Insurance_By             Varchar(50)  NOT NULL ,
  Insurance_Type           Varchar(50)  NULL ,
  Insurance_Perday_Rate    Float        NULL 
 
);




--------------------------
-- Create TABLE Deposit
--------------------------

CREATE TABLE Deposit 
(
  Deposit_ID            Int            NOT NULL ,
  Deposit_Amount        Float          NOT NULL ,
  Card_id               varchar(20)    NOT NULL,
  Rental_ID             Int            NOT NULL 
  );
  
  
--------------------------
-- Create TABLE Invoice
--------------------------

CREATE TABLE Invoice 
(
  Invoice_Number               Int        NOT NULL ,
  Total_Charge_Incx_Tax        Float      NULL ,
  Debit_Card_Total             Float      NULL ,
  Credit_Card_Total            Float      NULL ,
  Cash_Total                   Float      NULL ,
  Payment_Status               Varchar(10) NULL ,
  Payment_Date                 Date       NULL ,
  Rental_ID                    Int        NOT NULL 
  );
  
  

--------------------------
-- Create TABLE Tax
--------------------------

CREATE TABLE Tax 
(
  Tax_ID       Int        NOT NULL ,
  Tax_Rate     Float      NULL 
  );
  
  --------------------------
-- Create TABLE Location
--------------------------

CREATE TABLE Location 
(
  Location_ID       Int           NOT NULL ,
  Location_Street   Varchar(50)   NOT NULL ,
  Location_City     VarChar(50)   NOT NULL ,
  Location_State    Varchar(50)   NOT NULL ,
  Location_Zip_Code Int           NOT NULL ,
  Location_Phone    VARCHAR(50)   NOT NULL ,
  Location_Email    VARCHAR(50)   NULL ,
  Tax_ID            Int           NOT NULL
  );
--------------------------
-- Create TABLE Vehicle

-------------------------

CREATE TABLE Vehicle 
(
  Vehicle_ID              Varchar(50)  NOT NULL ,
  Vehicle_Type            Varchar(50)  NOT NULL ,
  Vehicle_Model           VarChar(50)  NOT NULL ,
  Vehicle_Year            Varchar(50)  NOT NULL ,
  Vehicle_Current_Mileage Int          NOT NULL ,
  Vehicle_Rental_Status   VARCHAR(50)  NOT NULL ,
  Vehicle_Number_Of_Seats Int          NOT NULL ,
  Vehicle_Rental_Rate     Int          NOT NULL ,
  Vehicle_Color           VARCHAR(20)  NOT NULL ,
  Location_ID             Int          NOT NULL 
  );
 

----------------------
-- Define clustered index 
---------------------- 
 CREATE INDEX location_city_id  ON Location (Location_id ASC,Location_city ASC);

  
----------------------
-- Define primary keys
----------------------


 ALTER TABLE Customer ADD CONSTRAINT PK_Customer PRIMARY KEY CLUSTERED (Customer_Id);
 ALTER TABLE License  ADD CONSTRAINT PK_License PRIMARY KEY CLUSTERED (License_Number);
 ALTER TABLE Card_Detail  ADD CONSTRAINT PK_Card_Detail PRIMARY KEY CLUSTERED (Card_ID);
 ALTER TABLE Insurance  ADD CONSTRAINT PK_Insurance PRIMARY KEY CLUSTERED (Insurance_ID);
 ALTER TABLE Rental  ADD CONSTRAINT PK_Rental PRIMARY KEY CLUSTERED (Rental_ID);
 ALTER TABLE Location ADD CONSTRAINT PK_Location PRIMARY KEY  (Location_ID);
 ALTER TABLE Deposit  ADD CONSTRAINT PK_Deposit PRIMARY KEY CLUSTERED (Deposit_ID);
 ALTER TABLE Invoice ADD CONSTRAINT PK_Invoice PRIMARY KEY CLUSTERED (Invoice_Number);
 ALTER TABLE Tax  ADD CONSTRAINT PK_tax PRIMARY KEY CLUSTERED (Tax_ID);
 ALTER TABLE Vehicle  ADD CONSTRAINT PK_Vehicle PRIMARY KEY CLUSTERED (Vehicle_ID);




 
 
----------------------
-- Define foreign keys
----------------------

 ALTER TABLE Customer ADD CONSTRAINT FK_Customer_Licence FOREIGN KEY (License_Number) REFERENCES License(License_Number);
 ALTER TABLE Card_Detail ADD CONSTRAINT FK_Card_detail_Customer FOREIGN KEY (Customer_Id) REFERENCES Customer(Customer_Id);
 ALTER TABLE Rental ADD CONSTRAINT FK_Rental_Customer FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID);
 ALTER TABLE Rental ADD CONSTRAINT FK_Rental_Vehicle FOREIGN KEY (Vehicle_ID) REFERENCES Vehicle(Vehicle_ID);
 ALTER TABLE Rental ADD CONSTRAINT FK_Rental_Insurance FOREIGN KEY (Insurance_ID) REFERENCES Insurance(Insurance_ID);
 ALTER TABLE Rental ADD CONSTRAINT FK_Rental_Pickup_Location FOREIGN KEY (Pickup_Location_ID) REFERENCES Location(Location_ID);
 ALTER TABLE Rental ADD CONSTRAINT FK_Rental_Dropoff_Location FOREIGN KEY (Dropoff_Location_ID) REFERENCES Location(Location_ID);
 ALTER TABLE Deposit ADD CONSTRAINT FK_Rental_Deposit FOREIGN KEY (Rental_ID) REFERENCES Rental(Rental_ID);
 ALTER TABLE Deposit ADD CONSTRAINT FK_Rental_Card FOREIGN KEY (Card_ID) REFERENCES Card_Detail(Card_ID);
 ALTER TABLE Invoice ADD CONSTRAINT FK_Rental_Invoice FOREIGN KEY (Rental_ID) REFERENCES Rental(Rental_ID);
 ALTER TABLE Location ADD CONSTRAINT FK_Location_Tax FOREIGN KEY (Tax_ID) REFERENCES Tax(Tax_ID);
 ALTER TABLE Vehicle ADD CONSTRAINT FK_Vehicle_Location FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID);
