USE lapatprc_vssdb;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Addresses;


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
