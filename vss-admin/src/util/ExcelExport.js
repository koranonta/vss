import { ShareTwoTone } from "@material-ui/icons";
import * as excelJS from "exceljs";
import { saveAs } from "file-saver";
import Constants from './Constants'
import Util from "./Util"

const K_COMMON_HEADER = ['ลำดับ', 'บัญชีเงินฝากเลขที่', 'ชื่อ- สกุล', 'เงินเดือน']
const K_COMMON_TRAILER = ['รวมหัก', 'โอนเข้าบัญชี', 'หมายเหตุ']

const K_ALIGN_VM_HC      = { vertical: 'middle', horizontal: 'center', wrapText: true }
const K_ALIGN_VM_HL      = { vertical: 'middle', horizontal: 'left', wrapText: true }
const K_THAI_BOLD_FONT   = { bold: true, size: 12, name: 'Angsana New' }  
const K_THAI_NORMAL_FONT = { size: 12, name: 'Angsana New' }  
const K_START_NUMERIC_COL = 4
const K_NUM_ROWS_PER_PAGE = 20

const K_FOOTER = [
  "   ลงชื่อ ............................................................................ผู้ลงนามแทนผู้รับใบอนุญาต",
  "   ลงชื่อ ............................................................................ผู้อำนวยการ",
  "   ลงชื่อ ............................................................................ผู้จัดการ",
  "   ลงชื่อ ............................................................................ผู้ทำบัญชี"
]

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

const getColumnHeader = (emp) => {
  const columnHeader = []
  K_COMMON_HEADER.forEach(item => columnHeader.push(item))
  emp.deductionItems.forEach(item => columnHeader.push(item.propertytypethainame))
  K_COMMON_TRAILER.forEach(item => columnHeader.push(item))    
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

const addHeader = (sheet, rowIndex) => {
  addMergeLine(sheet, rowIndex++, 1, 15, "หลักฐานการจ่ายเงินเดือนผ่านระบบธนาคาร", K_ALIGN_VM_HC, K_THAI_BOLD_FONT)
  addMergeLine(sheet, rowIndex++, 1, 15, "โรงเรียนวีรนาทศึกษามูลนิธิ อำเภอเมือง จังหวัดพัทลุง", K_ALIGN_VM_HC, K_THAI_BOLD_FONT)
  addMergeLine(sheet, rowIndex++, 1, 15, "ประจำเดือนพฤษภาคม  พ.ศ.2566", K_ALIGN_VM_HC, K_THAI_BOLD_FONT)
  return rowIndex
}

const addFooter = (sheet, rowIndex) => {
  K_FOOTER.forEach(item => {
    addMergeLine(sheet, rowIndex++, 2, 15, item, K_ALIGN_VM_HL, K_THAI_NORMAL_FONT)  
  })
  return rowIndex
}

const addColumnHeader = (sheet, columnHeader, rowIndex, alignment, font) => {
  sheet.getRow(rowIndex).values = columnHeader
  let srow = sheet.getRow(rowIndex);
  //srow.eachCell({includeEmpty: true}, (cell => {
  //  cell.alignment = alignment;
  //  cell.font = font    
  //}));  
}

const addSheet = (workbook, sheetName, list) => {
  let sheet = getSheet(workbook, sheetName)
  const numCols = sheetName === "ครูบรรจุ" ? 11 : 7
  for (let i=0; i<numCols; i++)
    sheet.getColumn(i + K_START_NUMERIC_COL).numFmt = '###,##0.00'  
  const columnHeader = getColumnHeader(list[0])
  let rowIndex = addHeader (sheet, 1)
  console.log (rowIndex)
  rowIndex = addColumnHeader(sheet, columnHeader, rowIndex, K_ALIGN_VM_HC, K_THAI_BOLD_FONT)
/*
  sheet.getRow(rowIndex).values = columnHeader
  let srow = sheet.getRow(rowIndex);
  srow.eachCell({includeEmpty: true}, (cell => {
    cell.alignment = K_ALIGN_VM_HC;
    cell.font = K_THAI_BOLD_FONT    
  }));  
*/
  let seq = 0;

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

    let srow = sheet.getRow(rowIndex);
    srow.eachCell({includeEmpty: true}, (cell => {
      cell.font = { size: 12, name: 'Angsana New' }      
    }));    
  })
  rowIndex += 2
  rowIndex = addFooter(sheet, rowIndex)

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
