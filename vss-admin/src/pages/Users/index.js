import React, { useState, useEffect } from 'react';
import ApiService from '../../services/ApiService'
import PageLoading from '../../components/PageLoading'
import UserList from './UserList'
import Constants from '../../util/Constants';
import * as AiIcons from 'react-icons/ai';
import PageHeader from '../../components/PageHeader'

const Users = () => {
  const [isLoading, setIsLoading] = useState(true)
  const [loadingMessage, setLoadingMessage] = useState()
  const [users, setUsers] = useState([])
  const [roles, setRoles] = useState([])
  const [itemsPerPage, setItemsPerPage] = useState(10)  

  useEffect(() => {
    const loadUsers = async () => {
      setIsLoading(true)
      try {
        setLoadingMessage("Loading users...")
        //  Load user roles
        const resp1 = await ApiService.getPropertiesByGroup(Constants.K_USER_ROLES_TYPE)
        let roleTypes = []
        if (resp1.status === Constants.K_HTTP_OK) {
          roleTypes = resp1.data.response.data
          setRoles(roleTypes.map(item => ({ title: item.propertytypethainame, id: +item.propertytypeid})))        
        }
        //  Load users
        const resp = await ApiService.getUsers()
        if (resp.status === Constants.K_HTTP_OK) 
          setUsers(resp.data.response.data)

        //console.log(resp.data.response.data)  
        //console.log(roles)          
      } catch (e) {
        setUsers([])
        console.log(e)
      } finally {
        setIsLoading(false)
      }
      setIsLoading(false)
    }

    loadUsers()
  },[])

  if (isLoading) return <PageLoading title={ loadingMessage }/>    

  return (
    <>
    <div className="container px-1">
        <UserList
          data={users}
          roles={roles} 
          itemsPerPage={itemsPerPage} 
          setItemsPerPage={setItemsPerPage}
        />
    </div>  
    </>
  );
}

export default Users;
