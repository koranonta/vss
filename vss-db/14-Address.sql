USE lapatprc_vssdb;
DROP TABLE IF EXISTS Addresses;
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
