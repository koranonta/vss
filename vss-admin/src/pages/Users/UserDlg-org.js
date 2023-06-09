import React, {useState, useEffect } from 'react'
import _ from 'lodash'
import { Typography } from '@material-ui/core';
import Util from '../../util/Util';
import AppStyles from '../../theme/AppStyles'
import Popup from '../../components/Popup'
import AppConfig from '../../config/AppConfig'
import { images } from '../../util/Images'
import { commonStyles } from '../../theme/CommonStyles';

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

  return (
     <Popup open={open} setOpen={setOpen}>
       <div style={{width}}>
         <div style={{ display: 'flex' }}>
           <Typography variant="h6" component="div" className={classes.orderDetailHeader}>
             {Util.capitalize(mode)} ผู้ใช้
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
           <div className={`row mt-2 ml-5 ${classes.underLine}` }>
            <div className="col-3">
              <label htmlFor="name" style={{...commonStyles.inputLabel}}>Name</label>
            </div>
            <div className="col">
              <input type="text" 
                 value={ _.isEmpty(buf) ? "" : buf.name}
                 disabled={readOnly}
                 onChange={handleChange} 
                 required 
                 className={`form-control ${classes.inputText}`} 
                 name="name"
                 id="name"/>
            </div>
           </div>

           <div className={`row mt-3 ml-5 ${classes.underLine}`}>
            <div className="col-3">
              <label htmlFor="password" style={{...commonStyles.inputLabel}}>Password</label>
            </div>
            <div className="col">
              <input type="text" 
                 value={ _.isEmpty(buf) ? "" : buf.password}
                 disabled={readOnly}
                 onChange={handleChange} 
                 required 
                 className={`form-control ${classes.inputText}`} 
                 name="password"
                 id="password"/>
            </div>
           </div>

           <div className={`row mt-3 ml-5 ${classes.underLine}`}>
             <div className="col-3">
               <label htmlFor="email" style={{...commonStyles.inputLabel}}>Email</label>
             </div>
             <div className="col">
               <input type="text" 
                 value={ _.isEmpty(buf) ? "" : buf.email}
                 disabled={readOnly}
                 onChange={handleChange} 
                 required 
                 className={`form-control ${classes.inputText}`} 
                 name="email"
                 id="email"/>
             </div>
           </div>

           <div className={`row mt-3 ml-5 ${classes.underLine}`}>
             <div className="col-3">
               <label htmlFor="phone" style={{...commonStyles.inputLabel}}>Phone</label>
             </div>
             <div className="col">
              <input type="text" 
                value={_.isEmpty(buf) ? "" : buf.phone}
                disabled={readOnly}
                onChange={handleChange} 
                required 
                className={`form-control ${classes.inputText}`} 
                name="phone" 
                id="phone"/>
            </div>
           </div>

           <div className={`row mt-3 ml-5 ${classes.underLine}`}>
             <div className="col-3">
               <label htmlFor="roleid" style={{...commonStyles.inputLabel}}>Role</label>
            </div>
            <div className="col">
              <select id="roleid" 
                value={_.isEmpty(buf) ? "" : +buf.roleid}
                disabled={readOnly === true}
                onChange={handleChange} 
                name="roleid" 
                className={`col selectpicker ${classes.selectOption} ${classes.inputText}`} >                
                  {roles.map ((item, index) => 
                    <option className={classes.inputText} key={index} value={item.id}>{item.title}</option>)}
              </select>
            </div>
           </div>             

           <div className={`mt-3 mb-3 ${classes.rightButtonPanel}`}>
             <button onClick={e => onOk(e)} name="submit" className={classes.pillButton} style={{width: '100px'}}>Save</button>
             <button onClick={e => onCancel(e)} name="cancel" className={`mr-2 ${classes.pillButtonPale}`} style={{width: '100px'}}>Cancel</button>

           </div>
       
         </form>    
       </div>
     </Popup>
  )  
}

export default UserDlg
