<%@ WebHandler Language="C#" Class="ashx_ExportExcel" %>

using System;
using System.Web;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;

public class ashx_ExportExcel : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    NpoiExcel Npo = new NpoiExcel();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string sr_guid = (!string.IsNullOrEmpty(context.Request.QueryString["sr_guid"])) ? context.Request.QueryString["sr_guid"].ToString() : "";
            string sDate = (!string.IsNullOrEmpty(context.Request.QueryString["sDate"])) ? context.Request.QueryString["sDate"].ToString() : "";
            string eDate = (!string.IsNullOrEmpty(context.Request.QueryString["eDate"])) ? context.Request.QueryString["eDate"].ToString() : "";
            string PerNo = (!string.IsNullOrEmpty(context.Request.QueryString["PerNo"])) ? context.Request.QueryString["PerNo"].ToString() : "";
            string Company = (!string.IsNullOrEmpty(context.Request.QueryString["Company"])) ? context.Request.QueryString["Company"].ToString() : "";
            string Dep = (!string.IsNullOrEmpty(context.Request.QueryString["Dep"])) ? context.Request.QueryString["Dep"].ToString() : "";
            string Position = (!string.IsNullOrEmpty(context.Request.QueryString["Position"])) ? context.Request.QueryString["Position"].ToString() : "";



            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = dal.Call_pr_LeaveExport(sr_guid, PerNo, Company, Dep, Position).DefaultView;


                FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/LeaveExport.xlsx"), FileMode.Open, FileAccess.Read);
                XSSFWorkbook wk = new XSSFWorkbook(fs);
                XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(0);

                IRow HeaderRow = sh.CreateRow(0);
                ICell DateCell = HeaderRow.CreateCell(0);

                XSSFCellStyle cellStyle = (XSSFCellStyle)wk.CreateCellStyle();
                XSSFFont font = (XSSFFont)wk.CreateFont();

                DateCell.CellStyle = cellStyle;
                font.FontHeightInPoints = 10;
                //font.Color = NPOI.HSSF.Util.HSSFColor.RED.index;
                cellStyle.SetFont(font);
                DateCell.SetCellValue("請假期間：" + sDate + "~" + eDate);
                for (int i = 0; i < dv.Count; i++)
                {
                    int cellN = i + 2;
                    if (dv[i]["PerGuid"].ToString() == "Sum")//加總
                    {
                        HeaderRow.CreateCell(3).SetCellValue(dv[i]["Duration1"].ToString());
                        HeaderRow.CreateCell(4).SetCellValue(dv[i]["Duration14"].ToString());
                        HeaderRow.CreateCell(5).SetCellValue(dv[i]["Duration9"].ToString());
                        HeaderRow.CreateCell(6).SetCellValue(dv[i]["Duration4"].ToString());
                        HeaderRow.CreateCell(7).SetCellValue(dv[i]["Duration10"].ToString());
                        HeaderRow.CreateCell(8).SetCellValue(dv[i]["Duration13"].ToString());
                        HeaderRow.CreateCell(9).SetCellValue(dv[i]["Duration5"].ToString());
                        HeaderRow.CreateCell(10).SetCellValue(dv[i]["Duration7"].ToString());
                        HeaderRow.CreateCell(11).SetCellValue(dv[i]["sickLavelSum"].ToString());//病假加總
                        HeaderRow.CreateCell(12).SetCellValue(dv[i]["Duration11"].ToString());
                        HeaderRow.CreateCell(13).SetCellValue(dv[i]["Duration2"].ToString());
                        HeaderRow.CreateCell(14).SetCellValue(dv[i]["Duration3"].ToString());
                        HeaderRow.CreateCell(15).SetCellValue(dv[i]["Duration8"].ToString());
                        HeaderRow.CreateCell(16).SetCellValue(dv[i]["Duration12"].ToString());
                        HeaderRow.CreateCell(17).SetCellValue(dv[i]["AnnualLeaveProportion"].ToString());
                        HeaderRow.CreateCell(18).SetCellValue(dv[i]["AnnualLeave"].ToString());
                        HeaderRow.CreateCell(19).SetCellValue(dv[i]["P1"].ToString());
                        HeaderRow.CreateCell(20).SetCellValue(dv[i]["SickLeavePayroll"].ToString());
                        HeaderRow.CreateCell(21).SetCellValue(dv[i]["MarriageLeavePayroll"].ToString());
                        HeaderRow.CreateCell(22).SetCellValue(dv[i]["FuneralLeavePayroll"].ToString());
                        HeaderRow.CreateCell(23).SetCellValue(dv[i]["MaternityLeavePayroll"].ToString());
                        cellN = cellN - 1;
                    }
                    else
                    {
                        //IRow row = sh.GetRow(cellN);
                        IRow row = sh.CreateRow(cellN);
                        row.CreateCell(0).SetCellValue(dv[i]["PerNo"].ToString());
                        row.CreateCell(1).SetCellValue(dv[i]["cbValue"].ToString());
                        row.CreateCell(2).SetCellValue(dv[i]["perName"].ToString());
                        row.CreateCell(3).SetCellValue(dv[i]["Duration1"].ToString());
                        row.CreateCell(4).SetCellValue(dv[i]["Duration14"].ToString());
                        row.CreateCell(5).SetCellValue(dv[i]["Duration9"].ToString());
                        row.CreateCell(6).SetCellValue(dv[i]["Duration4"].ToString());
                        row.CreateCell(7).SetCellValue(dv[i]["Duration10"].ToString());
                        row.CreateCell(8).SetCellValue(dv[i]["Duration13"].ToString());
                        row.CreateCell(9).SetCellValue(dv[i]["Duration5"].ToString());
                        row.CreateCell(10).SetCellValue(dv[i]["Duration7"].ToString());
                        row.CreateCell(11).SetCellValue(dv[i]["sickLavelSum"].ToString());//病假加總
                        row.CreateCell(12).SetCellValue(dv[i]["Duration11"].ToString());
                        row.CreateCell(13).SetCellValue(dv[i]["Duration2"].ToString());
                        row.CreateCell(14).SetCellValue(dv[i]["Duration3"].ToString());
                        row.CreateCell(15).SetCellValue(dv[i]["Duration8"].ToString());
                        row.CreateCell(16).SetCellValue(dv[i]["Duration12"].ToString());
                        row.CreateCell(17).SetCellValue(dv[i]["AnnualLeaveProportion1"].ToString());
                        row.CreateCell(18).SetCellValue(dv[i]["AnnualLeave"].ToString());
                        row.CreateCell(19).SetCellValue(dv[i]["P1"].ToString());
                        row.CreateCell(20).SetCellValue(dv[i]["SickLeavePayroll"].ToString());
                        row.CreateCell(21).SetCellValue(dv[i]["MarriageLeavePayroll"].ToString());
                        row.CreateCell(22).SetCellValue(dv[i]["FuneralLeavePayroll"].ToString());
                        row.CreateCell(23).SetCellValue(dv[i]["MaternityLeavePayroll"].ToString());
                    }
                }


                Npo.ExporkExcelNew(wk, "給薪假紀錄");//下載excel
            }
            else
            {
                context.Response.Write("TimeOut");
            }
        }
        catch (Exception ex)
        {
            ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_ExportPayroll.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("程式發生錯誤，請聯絡相關管理人員");

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