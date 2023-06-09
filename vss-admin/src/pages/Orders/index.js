import React, { useState, useEffect } from 'react';
import ApiService from '../../services/ApiService'
import PageLoading from '../../components/PageLoading'
import OrderList from './OrderList';

const Orders = () => {
  const [isLoading, setIsLoading] = useState(true)
  const [loadingMessage, setLoadingMessage] = useState()
  const [orders, setOrders] = useState([])
  const [statusOptions, setStatusOptions] = useState([])
  const [itemsPerPage, setItemsPerPage] = useState(10)

  useEffect(() => {
    const loadOrders = async () => {
      setIsLoading(true)
      try {
        setLoadingMessage("Loading orders...")
        const resp = await ApiService.getOrders()
        if (resp.data.status) {
          setOrders(resp.data.response.data)
        }

        setLoadingMessage("Loading order status...")
        const resp1 = await ApiService.getOrderStatus()
        if (resp1.data.status) {
          const statusList = []          
          resp1.data.response.data.forEach((item) => 
            statusList.push({ title: item.statusname, id: +item.statusid}))
          setStatusOptions(statusList)
        }        
      } catch (e) {
        setOrders([])
        console.log(e)
      } finally {
        setIsLoading(false)
      }
    }
    loadOrders()
  },[])

  if (isLoading) return <PageLoading title={ loadingMessage }/>    

  return (
      <OrderList
          data={orders} 
          statusOptions={statusOptions}
          itemsPerPage={itemsPerPage} 
          setItemsPerPage={setItemsPerPage}
        />
  );
}

export default Orders;

