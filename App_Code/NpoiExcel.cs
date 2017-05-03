using System.Web;
using System.IO;
using System.Data;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.HSSF.Util;
using System.Drawing;
using NPOI.XSSF.UserModel;
/// <summary>
/// NpoiExcel 的摘要描述
/// </summary>
public class NpoiExcel
{
    Common Com = new Common();

    
    /// <summary>
    /// 回傳Cell Number
    /// </summary>
    /// <param name="wk">Npoi Wk</param>
    /// <param name="sh">Npoi sh</param>
    /// <param name="RoomClass"洽談室編號></param>
    /// <param name="UserClass">User or Marker</param>
    /// <param name="RoomNumber">洽談室數量</param>
    /// <returns></returns>
    public int ReturnCellNumber(HSSFSheet sh, string RoomClass, string UserClass, string RoomNumber)
    {
        int CellNumber = 0; //回傳Cell Number
        IRow row = sh.GetRow(1);
        //sh.CreateRow(1);
        //計算Cell位置
        for (int i = 3; i < (int.Parse(RoomNumber) * 2) + 3; i += 2)
        {
            //row.CreateCell(i);
            ICell icell11 = row.GetCell(i);
            string CellValue = icell11.StringCellValue;
            if (CellValue == RoomClass)
            {
                CellNumber = i;
                break;
            }
        }

        //判斷如是User CellNumber + 1
        if (UserClass == "User")
            CellNumber = CellNumber + 1;


        return CellNumber;
    }

    /// <summary>
    /// 回傳Row Number
    /// </summary>
    /// <param name="sh">Npoi sh</param>
    /// <param name="TimeStr">時間</param>
    /// <param name="RowFirst">時間從第幾個row開始</param>
    /// <param name="CellNumber">時間軸在第幾個cell</param>
    /// <returns></returns>
    public int ReturnRowNumber(HSSFSheet sh, string TimeStr, int RowFirst, int CellNumber)
    {
        int RowNumber = 0; //回傳Cell Number


        for (int i = RowFirst; i < 25; i++)
        {
            //sh.CreateRow(i);
            IRow row = sh.GetRow(i);
            //row.CreateCell(CellNumber);
            ICell icell11 = row.GetCell(CellNumber);
            string CellValue = icell11.StringCellValue;
            if (CellValue == TimeStr)
            {
                RowNumber = i;
                break;
            }

        }


        return RowNumber;
    }

    /// <summary>
    /// 16色轉RGB
    /// </summary>
    /// <param name="hex"></param>
    /// <returns></returns>
    public Color HexColor(string hex)
    {
        //將井字號移除
        hex = hex.Replace("#", "");

        byte a = 255;
        byte r = 255;
        byte g = 255;
        byte b = 255;
        int start = 0;

        //處理ARGB字串 
        if (hex.Length == 8)
        {
            a = byte.Parse(hex.Substring(0, 2), System.Globalization.NumberStyles.HexNumber);
            start = 2;
        }

        // 將RGB文字轉成byte
        r = byte.Parse(hex.Substring(start, 2), System.Globalization.NumberStyles.HexNumber);
        g = byte.Parse(hex.Substring(start + 2, 2), System.Globalization.NumberStyles.HexNumber);
        b = byte.Parse(hex.Substring(start + 4, 2), System.Globalization.NumberStyles.HexNumber);

        return Color.FromArgb(a, r, g, b);
    }


    /// <summary>
    /// Color to Short for Npoi調色盤使用
    /// </summary>
    /// <param name="workbook"></param>
    /// <param name="SystemColour"></param>
    /// <returns></returns>
    public short GetXLColour(HSSFWorkbook workbook, System.Drawing.Color SystemColour)
    {
        short s = 0;
        HSSFPalette XlPalette = workbook.GetCustomPalette();
        HSSFColor XlColour = XlPalette.FindColor(SystemColour.R, SystemColour.G, SystemColour.B);
        IColor ICol = XlPalette.FindColor(SystemColour.R, SystemColour.G, SystemColour.B);
        XlColour = XlPalette.FindSimilarColor(SystemColour.R, SystemColour.G, SystemColour.B);
        s = XlColour.Indexed;
        //if (XlColour == null)
        //{
        //    if (NPOI.HSSF.Record.PaletteRecord.STANDARD_PALETTE_SIZE < 255)
        //    {
        //        if (NPOI.HSSF.Record.PaletteRecord.STANDARD_PALETTE_SIZE < 64)
        //        {
        //            //NPOI.HSSF.Record.PaletteRecord.STANDARD_PALETTE_SIZE = 64;
        //            //NPOI.HSSF.Record.PaletteRecord.STANDARD_PALETTE_SIZE += 1;
        //            //XlColour = XlPalette.AddColor(SystemColour.R, SystemColour.G, SystemColour.B);
        //            XlColour = XlPalette.FindSimilarColor(SystemColour.R, SystemColour.G, SystemColour.B);
        //            s = XlColour.Indexed;
        //        }
        //    }

        //}
        //else
        //{
        //    s = XlColour.Indexed;
        //}

        return s;
        //内置的INDEX有8~64，貌似addColor也是对这8~64赋值罢了,当都不为空的时候,就会抛出 Could not find free color index...
        //'Available colour palette entries: 65 to 32766 (0-64=standard palette; 64=auto, 32767=unspecified) 
    }



