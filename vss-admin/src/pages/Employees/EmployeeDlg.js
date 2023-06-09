import React, {useState, useEffect } from 'react'
import _ from 'lodash'
import { Typography } from '@material-ui/core';
import Grid from '@material-ui/core/Grid';
import Util from '../../util/Util';
import AppStyles from '../../theme/AppStyles'
import Popup from '../../components/Popup'
import AppConfig from '../../config/AppConfig'
import { images } from '../../util/Images'
import { commonStyles } from '../../theme/CommonStyles';
import OutlinedDiv from '../../components/Controls/OutlinedDiv'


const fields = [
  { label: 'ชื่อ :',      fieldName: 'name',     align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'ประเภท :',  fieldName: 'employeetypeid', align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'เลขบัญชีธนาคาร :',    fieldName: 'accountid',    align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'เลขบัตรประชาชน :', fieldName: 'identificationcardid',   align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'วันเกิด :', fieldName: 'birthdate',   align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'วันเริ่มงาน :', fieldName: 'joindate',   align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'เงินเดือน :', fieldName: 'salary',   align: 'right', labelWidth: '30%', inputWidth: '70%' },
  { label: 'ค่าตำแหน่ง :', fieldName: 'positionsalary',   align: 'right', labelWidth: '30%', inputWidth: '70%' }
]

const titles = [
  {id: 1, title: 'นาย'},
  {id: 2, title: 'นาง'},
  {id: 3, title: 'น.ส.'},
]

const employeeTypes = [
  {id: 1, title: 'ครูบรรจุ'},
  {id: 2, title: 'ลูกจ้าง'}
]


const EmployeeDlg = (props) => {
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
             {Util.capitalize(mode)} User
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
           <div style={{flexGrow: 1}}>

           <OutlinedDiv label="Employee" width="100%">

            <Grid container spacing={2}>
              <Grid item xs={2}>
              <label>วันเกิด</label>
              <select id="roleid" 
                placeholder="Title"
                value={_.isEmpty(buf) ? "" : +buf.roleid}
                disabled={readOnly === true}
                onChange={handleChange} 
                name="roleid" 
                className={`col selectpicker `} >                
                  {titles.map ((item, index) => 
                    <option  key={index} value={item.id}>{item.title}</option>)}
                </select> 
              </Grid>
              <Grid item xs={5}>
              <label>ชื่อ</label>
              <input type="text" 
                           style={{width: '100%'}}
                           placeholder="ชื่อ"
                           autoCapitalize={false} 
                           required                      
                           name="fname"
                           id="fname"/>                         
              </Grid>
              <Grid item xs={5}>
              <label>นามสกุล</label>
              <input type="text" 
                           style={{width: '100%'}}
                           placeholder="นามสกุล"
                           autoCapitalize={false} 
                           required                      
                           name="fname"
                           id="fname"/>
              </Grid>
              <Grid item xs={6}>
              <label>เลขบัญชีธนาคาร</label>
              <input type="text" 
                           style={{width: '100%'}}
                           placeholder="เลขบัญชีธนาคาร"
                           autoCapitalize={false} 
                           required                      
                           name="fname"
                           id="fname"/>
              </Grid>
              <Grid item xs={6}>
              <label>เลขบัตรประชาชน</label>
              <input type="text" 
                           style={{width: '100%'}}
                           placeholder="เลขบัตรประชาชน"
                           autoCapitalize={false} 
                           required                      
                           name="fname"
                           id="fname"/>
              </Grid>

              <Grid item xs={6}>
              <label>วันเกิด</label>
              <input type="date" 
                           style={{width: '100%'}}
                           placeholder="วันเกิด"
                           autoCapitalize={false} 
                           required                      
                           name="fname"
                           id="fname"/>
              </Grid>
              <Grid item xs={6}>
              <label>วันเริ่มงาน</label>
              <input type="date" 
                           style={{width: '100%'}}
                           placeholder="วันเริ่มงาน"
                           autoCapitalize={false} 
                           required                      
                           name="fname"
                           id="fname"/>
                          
              </Grid>

              <Grid item xs={4}>
              <select id="roleid" 
                placeholder="Title"
                value={_.isEmpty(buf) ? "" : +buf.roleid}
                disabled={readOnly === true}
                onChange={handleChange} 
                name="roleid" 
                className={`col selectpicker `} >                
                  {employeeTypes.map ((item, index) => 
                    <option  key={index} value={item.id}>{item.title}</option>)}
                </select> 

              </Grid>

              <Grid item xs={4}>
              <input type="number" 
                           style={{width: '100%', textAlign: 'right'}}
                           placeholder="เงินเดือน"
                           autoCapitalize={false} 
                           required                      
                           name="fname"
                           id="fname"/>
              </Grid>
              <Grid item xs={4}>
              <input type="number" 
                           style={{width: '100%', textAlign: 'right'}}
                           placeholder="ค่าตำแหน่ง"
                           autoCapitalize={false} 
                           required                      
                           name="fname"
                           id="fname"/>
              </Grid>
              </Grid>
              </OutlinedDiv>  
               
              <div className="mt-3">
                <OutlinedDiv label="Address" width="100%">

                <Grid container spacing={3}>
              <Grid item xs={3}>
                 Title
              </Grid>
              <Grid item xs={3}>
                 First Name
              </Grid>
              <Grid item xs={3}>
                 Last Name
              </Grid>
              <Grid item xs={3}>
                 EmpType
              </Grid>
              <Grid item xs={6}>
                   Bank account
              </Grid>
              <Grid item xs={6}>
                  Id card
              </Grid>

              <Grid item xs={6}>
                  Birth date
              </Grid>
              <Grid item xs={6}>
                  Employment start date
              </Grid>

              <Grid item xs={6}>
                  Salary
              </Grid>
              <Grid item xs={6}>
                  Base salary
              </Grid>
              </Grid>

                </OutlinedDiv>
              </div>


    </div>
           <div className={`mt-3 mb-3 ${classes.rightButtonPanel}`}>
             <button onClick={e => onCancel(e)} name="cancel" className={`mr-2 ${classes.pillButtonPale}`} style={{width: '100px'}}>Close</button>
             <button onClick={e => onOk(e)} name="submit" className={classes.pillButton} style={{width: '100px'}}>Save</button>
           </div>
       
         </form>    
       </div>
     </Popup>
  )  
}

export default EmployeeDlg


/*

                  {roles.map ((item, index) => 
                    <option className={classes.inputText} key={index} value={item.id}>{item.title}</option>)}

                    */

/*

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

              </select>
            </div>
           </div>             

           <div className={`mt-3 mb-3 ${classes.rightButtonPanel}`}>
             <button onClick={e => onCancel(e)} name="cancel" className={`mr-2 ${classes.pillButtonPale}`} style={{width: '100px'}}>Close</button>
             <button onClick={e => onOk(e)} name="submit" className={classes.pillButton} style={{width: '100px'}}>Save</button>
           </div>
       
         </form>    
*/