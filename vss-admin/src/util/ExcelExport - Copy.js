import * as excelJS from "exceljs";
import { saveAs } from "file-saver";
import Constants from './Constants'
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
  for (let i=4; i<=14; i++)
    sheet.getColumn(i).numFmt = '###,##0.00'

  let rowIndex = 1
  let seq = 0;
  //  Header
  sheet.getRow(rowIndex).values = columnHeader
  const hrow = sheet.getRow(rowIndex);
  hrow.eachCell({includeEmpty: true}, (cell => {
    cell.alignment = { vertical: 'middle', horizontal: 'center', wrapText: true };
    cell.font = { bold: true}
  }));

  //sheet.getRows(1).getCell(0).cellFormat().alignment({horizontal: 'center'})
  //sheet.getRows(1).getCell(1).cellFormat().alignment({horizontal: 'center'}).font().bold(true)

  //  Detail
  list.forEach(item => {
    rowIndex++;
    seq++;
    let info = []
    info.push(seq)
    info.push(item.accountid)
    info.push(Util.concatName(item))
    info.push(item.salary)
    item.deductionItems.forEach(elem => info.push(+elem.amount))
    info.push(+item.totalDeduction)
    info.push(+item.amountToPay)
    sheet.getRow(rowIndex).values = info
  })



}

const run = (list, payrollDate) => {
  const fileName = "vss-payroll-" + payrollDate.getFullYear() + "-" + Util.zeroPad((payrollDate.getMonth() + 1), 2) + ".xlsx"
  //console.log(fileName)
  const teacherList = list.filter(item => +item.employeetypeid === +Constants.K_TEACHER_TYPE_ID ? item : null)
  const staffList   = list.filter(item => +item.employeetypeid === +Constants.K_STAFF_TYPE_ID ? item : null)

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
