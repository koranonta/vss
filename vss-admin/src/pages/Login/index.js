import React, {useState, useContext } from 'react'
import _ from 'lodash'
import LoginDlg from './LoginDlg'
import { AppContext } from '../../context/AppContext';
import LoginConstants from './LoginConstants';
import Constants from '../../util/Constants';
import ApiService from '../../services/ApiService'

const Login = () => {
  const [openDlg, setOpenDlg] = useState(true)
  return ( 
    <LoginDlg
    width={'500px'}
    open={openDlg}
    setOpen={setOpenDlg}
    initialPos={{x: 50, y: -200}}   
  /> 
  );
}

export default Login
