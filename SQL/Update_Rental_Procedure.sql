DROP PROCEDURE IF EXISTS UPDATE_RENTAL;
SET SQL_SAFE_UPDATES = 0; 
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //
CREATE PROCEDURE  UPDATE_RENTAL()
BEGIN 
UPDATE  Rental  INNER JOIN Deposit  ON
Rental.Rental_ID = Deposit.Rental_ID
SET  Rental.Rental_Deposit_Paid_Status ='Paid'; 
UPDATE rental  R 
INNER JOIN  Vehicle   V ON v.vehicle_id= r.vehicle_id 
INNER JOIN Insurance I ON R.Insurance_ID =I.Insurance_ID
SET Rental_Charge = 
 (r.rental_days* v.vehicle_rental_rate) + 
(I.Insurance_perday_rate *r.rental_days) + 
CASE
    WHEN Rental_Car_ReturnTanklevel = 'HALF' THEN '15'    
    WHEN Rental_Car_ReturnTanklevel = 'EMPTY' THEN '25'
    ELSE '0'
END ;
 UPDATE Rental
 SET Rental_Days = datediff(Rental_Pickup_Date,Rental_dropoff_date);
UPDATE Vehicle V
INNER JOIN Rental R
 ON V.vehicle_id=R.vehicle_Id 
 SET V.Vehicle_Rental_Status ='Rented'
 WHERE CURDATE()  BETWEEN R.Rental_Pickup_Date and R.Rental_Dropoff_Date ;
 
UPDATE   Vehicle V 
INNER JOIN Rental R ON 
V.vehicle_id=R.vehicle_Id 
INNER JOIN Invoice I ON 
I.Rental_ID =R.Rental_ID
SET V.Vehicle_Rental_Status ='Not Rented'
WHERE Payment_Status='PAID';
 
END //
DELIMITER ;

CALL UPDATE_RENTAL();
