import React, {useState, useRef } from 'react'
import _ from 'lodash'
import AppConfig from '../../config/AppConfig'
import ApiService from '../../services/ApiService'
import AppStyles from '../../theme/AppStyles'
import { commonStyles } from '../../theme/CommonStyles'
import { colors } from '../../util/Colors'

export const Checkbox = ({ isChecked, label, checkHandler, index }) => {
  return (
    <div>
      <input
        type="checkbox"
        styles={{width: '50px', height: '50px'}}
        id={`checkbox-${index}`}
        checked={isChecked}
        onChange={checkHandler}
      />
      <label htmlFor={`checkbox-${index}`}>{label}</label>
    </div>
  )
}

const SendNotification = (props) => {
  const {users, setUsers } = props
  const {checkAll, setCheckAll} = useState(false)
  const titleRef = useRef()
  const bodyRef = useRef()


  const classes = AppStyles()  

  const handleUserSelect =  (e, userid) => {
    const list = users.map (user => user.userid === userid 
      ? {...user, checked: !user.checked}
      : user)
    setUsers(list)
  }

  const handleSelectAll = (e) => {
    console.log("in Handle Select All", e.target.checked)
    const list = users.map (user => ({...user, checked: e.target.checked}))
    setUsers(list)
  }

  const handleSendMessage = (e) => {
    e.preventDefault();
    console.log(e.target.title.value)
    console.log(e.target.body.value)
    const title = e.target.title.value
    const content = e.target.body.value

    let msg = {
      title : e.target.title.value,
      body: e.target.body.value
    }

    users.forEach(user => {
      if (user.checked)
        ApiService.pushExpoNotification( { ...msg, to: user.pushtoken })
        .then(resp => console.log(resp))
        .catch(e => console.log(e))
      })
  }

  const getSelectedUsers = () => _.isEmpty(users) ? 0 : users.filter(user => user.checked === true ? user : null).length
  
  const onClear = (e) => {
    e.preventDefault()
    titleRef.current.value = ""
    bodyRef.current.value = ""  
  }

  return (
    <>
    <div className="row">
      <div className="col-md-12">
        <h1 className={classes.title}>Notification</h1>
      </div>
    </div>
    <div className="row mt-3">
      <div className="col-md-3 pl-5">
        <div className="user_container" style={{overflowY: "scroll"}}>
          <table 
            className={`table table-sm ${classes.themeBackground}`} 
            id="userTable">
            <thead style={{position: 'sticky', top: 0}}>
              <tr>
                <th scope="col">USERS</th>
                <th scope="col">
                  <Checkbox 
                      isChecked={checkAll}
                      checkHandler={(e) => handleSelectAll(e)}
                      index={"All"}
                      key={"All"}/>
                </th>
              </tr>
            </thead>
            <tbody id="tabbody">
              {users.map(user => (
                <tr key={user.userid}>
                  <td>
                    <img src={ AppConfig.K_AVATAR_DIR + (!_.isEmpty(user.image) ?`${user.image}` : 'no-image.png')} 
                         width="30" 
                         style={{borderRadius: '50px'}}/>
                    <span className={`ml-2 ${classes.hero}`}>
                         {user.name}
                    </span>
                  </td>
                  <td width="25%" scope="row">
                    <Checkbox 
                      isChecked={user.checked}
                      checkHandler={(e) => handleUserSelect(e, user.userid)}
                      index={user.userid}
                      key={user.id} />
                  </td>
                </tr>))
              }
            </tbody>
          </table>
        </div>
    </div>

    <div className="col-md-7 ml-5 pr-2">
      <form id="msgForm" onSubmit={handleSendMessage}>
        <div className={`row ${classes.underLine}`} style={{width: '80%'}}>
          <div className="col-2">
            <label htmlFor="title" style={{...commonStyles.inputLabel}}>Title</label>
          </div>
          <div className="col">
            <input type="text" 
              ref = {titleRef}
              required 
              style={{backgroundColor: `${colors.yellowBackground}`}}
              className={`form-control pl-5 ${classes.inputText}`} 
              name="title" 
              id="title"/>
          </div>
        </div>

        <div className="row mt-3">
          <div className="col-2">
            <label htmlFor="body" style={{...commonStyles.inputLabel}}>Message</label>
          </div>
          <div className="col">
            <textarea 
              ref={bodyRef}
              className="form-control pl-2" 
              id="body" 
              name="body"
              style={{height: '10em', width: '75%', marginBottom: '7px', padding: '1px', backgroundColor: `${colors.yellowBackground}`}}></textarea>              
          </div>
        </div>

        {users.length > 0 &&
        <div className={`row mt-3 mb-3 ${classes.rightButtonPanel}`}
             style={{marginRight: '9em', width: '80%'}}>
           <button onClick={e => onClear(e)} name="cancel" className={`mr-2 ${classes.pillButtonPale}`} style={{width: '100px'}}>Clear</button>
           <button name="submit" className={classes.pillButton} style={{width: '100px'}} disabled={getSelectedUsers() === 0}>Send</button>
        </div>
        }
     </form>
    </div>


    </div>

    </>
  )  
}

export default SendNotification
