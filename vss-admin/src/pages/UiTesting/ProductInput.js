import React, { useState } from 'react';

const ProductInput = (props) => {
  const { item, setOpen, actionHandler } = props
  const [image, setImage] = useState()
  const categories = [
    {categoryid: 1, categoryname: 'Macaron'},
    {categoryid: 2, categoryname: 'Cake'},
    {categoryid: 3, categoryname: 'Tea'},
  ]

  const onImageChange = (event) => {
    console.log(event)
    if (event.target.files && event.target.files[0]) {
      setImage(URL.createObjectURL(event.target.files[0]));
    }    
  }

  const okClicked = () => {
    actionHandler(true)
    setOpen(false)
  }

  const cancelClicked = () => {
    actionHandler(false)
    setOpen(false)
  }

  return (
    <div style={{width:'500px'}} className="separator">
    <form>
      <input type="hidden" id="action" name="action"/>
      <input type="hidden" id="svimage" name="svimage"/>
      <input type="hidden" id="pid" name="pid"/>
      <input type="hidden" id="categoryname" name="categoryname"/>
      <input type="hidden" id="categoryid" name="categoryid"/>

      <div className="row">
        <div className="col-3"><label htmlFor="title" className="col-form-label">Title:</label></div>
        <div className="col"><input type="text" style={{height:'30px'}} required className="form-control" name="title" id="title"/></div>
      </div>

      <div className="row">
        <div className="col-3"><label htmlFor="catgid" className="col-form-label">Category:</label></div>
        <div className="col">
          <select className="seloptionbackground" id="catgid" name="catgid" className="col selectpicker" style={{height:'30px', width:'100%'}}>
            {categories.map ((item, index) => <option key={index} value={item.categoryid}>{item.categoryname}</option>)}
          </select>
        </div>
      </div>          

      <div className="row">
        <div className="col-3"><label htmlFor="unit" className="col-form-label">Unit:</label></div>
        <div className="col"><input type="text" style={{height:'30px'}} required className="form-control" name="unit" id="unit"/></div>
      </div>

      <div className="row">
        <div className="col-3"><label htmlFor="description" className="col-form-label">Description:</label></div>
        <div className="col">
          <textarea className="form-control" id="description" name="description"
                        style={{height: '6em', marginBottom: '7px', padding: '1px'}}>
          </textarea>              
        </div>
      </div>

      <div className="row">
        <div className="col-3"><label htmlFor="price" className="col-form-label">Price:</label></div>
        <div className="col"><input type="text" style={{height: '30px'}} required className="form-control" name="price" id="price"/></div>
      </div>          

      <div className="row">
        <div className="col-3"><label htmlFor="imgInput" className="col-form-label">Image:</label></div>
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
        <button type="button" onClick={okClicked} name="submit" className="btn btn-primary">Submit</button>
        <button type="button" onClick={cancelClicked} className="ml-2 btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
       
    </form>    
    </div>
  );
}

export default ProductInput
