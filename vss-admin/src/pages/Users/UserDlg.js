import React, {useState, useEffect } from 'react'
import _ from 'lodash'
import { Typography } from '@material-ui/core';
import Util from '../../util/Util';
import AppStyles from '../../theme/AppStyles'
import Popup from '../../components/Popup'
import AppConfig from '../../config/AppConfig'
import { images } from '../../util/Images'
import { commonStyles } from '../../theme/CommonStyles';

const fields = [
  { label: 'ชื่อ :',      fieldName: 'name',     align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'รหัสผ่าน :',  fieldName: 'password', type:'password', align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'อีเมล :',    fieldName: 'email',    align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'เบอร์โทร :', fieldName: 'phone',   align: 'right', labelWidth: '30%', inputWidth: '70%' }
]

const UserDlg = (props) => {
  const {item, roles, mode, open, setOpen, width, actionHandler } = props
  const [image, setImage] = useState()  
  const [buf, setBuf] = useState(item)
  const [readOnly, setReadOnly] = useState()

  const classes = AppStyles()

  useEffect(() => {
    setReadOnly (mode === 'delete')
    if (mode === 'add') {
      setBuf({})
      setImage("")
    }
    else if (!_.isEmpty(item)) {
      setBuf(item)
      if (!_.isEmpty(item.image)) 
        setImage(AppConfig.K_AVATAR_DIR + `${item.image}`)
    }
  },[item, mode])

  const onOk = (e) => {
    e.preventDefault()
    actionHandler(mode, buf)
    setOpen(false)
  }
  
  const onCancel = (e) => {  
    e.preventDefault()
    setOpen(false)  
  }  

  const onImageChange = (event) => {
    if (event.target.files && event.target.files[0]) {
      const imageUrl = URL.createObjectURL(event.target.files[0])
      setImage(imageUrl);
      setBuf({...buf, "imageUrl": event.target.files[0]})
    }    
  }  

  const handleChange = (e) => {
    const temp = {...buf, [e.target.name]: e.target.value}
    setBuf(temp)
  }

  if (_.isEmpty(fields)) return ""

  return (
     <Popup open={open} setOpen={setOpen}>
       <div style={{width}}>
         <div style={{ display: 'flex' }}>
           <Typography variant="h6" component="div" className={classes.orderDetailHeader}>
             {Util.toThaiMode(mode)}ผู้ใช้
           </Typography>
           <div>
            <label htmlFor="upload-button">
              <img src={_.isEmpty(image) ? images.userImage : image} 
                   style={{cursor: 'pointer', 
                   borderRadius: '3rem',
                   width: '110px',
                   }}/>
              <img src={images.editPhoto} 
                   style={{cursor: 'pointer', 
                   borderRadius: '1rem',
                   width: '25px',
                   position: 'absolute',
                   top: '44px',
                   right: '27px',
                   }}/>
            </label>
            <input type="file"
                   id="upload-button"
                   style={{ display: "none" }}
                   disabled={readOnly}
                   onChange={onImageChange}/>
          </div>
        </div>       

         <form>           
           <table width="80%">
             <tbody>
               {
                  fields.map((elem, index) => {
                    let fieldValue = _.isEmpty(buf) ? "" : buf[elem.fieldName]
                    return (
                    <tr key={index}>
                      <td width={elem.labelWidth} 
                          align={elem.align}> 
                          <label htmlFor={elem.fieldName} style={{...commonStyles.inputLabel}}>{elem.label}</label>
                      </td>
                      <td width={elem.inputWidth} >
                        <input type={_.isEmpty(elem.type) ? "text" : elem.type} 
                           style={{width: '100%'}}
                           value={ _.isEmpty(buf) ? "" : fieldValue}
                           disabled={readOnly}
                           onChange={handleChange}
                           autoCapitalize={false} 
                           required                      
                           name={elem.fieldName}
                           id={elem.fieldName}/>                         
                        </td>
  
                    </tr> 
                    )
                  }
                  )
                }
               <tr key="10">
                 <td align='right'><label htmlFor="roleid" style={{...commonStyles.inputLabel}}>บทบาท :</label></td>
                 <td>
                 <select id="roleid" 
                value={_.isEmpty(buf) ? "" : +buf.roleid}
                disabled={readOnly === true}
                onChange={handleChange} 
                name="roleid" 
                className={`col selectpicker `} >                
                  {roles.map ((item, index) => 
                    <option  key={index} value={item.id}>{item.title}</option>)}
                </select>               
                 </td>
               </tr>                  

             </tbody>
           </table>

           <div className={`mt-3 mb-3 ${classes.rightButtonPanel}`}>
             <button onClick={e => onOk(e)} disabled={false} name="submit" className={classes.pillButton} style={{width: '100px'}}>Save</button>
             <button onClick={e => onCancel(e)} name="cancel" className={`mr-2 ${classes.pillButton}`} style={{width: '100px'}}>Cancel</button>

           </div>
       
         </form>    
       </div>
     </Popup>
  )  
}

