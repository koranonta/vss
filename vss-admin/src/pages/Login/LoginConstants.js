const K_LOGIN_FIELDS = [
  { label: 'ชื่อ :',      fieldName: 'name',     align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'รหัสผ่าน :',  fieldName: 'password', align: 'right', labelWidth: '30%', inputWidth: '70%', type: 'password' },
]

const K_REGISTER_FIELDS = [
  { label: 'ชื่อ :',         fieldName: 'name',     align: 'right', labelWidth: '40%', inputWidth: '60%' },
  { label: 'อีเมล :',       fieldName: 'email',    align: 'right', labelWidth: '40%', inputWidth: '60%' },
  { label: 'เบอร์โทร :',    fieldName: 'phone',   align: 'right', labelWidth: '40%', inputWidth: '60%' },
  { label: 'รหัสผ่าน :',     fieldName: 'password', align: 'right', labelWidth: '40%', inputWidth: '60%', type: 'password' },
  { label: 'ยืนยันรหัสผ่าน :', fieldName: 'confirmpassword', align: 'right', labelWidth: '30%', inputWidth: '70%', type: 'password' },
]

const K_RESET_PASSWORD_FIELDS = [
  { label: 'ชื่อ :',         fieldName: 'name',     align: 'right', labelWidth: '40%', inputWidth: '60%' },
  { label: 'รหัสผ่าน :',     fieldName: 'newpassword', align: 'right', labelWidth: '40%', inputWidth: '60%', type: 'password' },
  { label: 'ยืนยันรหัสผ่าน :', fieldName: 'confirmpassword', align: 'right', labelWidth: '40%', inputWidth: '60%', type: 'password' },
]

const K_CLEAR_FIELDS = {
  name: "",
  email: "",
  phone: "",
  password: "",
  confirmpassword: ""
}

const K_FIELDS_OPTIONS = [  
  K_LOGIN_FIELDS,
  K_REGISTER_FIELDS,
  K_RESET_PASSWORD_FIELDS
]

const K_HEADERS = ['เข้าสู่ระบบ', 'สมัครผู้ใช้', 'เปลี่ยนรหัสผ่าน']

const K_LOGIN = 0
const K_REGISTER = 1
const K_RESET_PASSWORD = 2
const K_REGULAR_USER = 7

const LoginConstants = {
  K_FIELDS_OPTIONS,
  K_HEADERS,
  K_LOGIN,
  K_REGISTER,
  K_RESET_PASSWORD,
  K_CLEAR_FIELDS,
  K_REGULAR_USER,
}

export default LoginConstants