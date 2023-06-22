const K_TEACHER_TYPE_ID      = 3
const K_STAFF_TYPE_ID        = 4
const K_TEACHER_DEDUCTION_ID = 1
const K_STAFF_DEDUCTION_ID   = 2
const K_EMPLOYEE_TYPE        = 1
const K_USER_ROLES_TYPE      = 2
const K_GENDER_TYPE          = 3
const K_DEDICTION_TYPE       = 4


const K_HTTP_OK              = 200

const K_DEDUCTION_MAP = new Map()
K_DEDUCTION_MAP.set(K_TEACHER_TYPE_ID, K_TEACHER_DEDUCTION_ID)
K_DEDUCTION_MAP.set(K_STAFF_TYPE_ID, K_STAFF_DEDUCTION_ID)


const K_EMPTY_ADDRESS = {
  addressid: -1,
  address: "",
  street: "",
  subdistrict: "",
  district: "",
  province: "",
  city: "",
  country: "",
  postcode: "",
}

const Constants = {
  K_DEDUCTION_MAP,
  K_TEACHER_TYPE_ID,
  K_STAFF_TYPE_ID,
  K_EMPLOYEE_TYPE,
  K_USER_ROLES_TYPE,
  K_GENDER_TYPE,
  K_DEDICTION_TYPE,  
  K_HTTP_OK,
  K_EMPTY_ADDRESS,
}

export default Constants
