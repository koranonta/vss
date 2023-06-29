import React, { useState, useEffect, useContext } from 'react';
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
import { AppContext } from '../../context/AppContext';

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

const EmployeeList = ({ data, employeeTypes, genderTypes, itemsPerPage, setItemsPerPage, startFrom }) => {
  const [sortByKey, setSortByKey] = useState('id')
  const [order, setOrder] = useState('asc')
  const [openDlg, setOpenDlg] = useState(false)
  const [selItem, setSelItem] = useState()
  const [mode, setMode] = useState()
  const [empTypes, setEmpTypes] = useState()
  const [selEmpType, setSelEmpType] = useState()

  const { login } = useContext(AppContext)

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
      //console.log(login)
      const empSet = new Set()
      const empTypeList = []
      data.forEach(item => {
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

    const getAddress = (employee) => ({
      addressid: employee.addressid,
      address: employee.address,
      street: employee.street,
      subdistrict: employee.subdistrict,
      district: employee.district,
      province: employee.province,
      city: employee.city,
      country: employee.country,
      postcode: employee.postcode
    })

    const employeeHandler = (mode, employee) => {
      console.log("in Employee Handler")
      console.log("action", mode)
      console.log("employee", employee)
      if (mode === "add" || mode === "edit") {
        const formData = new FormData()
        formData.append('imgInput', employee.imageUrl);
        formData.append('employeetypeid', employee.employeetypeid);
        formData.append('accountid', employee.accountid);
        formData.append('genderid', employee.genderid);
        formData.append('firstname', employee.firstname);
        formData.append('lastname', employee.lastname);
        formData.append('identificationcardid', employee.identificationcardid);
        formData.append('birthdate', employee.birthdate);
        formData.append('joindate', employee.joindate);
        formData.append('salary', employee.salary);
        formData.append('positionsalary', employee.positionsalary);
        //  Employee address
        formData.append('address', employee.address);
        formData.append('street', employee.street);
        formData.append('subdistrict', employee.subdistrict);
        formData.append('district', employee.district);
        formData.append('province', employee.province);
        formData.append('city', employee.city);
        formData.append('country', employee.country);
        formData.append('postcode', employee.postcode);

        if (mode === "edit") 
          formData.append('employeeid', +employee.employeeid);
        let image = employee.image          
        if (!_.isEmpty(employee.imageUrl)) {
          image = employee.imageUrl.image.name
        }
        formData.append("image", image);
        ApiService.addEmployee(formData)
        .then(resp => {
          console.log(resp.data)
          if ( resp.data.status ) {
            console.log(resp.data.response)
            //const respEmp = resp.data.response.employee[0]
            const respEmp = resp.data.response.employee
            console.log(respEmp)
            const copiedData = (mode === "edit") 
              ? filteredData.map(elem => +elem.employeeid === +respEmp.employeeid ? {...respEmp} : elem)
              : [...filteredData, respEmp];
            const sortedData = Util.sortData(copiedData, 'employeeid', 'asc');  
            setFilteredData(sortedData)            
            if (mode === "add")
              setCurrentPage(pages)
          }
        })
        .catch(e => console.log(e))        
      }
      else if (mode === "delete") {            
        ApiService.deleteEmployee(employee.employeeid)
        .then (resp => {
          console.log(resp)
          if ( resp.data.status ) {
            const copiedData = [...filteredData];
            const filtered = copiedData.filter(
              elem => +elem.employeeid !== +employee.employeeid ? elem : null)
            setFilteredData(filtered)
          }
        })
        .catch(e => console.log(e))
      }

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
          <div className="col-md-12" >
            <table width="100%">
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
              {slicedData.map((item, index) => (
                <tr key={index} style={{ paddingBottom: '1rem'}}>
                  <td style={{...commonStyles.tableRow, textAlign: 'left', width: '5%'}}>{Util.zeroPad(item.employeeid, 3)}</td>
                  <td style={{...commonStyles.tableRow, width: '20%'}}>{Util.concatName(item)}</td>
                  <td style={{...commonStyles.tableRow, width: '10%'}}>{item.employeetypethainame}</td>
                  <td style={{...commonStyles.tableRow, width: '15%'}}>{item.accountid}</td>
                  <td style={{...commonStyles.tableRow, width: '15%'}}>{item.identificationcardid}</td>
                  <td style={{...commonStyles.tableRow}}>{item.birthdate === "0000-00-00" ? "" : Util.toDMY(item.birthdate)}</td>
                  <td style={{...commonStyles.tableRow}}>{item.joindate  === "0000-00-00" ? "" : Util.toDMY(item.joindate)}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'right'}}>{Util.formatNumber(+item.salary)}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'center'}}>
                    <img src={ AppConfig.K_AVATAR_DIR + (Util.hasImage(item.image) ?`${item.image}` : 'no-image.png')} width="40" style={{borderRadius: '40px'}}/>
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

       <EmployeeDlg 
         item={selItem}
         employeeTypes={employeeTypes}
         genderTypes={genderTypes}
         mode={mode}
         width={'500px'}
         open={openDlg}
         setOpen={setOpenDlg}
         actionHandler={employeeHandler}
       />         
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


  /*
  const testAdd = {
    'employeetypeid': 3
   ,'accountid': '123-456-789-10'
   ,'genderid': 10
   ,'firstname': 'kora'
   ,'lastname': 'nonta'
   ,'identificationcardid': '2245-44224-2244'
   ,'birthdate': '1966-04-10'
   ,'joindate': '2010-01-01'
   ,'image': ''
   ,'salary': 10000
   ,'positionsalary':0
   ,'address': '75/1 Accapat alley 4'
   ,'street': 'Sukhumvit soi 49'
   ,'subdistrict': 'Wattana'
   ,'district': 'Klongtey nuea'
   ,'province': 'Bangkok'
   ,'city': 'Bangkok'
   ,'country': 'Thailand'
   ,'postcode': '10110'
  }
*/

