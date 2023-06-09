import React, { useState, useEffect } from 'react';
import * as FaIcons from 'react-icons/fa';
import _ from 'lodash';
import ApiService from '../../services/ApiService'
import usePagination from '../../hooks/usePagination';
import Pagination from '../../components/Pagination';
import Util from '../../util/Util'
import OrderDlg from './OrderDlg';

import AppStyles from '../../theme/AppStyles';
import { commonStyles } from '../../theme/CommonStyles';

const OrderList = ({ data, statusOptions, itemsPerPage, setItemsPerPage, startFrom }) => {
  const [clients, setClients] = useState([])
  const [selClientId, setSelClientId] = useState()
  const [selStatusId, setSelStatusId] = useState()
  const [orderStatus, setOrderStatus] = useState([])
  const [sortByKey, setSortByKey] = useState('none')
  const [order, setOrder] = useState('asc')
  const [openDlg, setOpenDlg] = useState(false)
  const [selItem, setSelItem] = useState()
  const [orderStatusSummary, setOrderStatusSummary] = useState({
    regCnt: 0,
    ProcCnt: 0,
    ShpCnt: 0,
    cmptCnt: 0,
    cancelCnt: 0,
  })

  const columns = [
    { label: 'Id', sortKey: 'orderid', align: 'left', width: '8%' },
    { label: 'Client name', sortKey: 'clientname', align: 'left', width: '20%' },
    { label: 'Order date', sortKey: 'orderdate' },
    { label: 'Status', sortKey: 'statusname' },
    { label: 'Total items', sortKey: 'totalitems', align: 'left' },
    { label: 'Total amount', sortKey: 'totalamount' },
    { label: 'Action', sortKey: '', width:'10%', align: 'left' },
  ];

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

    const getStatusSummary = (list) => {
      let regCnt = 0
      let cmptCnt = 0
      let shpCnt = 0
      let procCnt = 0
      let cancelCnt = 0
      list.forEach(item => {
        switch (+item.statusid) {
          case 1: regCnt++; break
          case 2: procCnt++; break
          case 3: shpCnt++; break
          case 4: cmptCnt++; break
          case 5: cancelCnt++; break
        }
      })
      setOrderStatusSummary ({regCnt, procCnt, shpCnt, cmptCnt, cancelCnt})
      console.log(orderStatusSummary)
    }

    useEffect(() => {
      //console.log("in OrderList")
      const clientSet  = new Set()
      const statusSet  = new Set()
      const clientList = []
      const statusList = []
      clientList.push({ title: "All", id: -1})
      statusList.push({ title: "All", id: -1})
      data.forEach(item => {
        if (!clientSet.has(+item.clientid)) {
          clientSet.add(+item.clientid)
          clientList.push({ title: item.clientname, id: +item.clientid})          
        }
        if (!statusSet.has(+item.statusid)) {
          statusSet.add(+item.statusid)
          statusList.push({ title: item.statusname, id: +item.statusid})          
        }        
      })
      getStatusSummary(data)
      setClients(clientList)
      setOrderStatus(statusList.sort((a, b) => (a.id - b.id)))      
    },[])

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

    const handleSelectClient = (e) => {
      const selValue = +e.target.value
      setSelClientId(selValue)
      if (selValue === -1) {
        setFilteredData(data)
        getStatusSummary(data)
      }
      else {
        const copiedData = [...data];
        const filtered = copiedData.filter(
          elem => +elem.clientid === selValue && elem)
        getStatusSummary(filtered)
        setFilteredData(filtered)
        setSelStatusId(-1)
        setCurrentPage(1)
      }
    }

    const handleSelectStatus = (e) => {
      const selValue = +e.target.value
      setSelStatusId(selValue)
      let copiedData = (selClientId === undefined) 
        ? [...data ] 
        : data.filter(elem => +elem.clientid === +selClientId && elem)

      const filtered = selValue === -1 
        ? copiedData
        : copiedData.filter(elem => (+elem.statusid === selValue) && elem)
      setFilteredData(filtered)
    }

    const openPopup = (item) => {
      setSelItem(item)
      setOpenDlg(true)
      //console.log(selItem)
    }

    const handleOrderStatusChange = async (e, item) => {
      try {
        const newStatus = +e.target.value
        ApiService.updateOrderStatus(item.orderid, { statusid: newStatus, loginid: -1 })
         .then(resp => {
          if (resp.data.status) {          
            const list = filteredData.map(order => 
              +order.orderid === +item.orderid ? {...order, statusid: newStatus} : order )
             setFilteredData(list)    
          }
         })
      }
      catch (e) {
        console.log(e)
      }
    }

    // ----------------------------------------------------------
    //    UI Sections
    // ----------------------------------------------------------

    const filterSection = () => (
      <div className="row">
      <div className="col-md-2">
        <h1 className={classes.title}>Order</h1>
      </div>  
      <div className="col-md-6">
        <form className="mt-3 mb-3 is-flex" style={{justifyContent: 'center', verticalAlign: 'middle'}}>
        <div className={classes.filterLabel}>Client</div>
      <div className={classes.filterOptions}>
        {
        <select value={selClientId} onChange={(e) => handleSelectClient(e)} 
          style={{...commonStyles.filterOption}}>
          {clients.map((data, index) => (
            <option key={index} value={data.id}>{data.title}</option>
          ))}
        </select>
         }
      </div>

      <div className={`ml-5 ${classes.filterLabel}`}>Status</div>
      <div className={classes.filterOptions}>
        <select value={selStatusId} onChange={(e) => handleSelectStatus(e)}
          style={{...commonStyles.filterOption}}>
          {orderStatus.map((data, index) => (
            <option key={index} value={data.id}>{data.title}</option>
          ))}
        </select>
      </div>
        </form>
      </div>
    </div>
    )

    const summarySection = () => (
      <div className="row">
       <div className={classes.rightJustifyContainer}>    
        <table>
          <tr>
            {orderStatusSummary.regCnt !== 0 && <td style={{...commonStyles.orderSummary, textAlign: 'center'}}>{orderStatusSummary.regCnt}<br/>Registered</td>}
            {orderStatusSummary.procCnt !== 0 && <td style={{...commonStyles.orderSummary}}>{orderStatusSummary.procCnt}<br/>Processed</td>}
            {orderStatusSummary.shpCnt !== 0 && <td style={{...commonStyles.orderSummary}}>{orderStatusSummary.shpCnt}<br/>Shipped</td>}
            {orderStatusSummary.cmptCnt !== 0 && <td style={{...commonStyles.orderSummary}}>{orderStatusSummary.cmptCnt}<br/>Completed</td>}
            {orderStatusSummary.cancelCnt !== 0 && <td style={{...commonStyles.orderSummary}}>{orderStatusSummary.cancelCnt}<br/>Canceled</td>}
          </tr>
        </table>
      </div>        
    </div>
    )

    const orderList = () =>
      slicedData.length === 0 
        ? <div className="message is-link">
            <div className="message-body has-text-centered">No results</div>
          </div>
        : <>
        <div className="row">
        <div className="col-md-12">
        <table className="spacing-table">
          <thead>
            <tr>
              {columns.map((col, index) => (
                <th 
                  style={{ 
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
              <tr key={item.orderid} style={{ paddingBottom: '1rem'}}>
                <td style={{...commonStyles.tableRow, width: '8%'}}>#{Util.zeroPad(item.orderid, 5)}</td>
                <td style={{...commonStyles.tableRow, width: '20%'}}>{item.clientname}</td>
                <td style={{...commonStyles.tableRow}}>{Util.truncateSecond(item.orderdate)}</td>
                <td>
                  <select 
                    id="statusOptions" 
                    name="statusOptions" 
                    value={+item.statusid || ""}
                    onChange={(e) => handleOrderStatusChange (e, item)}                      
                    style={{...commonStyles.tableRow, height:'20px', width:'70%'}}
                    disabled={item.statusid > 3}>
                    {statusOptions.map ((opt, index) => +opt.id >= +item.statusid 
                       && <option key={index} value={opt.id}>{opt.title}</option>)
                    }
                  </select>
                </td>
                <td style={{...commonStyles.tableRow, textAlign: 'center'}}>{item.totalitems}</td>
                <td style={{...commonStyles.tableRow, textAlign: 'center'}}>{Util.formatNumber(item.totalamount)}</td>
                <td style={{...commonStyles.tableRow, textAlign: "center"}}>
                  <button type="button" className="btn btn-warning editbtn mr-1"  onClick={() => openPopup(item)}><FaIcons.FaBinoculars /></button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>

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
    </div>
    </div>

     <OrderDlg 
       item={selItem}
       open={openDlg}
       setOpen={setOpenDlg}
       width={'500px'} />
  
      </>

    return(
      <>
        {filterSection()}
        {summarySection()}
        {orderList()}
      </> )
}

export default OrderList


/*

                  <td>
                  <select 
                    id="statusOptions" 
                    name="statusOptions" 
                    value={+item.statusid || ""}
                    onChange={(e) => handleOrderStatusChange (e, item)}                      
                    style={{height:'25px', width:'70%'}}>
                    {statusOptions.map ((opt, index) => 
                    <option key={index} value={opt.id}>{opt.title}</option>)}
                   </select>

              </td>
*/              