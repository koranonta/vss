import React, { useState, useEffect } from 'react';
import AppConfig from '../../config/AppConfig';
import ApiService from '../../services/ApiService'
import PageLoading from '../../components/PageLoading'
import UserList from './UserList'

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
        const resp1 = await ApiService.getPropertiesByGroup(AppConfig.K_USER_ROLES_TYPE)
        let roleTypes = []
        if (resp1.data.status) {
          roleTypes = resp1.data.response.data
          setRoles(roleTypes.map(item => ({ title: item.propertytypethainame, id: +item.propertytypeid})))        
        }
        //  Load users
        const resp = await ApiService.getUsers()
        if (resp.data.status) 
          setUsers(resp.data.response.data)

        console.log(resp.data.response.data)  
        console.log(roles)          
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
