import React, { useState, useEffect } from 'react';
import ApiService from '../../services/ApiService'
import PageLoading from '../../components/PageLoading'
import EmployeeList from './EmployeeList'

const Employees = () => {
  const [isLoading, setIsLoading] = useState(true)
  const [loadingMessage, setLoadingMessage] = useState()
  const [employees, setEmplyees] = useState([])
  const [itemsPerPage, setItemsPerPage] = useState(10)  

  useEffect(() => {
    console.log("Employee")
    const loadEmployees = async () => {
      setIsLoading(true)
      try {
        setLoadingMessage("Loading employees...")
        const resp = await ApiService.getEmployees()
        
        if (resp.status = 200) {
          setEmplyees(resp.data.response.data)
          console.log(resp.data.response.data)
        }
      } catch (e) {
        setEmplyees([])
        console.log(e)
      } finally {
        setIsLoading(false)
      }
      setIsLoading(false)
    }

    loadEmployees()
  },[])

  if (isLoading) return <PageLoading title={ loadingMessage }/>    

  return (
    <>
    <div className="container px-1">
        <EmployeeList
          data={employees}
          itemsPerPage={itemsPerPage} 
          setItemsPerPage={setItemsPerPage}
        />
    </div>  
    </>
  );
}

export default Employees
