import React, { useState } from 'react';

const UserInput = (props) => {
  const { handleOkBtn, handleCancelBtn } = props
  const [image, setImage] = useState()
  const roles = [
    {roleid: 1, rolename: 'Customer'},
    {roleid: 2, rolename: 'Super user'},
    {roleid: 3, rolename: 'Admin'},
  ]

  const onImageChange = (event) => {
    console.log(event)
    if (event.target.files && event.target.files[0]) {
      setImage(URL.createObjectURL(event.target.files[0]));
    }    
  }

  const okClicked = () => {
    handleOkBtn()
  }

  const cancelClicked = () => {
    handleCancelBtn()
  }

  return (
    <div style={{width:'500px'}} className="separator">
    <form>

      <div className="row">
        <div className="col-3"><label htmlFor="name" className="col-form-label">Name:</label></div>
        <div className="col"><input type="text" style={{height:'30px'}} required className="form-control" name="name" id="name"/></div>
      </div>

      <div className="row">
        <div className="col-3"><label htmlFor="email" className="col-form-label">Email:</label></div>
        <div className="col"><input type="text" style={{height:'30px'}} required className="form-control" name="email" id="email"/></div>
      </div>

      <div className="row">
        <div className="col-3"><label htmlFor="phone" className="col-form-label">Phone:</label></div>
        <div className="col"><input type="text" style={{height:'30px'}} required className="form-control" name="phone" id="phone"/></div>
      </div>

      <div className="row">
        <div className="col-3"><label htmlFor="password" className="col-form-label">Password:</label></div>
        <div className="col"><input type="text" style={{height:'30px'}} required className="form-control" name="password" id="password"/></div>
      </div>

      <div className="row">
        <div className="col-3"><label htmlFor="roleid" className="col-form-label">Role:</label></div>
        <div className="col">
          <select className="seloptionbackground" id="roleid" name="roleid" className="col selectpicker" style={{height:'30px', width:'100%'}}>
            {roles.map ((item, index) => <option key={index} value={item.roleid}>{item.rolename}</option>)}
          </select>
        </div>
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

export default UserInput
