USE lapatprc_vssdb;
DROP TABLE IF EXISTS Users;

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

