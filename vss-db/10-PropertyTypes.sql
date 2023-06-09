USE lapatprc_vssdb;
DROP TABLE IF EXISTS PropertyTypes;
DROP TABLE IF EXISTS PropertyTypeGroups;

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



