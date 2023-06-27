import React, {useState, useEffect, useContext } from 'react'
import _ from 'lodash'
import { Typography } from '@material-ui/core';
import Popup from '../../components/Popup'
import AppStyles from '../../theme/AppStyles'

const buttonStyle = {
  width: "10rem",
  fontsize: "1.5rem",
  height: "2rem",
  padding: "5px",
  borderRadius: "10px",
  backgroundColor: "green",
  color: "White",
  border: "2px solid yellow",
};
const divStyle = {
  display: "flex",
  felxDirection: "row",
  position: "absolute",
  right: "0px",
  bottom: "5px",
  // padding: "1rem",
};
const confirmButtonStyle = {
  width: "5rem",
  height: "1.5rem",
  fontsize: "1rem",
  backgroundColor: "grey",
  color: "black",
  margin: "5px",
  borderRadius: "10px",
  border: "1px solid black",
};

const AlertDlg = (props) => {
  const { open, setOpen, width, title, message, initialPos, afterAlertAction} = props

  const classes = AppStyles()

  const handleClose = () => {
    setOpen(false)
    afterAlertAction()
  }

  return ( 
    <>
     <Popup open={open} setOpen={setOpen} initialPos={initialPos}>
       <div style={{width}}>
         <div style={{ display: 'flex' }}>
           <Typography variant="h6" component="div" className={classes.dialogHeader}>
             {title}
           </Typography>
         </div>  

         <h3 style = {{ marginTop: "-10px", padding: "5px 10px" }}>
                  {message} {" "}
          </h3>
            <br></br>
            <div style = {divStyle}>
               <button style = {confirmButtonStyle} onClick = {handleClose}>
                  Confirm
               </button>
               <button style = {confirmButtonStyle} onClick = {handleClose}>
                  Cancel
               </button>
            </div>
        </div>
      </Popup>
    </>
  );
}

export default AlertDlg
