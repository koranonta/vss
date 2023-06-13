import React, {useState, useEffect, useRef } from 'react'
import _ from 'lodash'
import { Typography } from '@material-ui/core';
import Grid from '@material-ui/core/Grid';
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

const EmployeeDlg = (props) => {
  const {item, employeeTypes, genderTypes, mode, open, setOpen, width, actionHandler } = props
  const [image, setImage] = useState()  
  const [buf, setBuf] = useAsyncState(item)
  const [readOnly, setReadOnly] = useState()
  const formRef = useRef()

  const classes = AppStyles()
  

  const loadItem = async () => {
    const curBuf = await setBuf(item)
  }

  useEffect(() => {  

    setReadOnly (mode === 'delete')    
    setBuf({})
    if (mode === 'add') {      
      setImage("")
    }
    else if (!_.isEmpty(item)) {
      //const temp = {...item}
      //console.log(temp)
      //setBuf(temp)
      loadItem()
      if (!_.isEmpty(item.image)) 
        setImage(AppConfig.K_AVATAR_DIR + `${item.image}`)
      console.log(buf)
    }
  },[item, mode])

  const onOk = (e) => {
    e.preventDefault()
    actionHandler(mode, buf)
    formRef.current.reset();
    setOpen(false)
  }
  
  const onCancel = (e) => {  
    e.preventDefault()
    formRef.current.reset();
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

         <form ref={formRef}>           
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
                           name="fname"
                           id="fname"/>                         
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
                           name="lname"
                           id="lname"/>
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
                           name="cardid"
                           id="cardid"/>
              </Grid>

              <Grid item xs={6}>
              <label>วันเกิด</label>
              <input type="date" 
                           style={{width: '100%'}}
                           placeholder="วันเกิด"
                           value={_.isEmpty(buf) ? "" : buf.birthdate }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="bdate"
                           id="bdate"/>
              </Grid>
              <Grid item xs={6}>
              <label>วันเริ่มงาน</label>
              <input type="date" 
                           style={{width: '100%'}}
                           placeholder="วันเริ่มงาน"
                           value={_.isEmpty(buf) ? "" : buf.joindate }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="jdate"
                           id="jdate"/>
                          
              </Grid>

              <Grid item xs={4}>
              <label>ประเภท</label>
              <br/>
              <select id="emptypeid" 
                placeholder="Title"
                value={_.isEmpty(buf) ? "" : +buf.employeetypeid}
                disabled={readOnly === true}
                onChange={handleChange} 
                name="emptypeid" 
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
                           autoCapitalize={false} 
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
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="fname"
                           id="fname"/>                 
                      </Grid>

                      <Grid item xs={12}>
                        <label>ถนน</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.street }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="fname"
                           id="fname"/> 
                      </Grid>      

                      <Grid item xs={4}>
                        <label>หมู่</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.subdistrict }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           name="fname"
                           id="fname"/> 
                      </Grid>                        


                      <Grid item xs={4}>
                        <label>ตำบล</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.district }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           name="fname"
                           id="fname"/> 
                      </Grid>                    


                      <Grid item xs={4}>
                        <label>อำเภอ</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.province }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           name="fname"
                           id="fname"/> 
                      </Grid>                      

                      <Grid item xs={4}>
                        <label>จังหวัด</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.city }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="fname"
                           id="fname"/> 
                      </Grid>

                      <Grid item xs={4}>
                        <label>ประเทศ</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.country }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="fname"
                           id="fname"/> 
                      </Grid>
                      <Grid item xs={4}>
                        <label>รหัสไปรษรีย์</label>
                        <input type="text" 
                           style={{width: '100%'}}
                           value={_.isEmpty(buf) ? "" : buf.postcode }
                           autoCapitalize={false} 
                           onChange={handleChange} 
                           required                      
                           name="fname"
                           id="fname"/> 
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


       


               




              </Grid>

                </OutlinedDiv>
              </div>

*/