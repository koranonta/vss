--  Add references
CALL spAddRefTable ('EMPTYPE', 'ผู้บริหาร', -1, @newId);
CALL spAddRefTable ('EMPTYPE', 'หัวหน้าแผนก', -1, @newId);
CALL spAddRefTable ('EMPTYPE', 'ครูบรรจุ', -1, @newId);
CALL spAddRefTable ('EMPTYPE', 'ลูกจ้าง', -1, @newId);
CALL spAddRefTable ('USERROLE', 'ผู้จัดการระบบ', -1, @newId);
CALL spAddRefTable ('USERROLE', 'ผู้บริหาร', -1, @newId);
CALL spAddRefTable ('USERROLE', 'ผู้ใช้ทั่วไป', -1, @newId);
CALL spAddRefTable ('GENDER', 'น.ส.', -1, @newId);
CALL spAddRefTable ('GENDER', 'นาง', -1, @newId);
CALL spAddRefTable ('GENDER', 'นาย', -1, @newId);
CALL spAddRefTable ('DEDUCTYPE', 'ครูบรรจุ', -1, @newId);


CALL spAddUser ('kora', 'knn',  'kora@gmail.com', '0639789149', 5, '', -1, @newId);
CALL spAddUser ('moo',  'moo',  'moo@gmail.com',  '0629879894', 5, '', -1, @newId);
CALL spAddUser ('dore', 'dore', 'dore@gmail.com', '0635424930', 6, '', -1, @newId);
CALL spAddUser ('demo', 'demo', 'demo@gmail.com', '0735411521', 7, '', -1, @newId);


--  Deduction template

CALL spAddDeduction    (11, 'Teacher Deduction', -1, @newId);
CALL spAddDeductionItem(1, 'Contribution',   'เงินสมทบ 3%', '3%',  -1, @newId);
CALL spAddDeductionItem(1, 'CPK/CPS',        'ชพค/ชพส',    NULL, -1, @newId);
CALL spAddDeductionItem(1, 'Cooperative',    'สหกรณ์',     NULL, -1, @newId);
CALL spAddDeductionItem(1, 'OamSinth',       'ออมสิน',     NULL, -1, @newId);
CALL spAddDeductionItem(1, 'GsbLoan',        'เงินกู้ สช.',    NULL, -1, @newId);
CALL spAddDeductionItem(1, 'PrivateLoan',    'กยศ.',      NULL, -1, @newId);
CALL spAddDeductionItem(1, 'Other',          'อื่นๆ',       NULL, -1, @newId);
CALL spAddDeductionItem(1, 'Saving',         'ออมทรัพย์',    NULL, -1, @newId);

CALL spAddDeduction    (12, 'Staff Deduction', -1, @newId);
CALL spAddDeductionItem(2, 'Contribution', 'สปส 5%',  '5%', -1, @newId);
CALL spAddDeductionItem(2, 'Saving',       'ออมทรัพย์', NULL, -1, @newId);
CALL spAddDeductionItem(2, 'Other',        'อื่นๆ',    NULL, -1, @newId);
CALL spAddDeductionItem(2, 'Insurance',    'ประกัน',   NULL, -1, @newId);

