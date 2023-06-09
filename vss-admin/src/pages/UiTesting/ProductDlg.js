import React, {useState } from 'react'
import _ from 'lodash'

import Util from '../../util/Util';
import AppStyles from '../../theme/AppStyles';
import Popup from '../../components/Popup'

const ProductDlg = (props) => {
  const {item, categories, mode, open, setOpen, width, actionHandler } = props
  const [image, setImage] = useState()  
  const [buf, setBuf] = useState({...item})

  const dlgWidth = _.isNull(width) ? '500px' : width

  const classes = AppStyles()

  const onOk = () => {
    actionHandler(buf)
    setOpen(false)
  }

  const onCancel = () => {  setOpen(false)  }  

  const onImageChange = (event) => {
    if (event.target.files && event.target.files[0]) {
      const imageUrl = URL.createObjectURL(event.target.files[0])
      setImage(imageUrl);
      setBuf({...buf, "image": imageUrl})
    }    
  }  

  const handleChange = (e) => {
    const temp = {...buf, [e.target.name]: e.target.value}
    setBuf(temp)
  }

  return (
     <Popup title={`${Util.capitalize(mode)} product`} open={open} setOpen={setOpen}>
       <div style={{width: `500px`}} className="separator">
         <form>
           <div className="row">
            <div className="col-3">
              <label htmlFor="title" className="col-form-label">Title:</label>
            </div>
            <div className="col">
              <input type="text" 
                 value={buf.title}
                 onChange={handleChange} 
                 style={{height:'30px'}} 
                 required 
                 className={`form-control ${classes.textHeight}`} 
                 name="title" 
                 id="title"/>
            </div>
           </div>

           <div className="row">
             <div className="col-3">
               <label htmlFor="categoryid" className="col-form-label">Category:</label>
            </div>
            <div className="col">
              <select id="categoryid" 
                value={buf.categoryid}
                onChange={handleChange} 
                name="categoryid" 
                className={`col selectpicker ${classes.selectOption}`} >
                  {categories.map ((item, index) => 
                    <option key={index} value={item.categoryid}>{item.categoryname}</option>)}
              </select>
            </div>
           </div>          


           <div className="row">
             <div className="col-3">
               <label htmlFor="description" className="col-form-label">Description:</label>
             </div>
             <div className="col">
               <textarea  
                 value={buf.description}
                 onChange={handleChange} className="form-control pl-2" id="description" name="description"
                        style={{height: '6em', marginBottom: '7px', padding: '1px'}}>
               </textarea>              
             </div>
           </div>

           <div className="row">
             <div className="col-3">
               <label htmlFor="unit" className="col-form-label">Unit:</label>
             </div>
             <div className="col">
              <input type="text" 
                value={buf.unit}
                onChange={handleChange} 
                style={{height:'30px', width: '50%'}} 
                required 
                className="form-control" 
                name="unit" 
                id="unit"/>
            </div>
           </div>


           <div className="row">
             <div className="col-3">
               <label htmlFor="price" className="col-form-label">Price:</label>
             </div>
             <div className="col">
               <input type="number" 
                 value={buf.price}
                 className={classes.inputNumber}
                 onChange={handleChange} style={{height: '30px', width: '50%', textAlign: 'right'}} required className="form-control" name="price" id="price"/>
             </div>
           </div>          

           <div className="row">
             <div className="col-3">
               <label htmlFor="imgInput" className="col-form-label">Image:</label>
             </div>
             <div className="col">
               <input type="file" onChange={onImageChange} className="form-control" id="imgInput" name="imgInput" placeholder="Image"/>
             </div>
           </div>

           <div className="row mt-3">
             <div className="d-flex justify-content-center">
               <img id="previewImg" width="50%" alt="" src={image}/>
             </div>
           </div>

           <div className="modal-footer mt-3">
             <button type="button" onClick={onOk} name="submit" className="btn btn-primary">Submit</button>
             <button type="button" onClick={onCancel} className="ml-2 btn btn-secondary" data-bs-dismiss="modal">Close</button>
           </div>
       
         </form>    
       </div>
     </Popup>
  )  
}

export default ProductDlg
