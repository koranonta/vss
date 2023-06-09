USE lapatprc_vssdb;
CALL spAddPropertyTypeGroup ('EmployeeTypes', 'ประเภทพนักงาน', -1, @newId);
CALL spAddPropertyType (1, 'Management',      'ผู้บริหาร',    NULL, NULL, -1, @newId);
CALL spAddPropertyType (1, 'Department head', 'หัวหน้าแผนก', NULL, NULL, -1, @newId);
CALL spAddPropertyType (1, 'Teacher',         'ครูบรรจุ',    NULL, NULL, -1, @newId);
CALL spAddPropertyType (1, 'Staff',           'ลูกจ้าง',     NULL, NULL, -1, @newId);

CALL spAddPropertyTypeGroup ('UserRoles', 'บทบาทของผู้ใช้', -1, @newId);
CALL spAddPropertyType (2, 'Admin',      'ผู้จัดการระบบ', NULL, NULL, -1, @newId);
CALL spAddPropertyType (2, 'Management', 'ผู้บริหาร',    NULL, NULL, -1, @newId);
CALL spAddPropertyType (2, 'User',       'ผู้ใช้ทั่วไป',   NULL, NULL, -1, @newId);

CALL spAddPropertyTypeGroup ('Genders', '', -1, @newId);
CALL spAddPropertyType (3, 'Miss', 'น.ส.',  NULL, NULL, -1, @newId);
CALL spAddPropertyType (3, 'Mrs',  'นาง',  NULL, NULL, -1, @newId);
CALL spAddPropertyType (3, 'Mr',   'นาย',  NULL, NULL, -1, @newId);

CALL spAddPropertyTypeGroup ('Deductions', 'หัก', -1, @newId);
CALL spAddPropertyType (4, 'Contribution for teacher', 'เงินสมทบ 3%', NULL, '3%', -1, @newId);
CALL spAddPropertyType (4, 'CPK/CPS',                  'ชพค/ชพส',   NULL, NULL, -1, @newId);
CALL spAddPropertyType (4, 'Cooperative',              'สหกรณ์',    NULL, NULL, -1, @newId);
CALL spAddPropertyType (4, 'OamSinth',                 'ออมสิน',    NULL, NULL, -1, @newId);
CALL spAddPropertyType (4, 'GsbLoan',                  'เงินกู้ สช.',   NULL, NULL, -1, @newId);
CALL spAddPropertyType (4, 'PrivateLoan',              'เงินกู้ สช.',   NULL, NULL, -1, @newId);
CALL spAddPropertyType (4, 'Other',                    'อื่นๆ',      NULL, NULL, -1, @newId);
CALL spAddPropertyType (4, 'Saving',                   'ออมทรัพย์',   NULL, NULL, -1, @newId);
CALL spAddPropertyType (4, 'Contribution for staff',   'สปส 5%',    NULL, '5%', -1, @newId);
CALL spAddPropertyType (4, 'Insurance',                'ประกัน',     NULL, NULL, -1, @newId);


DELIMITER $$

-- spAddPropertyType.sql
DROP PROCEDURE IF EXISTS spGetPropertyTypeByGroups
$$
CREATE PROCEDURE spGetPropertyTypeByGroups(
  pPropertyTypeGroupId INT 
)
/***********************************************************
 *  Procedure: spGetPropertyTypeByGroupId
 *
 *  Purpose:
 *    
 *
 *  Usage: CALL spGetPropertyTypeByGroups( -1 );
 *    
 *  Notes:
 *
 *  Created:   KNN     2023-06-03
 *  Modified
 *  Date         Author      Description
 *----------------------------------------------------------
 ***********************************************************/
BEGIN
  SELECT pt.PropertyTypeGroupId       as propertytypegroupid
        ,pg.PropertyTypeGroupName     as propertytypegroupname
        ,pg.PropertyTypeGroupThaiName as propertytypeGroupthainame
        ,pt.PropertyTypeId            as propertytypeid
        ,pt.PropertyTypeName          as propertytypename
        ,pt.PropertyTypeThaiName      as propertytypethainame
        ,pt.Alias                     as alias
        ,pt.AllowableValues           as allowablevalues
    FROM PropertyTypes pt
   INNER JOIN PropertyTypeGroups pg
      ON pt.PropertyTypeGroupId = pg.PropertyTypeGroupId
   WHERE pt.DateDeleted IS NULL
     AND pg.DateDeleted IS NULL
     AND (pt.PropertyTypeGroupId = pPropertyTypeGroupId OR IF( pPropertyTypeGroupId <= 0, 1, 0) = 1);
END
$$
DELIMITER ;
