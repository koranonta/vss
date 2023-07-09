CREATE TABLE Members (
  MemberId     INT      NOT NULL AUTO_INCREMENT,
  EmployeeId   INT      NOT NULL,
  JoinDate     DATETIME NOT NULL,
  DateCreated  DATETIME NOT NULL,
  DateModified DATETIME NOT NULL,
  DateDeleted  DATETIME DEFAULT NULL,
  CreatedBy    INT      NOT NULL DEFAULT -1,
  ModifiedBy   INT      NOT NULL DEFAULT -1,
  DeletedBy    INT      DEFAULT NULL,
  PRIMARY KEY (MemberId),
  FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId)
);

CREATE TABLE SavingItems (
  SavingItemId INT      NOT NULL AUTO_INCREMENT,
  MemberId     INT      NOT NULL,
  DepositDate  DATETIME NOT NULL,
  Amount       FLOAT    NOT NULL,
  DateCreated  DATETIME NOT NULL,
  DateModified DATETIME NOT NULL,
  DateDeleted  DATETIME DEFAULT NULL,
  CreatedBy    INT      NOT NULL DEFAULT -1,
  ModifiedBy   INT      NOT NULL DEFAULT -1,
  DeletedBy    INT      DEFAULT NULL,
  PRIMARY KEY (SavingItemId),
  FOREIGN KEY (MemberId) REFERENCES Members(MemberId)
);


CREATE TABLE Loans (
  LoanId       INT      NOT NULL AUTO_INCREMENT,
  MemberID     INT      NOT NULL,
  Amount       FLOAT    NOT NULL,
  Installment  FLOAT    NOT NULL,
  Status       INT      NOT NUL,
  DateCreated  DATETIME NOT NULL,
  DateModified DATETIME NOT NULL,
  DateDeleted  DATETIME DEFAULT NULL,
  CreatedBy    INT      NOT NULL DEFAULT -1,
  ModifiedBy   INT      NOT NULL DEFAULT -1,
  DeletedBy    INT      DEFAULT NULL,
  PRIMARY KEY (LoanId),
  FOREIGN KEY (MemberId) REFERENCES Members(MemberId)
);

CREATE TABLE LoanItems (
  LoanItemId      INT      NOT NULL AUTO_INCREMENT,
  LoanId          INT      NOT NULL,
  RemainingAmount FLOAT    NOT NULL,
  DueAmount       FLOAT    NOT NULL,
  InterestAmount  FLOAT    NOT NULL,
  PaidAmount      FLOAT    NOT NULL,
  PaidDate        DATETIME DEFAULT NULL,
  DateCreated     DATETIME NOT NULL,
  DateModified    DATETIME NOT NULL,
  DateDeleted     DATETIME DEFAULT NULL,
  CreatedBy       INT      NOT NULL DEFAULT -1,
  ModifiedBy      INT      NOT NULL DEFAULT -1,
  DeletedBy       INT      DEFAULT NULL,
  PRIMARY KEY (LoanItemId),
  FOREIGN KEY (LoanId) REFERENCES Loans(LoanId)
);

