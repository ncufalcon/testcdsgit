﻿using System;
using System.Web;
using System.Data;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;

public partial class webpage_page_Allowance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //protected DataTable readExcel(Stream ExcelFileStream, int SheetIndex, int HeaderRowIndex, int Xcount)
    //{
    //    IWorkbook wb;

    //    //office 2010 / 2003 判斷
    //    if (file_upload.FileName.Contains(".xlsx") || file_upload.FileName.Contains(".XLSX"))
    //        wb = new XSSFWorkbook(ExcelFileStream);
    //    else
    //        wb = new HSSFWorkbook(ExcelFileStream);

    //    ISheet sheet = wb.GetSheetAt(SheetIndex);
    //    DataTable table = new DataTable();
    //    //由第一列取標題做為欄位名稱
    //    IRow headerRow = sheet.GetRow(HeaderRowIndex);
    //    int cellCount = Xcount;

    //    for (int i = 0; i < cellCount; i++)
    //    {
    //        if (headerRow.GetCell(i) != null)
    //            table.Columns.Add(new DataColumn(headerRow.GetCell(i).ToString().Trim()));
    //        else
    //            table.Columns.Add(new DataColumn(""));
    //    }

    //    //略過第零列(標題列)，一直處理至最後一列
    //    for (int i = (HeaderRowIndex + 1); i <= sheet.LastRowNum; i++)
    //    {
    //        IRow row = sheet.GetRow(i);
    //        DataRow dataRow = table.NewRow();
    //        if (row == null)
    //        {
    //            table.Rows.Add(dataRow);
    //            continue;
    //        }
    //        //依先前取得的欄位數逐一設定欄位內容
    //        for (int j = 0; j < cellCount; j++)
    //            if (row.GetCell(j) != null)
    //            //如要針對不同型別做個別處理，可善用.CellType判斷型別
    //            //再用.StringCellValue, .DateCellValue, .NumericCellValue...取值
    //            {
    //                if (row.GetCell(j).CellType == CellType.Formula)
    //                {
    //                    IFormulaEvaluator iFormula = WorkbookFactory.CreateFormulaEvaluator(wb);
    //                    var formulaType = iFormula.Evaluate(row.GetCell(j)).CellType;
    //                    //結果類型為數值(日期結果會被轉為數值)
    //                    if (formulaType == CellType.Numeric)
    //                    {
    //                        ICell cell = iFormula.EvaluateInCell((row.GetCell(j)));
    //                        // 判斷是否日期
    //                        if (DateUtil.IsCellDateFormatted(cell))
    //                            dataRow[j] = row.GetCell(j).DateCellValue;
    //                        else
    //                            dataRow[j] = Math.Round(row.GetCell(j).NumericCellValue, 4, MidpointRounding.AwayFromZero);
    //                    }
    //                    //字串公式
    //                    else if (formulaType == CellType.String)
    //                        dataRow[j] = row.GetCell(j).StringCellValue.Replace("&nbsp;", "");
    //                    else
    //                        dataRow[j] = row.GetCell(j).ToString().Replace("&nbsp;", "");
    //                }
    //                else
    //                    dataRow[j] = row.GetCell(j).ToString().Trim().Replace("&nbsp;", "");
    //            }
    //        table.Rows.Add(dataRow);
    //    }
    //    //ExcelFileStream.Close();
    //    wb = null;
    //    sheet = null;
    //    return table;
    //}

    //protected void btnb_Click(object sender, EventArgs e)
    //{
    //    Stream oriexcel = file_upload.FileContent;
    //    //oriexcel.Position = 0;

    //    DataTable dt_excel = readExcel(oriexcel, 0, 0, 20);
    //}
}