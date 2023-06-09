CALL spAddDeduction    (3, 'Teacher salary deduction rules', 'กฏหักเงินเดือนครูบรรจุ', -1, @newId);
CALL spAddDeductionItem(1, 11, -1, @newId);
CALL spAddDeductionItem(1, 12, -1, @newId);
CALL spAddDeductionItem(1, 13, -1, @newId);
CALL spAddDeductionItem(1, 14, -1, @newId);
CALL spAddDeductionItem(1, 15, -1, @newId);
CALL spAddDeductionItem(1, 16, -1, @newId);
CALL spAddDeductionItem(1, 17, -1, @newId);
CALL spAddDeductionItem(1, 18, -1, @newId);

CALL spAddDeduction    (4, 'Staff salary deduction rules', 'กฏหักเงินเดือนลูกจ้าง', -1, @newId);
CALL spAddDeductionItem(2, 19, -1, @newId);
CALL spAddDeductionItem(2, 18, -1, @newId);
CALL spAddDeductionItem(2, 17, -1, @newId);
CALL spAddDeductionItem(2, 20, -1, @newId);
