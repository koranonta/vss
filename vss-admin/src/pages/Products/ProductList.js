import React, { useState, useEffect } from 'react';
import * as FaIcons from 'react-icons/fa';
import { IconButton } from '@material-ui/core';
import _ from 'lodash';
import usePagination from '../../hooks/usePagination';
import Pagination from '../../components/Pagination';
import ProductDlg from './ProductDlg';
import Util from '../../util/Util'
import ApiService from '../../services/ApiService'
import AppConfig from '../../config/AppConfig';
import AppStyles from '../../theme/AppStyles';
import { commonStyles } from '../../theme/CommonStyles';

import './table.css'
import { images } from '../../util/Images';

const columns = [
  { label: 'Id', sortKey: 'productid' },
  { label: 'Category', sortKey: 'categoryname', width:'25%', align: 'left' },
  { label: 'Title',    sortKey: 'title', width:'25%', align: 'left' },
  { label: 'Unit',     sortKey: 'unit',  align: 'right' },
  { label: 'Price',    sortKey: 'price', align: 'right' },
  { label: 'Image',    sortKey: '',      align: 'center' },
  { label: 'Action',   sortKey: '',      align: 'center' },
];

const ProductList = ({ data, categories, itemsPerPage, setItemsPerPage, startFrom }) => {
  const [filterCategories, setFilterCategories] = useState([])
  const [selCatg, setSelCatg] = useState()
  const [sortByKey, setSortByKey] = useState('productid')
  const [order, setOrder] = useState('asc')
  const [openDlg, setOpenDlg] = useState(false)
  const [selItem, setSelItem] = useState()
  const [mode, setMode] = useState()

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

    useEffect(() => {
      const catgSet = new Set()
      const catgList = []
      data.forEach(item => {
        if (!catgSet.has(+item.categoryid)) {
          catgSet.add(+item.categoryid)
          catgList.push({ title: item.categoryname, id: +item.categoryid})
        }
      })
      setFilterCategories(catgList)
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

    const handleSelectCategory = (e) => {
      const selValue = +e.target.value
      setSelCatg(selValue)
      if (selValue === -1) {
        setFilteredData(data)
      }
      else {
        const copiedData = [...data];
        const filtered = copiedData.filter(
          elem => +elem.categoryid === selValue ? elem : null)
        setFilteredData(filtered)
        setCurrentPage(1)
      }
    }

    const openPopup = (item, mode) => {
      setSelItem(item)
      setMode(mode)
      setOpenDlg(true)
    }

    const productHandler = async (mode, prod) => {
      if (mode === "add" || mode === "edit") {
        const formData = new FormData()
        formData.append('imgInput', prod.imageUrl);
        formData.append('title', prod.title);
        formData.append('categoryid', +prod.categoryid);
        formData.append('description', prod.description);
        formData.append('unit', prod.unit);
        formData.append('price', prod.price);
        if (mode === "edit") 
          formData.append('productid', +prod.productid);
        let image = prod.image          
        if (!_.isEmpty(prod.imageUrl)) {
          image = prod.imageUrl.image.name
        }
        formData.append("image", image);
        ApiService.addProduct(formData)
        .then(resp => {
          //console.log(resp.data)
          if ( resp.data.status ) {
            //console.log("respProd", resp.data.response.product[0] )
            const respProd = resp.data.response.product[0]
            const copiedData = (mode === "edit") 
              ? filteredData.map(elem => +elem.productid === +respProd.productid ? respProd : elem)
              : [...filteredData, respProd];
            const sortedData = Util.sortData(copiedData, 'productid', 'asc');  
            setFilteredData(sortedData)
            
          }
        })
        .catch(e => console.log(e))
      }
      else if (mode === "delete") {            
        ApiService.deleteProduct(prod.productid)
        .then (resp => {
          //console.log(resp)
          if ( resp.data.status ) {
            const copiedData = [...filteredData];
            const filtered = copiedData.filter(
              elem => +elem.productid !== +prod.productid ? elem : null)
            setFilteredData(filtered)
          }
        })
        .catch(e => console.log(e))
      }
    }    

    return(
      <>
        <div className="row">
          <div className="col-md-2">
            <h1 className={classes.title}>Product</h1>
            <IconButton onClick={() => {openPopup({}, 'add')}}>
              <img src={images.addIcon} alt="Add Product" width="40" title="Add Product"/>
            </IconButton>

          </div>  
          <div className="col-md-3">
            <form className="mt-3 mb-3 is-flex" style={{justifyContent: 'center', verticalAlign: 'middle'}}>
              <div className={classes.filterLabel}>Category :</div>
              <div className={classes.filterOptions}>
                <select id="selCatg" 
                  value={selCatg} 
                  onChange={(e) => handleSelectCategory(e)} 
                  style={{...commonStyles.filterOption}}>
                  <option key={-1} value={-1} style={{...commonStyles.filterOption}}>All</option>
                  {filterCategories.map((data, index) => (
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
                <tr key={item.productid} style={{ paddingBottom: '1rem'}}>
                  <td style={{...commonStyles.tableRow, textAlign: 'left' }}>{Util.zeroPad(item.productid, 3)}</td>
                  <td style={{...commonStyles.tableRow, whiteSpace: 'nowrap', width: '25%' }}>{item.categoryname}</td>
                  <td style={{...commonStyles.tableRow,  whiteSpace: 'nowrap', width: '25%' }}>{item.title}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'right' }}>{item.unit}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'right' }}>{Util.formatNumber(item.price)}</td>
                  <td style={{...commonStyles.tableRow, textAlign: 'center'}}>
                    <img src={ AppConfig.K_IMAGE_DIR + `${item.image}`} width="40%"/>
                  </td >
                  <td style={{ ...commonStyles.tableRow, whiteSpace: 'nowrap' }}>
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
        
         <ProductDlg 
           item={selItem}
           categories={categories}
           mode={mode}
           width={'600px'}
           open={openDlg}
           setOpen={setOpenDlg}
           actionHandler={productHandler}
         />                     

        </>
        :
        <div className="message is-link">
          <div className="message-body has-text-centered">No results</div>
        </div>
      }
      </>
    );    
}

export default ProductList
