import React, {useState, useEffect } from 'react'
import { makeStyles } from '@material-ui/core/styles';
import UserInput from './UserInput';


const useStyles = makeStyles((theme) => ({ tableFont: { fontSize: "12px" } }));

const UserDlg = (props) => {
  const {setOpenDlg, item } = props

  const classes = useStyles()

  const handleOkBtn = () => {
    //const relCirs = packageOptions.get( selMir )
    //const selPackage = relCirs.find(item => item.cir === selCir ? item : null)
    //processSubscriptionChange (selPackage)
    setOpenDlg(false)
  }

  const handleCancelBtn = () => {
    setOpenDlg(false)
    //cancelSubscriptionChange()
  }  

  const disableBtn = () => false

  return (
    <>
    <UserInput 
      handleOkBtn={handleOkBtn}
      handleCancelBtn={handleCancelBtn}
    />


    </>
  )  

}

export default UserDlg
