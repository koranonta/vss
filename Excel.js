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

const getSheet = (workbook, sheetName) => {
  const sheet = workbook.addWorksheet(sheetName, {
    pageSetup: {
      horizontalCentered: true,
      verticalCentered: true,
      paperSize: 9,
      orientation: 'landscape',
      margins: {
        left: 0.3149606, right: 0.3149606,
        top: 0.3543307, bottom: 0.3543307,
        header: 0.3149606, footer: 0.3149606
      }
    },
    style: {
      font: {
        size:16,
        name: 'Angsana New'
      }
    }
  })  
  return sheet
}

const addHeader = (sheet, sheetName) => {
  let rowIndex = 1
  let row = sheet.getRow(rowIndex).values = columnHeader
  worksheet.mergeCells('A1:P1');
  worksheet.mergeCells('A2:P2');
  worksheet.mergeCells('A3:P3');



  const mergeColumn = sheetName === "ครูบรรจุ" ? "" : 7
  const numCols = sheetName === "ครูบรรจุ" ? 11 : 7
  for (let i=0; i<numCols; i++)
    sheet.getColumn(i + 4).numFmt = '###,##0.00'


}

const addSheet = (workbook, sheetName, list) => {
  const columnHeader = []
  const emp = list[0]
  commonHeader.forEach(item => columnHeader.push(item))
  const deductionItems = emp.deductionItems.forEach(
    item => columnHeader.push(item.propertytypethainame))    
  commonTrailer.forEach(item => columnHeader.push(item))
  //console.log(columnHeader)

  let sheet = workbook.addWorksheet(sheetName, {
    pageSetup: {
      horizontalCentered: true,
      verticalCentered: true,
      paperSize: 9,
      orientation: 'landscape',
      margins: {
        left: 0.3149606, right: 0.3149606,
        top: 0.3543307, bottom: 0.3543307,
        header: 0.3149606, footer: 0.3149606
      }
    },
    style: {
      font: {
        size:16,
        name: 'Angsana New'
      }
    }
  })
  const numCols = sheetName === "ครูบรรจุ" ? 11 : 7
  for (let i=0; i<numCols; i++)
    sheet.getColumn(i + 4).numFmt = '###,##0.00'

  let rowIndex = 1
  let seq = 0;
  //  Header
  sheet.getRow(rowIndex).values = columnHeader
  let srow = sheet.getRow(rowIndex);
  srow.eachCell({includeEmpty: true}, (cell => {
    cell.alignment = { vertical: 'middle', horizontal: 'center', wrapText: true };
    cell.font = { size: 12, name: 'Angsana New' }
    
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

    srow = sheet.getRow(rowIndex);
    srow.eachCell({includeEmpty: true}, (cell => {
      cell.font = { size: 12, name: 'Angsana New' }      
    }));    
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
