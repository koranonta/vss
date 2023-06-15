DROP TABLE IF EXISTS PayrollRuns;
DROP TABLE IF EXISTS PayrollTransactions;
DROP TABLE IF EXISTS PayrollTransactionItems;


CREATE TABLE PayrollRuns (
  PayrollRunId   INT      NOT NULL AUTO_INCREMENT,
  PayrollRunDate DATETIME NOT NULL,
  DateCreated    DATETIME NOT NULL,
  DateModified   DATETIME NOT NULL,
  DateDeleted    DATETIME DEFAULT NULL,
  CreatedBy      INT      NOT NULL DEFAULT -1,
  ModifiedBy     INT      NOT NULL DEFAULT -1,
  DeletedBy      INT      DEFAULT NULL,
  PRIMARY KEY (PayrollRunId)
);  
  
CREATE TABLE PayrollTransactions (
  PayrollTransactionId INT      NOT NULL AUTO_INCREMENT,
  PayRollRunId         INT      NOT NULL,
  EmployeeId           INT      NOT NULL,
  DeductionId          INT      NOT NULL,
  DateCreated          DATETIME NOT NULL,
  DateModified         DATETIME NOT NULL,
  DateDeleted          DATETIME DEFAULT NULL,
  CreatedBy            INT      NOT NULL DEFAULT -1,
  ModifiedBy           INT      NOT NULL DEFAULT -1,
  DeletedBy            INT      DEFAULT NULL,
  PRIMARY KEY (PayrollTransactionId),
  FOREIGN KEY (EmployeeId)   REFERENCES Employees(EmployeeId),
  FOREIGN KEY (DeductionId)  REFERENCES Deductions(DeductionId),
  FOREIGN KEY (PayRollRunId) REFERENCES PayrollRuns(PayRollRunId)
);

CREATE TABLE PayrollTransactionItems (
  PayrollTransactionItemId INT      NOT NULL AUTO_INCREMENT,
  PayrollTransactionId     INT      NOT NULL,
  PropertyTypeId           INT      NOT NULL,
  Amount                   FLOAT    DEFAULT 0.0,
  DateCreated              DATETIME NOT NULL,
  DateModified             DATETIME NOT NULL,
  DateDeleted              DATETIME DEFAULT NULL,
  CreatedBy                INT      NOT NULL DEFAULT -1,
  ModifiedBy               INT      NOT NULL DEFAULT -1,
  DeletedBy                INT      DEFAULT NULL,
  PRIMARY KEY (PayrollTransactionItemId),
  FOREIGN KEY (PayrollTransactionId) REFERENCES SalaryTransactions(PayrollTransactionId),
  FOREIGN KEY (PropertyTypeId) REFERENCES PropertyTypes(PropertyTypeId)
);

