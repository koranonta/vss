import _ from "lodash";
import * as excelJS from "exceljs";
import { saveAs } from "file-saver";
import Constants from './Constants'
import Util from "./Util"
import ReportConstants from "./ReportConstants";


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
    pageSetup: ReportConstants.K_PAGE_SETUP,
    style: ReportConstants.K_SHEET_STYLE
  }
  
/*    
    {
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
      font: { size:16, name: 'Angsana New' }
    }
  }
*/  
  )  
  return sheet
}

const getColumnHeader = (emp) => {
  const columnHeader = []
  ReportConstants.K_COMMON_HEADER.forEach(item => columnHeader.push(item))
  emp.deductionItems.forEach(item => columnHeader.push(item.propertytypethainame))
  ReportConstants.K_COMMON_TRAILER.forEach(item => columnHeader.push(item))    
  return columnHeader
}

const addMergeLine = (sheet, rowIndex, startCol, endCol, info, alignment, font) => {
  sheet.mergeCells(rowIndex, startCol, rowIndex, endCol)
  sheet.getRow(rowIndex).getCell(startCol).value = info
  const srow = sheet.getRow(rowIndex);
  srow.eachCell({includeEmpty: true}, (cell => {
    cell.alignment = alignment;
    cell.font = font    
  }));
}

const addHeader = (sheet, rowIndex, title) => {
  addMergeLine(sheet, rowIndex++, 1, 15, "หลักฐานการจ่ายเงินเดือนผ่านระบบธนาคาร", ReportConstants.K_ALIGN_VM_HC, ReportConstants.K_THAI_BOLD_FONT)
  addMergeLine(sheet, rowIndex++, 1, 15, "โรงเรียนวีรนาทศึกษามูลนิธิ อำเภอเมือง จังหวัดพัทลุง", ReportConstants.K_ALIGN_VM_HC, ReportConstants.K_THAI_BOLD_FONT)
  addMergeLine(sheet, rowIndex++, 1, 15, title, ReportConstants.K_ALIGN_VM_HC, ReportConstants.K_THAI_BOLD_FONT)
  return rowIndex
}

const addFooter = (sheet, rowIndex) => {
  ReportConstants.K_FOOTER.forEach(item => {
    addMergeLine(sheet, rowIndex++, 2, 15, item, ReportConstants.K_ALIGN_VM_HL, ReportConstants.K_THAI_NORMAL_FONT)  
  })
  return rowIndex
}

const addColumnHeader = (sheet, columnHeader, rowIndex, alignment, font) => {  
  sheet.getRow(rowIndex).values = columnHeader
  let srow = sheet.getRow(rowIndex);
  srow.eachCell({includeEmpty: true}, ((cell, cellIndex) => {
    cell.alignment = alignment;
    cell.font = font;
    cell.border = ReportConstants.K_THIN_BORDER_STYLE;
  }));  
  return rowIndex
}

const addSheet = (workbook, sheetName, list, title) => {
  let sheet = getSheet(workbook, sheetName)
  const numCols = sheetName === "ครูบรรจุ" ? 11 : 7
  for (let i=0; i<numCols; i++) {
    sheet.getColumn(i + ReportConstants.K_START_NUMERIC_COL).numFmt = '###,##0.00'  
    //let cellWidth = cellSizeMap.get(i+1) 
    //console.log(cellWidth)
    //if (!_.isEmpty(cellWidth)) {
    //  sheet.getColumn(i + 1).width = 20
    //  console.log(i, cellWidth)
    //}  
  }
  const columnHeader = getColumnHeader(list[0])
  let rowIndex = 1
  rowIndex = addHeader (sheet, rowIndex, title)
  rowIndex = addColumnHeader(sheet, columnHeader, rowIndex, ReportConstants.K_ALIGN_VM_HC, ReportConstants.K_THAI_BOLD_FONT)
  let seq = 0;
  let itemOnPage = 0
  //  Detail
  list.forEach(item => {
    rowIndex++;
    seq++;
    itemOnPage++;
    let info = []
    info.push(seq)
    info.push(item.accountid)
    info.push(Util.concatName(item))
    info.push(item.salary)
    item.deductionItems.forEach(elem => info.push(+elem.amount))
    info.push(+item.totalDeduction)
    info.push(+item.amountToPay)
    info.push("")
    sheet.getRow(rowIndex).values = info
    let srow = sheet.getRow(rowIndex);
    srow.eachCell({includeEmpty: true}, (cell => {
      cell.font = { size: 12, name: 'Angsana New' };
      cell.border = ReportConstants.K_THIN_BORDER_STYLE;      
    }));    
    if ((itemOnPage % ReportConstants.K_NUM_ROWS_PER_PAGE) === 0) {
      rowIndex += 2
      rowIndex = addFooter(sheet, rowIndex)
      rowIndex++;
      rowIndex = addHeader (sheet, rowIndex, title)
      rowIndex = addColumnHeader(sheet, columnHeader, rowIndex, ReportConstants.K_ALIGN_VM_HC, ReportConstants.K_THAI_BOLD_FONT)      
    } 
  })
  rowIndex += 2
  rowIndex = addFooter(sheet, rowIndex)
}

const run = (list, payrollDate) => {
  const fileName = "vss-payroll-" + payrollDate.getFullYear() + "-" + Util.zeroPad((payrollDate.getMonth() + 1), 2) + ".xlsx"
  const title = "ประจำเดือน" + Util.thaimonths[payrollDate.getMonth()] + "    พ.ศ." + Util.toThaiYear(payrollDate.getFullYear())
  const teacherList = list.filter(item => +item.employeetypeid === +Constants.K_TEACHER_TYPE_ID ? item : null)
  const staffList   = list.filter(item => +item.employeetypeid === +Constants.K_STAFF_TYPE_ID ? item : null)

  const workbook = createWorkBook()
  addSheet (workbook, "ครูบรรจุ", teacherList, title)
  addSheet (workbook, "ลูกจ้าง", staffList, title)

  workbook.xlsx.writeBuffer().then( buffer => {
    const blob = new Blob([buffer], { type: "applicationi/xlsx" });
    saveAs(blob, fileName);  
  })
}

const ExcelExport = {
  run,
}

export default ExcelExport
