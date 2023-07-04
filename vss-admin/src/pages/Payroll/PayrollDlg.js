import React, {useState, useEffect } from 'react'
import _ from 'lodash'
import { Typography } from '@material-ui/core';
import Util from '../../util/Util';
import AppStyles from '../../theme/AppStyles'
import Popup from '../../components/Popup'
import AppConfig from '../../config/AppConfig'
import { images } from '../../util/Images'
import { commonStyles } from '../../theme/CommonStyles';

const PayrollDlg = (props) => {
  const {item, mode, open, setOpen, width, actionHandler } = props
  const [buf, setBuf] = useState({})
  const [input, setInput] = useState('');
  const [totalDeduction, setTotalDeduction] = useState(0.0)
  const [amountToPay, setAmountToPay] = useState(0.0)

  const classes = AppStyles()

  useEffect(() => {        
    if (!_.isEmpty(item)) {
console.log(item)

      let deductItems = {}
      let tempDeduction = 0.0
      console.log(item.deductionItems)
      item.deductionItems.forEach(elem => {
        deductItems = {...deductItems, 
          [elem.propertytypename.replaceAll(' ', '_')]: elem.amount}
        tempDeduction += +elem.amount
        //console.log(+elem.amount)
      })
      //console.log(item.salary, tempDeduction)
      //console.log(deductItems)
      setBuf(deductItems)
      setTotalDeduction(tempDeduction)
      setAmountToPay(item.salary - tempDeduction)      

      //console.log(buf)
    }
  },[item])

  const onOk = (e) => {
    e.preventDefault()
    const res = {...buf, totalDeduction, amountToPay}
    const map = new Map()
    Object.entries(buf).forEach(([key, value]) => map.set(key, value))
    map.set('totalDeduction', totalDeduction)
    map.set('amountToPay', amountToPay)
    //console.log(map)
    actionHandler(mode, res)
    setOpen(false)
  }
  
  const onCancel = (e) => {  
    e.preventDefault()
    setOpen(false)  
  }  

  const handleChange = (e) => {
    let inpVal = e.target.value.replace(",", "")
    setInput(inpVal)
    buf[e.target.name] = parseFloat(inpVal)
    let tempDeduction = 0;
    Object.entries(buf).forEach( 
      ([key, value]) => {
        //console.log(key, value)
        //console.log(value)
        if (!isNaN(value)) {
          tempDeduction += +value
        }
      }
    )
    setTotalDeduction(tempDeduction)
    setAmountToPay(item.salary - tempDeduction) 
    //console.log(totalDeduction)
    //console.log(amountToPay)
  }

  if (item === undefined || buf === {})return ""

  return (
     <Popup open={open} setOpen={setOpen}>
       <div style={{width}}>
         
           <Typography variant="h6" component="div" className={classes.orderDetailHeader}>
              Payroll
           </Typography>

           <div className={`row mt-2 ml-5` }>
             <table>
               <tbody>
                 <tr><td style={{width:'50%', textAlign: 'right'}}>ชื่อ นามสกุล : &nbsp;</td><td>{Util.concatName(item)}</td></tr>
                 <tr><td style={{width:'50%', textAlign: 'right'}}>เลขบัญชีธนาคาร : &nbsp;</td><td>{item.accountid}</td></tr>
                 <tr><td style={{width:'50%', textAlign: 'right'}}>เงินเดือน : &nbsp;</td><td>{Util.formatNumber(item.salary)}</td></tr>
               </tbody>
             </table>
           </div>

           <div style={{marginLeft: '20px', marginTop: '20px'}}>
           <form>           
             <table>        
               <tbody>
               {item.deductionItems.map((elem, index) => {
                  let fieldName = elem.propertytypename.replaceAll(' ', '_')
                  //let amtValue = Util.formatNumber(buf[`${fieldName}`])
                  let amtValue = buf[`${fieldName}`]
                  //totalDeduction += elem.amount
                  //amountToPay = item.salary - totalDeduction
                  return (
                   <tr key={index}>
                     <td style={{width:'50%', textAlign: 'right'}}>
                       <label htmlFor={fieldName} style={{...commonStyles.inputLabel}}>{elem.propertytypethainame} :</label>
                     </td>               
                     <td>                 
                       <input type="number" 
                         style={{textAlign: 'right'}}
                         value={ amtValue || ""}
                         //disabled={elem.calculationrule !== null}
                         onChange={handleChange} 
                         autoComplete="off"
                         name={fieldName}
                         id={fieldName}/>
                     </td>
                   </tr>)
                })}
                <tr key={1000}>
                  <td style={{width:'50%', textAlign: 'right'}}><label style={{...commonStyles.inputLabel}}>รวมหัก :</label></td>
                  <td style={{textAlign: 'right'}}><label style={{...commonStyles.inputLabel}}>{Util.formatNumber(totalDeduction)}</label></td>
                </tr>
                <tr key={1001}>
                  <td style={{width:'50%', textAlign: 'right'}}><label style={{...commonStyles.inputLabel}}>โอนเข้าบัญชี :</label></td>
                  <td style={{textAlign: 'right'}}><label style={{...commonStyles.inputLabel}}>{Util.formatNumber(amountToPay)}</label></td>
                </tr>
                </tbody> 
            </table>

          <div className={`mt-3 mb-3 ${classes.rightButtonPanel}`}>
            <button onClick={e => onOk(e)} name="submit" className={classes.pillButton} style={{width: '100px'}}>Save</button>
            <button onClick={e => onCancel(e)} name="cancel" className={`mr-2 ${classes.pillButton}`} style={{width: '100px'}}>Cancel</button>

          </div>
      
        </form>    


           </div>
       </div>
     </Popup>
  )  
}

