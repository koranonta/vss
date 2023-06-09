import React, { useState } from 'react';
import * as AiIcons from 'react-icons/ai';
import Popup from '../../components/Popup';
import PageHeader from '../../components/PageHeader'
import ProductInput from './ProductInput';
import Util from '../../util/Util';
import UserDlg from './UserDlg';
import ProductDlg from './ProductDlg';

const UiTesting = () => {
  const [openDlg, setOpenDlg] = useState(false)
  const [openUserDlg, setOpenUserDlg] = useState(false)
  const [product, setProduct] = useState()
  const [user, setUser] = useState()
  const [mode, setMode] = useState("Add")

  const [item, ] = useState (
{
  categoryid: 1,
  categoryname: "Macaron",
  description: "Desc----------*",
  image: "4AE9B9A0-3B77-4FD4-888E-16E8FC146FE5.jpeg",
  price: 1850,
  productid: 2,
  title: "Macarons",
  unit: "40 pieces",
}    
  )

  const categories = [
    {categoryid: 1, categoryname: 'Macaron'},
    {categoryid: 2, categoryname: 'Cake'},
    {categoryid: 3, categoryname: 'Tea'},
  ]  


  const productHandler = (value) => {
    console.log("in Product Handler", value)
  }

  return (
    <>
    <PageHeader 
         title="UI Testing"
       icon={<AiIcons.AiFillSetting />}
      />
    <div className="container px-1">
        UI Testing
        <br/>
        <br/>

     <button type="button" onClick={() => {setOpenDlg(true)}} className="ml-2 btn btn-secondary" >Product Dlg</button>     
     <button type="button" onClick={() => setOpenUserDlg(true)} className="ml-2 btn btn-secondary" >User Dlg</button>     


     </div>

     <ProductDlg 
       item={item}
       categories={categories}
       mode={"Add"}
       width={'500px'}
       open={openDlg}
       setOpen={setOpenDlg}
       actionHandler={productHandler}
     />

     <Popup title={`${Util.capitalize(mode)} user`}
            open={openUserDlg} 
            setOpen={setOpenUserDlg}>
            <UserDlg 
              setOpenDlg = {setOpenUserDlg}
              item={product}
            />             
     </Popup> 


    </>
  );
}

export default UiTesting;


/*

     <Popup title={`${Util.capitalize(mode)} product`}
            open={openDlg}
            setOpen={setOpenDlg}>
            <ProductDlg 
              setOpenDlg = {setOpenDlg}
              item={product}
            />             
     </Popup> 



     <Popup title={`${Util.capitalize(mode)} product`}
            open={openDlg}
            setOpen={setOpenDlg}>

      <ProductInput 
            item = {"item"}
            setOpen={setOpenDlg}
            actionHandler={productHandler} />

     </Popup> 





*/