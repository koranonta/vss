import React, {useState, useContext } from 'react'
import _ from 'lodash'
import LoginDlg from './LoginDlg'
import { AppContext } from '../../context/AppContext';

const Login = () => {
  const { login, setLogin } = useContext(AppContext)
  const [openDlg, setOpenDlg] = useState(true)

  const { loginId } = useContext(AppContext)  

  const loginHandler = (mode, user) => {
    console.log("in Login Handler")
    console.log("action", mode)
    console.log("user", user)

/*    
    if (mode === "add" || mode === "edit") {
      const formData = new FormData()
      formData.append('imgInput', user.imageUrl);
      formData.append('name', user.name);
      formData.append('password', user.password);
      formData.append('email', user.email);
      formData.append('phone', user.phone);
      formData.append('roleid', user.roleid);
      if (mode === "edit") 
        formData.append('userid', +user.userid);
      let image = user.image          
      if (!_.isEmpty(user.imageUrl)) {
        image = user.imageUrl.image.name
      }
      formData.append("image", image);
      console.clear()
      ApiService.addUser(formData)
      .then(resp => {
        if ( resp.data.status ) {
          const respUser = resp.data.response.user[0]
          //console.log(respUser)
          const copiedData = (mode === "edit") 
            ? filteredData.map(elem => +elem.userid === +respUser.userid ? respUser : elem)
            : [...filteredData, respUser];
          const sortedData = Util.sortData(copiedData, 'userid', 'asc');  
          setFilteredData(sortedData)
          
        }
      })
      .catch(e => console.log(e))        
    }
    else if (mode === "delete") {            
      ApiService.deleteUser(user.userid)
      .then (resp => {
        console.log(resp)
        if ( resp.data.status ) {
          const copiedData = [...filteredData];
          const tempFiltered = copiedData.filter(
            elem => +elem.userid !== +user.userid ? elem : null)
          setFilteredData(tempFiltered)
        }
      })
      .catch(e => console.log(e))
    }
*/    
  }    

  return ( 
    <LoginDlg
    width={'500px'}
    open={openDlg}
    setOpen={setOpenDlg}
    initialPos={{x: 50, y: -200}}
    actionHandler={loginHandler}
  /> 
  );
}

export default Login
