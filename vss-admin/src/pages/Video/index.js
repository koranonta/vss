import React, {useState, useEffect} from 'react';
import _ from 'lodash'
import ApiService from '../../services/ApiService'
import PageLoading from '../../components/PageLoading'
import SendNotification from './SendNotification';

const Video = () => {
  const [isLoading, setIsLoading] = useState(true)
  const [loadingMessage, setLoadingMessage] = useState()
  const [users, setUsers] = useState([])

  useEffect(() => {
    const loadUsers = async () => {
      setIsLoading(true)
      try {
        setLoadingMessage("Loading users...")
        const resp = await ApiService.getUsers()
        if (resp.data.status) {
          const userList = resp.data.response.data.map(user => ({...user, checked: false}))
          const userWithPushToken = userList.filter (user => !_.isEmpty(user.pushtoken) ? user : null )
          setUsers(userWithPushToken)
          //setUsers(userList)
        }
      } catch (e) {
        setUsers([])
        console.log(e)
      } finally {
        setIsLoading(false)
      }
    }
    loadUsers()
  },[])

  if (isLoading) return <PageLoading title={ loadingMessage }/>    


  return (
    <SendNotification 
      className="container px-1"
      users = {users}
      setUsers = {setUsers}
    />
  );
}

export default Video