export default UserDlg


/*

         <form>           
           <table width="80%">
             <tbody>
               <tr key="1">
                 <td width="20%" align="right"><label htmlFor="name" style={{...commonStyles.inputLabel}}>ชื่อ</label></td>
                 <td width="70%">
                   <input type="text" 
                     style={{width: '100%'}}
                     value={ _.isEmpty(buf) ? "" : buf.name}
                     disabled={readOnly}
                     onChange={handleChange} 
                     required 
                     
                     name="name"
                     id="name"/>                   
                 </td>
               </tr>

               <tr key="2">
                 <td><label htmlFor="password" style={{...commonStyles.inputLabel}}>รหัสผ่าน</label></td>
                 <td>
                 <input type="text" 
                 value={ _.isEmpty(buf) ? "" : buf.password}
                 disabled={readOnly}
                 onChange={handleChange} 
                 required 
                  
                 name="password"
                 id="password"/>           
                 </td>
               </tr>

               <tr key="3">
                 <td><label htmlFor="email" style={{...commonStyles.inputLabel}}>อีเมล</label></td>
                 <td>
                 <input type="text" 
                 value={ _.isEmpty(buf) ? "" : buf.email}
                 disabled={readOnly}
                 onChange={handleChange} 
                 required 
                 
                 name="email"
                 id="email"/>                 
                 </td>
               </tr>

               <tr key="4">
                 <td><label htmlFor="phone" style={{...commonStyles.inputLabel}}>เบอร์โทร</label></td>
                 <td>
                 <input type="text" 
                value={_.isEmpty(buf) ? "" : buf.phone}
                disabled={readOnly}
                onChange={handleChange} 
                required 
               
                name="phone" 
                id="phone"/>                
                 </td>
               </tr>                    

               <tr key="4">
                 <td><label htmlFor="roleid" style={{...commonStyles.inputLabel}}>บทบาท</label></td>
                 <td>
                 <select id="roleid" 
                value={_.isEmpty(buf) ? "" : +buf.roleid}
                disabled={readOnly === true}
                onChange={handleChange} 
                name="roleid" 
                className={`col selectpicker `} >                
                  {roles.map ((item, index) => 
                    <option  key={index} value={item.id}>{item.title}</option>)}
              </select>               
                 </td>
               </tr>                  

             </tbody>
           </table>






           <div className={`mt-3 mb-3 ${classes.rightButtonPanel}`}>
             <button onClick={e => onOk(e)} name="submit" className={classes.pillButton} style={{width: '100px'}}>Save</button>
             <button onClick={e => onCancel(e)} name="cancel" className={`mr-2 ${classes.pillButtonPale}`} style={{width: '100px'}}>Cancel</button>

           </div>
       
         </form>    
*/