import React, { useState, useEffect } from 'react';
import moment from 'moment';

import ApiService from '../../services/ApiService'
import PageLoading from '../../components/PageLoading'
import PayrollList from './PayrollList'
import Util from '../../util/Util';
import Constants from '../../util/Constants';

const Payroll = () => {
  const [isLoading, setIsLoading] = useState(true)
  const [loadingMessage, setLoadingMessage] = useState()
  const [employees, setEmplyees] = useState([])
  const [deductions, setDeductions] = useState([])
  const [itemsPerPage, setItemsPerPage] = useState(10)  

  useEffect(() => {
    console.log("Payroll")
    const loadEmployees = async () => {
      setIsLoading(true)
      try {
        setLoadingMessage("Loading deductions...")
        const resp1 = await ApiService.getDeductionRules()
        let deductionList = []
        if (resp1.status === Constants.K_HTTP_OK)
          deductionList = resp1.data.response.data
        console.log(deductionList)
        setLoadingMessage("Loading employees...")
        const resp = await ApiService.getEmployees()
        //console.log(resp.data)
        if (resp.status === Constants.K_HTTP_OK) {  
          let deductionId = null
          let totalDeduction
          let amountToPay
          const empList = resp.data.response.data.map(elem => {
            deductionId = Constants.K_DEDUCTION_MAP.get(+elem.employeetypeid)
            totalDeduction = 0.0
            let deductionItems = []
            deductionList.forEach (item => {
              if (+item.deductionid === deductionId) {                
                let amount = Util.calculateDeduction(elem.salary, item.calculationrule, +item.maximumvalue)
                totalDeduction += amount
                deductionItems.push (  
                  { 
                    propertytypeid: +item.propertytypeid,
                    propertytypename: item.propertytypename,
                    propertytypethainame: item.propertytypethainame,
                    calculationrule: item.calculationrule,
                    maximumvalue: item.maximumvalue,
                    amount              
                  }               
                )
              }
            })
            amountToPay = elem.salary - totalDeduction
            let sal = (elem.salary * 100.0) / 100.0
            let anciente = parseInt(moment(elem.joindate).fromNow().match(/\d+/))
            return { ...elem, deductionId, deductionItems, totalDeduction, amountToPay, salary: sal, anciente}
          })
          //console.log(empList)
          setEmplyees(empList)
        }      
      } catch (e) {
        setEmplyees([])
        setDeductions([])
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
        <PayrollList
          data={employees}
          deductions={deductions}
          itemsPerPage={itemsPerPage} 
          setItemsPerPage={setItemsPerPage}
        />
    </div>  
    </>
  );
}

export default Payroll
