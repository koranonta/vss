DROP TABLE IF EXISTS Deductions;
DROP TABLE IF EXISTS DeductionItems;

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
  PRIMARY KEY (DeductionId),
  FOREIGN KEY (DeductionTypeId) REFERENCES PropertyTypes(PropertyTypeId),
  
);

CREATE TABLE DeductionItems (
  DeductionItemId   INT         NOT NULL AUTO_INCREMENT,
  DeductionId       INT         NOT NULL,
  PropertyTypeId    INT         NOT NULL,
  DateCreated       DATETIME    NOT NULL,
  DateModified      DATETIME    NOT NULL,
  DateDeleted       DATETIME    DEFAULT NULL,
  CreatedBy         INT         NOT NULL DEFAULT -1,
  ModifiedBy        INT         NOT NULL DEFAULT -1,
  DeletedBy         INT         DEFAULT NULL,
  PRIMARY KEY (DeductionItemId),
  FOREIGN KEY (DeductionId) REFERENCES Deductions(Deductions),
  FOREIGN KEY (PropertyTypeId) REFERENCES PropertyTypes(PropertyTypeId)
);
