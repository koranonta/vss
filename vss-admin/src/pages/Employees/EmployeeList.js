import React, { useState, useEffect } from 'react';
import * as FaIcons from 'react-icons/fa';
import { IconButton } from '@material-ui/core';
import _ from 'lodash';
import usePagination from '../../hooks/usePagination';
import Pagination from '../../components/Pagination';
import EmployeeDlg from './EmployeeDlg';
import Util from '../../util/Util'
import ApiService from '../../services/ApiService'
import AppConfig from '../../config/AppConfig';
import AppStyles from '../../theme/AppStyles';
import { commonStyles } from '../../theme/CommonStyles';
import { images } from '../../util/Images';
import EmployeeFilterAndSearch from '../../components/EmployeeFilterAndSearch';

const columns = [
  { label: 'รหัส', sortKey: 'employeeid', align: 'left', width: '8%' },
  { label: 'ชื่อ นามสกุล', sortKey: 'name', align: 'left', width: '10%' },
  { label: 'ประเภท', sortKey: 'employeetypename', width:'5%' },
  { label: 'เลขบัญชีธนาคาร', sortKey: 'accountid', width:'10%' },
  { label: 'เลขบัตรประชาชน', sortKey: 'identificationcardid', width:'10%' },
  { label: 'วันเกิด', sortKey: 'birthdate', width:'8%' },
  { label: 'วันเริ่มงาน', sortKey: 'joindate', width:'5%' },
  { label: 'เงินเดือน', sortKey: 'salary', align: 'right', width:'10%' },
  { label: 'รูปประจำตัว', sortKey: '', align: 'center', width:'10%' },  
  { label: 'จัดการ', sortKey: '', align: 'center', width:'10%' },
];

const EmployeeList = ({ data, roles, itemsPerPage, setItemsPerPage, startFrom }) => {
  const [sortByKey, setSortByKey] = useState('id')
  const [order, setOrder] = useState('asc')
  const [openDlg, setOpenDlg] = useState(false)
  const [selItem, setSelItem] = useState()
  const [mode, setMode] = useState()
  const [empTypes, setEmpTypes] = useState()
  const [selEmpType, setSelEmpType] = useState()

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

    useEffect(()=> {
      const empSet = new Set()
      const empTypeList = []
      data.forEach(item => {
        console.log()
        if (!empSet.has(item.employeetypethainame)) {
          empSet.add(item.employeetypethainame)
          empTypeList.push({ title: item.employeetypethainame, id: item.employeetypeid })
        }
      })
      setEmpTypes(empTypeList)      
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

    const userHandler = (mode, user) => {

/*      
      console.log("in User Handler")
      console.log("action", mode)
      console.log("user", user)
      if (mode === "add" || mode === "edit") {
        const formData = new FormData()
        formData.append('imgInput', user.imageUrl);
        formData.append('name', user.name);
        formData.append('password', user.password);
        formData.append('email', user.email);
        formData.append('phone', user.phone);
        formData.append('roleid', user.roleid);
        if (mode === "edit") 
          formData.append('userid', +user.userid);
        let image = user.image          
        if (!_.isEmpty(user.imageUrl)) {
          image = user.imageUrl.image.name
        }
        formData.append("image", image);
        ApiService.addUser(formData)
        .then(resp => {
          console.log(resp.data)
          if ( resp.data.status ) {
            const respUser = resp.data.response.user[0]
            const copiedData = (mode === "edit") 
              ? filteredData.map(elem => +elem.userid === +respUser.userid ? respUser : elem)
              : [...filteredData, respUser];
            const sortedData = Util.sortData(copiedData, 'userid', 'asc');  
            setFilteredData(sortedData)
            
          }
        })
        .catch(e => console.log(e))        
      }
      else if (mode === "delete") {            
        ApiService.deleteUser(user.userid)
        .then (resp => {
          console.log(resp)
          if ( resp.data.status ) {
            const copiedData = [...filteredData];
            const filtered = copiedData.filter(
              elem => +elem.userid !== +user.userid ? elem : null)
            setFilteredData(filtered)
          }
        })
        .catch(e => console.log(e))
      }
*/      
    }    

    const handleEmpType = (e) => {
      const selType = +e.target.value
      //console.log(selType)
      setSelEmpType(selType)
      if (selType === -1) 
        setFilteredData(data)
      else {
        const copiedData = [...data];
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

    return(      
      <>
        <div className="row">
          <div className="col-md-2">
            <h1 className={classes.title}>พนักงาน</h1>
            <IconButton onClick={() => {openPopup({}, 'add')}}>
              <img src={images.addIcon} alt="เพิ่มพนักงาน" width="40" title="เพิ่มพนักงาน"/>
            </IconButton>        
          </div>
    
          <EmployeeFilterAndSearch 
            selEmpType={selEmpType}
            empTypes={empTypes}
            handleEmpType={handleEmpType}
            onSearch={onSearch}/>
        </div>


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
                  <td style={{...commonStyles.tableRow, width: '15%'}}>{item.identificationcardid}</td>
                  <td style={{...commonStyles.tableRow}}>{item.birthdate}</td>
                  <td style={{...commonStyles.tableRow}}>{item.joindate}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'right'}}>{Util.formatNumber(+item.salary)}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'center'}}>

                    <img src={ AppConfig.K_AVATAR_DIR + (!_.isEmpty(item.image) ?`${item.image}` : 'no-image.png')} width="40" style={{borderRadius: '40px'}}/>

                    
                  </td >
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

        </>
        :
        <div className="message is-link">
          <div className="message-body has-text-centered">No results</div>
        </div>
      }
     </>
    );    
}

export default EmployeeList
       
/*

       <EmployeeDlg 
         item={selItem}
         roles={roles}
         mode={mode}
         width={'500px'}
         open={openDlg}
         setOpen={setOpenDlg}
         actionHandler={userHandler}
       />           

                       <img src={ (!_.isEmpty(item.image) ? AppConfig.K_AVATAR_DIR + `${item.image}` : 'no-user-image.jpg')} width="40" style={{borderRadius: '40px'}}/>


*/       