    /// <summary>
    /// 畫excel格線
    /// </summary>
    /// <param name="wk"></param>
    /// <param name="sh"></param>
    /// <param name="RowFirst"></param>
    /// <param name="RowLast"></param>
    /// <param name="CellFirst"></param>
    /// <param name="CellLast"></param>
    public void ExcelLine(HSSFWorkbook wk, HSSFSheet sh, int RowFirst, int RowLast, int CellFirst, int CellLast)
    {
        for (int i = CellFirst; i < CellLast; i++)
        {

            for (int j = RowFirst; j < RowLast; j++)
            {
                //sh.CreateRow(j);
                IRow row = sh.GetRow(j);
                //row.CreateCell(i);
                ICell icell11 = row.GetCell(i);
                HSSFCellStyle cellStyle = (HSSFCellStyle)wk.CreateCellStyle();
                cellStyle.Alignment = NPOI.SS.UserModel.HorizontalAlignment.Center;//儲存格置中對齊
                cellStyle.BorderLeft = NPOI.SS.UserModel.BorderStyle.Thin; //設定左框線
                cellStyle.BorderRight = NPOI.SS.UserModel.BorderStyle.Thin;//設定又框線
                cellStyle.BorderTop = NPOI.SS.UserModel.BorderStyle.Thin;//設定上框線
                cellStyle.BorderBottom = NPOI.SS.UserModel.BorderStyle.Thin;//設定下框線
                //cellStyle.WrapText = true;
                icell11.CellStyle = cellStyle;
            }
        }

    }












    /// <summary>
    /// 將DataTable 轉excel
    /// </summary>
    /// <param name="dt"></param>
    /// <param name="SeetName"></param>
    public void NpoiDTExport(DataTable dt, string FileName)
    {
        //NopiExport Ne = new NopiExport();
        //記憶體中創建一個空的Excel檔

        ////建立Excel 2003檔案
        //IWorkbook wb = new HSSFWorkbook();
        //ISheet ws;

        //////建立Excel 2007檔案
        //IWorkbook wb = new XSSFWorkbook();
        //ISheet ws;

        HSSFWorkbook wk = new HSSFWorkbook();



        HSSFSheet sh = (HSSFSheet)wk.CreateSheet(FileName);//在Excel檔上通過對HSSFSheet創建一個工作表           
        IRow headerRow = sh.CreateRow(0);//工作表上添加一行        


        //dt 表頭
        foreach (DataColumn column in dt.Columns)
        {
            //headerRow.CreateCell(column.Ordinal).SetCellValue(column.ColumnName);
            headerRow.Height = 10 * 50;
            ICell cell = headerRow.CreateCell(column.Ordinal);
            sh.SetColumnWidth(column.Ordinal, 20 * 256); //設定欄寬

            HSSFCellStyle CS = (HSSFCellStyle)wk.CreateCellStyle();
            IFont font = (IFont)wk.CreateFont();
            font.FontHeightInPoints = 14;

            CS.WrapText = true; //自動換行
            CS.SetFont(font);
            cell.CellStyle = CS;
            cell.SetCellValue(column.ColumnName);
        }


        //匯入資料
        int rowIndex = 1;
        foreach (DataRow row in dt.Rows)
        {
            HSSFRow dataRow = (HSSFRow)sh.CreateRow(rowIndex);

            foreach (DataColumn column in dt.Columns)
            {
                dataRow.CreateCell(column.Ordinal).SetCellValue(row[column].ToString());
                dataRow.GetCell(column.Ordinal).CellStyle.WrapText = true;
            }
            rowIndex++;
        }



        ExporkExcel(wk, FileName); //匯出


    }




    /// <summary>
    /// 下載Excel_2003
    /// </summary>
    /// <param name="workbook"></param>
    public void ExporkExcel(HSSFWorkbook workbook, string FileName)
    {
        MemoryStream ms = new MemoryStream();
        workbook.Write(ms);
        //Convert the memorystream to an array of bytes.
        byte[] byteArray = ms.ToArray();
        //Clean up the memory stream
        ms.Flush();
        ms.Close();
        // Clear all content output from the buffer stream
        HttpContext.Current.Response.Clear();
        // Add a HTTP header to the output stream that specifies the default filename
        // for the browser's download dialog
        HttpContext.Current.Response.Charset = "utf-8";
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpContext.Current.Server.UrlEncode(FileName) + ".xls");
        // Add a HTTP header to the output stream that contains the 
        // content length(File Size). This lets the browser know how much data is being transfered
        HttpContext.Current.Response.AddHeader("Content-Length", byteArray.Length.ToString());
        // Set the HTTP MIME type of the output stream

        // Write the data out to the client.
        HttpContext.Current.Response.BinaryWrite(byteArray);

    }

    /// <summary>
    /// 下載新版Excel_2007
    /// </summary>
    /// <param name="workbook"></param>
    public void ExporkExcelNew(XSSFWorkbook workbook, string FileName)
    {
        MemoryStream ms = new MemoryStream();
        workbook.Write(ms);
        //Convert the memorystream to an array of bytes.
        byte[] byteArray = ms.ToArray();
        //Clean up the memory stream
        ms.Flush();
        ms.Close();
        // Clear all content output from the buffer stream
        HttpContext.Current.Response.Clear();
        // Add a HTTP header to the output stream that specifies the default filename
        // for the browser's download dialog
        HttpContext.Current.Response.Charset = "utf-8";
        HttpContext.Current.Response.ContentType = "application/vnd.ms-excel";
        HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpContext.Current.Server.UrlEncode(FileName) + ".xlsx");
        // Add a HTTP header to the output stream that contains the 
        // content length(File Size). This lets the browser know how much data is being transfered
        HttpContext.Current.Response.AddHeader("Content-Length", byteArray.Length.ToString());
        // Set the HTTP MIME type of the output stream

        // Write the data out to the client.
        HttpContext.Current.Response.BinaryWrite(byteArray);

    }
}