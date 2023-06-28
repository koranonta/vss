import React, { useState, useEffect } from 'react';
import * as FaIcons from 'react-icons/fa';
import { IconButton } from '@material-ui/core';
import _ from 'lodash';
import usePagination from '../../hooks/usePagination';
import Pagination from '../../components/Pagination';
import UserDlg from './UserDlg';
import Util from '../../util/Util'
import ApiService from '../../services/ApiService'
import AppConfig from '../../config/AppConfig';
import AppStyles from '../../theme/AppStyles';
import { commonStyles } from '../../theme/CommonStyles';
import { images } from '../../util/Images';

const columns = [
  { label: 'รหัส', sortKey: 'userid', align: 'left', width: '5%' },
  { label: 'ชื่อ', sortKey: 'name', width:'10%' },
  { label: 'อีเมล', sortKey: 'email', width:'15%' },
  { label: 'เบอร์โทร', sortKey: 'phone', width:'10%' },
  { label: 'บทบาท', sortKey: 'roletype', width:'10%' },
  { label: 'รูปประจำตัว', sortKey: '', align: 'left', width:'5%' },
  { label: 'จัดการ', sortKey: '', align: 'center', width:'10%' },
];

const UserList = ({ data, roles, itemsPerPage, setItemsPerPage, startFrom }) => {
  const [filterRole, setFilterRole] = useState([])
  const [sortByKey, setSortByKey] = useState('userid')
  const [order, setOrder] = useState('asc')
  const [openDlg, setOpenDlg] = useState(false)
  const [selItem, setSelItem] = useState()
  const [mode, setMode] = useState()
  const [selRole, setSelRole] = useState()

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
      const catgSet = new Set()
      const catgList = []
      data.forEach(item => {
        if (!catgSet.has(+item.roleid)) {
          catgSet.add(+item.roleid)
          catgList.push({ title: item.rolethainame, id: +item.roleid})
        }
      })
      setFilterRole(catgList)      
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
      //if (mode === 'add') {
      //  console.log("Add")
      //  const testAdd = {name: 'tua.knn', password: 'tua', email: 'tua.knn@gmail.com', phone: '80858445545', roleid: 7}
      //  console.log(testAdd)
      //  setSelItem(testAdd)
      //}
      //else 
      setSelItem(item)
      setMode(mode)
      setOpenDlg(true)
    }

    const userHandler = (mode, user) => {
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
        console.clear()
        ApiService.addUser(formData)
        .then(resp => {
          if ( resp.data.status ) {
            const respUser = resp.data.response.user[0]
            //console.log(respUser)
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
            const tempFiltered = copiedData.filter(
              elem => +elem.userid !== +user.userid ? elem : null)
            setFilteredData(tempFiltered)
          }
        })
        .catch(e => console.log(e))
      }
    }    

    const handleSelectRole = (e) => {
      const selValue = +e.target.value
      setSelRole(selValue)
      if (selValue === -1) {
        setFilteredData(data)
      }
      else {
        const copiedData = [...data];
        const filtered = copiedData.filter(
          elem => +elem.roleid === selValue ? elem : null)
        setFilteredData(filtered)
        setCurrentPage(1)
      }
    }    

    return(      
      <>
      <div className="row">
        <div className="col-md-2">
          <h1 className={classes.title}>ผู้ใช้</h1>
          <IconButton onClick={() => {openPopup({}, 'add')}}>
            <img src={images.addIcon} alt="เพิ่มผู้ใช้" width="40" title="เพิ่มผู้ใช้"/>
          </IconButton>        
        </div>
        <div className="col-md-3">
            <form className="mt-3 mb-3 is-flex" style={{justifyContent: 'center', verticalAlign: 'middle'}}>
              <div className={classes.filterLabel}>ประเภทผู้ใช้</div>
              <div className={classes.filterOptions}>
                <select id="selRole" 
                  value={selRole} 
                  onChange={(e) => handleSelectRole(e)} 
                  style={{...commonStyles.filterOption}}>
                  <option key={-1} value={-1} style={{...commonStyles.filterOption}}>ทั้งหมด</option>
                  {filterRole.map((data, index) => (
                     <option key={index} value={data.id}                 
                       style={{...commonStyles.filterOption}}
                     >{data.title}</option>))}
                </select>
              </div>
            </form>
          </div>
      </div>

      {slicedData.length > 0 ? <>
        <div className="row">
          <div className="col-md-12" style={{'overflowX': 'auto'}}>
            <table>
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
                <tr key={item.userid} style={{ paddingBottom: '1rem'}}>
                  <td style={{...commonStyles.tableRow, textAlign: 'left', width: '5%'}}>{Util.zeroPad(item.userid, 3)}</td>
                  <td style={{...commonStyles.tableRow, width: '15%'}}>{item.name}</td>
                  <td style={{...commonStyles.tableRow, width: '25%'}}>{item.email}</td>
                  <td style={{...commonStyles.tableRow, width: '15%'}}>{item.phone}</td>
                  <td style={{...commonStyles.tableRow}}>{item.rolethainame}</td>
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

      <UserDlg 
         item={selItem}
         roles={roles}
         mode={mode}
         width={'500px'}
         open={openDlg}
         setOpen={setOpenDlg}
         actionHandler={userHandler}
      />           
     </>
    );    
}

export default UserList
       