CALL spAddemployee (3, '111-2-33333-4', 10, 'kora', 'nonta', '9-1008-02452-28-9', '2509-04-10', '2010-01-01', 'karawith.n.png', 10000.00, 0, -1, @newId);

SELECT * FROM `Employees` WHERE EmployeeId =  158;

-- Id = 158

CALL spUpdateEmployee (158, 3, '111-2-33333-4', 10, 'kora-abcdef', 'nonta', '9-1008-02452-28-9', '2509-04-10', '2010-01-01', 'karawith.n.png', 10000.00, 0, -1);

CALL spDeleteEmployee (158, -1);



CALL spAddAddress (158, '75/1 Soi 49', 'Klongtei', 'Wattana', 'Sukhumvit Road', 'Bangkok', 'Prakanong', 'Thailand', '10110', -1, @newId);

-- Id = 6
SELECT * FROM Addresses;


CALL spUpdateAddress (6, 158, '75/1 Eakmai 97', 'Klongtei', 'Wattana', 'Sukhumvit Road', 'Bangkok', 'Prakanong', 'Thailand', '10110', -1);


CALL spDeleteAddress (6, -1);

