import React, { useState, useEffect } from 'react';
import ApiService from '../../services/ApiService'
import PageLoading from '../../components/PageLoading'
import PayrollList from './PayrollList'
import AppConfig from '../../config/AppConfig';
import Util from '../../util/Util';
import moment from 'moment';
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
        if (resp1.status = 200)
          deductionList = resp1.data.response.data
        //console.log(deductionList)
        setLoadingMessage("Loading employees...")
        const resp = await ApiService.getEmployees()
        //console.log(resp.data)
        if (resp.status = 200) {  
          let deductionId = null
          let totalDeduction
          let amountToPay
          const empList = resp.data.response.data.map(elem => {
            //deductionId = (+elem.employeetypeid === K_TEACHER_TYPE) ? K_TEACHER_DEDUCTION : K_STAFF_DEDUCTION
            deductionId = AppConfig.K_DEDUCTION_MAP.get(+elem.employeetypeid)
            totalDeduction = 0.0
            let deductionItems = []
            deductionList.forEach (item => {
              if (+item.deductionid === deductionId) {
                let amount = Util.calculateDeduction(elem.salary, item.allowablevalues)
                totalDeduction += amount
                deductionItems.push (
                  { propertytypeid: +item.propertytypeid,
                    propertytypename: item.propertytypename,
                    propertytypethainame: item.propertytypethainame,
                    allowablevalues: item.allowablevalues,
                    amount              
                  }                   
                )}
            })
            amountToPay = elem.salary - totalDeduction
            let sal = (elem.salary * 100.0) / 100.0
            let anciente = parseInt(moment(elem.joindate).fromNow().match(/\d+/))
            return { ...elem, deductionItems, totalDeduction, amountToPay, salary: sal, anciente}
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
