import React, { useState, useEffect } from 'react';
import ApiService from '../../services/ApiService'
import PageLoading from '../../components/PageLoading'
import EmployeeList from './EmployeeList'
import Constants from '../../util/Constants';
import Util from '../../util/Util';

const Employees = () => {
  const [isLoading, setIsLoading] = useState(true)
  const [loadingMessage, setLoadingMessage] = useState()
  const [employees, setEmplyees] = useState([])
  const [employeeTypes, setEmployeeTypes] = useState([])
  const [genderTypes, setGenderTypes] = useState([])
  const [itemsPerPage, setItemsPerPage] = useState(10)  

  useEffect(() => {
    console.log("Employee")
    const loadEmployees = async () => {
      setIsLoading(true)
      try {
        setLoadingMessage("Loading employees...")

        //  Load employee roles properties
        const resp1 = await ApiService.getPropertiesByGroup(Constants.K_EMPLOYEE_TYPE)
        if (resp1.status === Constants.K_HTTP_OK) {
          const empTypeOptions = Util.propertiesToThaiOptionSelector(resp1.data.response.data)
          setEmployeeTypes(empTypeOptions)
        }
        //  Load gender properties
        const resp2 = await ApiService.getPropertiesByGroup(Constants.K_GENDER_TYPE)
        if (resp2.status === Constants.K_HTTP_OK) {
          const genderTypeOptions = Util.propertiesToThaiOptionSelector(resp2.data.response.data)
          setGenderTypes(genderTypeOptions)
        }

        //  Load address
        const addrMap = new Map()
        const resp3 = await ApiService.getAddresses()
        if (resp3.status === Constants.K_HTTP_OK) {
          resp3.data.response.data.forEach(addr => 
            !addrMap.has(+addr.employeeid) && addrMap.set(+addr.employeeid, addr))
        }

        //  Load employee list
        const resp = await ApiService.getEmployees()        
        if (resp.status === Constants.K_HTTP_OK) {
          //console.log(resp.data.response.data)
          const empList = resp.data.response.data.map(item => {
            //  Add address information
            let addr = addrMap.has(+item.employeeid) 
              ? addrMap.get(+item.employeeid) 
              : Constants.K_EMPTY_ADDRESS
            return ({...item, ...addr})
          })
          //console.log(empList)
          setEmplyees(empList)
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
          employeeTypes={employeeTypes}
          genderTypes={genderTypes}
          itemsPerPage={itemsPerPage} 
          setItemsPerPage={setItemsPerPage}
        />
    </div>  
    </>
  );
}

export default Employees
