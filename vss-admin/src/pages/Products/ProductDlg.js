import React, {useState, useEffect } from 'react'
import _ from 'lodash'
import { Typography } from '@material-ui/core';
import Util from '../../util/Util';
import AppStyles from '../../theme/AppStyles';
import Popup from '../../components/Popup'
import AppConfig from '../../config/AppConfig';
import { images } from '../../util/Images'
import { commonStyles } from '../../theme/CommonStyles';
const ProductDlg = (props) => {
  const {item, categories, mode, open, setOpen, width, actionHandler } = props
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
        setImage(AppConfig.K_IMAGE_DIR + `${item.image}`)
    }
  },[item, mode])

  const onOk = (e) => {
    e.preventDefault()
    actionHandler(mode, {...buf, image: item.image})
    setOpen(false)
  }
  
  const onCancel = (e) => {  
    e.preventDefault()
    setOpen(false)  
  }  

  const onImageChange = (event) => {
    if (event.target.files && event.target.files[0]) {
      // for display
      const imageUrl = URL.createObjectURL(event.target.files[0])
      setImage(imageUrl);
      setBuf({...buf, "imageUrl" : event.target.files[0]})
    }    
  }  

  const handleChange = (e) => {
    const temp = {...buf, [e.target.name]: e.target.value}
    setBuf(temp)
  }

  return (
     <Popup open={open} setOpen={setOpen}>
       <div style={{width}}>
         {/*  Header */}
         <div style={{ display: 'flex' }}>
            <Typography variant="h6" component="div" className={classes.orderDetailHeader}>
              {Util.capitalize(mode)} Product
            </Typography>
            <div>
              <label htmlFor="upload-button">
                <img src={_.isEmpty(image) ? images.productImage : image} 
                     style={{cursor: 'pointer',                      
                     width: '100px',}}/>
              <img src={images.editPhoto} 
                   style={{cursor: 'pointer', 
                   borderRadius: '1rem',
                   width: '25px',
                   position: 'absolute',
                   top: '47px',
                   right: '8px',
                   }}/>

              </label>
              <input type="file"
                   id="upload-button"
                   style={{ display: "none" }}
                   disabled={readOnly}
                   onChange={onImageChange}
              />            
            </div>
         </div>   
          
          <form>
           {/*  Input title */}
           <div className={`row mt-2 ml-5 ${classes.underLine}` }>
             <div className={`col-2`} >          
                <label htmlFor="title" style={{...commonStyles.inputLabel}}>Title</label>
             </div>
             <div className="col-10">          
              <input type="text" 
                 value={ _.isEmpty(buf) ? "" : buf.title}
                 disabled={readOnly}
                 onChange={handleChange} 
                 required 
                 className={`form-control ${classes.inputText}`} 
                 name="title" 
                 id="title"/>
             </div>
           </div>

           {/*  Input category */}
           <div className={`row mt-3 ml-5 ${classes.underLine}`}>
            <div className="col-2">            
              <label htmlFor="categoryid" style={{...commonStyles.inputLabel}}>Category</label>              
            </div>
            <div className="col-10">               
              <select id="categoryid" 
                value={_.isEmpty(buf) ? -1 : buf.categoryid}
                disabled={readOnly}
                onChange={handleChange} 
                name="categoryid"
                className={`col selectpicker ${classes.selectOption} ${classes.inputText}`} >
                  {categories.map ((item, index) => 
                    <option className={classes.inputText} key={index} value={item.id}>{item.title}</option>)}
              </select>
              </div>
            </div>
           
           {/*  Input unit */}
           <div className={`row mt-3 ml-5 ${classes.underLine}`}>
             <div className="col-2">
               <label htmlFor="unit" style={{...commonStyles.inputLabel}}>Unit</label>              
             </div>
             <div className="col-10">
               <input type="text" 
                 value={_.isEmpty(buf) ? "" : buf.unit}
                 disabled={readOnly}
                 onChange={handleChange} 
                 required 
                 className={`form-control ${classes.inputText}`} 
                 name="unit" 
                 id="unit"/>
             </div>
           </div>

           {/*  Input price */}
           <div className={`row mt-3 ml-5 ${classes.underLine}`}>
             <div className="col-2">             
               <label htmlFor="price" style={{...commonStyles.inputLabel}}>Price</label>   
             </div>
             <div className="col-10">
               <input type="number" 
                 value={_.isEmpty(buf) ? "" : buf.price}
                 disabled={readOnly}
                 className={`form-control ${classes.inputText}`}
                 onChange={handleChange} 
                 required 
                 name="price" 
                 id="price"/>
              </div>
           </div>

           <div className="row mt-4 ml-5">
             <div className="col-2">
               <label htmlFor="description" className={classes.heroLight}>Description</label>
             </div>
             <div className="col-8">
               <textarea  
                 value={_.isEmpty(buf) ? "" : buf.description}
                 disabled={readOnly}
                 onChange={handleChange} className={`form-control pl-2 ${classes.heroLight}`} id="description" name="description"
                        style={{height: '6em', marginBottom: '7px', padding: '1px'}}>
               </textarea>              
             </div>
           </div>

           <div className={classes.rightButtonPanel}>
             <button onClick={e => onCancel(e)} name="cancel" className={`mr-2 ${classes.pillButtonPale}`} style={{width: '100px'}}>Close</button>
             <button onClick={e => onOk(e)} name="submit" className={classes.pillButton} style={{width: '100px'}}>Save</button>
           </div>
       
         </form>    
       </div>
     </Popup>
  )  
}

export default ProductDlg
