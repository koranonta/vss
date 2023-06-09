import { Streetview } from "@material-ui/icons";
import * as excelJS from "exceljs";
//import { saveAs } from "file-saver";

const ExcelExport = ({list, fileName}) => {
  const workbook = new excelJS.Workbook();
  workbook.creator = "test";
  workbook.lastModifiedBy = "test";
  workbook.created = new Date();
  workbook.modified = new Date();
  
  let sheet = workbook.addWorksheet("sheet1");



  console.log(list)

}

export default ExportExcel