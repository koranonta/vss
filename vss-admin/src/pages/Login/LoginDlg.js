import React, {useState, useEffect, useContext } from 'react'
import {useNavigate} from "react-router-dom"
import _ from 'lodash'
import { Typography } from '@material-ui/core';
import { commonStyles } from '../../theme/CommonStyles';
import AppStyles from '../../theme/AppStyles'
import Popup from '../../components/Popup'
import LoginConstants from './LoginConstants';
import { AppContext } from '../../context/AppContext';
import Constants from '../../util/Constants';
import ApiService from '../../services/ApiService'
import AlertDlg from '../../components/AlertDlg';
import { sideBarData } from '../../components/Navbar/SidebarData';

const LoginDlg = (props) => {
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [emailError, setEmailError] = useState(false)
  const [passwordError, setPasswordError] = useState(false)

  const {open, setOpen, width, initialPos } = props  
  const [buf, setBuf] = useState({})
  const [mode, setMode] = useState(LoginConstants.K_LOGIN)
  const [openAlert, setOpenAlert] = useState(false)
  const [message, setMessage] = useState()

  const classes = AppStyles()

  const { login, setLogin, setSelMenu } = useContext(AppContext)
  const navigate = useNavigate();

  /*
  const testLogin = {
    name: 'kora'
   ,password: 'knn'
  }

  useEffect(() => {
    setBuf(testLogin)
  },[])
*/
  const handleSubmit = (event) => {
    event.preventDefault()
    setEmailError(false)
    setPasswordError(false)
    if (email === '') 
      setEmailError(true)
    if (password === '') 
      setPasswordError(true)
    if (email && password) 
      console.log(email, password)
  }

  const loginHandler = (user) => {
    console.log("in Login Handler")
    console.log("action", user.action)
    console.log("user", user)
    ApiService.authenticate(user)
    .then(resp => {
      if (resp.status === Constants.K_HTTP_OK) {
        setLogin(resp.data.response)
        setSelMenu(sideBarData[1].title)
        setOpen(false)
        navigate("/employees")
      }
      else {
        setMessage(resp.error[0].message)
        setOpenAlert(true)
      }
    })
    .catch(e => {
      console.log(e)
    })            
  }    

  const onOk = (e) => {
    e.preventDefault()
    const loginId = _.isEmpty(login) ? -1 : login.userid
    let body = {...buf, "action": (+mode + 1), "loginid": loginId}
    if (+mode === LoginConstants.K_REGISTER) 
      body = {...body, "image": null, "roleid": LoginConstants.K_REGULAR_USER}
    loginHandler(body)
  }

  const handleChange = (e) => {
    const temp = {...buf, [e.target.name]: e.target.value}
    setBuf(temp)
  }
  
  const handleOption = (opt) => {
    setBuf(LoginConstants.K_CLEAR_FIELDS)
    setMode(opt)
  }

  const getFooterOptions = () => {
    if (mode === LoginConstants.K_LOGIN) 
      return (
        <>
          <small>ยังไม่มีผู้ใช้? <a onClick={e=>handleOption(LoginConstants.K_REGISTER)}>สมัครผู้ใช้</a></small>
          <small> หรือ <a onClick={e=>handleOption(LoginConstants.K_RESET_PASSWORD)}>เปลี่ยนรหัสผ่าน</a></small>
        </>
      )
    else if (mode === LoginConstants.K_REGISTER || mode === LoginConstants.K_RESET_PASSWORD) 
      return (<small>มีผู้ใช้แล้ว? <a onClick={e=>handleOption(LoginConstants.K_LOGIN)}>เข้าสู่ระบบ</a></small>)
  }

  return ( 
    <>
     <Popup open={open} setOpen={setOpen} initialPos={initialPos}>
       <div style={{width}}>
         <div style={{ display: 'flex' }}>
           <Typography variant="h6" component="div" className={classes.dialogHeader}>
             {LoginConstants.K_HEADERS[mode]}
           </Typography>
         </div>  

         <div className="mt-3">
         <form> 
           <table width="80%">
             <tbody>
             {
                LoginConstants.K_FIELDS_OPTIONS[mode].map((elem, index) => {
                  let fieldValue = _.isEmpty(buf) ? "" : buf[elem.fieldName]
                  return (
                    <tr key={"R" + index}>
                      <td key={"C" + index} width={elem.labelWidth} align={elem.align}> 
                        <label htmlFor={elem.fieldName} style={{...commonStyles.inputLabel}}>{elem.label}</label>
                      </td>
                      <td width={elem.inputWidth} >
                        <input type="text" 
                          autoComplete="off"
                          key={'input' + index}
                          style={{width: '100%'}}
                          defaultValue={ _.isEmpty(buf) ? "" : fieldValue}
                          onChange={(e) => handleChange(e)}
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
                 <button onClick={e => onOk(e)} disabled={false} name="submit" className={classes.pillButton} style={{width: '60%'}}>{LoginConstants.K_HEADERS[mode]}</button>                 
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

      <AlertDlg 
       width={'300px'}
       open={openAlert}
       setOpen={setOpenAlert}
       initialPos={{x: 50, y: -200}}  
       title="Alert"
       message={message}
       />      


    </>
  );
}

export default LoginDlg


/*

import AlertDlg from '../../components/AlertDlg';

      <small>Need an account? <a onClick={e=>handleOption(1)}>Register here</a></small>

Login templates

https://enlear.academy/31-example-login-form-for-website-42abc6f6d525
https://freshdesignweb.com/css-login-form-templates/
https://www.begindot.com/free-css3-html5-login-form-templates/


     <AlertDlg 
       width={'300px'}
       open={openAlert}
       setOpen={setOpenAlert}
       initialPos={{x: 50, y: -200}}  
       title="Alert"
       message={message}
       />


*/