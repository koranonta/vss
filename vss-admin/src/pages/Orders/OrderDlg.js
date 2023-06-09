import React, {useState, useEffect } from 'react'
import { Typography } from '@material-ui/core';
import _ from 'lodash';


import Util from '../../util/Util';
import Popup from '../../components/Popup'
import ApiService from '../../services/ApiService';
import { colors } from '../../util/Colors'
import AppConfig from '../../config/AppConfig';
import AppStyles from '../../theme/AppStyles';
import { commonStyles } from '../../theme/CommonStyles';
import LoadingPopup from '../../components/Controls/LoadingPopup';
import { images } from '../../util/Images'

const OrderDlg = (props) => {
  const {item, open, setOpen, width, openLoading, setOpenLoading } = props
  const [orderItems, setOrderItems] = useState()
  const [totalAmount, setTotalAmount] = useState()
  
  const classes = AppStyles()

  useEffect(() => {
    const loadOrderItems = async (orderId) => {
      try {
        //setIsLoading(true)
        setOpenLoading(true)
        const resp = await ApiService.getOrderItemsByOrderId( orderId )
        //console.log(resp)
        if (resp.data.status) {
          let tempTotalAmount = 0.0
          const orderItems = resp.data.response.data
          //console.log(orderId, orderItems.length)
          orderItems.forEach(item => {
            tempTotalAmount += parseFloat(item.quantity * item.price)
          })
          setTotalAmount (tempTotalAmount)
          setOrderItems(orderItems)
        }
      }
      catch (e) {
        console.log(e)
      }
      finally {
        //setIsLoading(false)
        setOpenLoading(false)
      }
    }
    //console.log(item)
    if (!_.isEmpty(item))
      loadOrderItems(item.orderid)        
    //console.log(item)

  },[item]) 
  
  if (_.isEmpty(orderItems) || _.isEmpty(item) || openLoading) return ""

  return (
    <>
     <Popup open={open} setOpen={setOpen} width={width}>
        <div style={{ display: 'flex' }}>
            <Typography variant="h6" component="div" className={classes.orderDetailHeader}>
              Order Detail
            </Typography>
        </div>       

       <div className="row">
         <div className={`col-3 ${classes.orderLabel}`}>Order No : </div> 
         <div className={`col-9 ${classes.orderHeader}`}>#{Util.zeroPad(item.orderid, 5)}</div> 
         <div className={`col-3 ${classes.orderLabel}`}>Customer : </div> 
         <div className={`col-9 ${classes.orderHeader}`}>{item.clientname}</div> 
         <div className={`col-3 ${classes.orderLabel}`}>Date : </div> 
         <div className={`col-9 ${classes.orderHeader}`}>{Util.truncateTime(item.orderdate)}</div> 
       </div>
       <div style={{fontSize: '8px'}}>{Util.dupString('.', 120)}</div>

       <div className={classes.orderStatusLabel}>Status</div> 
       <div className={classes.orderStatusValue}>{item.statusname}</div> 

       <div className="mt-4">
       <table width='98%'>
         <thead>
           <tr style={{backgroundColor: colors.palePink}}>
             <td style={{paddingLeft: '15px', width: '60%', ...commonStyles.orderItemHeader}}>PRODUCT</td>
             <td style={{width: '20%', ...commonStyles.orderItemHeader}}>QUANTITY</td>
             <td style={{width: '20%', textAlign: 'right', ...commonStyles.orderItemHeader}}>PRICE</td>
           </tr>
         </thead>
         <tbody>
         {  orderItems.map ((item, index) => (
            <tr key={index.toString()} style={{padding: '5px'}}>
              <td style={{width: '60%', paddingLeft: '15px', paddingTop: '.5rem'}}>
                <span className="mr-3">
                  <img src={ AppConfig.K_IMAGE_DIR + `${item.image}`} width="50px"/>
                </span>
                <span className={classes.orderItemDetail}>{item['productname']}</span>
              </td>
              <td style={{width: '20%', textAlign: 'center', paddingTop: '.5rem'}} className={classes.orderItemDetail}>{item['quantity']}</td>
              <td style={{width: '20%', textAlign: 'right', paddingTop: '.5rem'}} className={classes.orderItemDetail}>{Util.formatNumber(item['amount'])}</td>
            </tr>
          ))}           

         </tbody>
       </table>
       </div>

       <div className={`mr-3 ${classes.rightJustifyContainer}`}>
         <div className={classes.orderSummaryContainer}>
           <div className="row">
             <div className={`col-7 ${classes.subTotal}`}>Subtotal</div>
             <div className={`col-5 ${classes.subTotal}`}>{Util.formatNumber(totalAmount)}</div>
           </div>
           <div className="row">
             <div style={{fontSize: '8px'}}>{Util.dupString('.', 70)}</div>
           </div>
           <div className="row">
           <div className={`col-7 ${classes.total}`}>Total</div>
             <div className={`col-5 ${classes.total}`}>{Util.formatNumber(totalAmount)}</div>
           </div>           
         </div>
       </div>
       <div className={`mb-2 mr-5 ${classes.rightJustifyContainer}`}>
         <button onClick={() => setOpen(false)} name="cancel" className={`mr-2 ${classes.pillButtonPale}`} style={{width: '100px'}}>Close</button>
       </div>       
     </Popup>
     
     </>
  )  
}

export default OrderDlg


