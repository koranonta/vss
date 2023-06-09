import React, { useState } from 'react'
import * as FaIcons from 'react-icons/fa';

const Pagination = ({ 
    prevPage, 
    nextPage, 
    pagination,
    changePage,
    itemsPerPage,
    setItemsPerPage
    }) => {

  const [pageSizeOptions,] = useState([10, 15, 20, 25, 30, 50])

  const getPaginationButtons = () => {
    const list = pagination.map((page, index) => {
      if(!page.ellipsis) {
        return <li key={page.id}>
          <a 
            href="/#"
            className={page.current ? `pagination-link selPage` : 'pagination-link'}
            onClick={(e) => changePage(page.id, e)}
          >
            {page.id}
          </a>
        </li>
      }else {
        return <li key={page.id}><span className="pagination-ellipsis">&hellip;</span></li>
      }
    })

    if (list.length > 2) {
      list.unshift( (<li key={"first"}><a href="/#" className="pagination-previous" onClick={prevPage}><FaIcons.FaCaretLeft /></a> </li> ) )
      list.push ( (<li key={"last"}><a href="/#" className="pagination-previous" onClick={nextPage}><FaIcons.FaCaretRight /></a> </li>) )
    }
    return list
  }

  return (
    <nav className="pagination">
    <ul className="pagination-list">

      { getPaginationButtons() }

      <li key="1000">
        <div style={{ marginLeft: "20px", marginRight: "20px"}}>
           Page size : &nbsp;
           <select id="pageSize" name="pageSize" value={itemsPerPage} onChange={(e) => setItemsPerPage( +e.target.value ) }>
              {pageSizeOptions.map((data, index) => (
                <option key={index} value={data}>{data}</option>
              ))}
           </select>
        </div>
      </li>
    </ul>
  </nav>
  )
}

export default Pagination


/*


  const getPaginationButtons = () => {
    const list = pagination.map((page, index) => {
      if(!page.ellipsis) {
        return <li key={page.id}>
          <a 
            href="/#"
            className={page.current ? 'pagination-link is-current' : 'pagination-link'}
            onClick={(e) => changePage(page.id, e)}
          >
            {page.id}
          </a>
        </li>
      }else {
        return <li key={page.id}><span className="pagination-ellipsis">&hellip;</span></li>
      }
    })

*/    