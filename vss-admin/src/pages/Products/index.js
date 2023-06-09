import React, { useState, useEffect } from 'react';
import ApiService from '../../services/ApiService'
import PageLoading from '../../components/PageLoading'
import ProductList from './ProductList';

const Products = () => {
  const [isLoading, setIsLoading] = useState(true)
  const [loadingMessage, setLoadingMessage] = useState()
  const [products, setProducts] = useState([])
  const [categories, setCategories] = useState([])
  const [itemsPerPage, setItemsPerPage] = useState(10)

  useEffect(() => {
    const loadProducts = async () => {
      setIsLoading(true)
      try {
        setLoadingMessage("Loading products...")
        const resp = await ApiService.getProducts()
        if (resp.data.status)
          setProducts(resp.data.response.data)
        const resp1 = await ApiService.getCategories()
        if (resp1.data.status) {          
          setCategories(resp1.data.response.data.map(
            item => ({title: item.categoryname, id: +item.categoryid} )))
        }
      } catch (e) {
        setProducts([])
        setCategories([])
        console.log(e)
      } finally {
        setIsLoading(false)
      }
    }

    loadProducts()
  },[])

  if (isLoading) return <PageLoading title={ loadingMessage }/>    

  return (
      <div className="container px-1">
        <ProductList
          data={products} 
          categories={categories}
          itemsPerPage={itemsPerPage} 
          setItemsPerPage={setItemsPerPage}
        />
      </div>
  );
}

export default Products;
