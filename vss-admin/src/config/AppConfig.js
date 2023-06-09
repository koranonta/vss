const K_BASE_URL = "https://www.lapassionbkk.com/app/vss/backend/"
//const K_BASE_URL = "https://ontheeire.org/app/lap-api/"
//const K_BASE_URL = "http://localhost:5000/"
const K_API_URL              = K_BASE_URL + "api"
const K_IMAGE_DIR            = K_BASE_URL + "assets/images/products/"
const K_AVATAR_DIR           = K_BASE_URL + "assets/images/avatars/"
const K_TEACHER_TYPE_ID      = 3
const K_STAFF_TYPE_ID        = 4
const K_TEACHER_DEDUCTION_ID = 1
const K_STAFF_DEDUCTION_ID   = 2
const K_EMPLOYEE_TYPE        = 1
const K_USER_ROLES_TYPE      = 2
const K_GENDER_TYPE          = 3
const K_DEDICTION_TYPE       = 4

const K_DEDUCTION_MAP = new Map()
K_DEDUCTION_MAP.set(K_TEACHER_TYPE_ID, K_TEACHER_DEDUCTION_ID)
K_DEDUCTION_MAP.set(K_STAFF_TYPE_ID, K_STAFF_DEDUCTION_ID)

const AppConfig = {
  K_BASE_URL,
  K_API_URL,
  K_IMAGE_DIR,
  K_AVATAR_DIR, 
  K_DEDUCTION_MAP,
  K_TEACHER_TYPE_ID,
  K_STAFF_TYPE_ID,
  K_EMPLOYEE_TYPE,
  K_USER_ROLES_TYPE,
  K_GENDER_TYPE,
  K_DEDICTION_TYPE,  
}

export default AppConfig
