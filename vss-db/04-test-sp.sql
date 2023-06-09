CALL spGetProducts();
CALL spGetUsers();


CALL spAddAddress (4, 1, '365 North Tejon', '', 'Middleton', 'Colorado Springs', '10110', 'USA', -1, @NewId);
SELECT NewId = @NewId;

CALL spAddAddress (4, 1, '365 North Tejon', '', 'Middleton', 'Colorado Springs', '10110', 'USA', -1, @NewId);
SELECT @NewId;



CALL spAddAddress (1, 1, '75 Sukhumvit Soi 49', 'Klong Tei Nuea', 'Wattana', 'Bangkok', '10110', 'Thailand', -1, @NewId);
CALL spAddAddress (2, 1, '10 Sukhumvit Soi 55', 'Klong Tei Nuea', 'Wattana', 'Bangkok', '10110', 'Thailand', -1, @NewId);
CALL spAddAddress (3, 1, '10 Planok Rd Soi 10', 'BangSue', 'Wattana', 'Bangkok', '10110', 'Thailand', -1, @NewId);
CALL spAddAddress (4, 1, '365 North Tejon', '', 'Middleton', 'Colorado Springs', '10110', 'USA', -1, @NewId);

CALL spUpdateAddress (4, 1, '365 North Tejon', '', 'Middleton', 'Denver', '10110', 'USA', -1);

CALL spDeleteAddress (4, 1, -1);

CALL spGetAddressByUserId(2, 1);


--


www.lapassionbkk.com/app/chvp/backend/api/address.php?id=1


https://www.lapassionbkk.com/app/chvp/backend/api/address.php?id=1&invoiceTypeId=1

https://www.lapassionbkk.com/app/chvp/backend/api/users.php

https://www.lapassionbkk.com/app/chvp/backend/api/users.php?id=1

https://www.lapassionbkk.com/app/chvp/backend/api/address.php?id=1