export default PayrollDlg


/*



           
           <div style={{ display: 'flex' }}>           
           <div className={`row mt-2 ml-5` }>
             <div className="col-3" ><label>Name</label></div>
             <div className="col"><label>{item.name}</label></div>
           </div>
           <div className={`row mt-2 ml-5` }>
             <div className="col-3"><label>AccountId</label></div>
             <div className="col"><label>{item.accountId}</label></div>
           </div>
           <div className={`row mt-2 ml-5` }>
             <div className="col-3"><label>Salary</label></div>
             <div className="col"><label>{Util.formatNumber(item.salary)}</label></div>
           </div>

         </div>       

         <form>           
         
          {item.deductItems.map(elem => {
            let fieldName = elem.deductionName.replaceAll(' ', '_')
            totalDeduction += elem.amount
            amountToPay = item.salary - totalDeduction

            return (
              <div className={`row mt-2 ml-5`} style={{ display: 'flex' }}>
                <div className="col-5">
                  <label htmlFor={fieldName} style={{...commonStyles.inputLabel}}>{elem.deductionThaiName} :</label>
                </div>
                <div className={`col  ${classes.underLine}`}>
                  <input type="text" 
                    value={ elem.amount || ""}
                    disabled={elem.value !== null}
                    onChange={handleChange} 
                    required 
                    className={`form-control ${classes.inputText} textAlign="right"`} 
                    name={fieldName}
                    id={fieldName}/>
                </div>
              </div>
            )
          })}

              <div className={`row mt-2 ml-5`} style={{ display: 'flex' }}>
                <div className="col-5">
                  <label style={{...commonStyles.inputLabel}}>รวมหัก :</label>
                </div>
                <div className="col">
                  <label style={{...commonStyles.inputLabel}}>{Util.formatNumber(totalDeduction)}</label>
                </div>
              </div>

              <div className={`row mt-2 ml-5`} style={{ display: 'flex' }}>
                <div className="col-5">
                  <label style={{...commonStyles.inputLabel}}>โอนเข้าบัญชี :</label>
                </div>
                <div className="col">
                  <label style={{...commonStyles.inputLabel}}>{Util.formatNumber(amountToPay)}</label>
                </div>
              </div>


           <div className={`mt-3 mb-3 ${classes.rightButtonPanel}`}>
             <button onClick={e => onCancel(e)} name="cancel" className={`mr-2 ${classes.pillButtonPale}`} style={{width: '100px'}}>Close</button>
             <button onClick={e => onOk(e)} name="submit" className={classes.pillButton} style={{width: '100px'}}>Save</button>
           </div>
       
         </form>    
       </div>
*/