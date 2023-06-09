import React, { useState, useEffect } from 'react';
import _ from 'lodash';
import { commonStyles } from '../../theme/CommonStyles';
import Util from '../../util/Util';


const YearMonthPicker = ({ initialSate }) => {
  const [years, setYears] = useState()

  
  useEffect(() => {
    

  }, [])


  return (
    <div className="row">
      <div className="col-md-3 mb-3">
        <form className="mt-3 mb-3 is-flex" style={{justifyContent: 'center', verticalAlign: 'middle'}}>
          <div className={classes.filterLabel}>ปี :</div>
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


          <button onClick={e => onSearch(e, searchText)} className={`ml-3 ${classes.pillButton}`} style={{width: '60px'}}>Go</button> 
          <button onClick={e => { setSearchText(""); onSearch(e, "") }}
            className={`${classes.pillButtonPale}`} style={{width: '60px'}}>Clear</button>               
        </form>
      </div>     
    </div>
  )
}

export default YearMonthPicker