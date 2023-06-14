
DELETE FROM `Employees` WHERE EmployeeId > 156;
DELETE FROM `Addresses` WHERE AddressId > 5;

SELECT * FROM Employees WHERE EmployeeId > 156;
SELECT * FROM Addresses WHERE AddressId > 5;



UPDATE Employees
  SET DateDeleted = NULL
     ,DeletedBy = NULL
WHERE EmployeeId > 156;

     