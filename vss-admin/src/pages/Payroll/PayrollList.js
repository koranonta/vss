import React, { useState, useEffect } from 'react';
import * as FaIcons from 'react-icons/fa';
import { IconButton } from '@material-ui/core';
import Grid from '@material-ui/core/Grid';
import "react-datepicker/dist/react-datepicker.css";
import moment from 'moment';

import _ from 'lodash';
import DatePicker from "react-datepicker";
import usePagination from '../../hooks/usePagination';
import Pagination from '../../components/Pagination';
import PayrollDlg from './PayrollDlg';
import Util from '../../util/Util'
import AppStyles from '../../theme/AppStyles';
import { commonStyles } from '../../theme/CommonStyles';
import { images } from '../../util/Images';
import EmployeeFilterAndSearch from '../../components/EmployeeFilterAndSearch';
import ApiService from '../../services/ApiService'
import Constants from '../../util/Constants';

import ExcelExport from '../../util/ExcelExport';

const columns = [
  { label: 'รหัส', sortKey: 'id', align: 'left', width: '5%' },
  { label: 'ชื่อ นามสกุล', sortKey: 'name', align: 'left', width: '10%' },
  { label: 'ประเภท', sortKey: 'employeetypethainame', align: 'left', width:'10%' },
  { label: 'เลขบัญชีธนาคาร', sortKey: 'accountId', width:'10%' },  
  { label: 'วันเริ่มงาน', sortKey: 'joindate', width:'5%' },  
  { label: 'อายุงาน', sortKey: 'anciente', width:'3%' },  
  { label: 'เงินเดือน', sortKey: 'salary', align: 'right', width:'8%' },
  { label: 'รวมหัก', sortKey: 'totalDeduction', align: 'right', width:'8%' },
  { label: 'ยอดสุทธิ', sortKey: 'netAmount', align: 'right', width:'8%' },
  { label: 'จัดการ', sortKey: '', align: 'center', width:'10%' },
];

