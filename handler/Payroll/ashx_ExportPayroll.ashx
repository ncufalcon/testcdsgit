<%@ WebHandler Language="C#" Class="ashx_ExportPayroll" %>

using System;
using System.Web;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;

public class ashx_ExportPayroll : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{

    NpoiExcel Npo = new NpoiExcel();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {

        string sr_guid = (!string.IsNullOrEmpty(context.Request.QueryString["sr_guid"])) ? context.Request.QueryString["sr_guid"].ToString() : "";
        string PerGuid = (!string.IsNullOrEmpty(context.Request.QueryString["PerGuid"])) ? context.Request.QueryString["PerGuid"].ToString() : "";
        string Leave = (!string.IsNullOrEmpty(context.Request.QueryString["Leave"])) ? context.Request.QueryString["Leave"].ToString() : "";
        string ShouldPay = (!string.IsNullOrEmpty(context.Request.QueryString["ShouldPay"])) ? context.Request.QueryString["ShouldPay"].ToString() : "";
        string Company = (!string.IsNullOrEmpty(context.Request.QueryString["Company"])) ? context.Request.QueryString["Company"].ToString() : "";
        string Dep = (!string.IsNullOrEmpty(context.Request.QueryString["Dep"])) ? context.Request.QueryString["Dep"].ToString() : "";

        payroll.model.sy_PayRoll pModel = new payroll.model.sy_PayRoll();




        if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
        {
            DataView dv = dal.SelSy_PaySalaryExport(pModel).DefaultView;


            //FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/LeaveExport.xlsx"), FileMode.Open, FileAccess.Read);
            //XSSFWorkbook wk = new XSSFWorkbook(fs);
            //XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(0);

            //IRow HeaderRow = sh.CreateRow(0);
            //ICell DateCell = HeaderRow.CreateCell(0);

            //XSSFCellStyle cellStyle = (XSSFCellStyle)wk.CreateCellStyle();
            //XSSFFont font = (XSSFFont)wk.CreateFont();

            //DateCell.CellStyle = cellStyle;
            //font.FontHeightInPoints = 10;
            ////font.Color = NPOI.HSSF.Util.HSSFColor.RED.index;
            //cellStyle.SetFont(font);
            ////DateCell.SetCellValue("請假期間：" + sDate + "~" + eDate);
            //for (int i = 0; i < dv.Count; i++)
            //{
            //    int cellN = i + 2;

            //        HeaderRow.CreateCell(3).SetCellValue(dv[i]["Duration1"].ToString());
            //        HeaderRow.CreateCell(4).SetCellValue(dv[i]["Duration14"].ToString());
            //        HeaderRow.CreateCell(5).SetCellValue(dv[i]["Duration9"].ToString());
            //        HeaderRow.CreateCell(6).SetCellValue(dv[i]["Duration4"].ToString());
            //        HeaderRow.CreateCell(7).SetCellValue(dv[i]["Duration10"].ToString());
            //        HeaderRow.CreateCell(8).SetCellValue(dv[i]["Duration13"].ToString());
            //        HeaderRow.CreateCell(9).SetCellValue(dv[i]["Duration5"].ToString());
            //        HeaderRow.CreateCell(10).SetCellValue(dv[i]["Duration7"].ToString());
            //        HeaderRow.CreateCell(11).SetCellValue(dv[i]["sickLavelSum"].ToString());//病假加總
            //        HeaderRow.CreateCell(12).SetCellValue(dv[i]["Duration11"].ToString());
            //        HeaderRow.CreateCell(13).SetCellValue(dv[i]["Duration2"].ToString());
            //        HeaderRow.CreateCell(14).SetCellValue(dv[i]["Duration3"].ToString());
            //        HeaderRow.CreateCell(15).SetCellValue(dv[i]["Duration8"].ToString());
            //        HeaderRow.CreateCell(16).SetCellValue(dv[i]["Duration12"].ToString());
            //        HeaderRow.CreateCell(17).SetCellValue(dv[i]["AnnualLeaveProportion"].ToString());
            //        HeaderRow.CreateCell(18).SetCellValue(dv[i]["AnnualLeave"].ToString());
            //        HeaderRow.CreateCell(19).SetCellValue(dv[i]["P1"].ToString());
            //        HeaderRow.CreateCell(20).SetCellValue(dv[i]["SickLeavePayroll"].ToString());
            //        HeaderRow.CreateCell(21).SetCellValue(dv[i]["MarriageLeavePayroll"].ToString());
            //        HeaderRow.CreateCell(22).SetCellValue(dv[i]["FuneralLeavePayroll"].ToString());
            //        HeaderRow.CreateCell(23).SetCellValue(dv[i]["MaternityLeavePayroll"].ToString());
            //        cellN = cellN - 1;

            //}


            //Npo.ExporkExcelNew(wk, "給薪假紀錄");//下載excel
        }
        else
        {
            context.Response.Write("TimeOut");
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}