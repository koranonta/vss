const K_COMMON_HEADER = ['ลำดับ', 'บัญชีเงินฝากเลขที่', 'ชื่อ- สกุล', 'เงินเดือน']
const K_COMMON_TRAILER = ['รวมหัก', 'โอนเข้าบัญชี', 'หมายเหตุ']

const K_ALIGN_VM_HC      = { vertical: 'middle', horizontal: 'center', wrapText: true }
const K_ALIGN_VM_HL      = { vertical: 'middle', horizontal: 'left', wrapText: true }
const K_THAI_BOLD_FONT   = { bold: true, size: 12, name: 'Angsana New' }  
const K_THAI_NORMAL_FONT = { size: 12, name: 'Angsana New' }  
const K_THIN_BORDER_STYLE     = {
  top: {style:'thin'},
  left: {style:'thin'},
  bottom: {style:'thin'},
  right: {style:'thin'}}

const K_START_NUMERIC_COL = 4
const K_NUM_ROWS_PER_PAGE = 20
const K_ROW_HEIGHT = 25
const K_COLUMN_HEADER_ROW_HEIGHT = 62

const K_FOOTER = [
  "   ลงชื่อ ............................................................................ผู้ลงนามแทนผู้รับใบอนุญาต",
  "   ลงชื่อ ............................................................................ผู้อำนวยการ",
  "   ลงชื่อ ............................................................................ผู้จัดการ",
  "   ลงชื่อ ............................................................................ผู้ทำบัญชี"
]

const K_PAGE_SETUP = {
  horizontalCentered: true,
  verticalCentered: true,
  paperSize: 9,
  orientation: 'landscape',
  margins: {
    left: 0.3149606, right: 0.3149606,
    top: 0.3543307, bottom: 0.3543307,
    header: 0.3149606, footer: 0.3149606
  }
}

const K_SHEET_STYLE = { font: { size:16, name: 'Angsana New' } }

const cellSizeMap = new Map()

cellSizeMap.set(1, 10)
cellSizeMap.set(2, 30)
cellSizeMap.set(3, 30)

const ReportConstants = {
  K_COMMON_HEADER,
  K_COMMON_TRAILER,
  K_ALIGN_VM_HC,
  K_ALIGN_VM_HL,
  K_THAI_BOLD_FONT,
  K_THAI_NORMAL_FONT,
  K_THIN_BORDER_STYLE,
  K_START_NUMERIC_COL,
  K_NUM_ROWS_PER_PAGE,
  K_FOOTER,
  cellSizeMap,
  K_PAGE_SETUP,
  K_SHEET_STYLE,
  K_ROW_HEIGHT,
  K_COLUMN_HEADER_ROW_HEIGHT,
}

export default ReportConstants