const PayrollList = ({ data, itemsPerPage, setItemsPerPage, startFrom }) => {
  const [sortByKey, setSortByKey] = useState('id')
  const [order, setOrder] = useState('asc')
  const [selItem, setSelItem] = useState()
  const [empTypes, setEmpTypes] = useState()
  const [selEmpType, setSelEmpType] = useState()
  const [openDlg, setOpenDlg] = useState()
  const [mode, setMode] = useState()
  const [payrollDate, setPayrollDate] = useState(new Date())
  const [selMonth, setSelMonth] = useState()
  const [selYear, setSelYear] = useState()
  const [showMain, setShowMain] = useState(true)
  const [runId, setRunId] = useState()
  const [svData, setSvData] = useState()

  const { 
    slicedData, 
    pagination, 
    prevPage, 
    nextPage, 
    changePage, 
    setCurrentPage,
    pages,    
    setFilteredData, 
    filteredData } = usePagination({ itemsPerPage, data, startFrom });

    const classes = AppStyles()

    const getDeductionInfo = (salary, deductionItems) => {
      let totalDeduction = 0.0
      deductionItems.forEach(item => totalDeduction += +item.amount)
      const amountToPay = salary - totalDeduction
      //console.log(salary, totalDeduction, amountToPay)
      return {
        deductionItems
       ,totalDeduction
       ,amountToPay 
      }
    }

    const initDeduction = (item) => {
      let totalDeduction = 0.0
      let deductionItems = []
      item.deductionItems.forEach (elem => {
        let amount = Util.calculateDeduction(item.salary, elem.calculationrule, +elem.maximumvalue)
        totalDeduction += amount        
        deductionItems.push ( 
          { 
            propertytypeid: +elem.propertytypeid,
            propertytypename: elem.propertytypename,
            propertytypethainame: elem.propertytypethainame,
            calculationrule: elem.calculationrule,
            maximumvalue: elem.maximumvalue,
            amount              
          })
      })
      const amountToPay = (+item.salary - totalDeduction)
      return { deductionItems, totalDeduction, amountToPay }
    }

    const loadPayrollRun = (date) => {
      const tmpDate = new Date(date.getFullYear(), date.getMonth(), 1);
      const firstDay = moment(tmpDate).format('YYYY-MM-DD')

      ApiService.getPayrollRunByDate(firstDay).then(resp => {
        if (resp.status === Constants.K_HTTP_OK) {
          const selRunId = +resp.data.response[0]['runid']
          setRunId(selRunId) 
          const deductionMap = new Map()
          ApiService.getPayrollTransactionItems(selRunId).then(resp1 => {
            if (resp1.status === Constants.K_HTTP_OK) {
              let savedDeductions = resp1.data.response
              //console.log(savedDeductions)
              //  Create employee deduction map
              savedDeductions.forEach( item => 
                deductionMap.has(+item.employeeid) 
                  ? deductionMap.get(+item.employeeid).push(item)
                  : deductionMap.set(+item.employeeid, [item])
              )
              //  Assign saved deductions to employee list
              //console.log(deductionMap)
              const temp = data.map(elem => 
                deductionMap.has(+elem.employeeid)
                  ? { ...elem, ...getDeductionInfo(+elem.salary, deductionMap.get(+elem.employeeid))}
                  : { ...elem, ...initDeduction(elem) } 
                )
              setSvData(temp)  
              setFilteredData(temp)              
            }
          })
        }
      })
    }

    useEffect(()=> {
      const empSet = new Set()
      const empTypeList = []
      data.forEach(item => {
        if (!empSet.has(item.employeetypethainame)) {
          empSet.add(item.employeetypethainame)
          empTypeList.push({ title: item.employeetypethainame, id: item.employeetypeid })
        }
      })
      setEmpTypes(empTypeList)    
      setSelYear(payrollDate.getFullYear())
      setSelMonth(Util.thaimonths[payrollDate.getMonth()])  
      loadPayrollRun(payrollDate)
    },[data])

    useEffect(() => {
      const copyOfFilteredData = [...filteredData];
      const sortFiltered = copyOfFilteredData;
      setFilteredData(sortFiltered);
    }, [itemsPerPage])      

    const sortHandler = (sortBy, orderBy) => {
      if(sortByKey !== sortBy) {
        setSortByKey(sortBy);
      }
      if(order !== orderBy) {
        setOrder(orderBy);
      }
      const copyOfFilteredData = [...filteredData];
      const filtered = Util.sortData(copyOfFilteredData, sortBy, orderBy);
      setFilteredData(filtered);
    }    

    const openPopup = (item, mode) => {
      setSelItem(item)
      setMode(mode)
      setOpenDlg(true)
    }

    const addPayrollTransaction = async (item, updatedDeductionItems) => {
      //  Add payroll transaction
      const transBody = {
        "payrollrunid": +runId
        ,"employeeid": +item.employeeid
        ,"deductionid": +item.deductionId
        ,"loginid": -1
      }
      //console.clear()
      //console.log(transBody)
      ApiService.addPayrollTransaction(transBody)
        .then (resp => {
          if (resp.status === Constants.K_HTTP_OK) {
            const transId = resp.data.response.payrolltransaction[0]['payrolltransactionid']
            //  Add payroll transaction item
            updatedDeductionItems.forEach (elem => {
              let transItem = {
                  payrolltransactionid: +transId
                 ,propertytypeid: +elem.propertytypeid
                 ,amount: +elem.amount
                 ,loginid: -1
                }
              ApiService.addPayrollTransactionItem(transItem)
                //.then (resp1 => console.log(resp1.status) )
                .catch(e1    => console.log(e1) ) 
            })      
          }
        })
        .catch( e => console.log(e))      
    }
    
    const payrollHandler = (mode, res) => {
      //console.log("in Payroll Handler")
      //console.log("action", mode)
      //console.log("res", res)          
      //console.log(selItem)
      //console.log(filteredData)
      const temp = filteredData.map(item => {
        if (selItem.employeeid === item.employeeid) {
          const updatedDeductionItems = item.deductionItems.map (elem => {
            let fieldName = elem.propertytypename.replaceAll(" ", "_")
            return {...elem, amount: res[fieldName]}
          })
          addPayrollTransaction ( item, updatedDeductionItems )
          return ({...item, 
                    totalDeduction: res.totalDeduction, 
                    amountToPay: res.amountToPay,
                    deductionItems: updatedDeductionItems })
        }
        else 
          return item
      })
      setFilteredData(temp)
    }    

    const handleEmpType = (e) => {
      const selType = +e.target.value
      //console.log(selType)
      setSelEmpType(selType)
      if (selType === -1) 
        setFilteredData(svData)
      else {
        const copiedData = [...svData];
        const filteredList = copiedData.filter( elem =>           
          +elem.employeetypeid === selType ? elem : null )
        //console.log(filteredList)
        setFilteredData(filteredList)
        setCurrentPage(1)
      }
    }  
    
    const onSearch = (e, searchText) => {
      e.preventDefault()
      const copiedData = [...data];
      const filteredList = copiedData.filter( elem => {
        let name = Util.concatName(elem)
        return name.indexOf(searchText) > -1 ? elem : null
      })
      setFilteredData(filteredList)
      setCurrentPage(1)
    }   

    const handlePayrollDate = (date) => {
      setSelYear(Util.toThaiYear(date.getFullYear()))
      setSelMonth(Util.thaimonths[date.getMonth()])      
      const newDate = new Date(date.getFullYear(), date.getMonth(), 1);
      setPayrollDate(newDate)
      loadPayrollRun(newDate)
      setShowMain(true)
    }

    const clearPayrollDate = () => {
      setSelYear("")
      setSelMonth("")
      setPayrollDate(new Date())
      setShowMain(false)
    }

    const onExcelExport = () => ExcelExport.run(svData, payrollDate)
    
    const header = () => (
      !showMain  &&  
      <table>
        <tbody>
          <tr>
            <td><h1 className={classes.title}>เงินเดือน</h1></td>
            <td>      
              <div className="mt-5 ml-3 col-md-5">
                <DatePicker selected={payrollDate}
                            style={{fontSize: '18px'}}
                            onChange={(date) => handlePayrollDate(date)}/>
              </div>
             </td>
          </tr>
        </tbody>
      </table>        
     )

    const mainScreen = () => (
      <>
       <Grid container>
        <Grid item xs={4}>
          <h1 className={classes.title}>เงินเดือน  {selMonth} {selYear}</h1>
        </Grid>
        <Grid item xs={6}>
          <div className={"ml-5 mt-3"} >
             <button onClick={(e) => clearPayrollDate()} name="cancel" className={`mr-2 ${classes.pillButton}`} style={{width: '100px'}}>New Month</button>
          </div>
        </Grid>

        <Grid item xs={12}>
          <EmployeeFilterAndSearch 
            selEmpType={selEmpType}
            empTypes={empTypes}
            handleEmpType={handleEmpType}
            onSearch={onSearch}/>
        </Grid>
       </Grid>            

      {slicedData.length > 0 ? <>
        <div className="row">
          <div className="col-md-12">
            <table className="spacing-table">
              <thead>
                <tr>
                {columns.map((col, index) => (
                  <th style={{
                    ...commonStyles.tableHeader,                       
                    textAlign: _.isEmpty(col.align) ? 'left' : col.align,
                    width: !_.isEmpty(col.width) && col.width     
                  }}
                  key={index}
                  onClick={() => 
                  col.sortKey !== '' 
                    ? sortHandler(col.sortKey, sortByKey === col.sortKey ? order === 'asc' ? 'desc' : 'asc' : 'asc')
                    : ""}>
                    {col.label}
                    {sortByKey === col.sortKey &&
                    <span className="icon">
                      {order === 'asc'
                        ? <FaIcons.FaSortUp />
                        : <FaIcons.FaSortDown />
                      }
                    </span>
                  }
                  </th>
                ))}
              </tr>
            </thead>
            <tbody>
              {slicedData.map(item => (
                <tr key={item.employeeid} style={{ paddingBottom: '1rem'}}>
                  <td style={{...commonStyles.tableRow, textAlign: 'left', width: '5%'}}>{Util.zeroPad(item.employeeid, 3)}</td>
                  <td style={{...commonStyles.tableRow, width: '20%'}}>{Util.concatName(item)}</td>
                  <td style={{...commonStyles.tableRow, width: '10%'}}>{item.employeetypethainame}</td>
                  <td style={{...commonStyles.tableRow, width: '15%'}}>{item.accountid}</td>
                  <td style={{...commonStyles.tableRow, width: '15%'}}>{item.joindate  === "0000-00-00" ? "" :  Util.toDMY(item.joindate)}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'right'}}>{item.joindate  === "0000-00-00" ? "" : item.anciente + " ปี"}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'right'}}>{Util.formatNumber(item.salary)}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'right'}}>{Util.formatNumber(item.totalDeduction)}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'right'}}>{Util.formatNumber(item.salary - item.totalDeduction)}</td>
                  <td style={{...commonStyles.tableRow, whiteSpace: 'nowrap'}}>
                    <IconButton onClick={() =>openPopup(item, 'edit')}>
                      <img src={images.editIcon} width="30px" alt={item.title}/>
                    </IconButton>
                    <IconButton onClick={() =>openPopup(item, 'delete')}>
                      <img src={images.deleteIcon} width="30px" alt={item.title}/>
                    </IconButton>

                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          <br/>

          <Grid container>
            <Grid item xs={4}>
              <div className="mt-2">
              <button onClick={e => onExcelExport(e)} name="excelExport" className={`mr-2 ${classes.pillButton}`} style={{width: '150px'}}>Excel Export</button>
              </div>
            </Grid>
            <Grid item xs={8}>
            { pages > 1 &&
              <div className={classes.rightJustifyContainer}>
                <Pagination
                   prevPage = {prevPage}
                   nextPage = {nextPage}
                   pagination = {pagination}
                   changePage = {changePage}
                   itemsPerPage = {itemsPerPage}
                   setItemsPerPage = {setItemsPerPage} />
              </div>
            }

            </Grid>
          </Grid>  
          </div>
        </div> 

        <PayrollDlg 
           item={selItem}
           width={'400px'}
           open={openDlg}
           setOpen={setOpenDlg}
           mode={mode}
           actionHandler={payrollHandler} /> 

        </>
        :
        <div className="message is-link">
          <div className="message-body has-text-centered">No results</div>
        </div>
      }
     </>
    )
    
    return(      
      <>
      { header() }
      { showMain && mainScreen() }
      </>
    ) 
}

export default PayrollList
       

