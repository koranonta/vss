import React, { useState, useEffect } from 'react';
import { commonStyles } from '../../theme/CommonStyles';
import AppStyles from '../../theme/AppStyles';

const EmployeeFilterAndSearch = ({ selEmpType, empTypes, handleEmpType, onSearch }) => {
  const [searchText, setSearchText] = useState("")
  const classes = AppStyles()

  return (
    <div className="col-md-3 mb-3">
    <form className="mt-3 mb-3 is-flex" style={{justifyContent: 'center', verticalAlign: 'middle'}}>
      <div className={classes.filterLabel}>ประเภทพนักงาน :</div>
      <div className={classes.filterOptions}>
        <select id="selRole" 
          value={selEmpType} 
          onChange={(e) => handleEmpType(e)} 
          style={{...commonStyles.filterOption}}>
          <option key={-1} value={"-1"} style={{...commonStyles.filterOption}}>ทั้งหมด</option>
          { empTypes !== undefined && empTypes.map((data, index) => (
             <option key={index} value={data.id}                 
               style={{...commonStyles.filterOption}}
             >{data.title}</option>))                     
          }
        </select>
      </div>

      <div className={`${classes.filterLabel}`} style={{marginLeft: '20%'}}>ค้นหา :</div>
      <div className={`ml-2`}>
      <input type="text" 
         value={searchText}
         className={classes.inputText}
         onChange={(e) => setSearchText(e.target.value)} 
         name="search"
         id="search"/>
        </div> 

        <button onClick={e => onSearch(e, searchText)} className={`ml-3 ${classes.pillButton}`} style={{width: '60px'}}>Go</button> 
        <button onClick={e => { setSearchText(""); onSearch(e, "") }}
           className={`${classes.pillButton}`} style={{width: '60px'}}>Clear</button>               
    </form>
  </div>    
  )
}

export default EmployeeFilterAndSearch
