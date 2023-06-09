/*

CREATE PROCEDURE spAddRefTable (
  pRefTypeKind VARCHAR(10)
 ,pRefTypeName VARCHAR(100)
 ,pLoginId     INT
)


INSERT INTO `RefTable` (`RefTypeKind`, `RefTypeName`) VALUES
('EMPTYPE', 'ผู้บริหาร');
('EMPTYPE', 'หัวหน้าแผนก');
('EMPTYPE', 'ครูบรรจุ');
('EMPTYPE', 'ลูกจ้าง');
('USERROLE', 'ผู้จัดการระบบ');
('USERROLE', 'ผู้บริหาร');
('USERROLE', 'ผู้ใช้ทั่วไป');
('GENDER', 'น.ส.');
('GENDER', 'นาง');
('GENDER', 'นาย');
('DEDUCTYPE', 'ครูบรรจุ');
('DEDUCTYPE', 'ลูกจ้าง');

SELECT * FROM RefTable;




*/