import * as excelJS from "exceljs";
import { saveAs } from "file-saver";
import AppConfig from '../config/AppConfig'
import Util from "./Util"

const commonHeader = ['ลำดับ', 'บัญชีเงินฝากเลขที่', 'ชื่อ- สกุล', 'เงินเดือน']
const commonTrailer = ['รวมหัก', 'โอนเข้าบัญชี', 'หมายเหตุ']

const createWorkBook = () => {
  const workbook = new excelJS.Workbook();
  workbook.creator = "vss-payroll-system"
  workbook.lastModifiedBy = "vss-payroll-system"
  workbook.created = new Date()
  workbook.modified = new Date()
  return workbook
}

const addSheet = (workbook, sheetName, list) => {
  const columnHeader = []
  const emp = list[0]
  commonHeader.forEach(item => columnHeader.push(item))
  const deductionItems = emp.deductionItems.forEach(
    item => columnHeader.push(item.propertytypethainame))    
  commonTrailer.forEach(item => columnHeader.push(item))
  //console.log(columnHeader)

  let sheet = workbook.addWorksheet(sheetName)
  let rowIndex = 1
  let seq = 0;
  sheet.getRow(rowIndex).values = columnHeader
  list.forEach(item => {
    rowIndex++;
    seq++;
    let info = []
    info.push(seq)
    info.push(item.accountid)
    info.push(Util.concatName(item))
    info.push(item.salary)
    item.deductionItems.forEach(elem => {
      console.log(elem.amount)
      info.push(elem.amount)
    })
    info.push(item.totalDeduction)
    info.push(item.amountToPay)
    sheet.getRow(rowIndex).values = info
    //sheet.getRow(rowIndex).getCell('D' + rowIndex).numFmt = '##,###.00'
    //sheet.getRow(rowIndex).getCell('E').numFmt = '##,###.00'
  })
}

const run = (list, payrollDate) => {
  const fileName = "vss-payroll-" + payrollDate.getFullYear() + "-" + Util.zeroPad((payrollDate.getMonth() + 1), 2) + ".xlsx"
  //console.log(fileName)
  const teacherList = list.filter(item => +item.employeetypeid === +AppConfig.K_TEACHER_TYPE_ID ? item : null)
  const staffList   = list.filter(item => +item.employeetypeid === +AppConfig.K_STAFF_TYPE_ID ? item : null)

  //console.log(teacherList)
  //console.log(staffList)

  const workbook = createWorkBook()
  addSheet (workbook, "ครูบรรจุ", teacherList)
  addSheet (workbook, "ลูกจ้าง", staffList)

  workbook.xlsx.writeBuffer().then( buffer => {
    const blob = new Blob([buffer], { type: "applicationi/xlsx" });
    saveAs(blob, fileName);  
  })
}

const ExcelExport = {
  run,
}

export default ExcelExport
