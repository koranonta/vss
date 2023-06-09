import React, { useState, useEffect } from 'react';

const CustomTable = ({ data, columns, itemsPerPage, setItemsPerPage, startFrom }) => {

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

  return (
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
</>
  )    

}

export default CustomTable