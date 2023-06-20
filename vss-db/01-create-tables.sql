USE lapatprc_vssdb;
DROP TABLE IF EXISTS PropertyTypes;
DROP TABLE IF EXISTS PropertyTypeGroups;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Emplyees;
DROP TABLE IF EXISTS Addresses;
DROP TABLE IF EXISTS Deductions;
DROP TABLE IF EXISTS DeductionItems;
DROP TABLE IF EXISTS PayrollRuns;
DROP TABLE IF EXISTS PayrollTransactions;
DROP TABLE IF EXISTS PayrollTransactionItems;


CREATE TABLE PropertyTypeGroups (
  PropertyTypeGroupId       INT          NOT NULL AUTO_INCREMENT,
  PropertyTypeGroupName     VARCHAR(100) NOT NULL,
  PropertyTypeGroupThaiName VARCHAR(100),
  DateCreated  DATETIME     NOT NULL,
  DateModified DATETIME     NOT NULL,
  DateDeleted  DATETIME     DEFAULT NULL,
  CreatedBy    INT          NOT NULL DEFAULT -1,
  ModifiedBy   INT          NOT NULL DEFAULT -1,
  DeletedBy    INT          DEFAULT NULL,
  PRIMARY KEY (PropertyTypeGroupId)
);


CREATE TABLE PropertyTypes (
  PropertyTypeId         INT NOT NULL AUTO_INCREMENT,  
  PropertyTypeGroupId    INT NOT NULL,
  PropertyTypeName       VARCHAR(100) NOT NULL,
  PropertyTypeThaiName   VARCHAR(100),
  Alias                  VARCHAR(100),
  AllowableValues        VARCHAR(100),
  Rules                  VARCHAR(100),
  SortOrder              INT
  DateCreated  DATETIME  NOT NULL,
  DateModified DATETIME  NOT NULL,
  DateDeleted  DATETIME  DEFAULT NULL,
  CreatedBy    INT       NOT NULL DEFAULT -1,
  ModifiedBy   INT       NOT NULL DEFAULT -1,
  DeletedBy    INT       DEFAULT NULL,
  PRIMARY KEY (PropertyTypeId),
  FOREIGN KEY (PropertyTypeGroupId) REFERENCES PropertyTypeGroups(PropertyTypeGroupId),
  INDEX PropertyTypesIndex (PropertyTypeId, PropertyTypeGroupId)
);

CREATE TABLE Users (
  UserId       INT          NOT NULL AUTO_INCREMENT,
  Name         VARCHAR(100) NOT NULL,
  Password     VARCHAR(255) NOT NULL,
  Email        VARCHAR(100) DEFAULT NULL,
  Phone        VARCHAR(100) DEFAULT NULL,
  RoleId       INT          NOT NULL,
  Image        VARCHAR(100) DEFAULT NULL,
  DateCreated  DATETIME     NOT NULL,
  DateModified DATETIME     NOT NULL,
  DateDeleted  DATETIME     DEFAULT NULL,
  CreatedBy    INT          NOT NULL DEFAULT -1,
  ModifiedBy   INT          NOT NULL DEFAULT -1,
  DeletedBy    INT          DEFAULT NULL,
  PRIMARY KEY (UserId),
  FOREIGN KEY (RoleId) REFERENCES PropertyTypes(PropertyTypeId)
);

CREATE TABLE Employees (
  EmployeeId           INT          NOT NULL AUTO_INCREMENT,
  EmployeeTypeId       INT          NOT NULL,
  AccountId            VARCHAR(50)  NOT NULL,
  GenderId             INT          NOT NULL,
  FirstName            VARCHAR(50)  NOT NULL,
  LastName             VARCHAR(50)  NOT NULL,
  IdentificationCardId VARCHAR(50)  NOT NULL,
  BirthDate            DATE         NOT NULL,
  JoinDate             DATE         NOT NULL,
  Image                VARCHAR(100) DEFAULT NULL,
  Salary               FLOAT        NOT NULL DEFAULT 0.0,
  PositionSalary       FLOAT        NOT NULL DEFAULT 0.0,
  DateCreated          DATETIME     NOT NULL,
  DateModified         DATETIME     NOT NULL,
  DateDeleted          DATETIME     DEFAULT NULL,
  CreatedBy            INT          NOT NULL DEFAULT -1,
  ModifiedBy           INT          NOT NULL DEFAULT -1,
  DeletedBy            INT          DEFAULT NULL,
  PRIMARY KEY (EmployeeId),
  FOREIGN KEY (GenderId) REFERENCES PropertyTypes(PropertyTypeId),
  FOREIGN KEY (EmployeeTypeID) REFERENCES PropertyTypes(PropertyTypeId)
);

CREATE TABLE Addresses (
  AddressId     INT          NOT NULL AUTO_INCREMENT,
  EmployeeId    INT          NOT NULL,
  Address       VARCHAR(100) NOT NULL,
  SubDistrict   VARCHAR(100) DEFAULT NULL,
  District      VARCHAR(100) DEFAULT NULL,
  Street        VARCHAR(255) DEFAULT NULL,
  City          VARCHAR(100) NOT NULL,
  Province      VARCHAR(100) NOT NULL,
  Country       VARCHAR(100) NOT NULL,
  PostCode      VARCHAR(20)  NOT NULL,
  DateCreated   DATETIME     NOT NULL,
  DateModified  DATETIME     NOT NULL,
  DateDeleted   DATETIME     DEFAULT NULL,
  CreatedBy     INT          NOT NULL DEFAULT -1,
  ModifiedBy    INT          NOT NULL DEFAULT -1,
  DeletedBy     INT          DEFAULT NULL,
  PRIMARY KEY (AddressId),
  FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId)
);

CREATE TABLE Deductions (
  DeductionId       INT          NOT NULL AUTO_INCREMENT,
  DeductionTypeId   INT          NOT NULL,
  DeductionName     VARCHAR(100) NOT NULL,
  DeductionThaiName VARCHAR(100) NOT NULL,
  DateCreated       DATETIME     NOT NULL,
  DateModified      DATETIME     NOT NULL,
  DateDeleted       DATETIME     DEFAULT NULL,
  CreatedBy         INT          NOT NULL DEFAULT -1,
  ModifiedBy        INT          NOT NULL DEFAULT -1,
  DeletedBy         INT          DEFAULT NULL,
  PRIMARY KEY (DeductionId)
);

CREATE TABLE DeductionItems (
  DeductionItemId   INT          NOT NULL AUTO_INCREMENT,
  DeductionId       INT          NOT NULL,
  PropertyTypeId    INT          NOT NULL,
  CalculationRule   VARCHAR(100) DEFAULT NULL,
  MaximumValue      FLOAT        DEFAULT NULL,
  DateCreated       DATETIME     NOT NULL,
  DateModified      DATETIME     NOT NULL,
  DateDeleted       DATETIME     DEFAULT NULL,
  CreatedBy         INT          NOT NULL DEFAULT -1,
  ModifiedBy        INT          NOT NULL DEFAULT -1,
  DeletedBy         INT          DEFAULT NULL,
  PRIMARY KEY (DeductionItemId),
  FOREIGN KEY (DeductionId) REFERENCES Deductions(Deductions),
  FOREIGN KEY (PropertyTypeId) REFERENCES PropertyTypes(PropertyTypeId)
);

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

