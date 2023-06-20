import React, {useState, useEffect } from 'react'
import _ from 'lodash'
import { Typography } from '@material-ui/core';
import { commonStyles } from '../../theme/CommonStyles';
import AppStyles from '../../theme/AppStyles'
import Popup from '../../components/Popup'
const K_LOGIN_FIELDS = [
  { label: 'ชื่อ :',      fieldName: 'name',     align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'รหัสผ่าน :',  fieldName: 'password', align: 'right', labelWidth: '30%', inputWidth: '70%' },
]

const K_REGISTER_FIELDS = [
  { label: 'ชื่อ :',         fieldName: 'name',     align: 'right', labelWidth: '40%', inputWidth: '60%' },
  { label: 'อีเมล :',       fieldName: 'email',    align: 'right', labelWidth: '40%', inputWidth: '60%' },
  { label: 'เบอร์โทร :',    fieldName: 'phone',   align: 'right', labelWidth: '40%', inputWidth: '60%' },
  { label: 'รหัสผ่าน :',     fieldName: 'password', align: 'right', labelWidth: '40%', inputWidth: '60%' },
  { label: 'ยืนยันรหัสผ่าน :', fieldName: 'confirmpassword', align: 'right', labelWidth: '30%', inputWidth: '70%' },
]

const K_RESET_PASSWORD_FIELDS = [
  { label: 'ชื่อ :',         fieldName: 'name',     align: 'right', labelWidth: '40%', inputWidth: '60%' },
  { label: 'รหัสผ่าน :',     fieldName: 'password', align: 'right', labelWidth: '40%', inputWidth: '60%' },
  { label: 'ยืนยันรหัสผ่าน :', fieldName: 'confirmpassword', align: 'right', labelWidth: '40%', inputWidth: '60%' },
]

const K_FIELDS_OPTIONS = [
  K_LOGIN_FIELDS,
  K_REGISTER_FIELDS,
  K_RESET_PASSWORD_FIELDS
]

const K_HEADERS = ['เข้าสู่ระบบ', 'สมัครผู้ใช้', 'เปลี่ยนรหัสผ่าน']

const K_LOGIN = 0
const K_REIGSTER = 1
const K_CHANGE_PASSWORD = 2

const LoginDlg = (props) => {
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [emailError, setEmailError] = useState(false)
  const [passwordError, setPasswordError] = useState(false)

  const {open, setOpen, width, actionHandler, initialPos } = props  
  const [buf, setBuf] = useState({})
  const [mode, setMode] = useState(K_LOGIN)

  const classes = AppStyles()

  const testLogin = {
    name: 'kora'
   ,password: 'knn'
  }

  useEffect(() => {
    setBuf(testLogin)
  },[])

  const handleSubmit = (event) => {
    event.preventDefault()
    setEmailError(false)
    setPasswordError(false)
    if (email == '') 
      setEmailError(true)
    if (password == '') 
      setPasswordError(true)
    if (email && password) 
      console.log(email, password)
  }

  const onOk = (e) => {
    e.preventDefault()
    if (mode === K_LOGIN) {

    } 
    actionHandler(mode, buf)
    setOpen(false)
  }

  const onCancel = (e) => {  
    e.preventDefault()    
  } 

  const handleChange = (e) => {
    const temp = {...buf, [e.target.name]: e.target.value}
    setBuf(temp)
  }

  const handleOption = (opt) => {
    setMode(opt)
  }

  const getFooterOptions = () => {
    if (mode === K_LOGIN) 
      return (
        <>
          <small>ยังไม่มีผู้ใช้? <a onClick={e=>handleOption(1)}>สมัครผู้ใช้</a></small>
          <small> หรือ <a onClick={e=>handleOption(2)}>เปลี่ยนรหัสผ่าน</a></small>
        </>
      )
    else if (mode === K_REIGSTER || mode === K_CHANGE_PASSWORD) 
      return (<small>มีผู้ใช้แล้ว? <a onClick={e=>handleOption(0)}>เข้าสู่ระบบ</a></small>)
  }

  return ( 
     <Popup open={open} setOpen={setOpen} initialPos={initialPos}>
       <div style={{width}}>
         <div style={{ display: 'flex' }}>
           <Typography variant="h6" component="div" className={classes.orderDetailHeader}>
             {K_HEADERS[mode]}
           </Typography>
         </div>  

         <div className="mt-3">
         <form> 
           <table width="80%">
             <tbody>
             {
                K_FIELDS_OPTIONS[mode].map((elem, index) => {
                let fieldValue = _.isEmpty(buf) ? "" : buf[elem.fieldName]
                return (
                  <tr key={index}>
                    <td width={elem.labelWidth} align={elem.align}> 
                      <label htmlFor={elem.fieldName} style={{...commonStyles.inputLabel}}>{elem.label}</label>
                    </td>
                    <td width={elem.inputWidth} >
                      <input type="text" 
                        style={{width: '100%'}}
                        value={ _.isEmpty(buf) ? "" : fieldValue}
                        onChange={handleChange}
                        autoCapitalize={false} 
                        required                      
                        name={elem.fieldName}
                        id={elem.fieldName}/>                         
                    </td>
                  </tr>)})
             }
             <tr>
               <td colSpan="2" align="right">
               <div className={`mt-3 mb-3`}>
                 <button onClick={e => onOk(e)} disabled={false} name="submit" className={classes.pillButton} style={{width: '60%'}}>{K_HEADERS[mode]}</button>                 
              </div>
               </td>
             </tr>
             </tbody>
           </table>
            { getFooterOptions() }          
            </form>  
         </div>
        </div>
      </Popup>
  );
}

export default LoginDlg


/*

      <small>Need an account? <a onClick={e=>handleOption(1)}>Register here</a></small>

Login templates

https://enlear.academy/31-example-login-form-for-website-42abc6f6d525
https://freshdesignweb.com/css-login-form-templates/
https://www.begindot.com/free-css3-html5-login-form-templates/




*/