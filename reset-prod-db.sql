INSERT INTO Employees (


INSERT INTO Employees (EmployeeTypeId, AccountId, GenderId, FirstName, LastName, DateCreated, DateModified, CreatedBy, ModifiedBy)
  VALUES(4, '3680252943', 10, 'ปุญณพงษ์', 'เดชแสง'),
  VALUES(4, '9083235181', 8, 'ภัสสร', 'สมเพ็ชร์');
  
    
    
DELETE FROM PayrollTransactionItems;
DELETE FROM PayrollTransactions;
DELETE FROM PayrollRuns;
DELETE FROM Addresses;
DELETE FROM Employees;    


ALTER TABLE tablename AUTO_INCREMENT = 1