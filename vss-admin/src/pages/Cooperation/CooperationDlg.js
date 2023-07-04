import React, {useState, useEffect } from 'react'
import _ from 'lodash'
import { Typography } from '@material-ui/core';
import Grid from '@material-ui/core/Grid';
import DatePicker from "react-datepicker";  
  
import "react-datepicker/dist/react-datepicker.css";  


import Util from '../../util/Util';
import AppStyles from '../../theme/AppStyles'
import Popup from '../../components/Popup'
import AppConfig from '../../config/AppConfig'
import { images } from '../../util/Images'
import OutlinedDiv from '../../components/Controls/OutlinedDiv'
import useAsyncState from '../../hooks/useAsyncState';


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

const CooperationDlg = (props) => {
  const {item, employeeTypes, genderTypes, mode, open, setOpen, width, actionHandler } = props
  const [image, setImage] = useState()  
  const [buf, setBuf] = useState({})
  const [readOnly, setReadOnly] = useState()
  const [birthdate, setBirthdate] = useState(_.isEmpty(item) ? null : item.birthdate)

  const classes = AppStyles()

  useEffect(() => {  
    setImage("")
    setReadOnly (mode === 'delete')    
    if (mode === 'add') { 
      setBuf({})
      //setBuf(item)
    }
    else if (!_.isEmpty(item)) {
      setBuf(item)
      if (!_.isEmpty(item.image)) 
        setImage(AppConfig.K_AVATAR_DIR + `${item.image}`)
    }
  },[item, mode])

  const onOk = (e) => {
    e.preventDefault()
    console.log(buf)
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

  //const handleDate = (date, fieldName) => {
  //  console.log(date, fieldName)
  //  const temp = {...buf, [fieldName]: date}
  //  setSelectedDate(date)
  //}

  return (
     <Popup open={open} setOpen={setOpen}>
       <div style={{width}}>
         <div style={{ display: 'flex' }}>
           <Typography variant="h6" component="div" className={classes.orderDetailHeader}>
             {Util.toThaiMode(mode)}พนักงาน
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
              <label>คำนำ</label>
              <select id="genderid" 
                placeholder="Title"
                value={_.isEmpty(buf) ? "" : +buf.genderid}
                disabled={readOnly === true}
                onChange={handleChange} 
                name="genderid" 
                className={`col selectpicker `} >                
                  {genderTypes.map ((item, index) => 
                    <option  key={index} value={item.id}>{item.title}</option>)}
                </select> 
              </Grid>
              <Grid item xs={5}>
              <label>ชื่อ</label>
              <input type="text" 
                           style={{width: '100%'}}
                           placeholder="ชื่อ"
                           value={_.isEmpty(buf) ? "" : buf.firstname}
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="firstname"
                           id="firstname"/>                         
              </Grid>
              <Grid item xs={5}>
              <label>นามสกุล</label>
              <input type="text" 
                           style={{width: '100%'}}
                           placeholder="นามสกุล"
                           value={_.isEmpty(buf) ? "" : buf.lastname}
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="lastname"
                           id="lastname"/>
              </Grid>
              <Grid item xs={6}>
              <label>เลขบัญชีธนาคาร</label>
              <input type="text" 
                           style={{width: '100%'}}
                           placeholder="เลขบัญชีธนาคาร"
                           value={_.isEmpty(buf) ? "" : buf.accountid }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="accountid"
                           id="accountid"/>
              </Grid>
              <Grid item xs={6}>
              <label>เลขบัตรประชาชน</label>
              <input type="text" 
                           style={{width: '100%'}}
                           placeholder="เลขบัตรประชาชน"
                           value={_.isEmpty(buf) ? "" : buf.identificationcardid }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="identificationcardid"
                           id="identificationcardid"/>
              </Grid>

              <Grid item xs={6}>
              <label>วันเกิด</label>

{/*
              <DatePicker selected={ birthdate }
            onChange={ date=>setBirthdate(date) }
            dateFormat="dd-MM-yyyy"
            placeholder="dd-MM-yyyy"
            //onChange={ date=>setSelectedDate(date)}
            //minDate={ new Date()}
            //maxDate={ new Date()}
            //filterDate={ date=>date.getDay()!=6 && date.getDay()!=0}
           // isClearable
            showYearDropdown
            name="birthdate"
            />               
*/}
              <input type="date" 
                           style={{width: '100%'}}
                           placeholder="dd-mm-yyyy"
                           value={_.isEmpty(buf) ? "" : buf.birthdate }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="birthdate"
                           id="birthdate"/>

              </Grid>
              <Grid item xs={6}>
              <label>วันเริ่มงาน</label>
              <input type="date" 
                           style={{width: '100%'}}
                           placeholder="dd-mm-yyyy"
                           value={_.isEmpty(buf) ? "" : buf.joindate }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="joindate"
                           id="joindate"/>
                          
              </Grid>

              <Grid item xs={4}>
              <label>ประเภท</label>
              <br/>
              <select id="employeetypeid" 
                placeholder="Title"
                value={_.isEmpty(buf) ? "" : +buf.employeetypeid}
                disabled={readOnly === true}
                onChange={handleChange} 
                name="employeetypeid" 
                className={`col selectpicker `} >                
                  {employeeTypes.map ((item, index) => 
                    <option  key={index} value={item.id}>{item.title}</option>)}
                </select> 

              </Grid>

              <Grid item xs={4}>
              <label>เงินเดือน</label>
              <input type="number" 
                           style={{width: '100%', textAlign: 'right'}}
                           placeholder="เงินเดือน"
                           value={_.isEmpty(buf) ? "" : +buf.salary }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="salary"
                           id="salary"/>
              </Grid>

              <Grid item xs={4}>
              <label>ค่าตำแหน่ง</label>
              <input type="number" 
                           style={{width: '100%', textAlign: 'right'}}
                           placeholder="ค่าตำแหน่ง"
                           value={_.isEmpty(buf) ? "" : +buf.positionsalary }
                           onChange={handleChange} 
                           required                      
                           name="possalary"
                           id="possalary"/>
              </Grid>
              </Grid>
              </OutlinedDiv>  

              <div className="mt-3">
                <OutlinedDiv label="ที่อยู่" width="100%">
                  <Grid container spacing={3} rowSpacing={0.5}>
                    <Grid item xs={12}>
                       <label>ที่อยู่</label>
                       <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.address }
                           onChange={handleChange} 
                           required                      
                           name="address"
                           id="address"/>                 
                      </Grid>

                      <Grid item xs={12}>
                        <label>ถนน</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.street }
                           onChange={handleChange} 
                           required                      
                           name="street"
                           id="street"/> 
                      </Grid>      

                      <Grid item xs={4}>
                        <label>หมู่</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.subdistrict }
                           onChange={handleChange} 
                           name="subdistrict"
                           id="subdistrict"/> 
                      </Grid>                        

                      <Grid item xs={4}>
                        <label>ตำบล</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.district }
                           onChange={handleChange} 
                           name="district"
                           id="district"/> 
                      </Grid>                    

                      <Grid item xs={4}>
                        <label>อำเภอ</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.province }
                           onChange={handleChange} 
                           name="province"
                           id="province"/> 
                      </Grid>                      

                      <Grid item xs={4}>
                        <label>จังหวัด</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.city }
                           onChange={handleChange} 
                           required                      
                           name="city"
                           id="city"/> 
                      </Grid>

                      <Grid item xs={4}>
                        <label>ประเทศ</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.country }
                           onChange={handleChange} 
                           required                      
                           name="country"
                           id="country"/> 
                      </Grid>
                      <Grid item xs={4}>
                        <label>รหัสไปรษณีย์</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.postcode }
                           onChange={handleChange} 
                           required                      
                           name="postcode"
                           id="postcode"/> 
                      </Grid>                      

                  </Grid>
                </OutlinedDiv>
              </div>

              
           </div>
           <div className={`mt-3 mb-3 ${classes.rightButtonPanel}`}>
             <button onClick={e => onOk(e)} name="submit" className={classes.pillButton} style={{width: '100px'}}>Save</button>
             <button onClick={e => onCancel(e)} name="cancel" className={`mr-2 ${classes.pillButton}`} style={{width: '100px'}}>Cancel</button>
           </div>
       
         </form>    
       </div>
     </Popup>
  )  
}

export default CooperationDlg

