<%@ WebHandler Language="C#" Class="ashx_AttendanceReport" %>

using System;
using System.Web;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;
public class ashx_AttendanceReport : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{

    payroll.gdal dal = new payroll.gdal();
    Common com = new Common();
    NpoiExcel Npo = new NpoiExcel();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string sDate = (!string.IsNullOrEmpty(context.Request.QueryString["sDate"])) ? context.Request.QueryString["sDate"].ToString() : "";
            string eDate = (!string.IsNullOrEmpty(context.Request.QueryString["eDate"])) ? context.Request.QueryString["eDate"].ToString() : "";
            string PerNo = (!string.IsNullOrEmpty(context.Request.QueryString["PerNo"])) ? context.Request.QueryString["PerNo"].ToString() : "";
            string PerName = (!string.IsNullOrEmpty(context.Request.QueryString["PerName"])) ? context.Request.QueryString["PerName"].ToString() : "";
            string Company = (!string.IsNullOrEmpty(context.Request.QueryString["Company"])) ? context.Request.QueryString["Company"].ToString() : "";
            string Dep = (!string.IsNullOrEmpty(context.Request.QueryString["Dep"])) ? context.Request.QueryString["Dep"].ToString() : "";


            payroll.model.sy_Person pModel = new payroll.model.sy_Person();
            pModel.sDate = sDate;
            pModel.eDate = eDate;
            pModel.perNo = PerNo;
            pModel.perName = PerName;
            pModel.perCompanyName = Company;
            pModel.perDep = Dep;

            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = dal.Sel_pr_AttendanceReport(pModel).DefaultView;


                FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/Attendance.xlsx"), FileMode.Open, FileAccess.Read);
                XSSFWorkbook wk = new XSSFWorkbook(fs);
                XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(0);

                IRow HeaderRow = sh.CreateRow(3);
                ICell DateCell = HeaderRow.CreateCell(0);
                ICell DateCell13 = HeaderRow.CreateCell(13);


                XSSFCellStyle DateStyle = wk.CreateCellStyle() as XSSFCellStyle;
                XSSFDataFormat format = wk.CreateDataFormat() as XSSFDataFormat;
                DateStyle.DataFormat = format.GetFormat("yyyy/MM/dd");

                //ICell DateCell_10 = HeaderRow.CreateCell(10);
                XSSFCellStyle cellStyle = (XSSFCellStyle)wk.CreateCellStyle();
                XSSFFont font = (XSSFFont)wk.CreateFont();
                DateCell.SetCellValue("製表日期:" + DateTime.Now.ToString("yyyy/MM/dd"));
                DateCell13.SetCellValue("期間:" + sDate + "至" + eDate);

                for (int i = 0; i < dv.Count; i++)
                {
                    int cellN = i + 5;
                    IRow row = sh.CreateRow(cellN);
                    row.CreateCell(0).SetCellValue(dv[i]["cbValue"].ToString());//分店編號
                    row.CreateCell(1).SetCellValue(dv[i]["perNo"].ToString());//工號
                    row.CreateCell(2).SetCellValue(dv[i]["perName"].ToString());//姓名
                    if (dv[i]["aAttendanceDate"].ToString() != "小計" && dv[i]["aAttendanceDate"].ToString() != "")
                    {
                        ICell c3 = row.CreateCell(3);
                        c3.CellStyle = DateStyle;
                        c3.SetCellValue(DateTime.Parse(dv[i]["aAttendanceDate"].ToString())); //日期
                    } else
                    { row.CreateCell(3).SetCellValue(dv[i]["aAttendanceDate"].ToString()); }//日期)

                    row.CreateCell(4).SetCellValue(com.toDou(dv[i]["aDays"].ToString()));//出勤天數
                    row.CreateCell(5).SetCellValue(com.toDou(dv[i]["aLeave"].ToString()));//休假天數
                    row.CreateCell(6).SetCellValue(com.toDou(dv[i]["aTimes"].ToString()));//出勤時數
                    row.CreateCell(7).SetCellValue(com.toDou(dv[i]["aGeneralOverTime1"].ToString()));//加班時數-1類
                    row.CreateCell(8).SetCellValue(com.toDou(dv[i]["aGeneralOverTime2"].ToString()));//加班時數-2類
                    row.CreateCell(9).SetCellValue(com.toDou(dv[i]["aGeneralOverTime3"].ToString()));//加班時數-3類

                    row.CreateCell(10).SetCellValue(com.toDou(dv[i]["aHolidayOverTimes"].ToString()));//假日加班時數
                    row.CreateCell(11).SetCellValue(com.toDou(dv[i]["aHolidayOverTime1"].ToString()));//假日加班時數-1類
                    row.CreateCell(12).SetCellValue(com.toDou(dv[i]["aHolidayOverTime2"].ToString()));//假日加班時數-2類
                    row.CreateCell(13).SetCellValue(com.toDou(dv[i]["aHolidayOverTime3"].ToString()));//假日加班時數-3類
                    row.CreateCell(14).SetCellValue(com.toDou(dv[i]["aOverTimeSum"].ToString()));//加班總時數


                    row.CreateCell(15).SetCellValue(com.toDou(dv[i]["aOffDayOverTime1"].ToString()));//休息日加班時數-1類
                    row.CreateCell(16).SetCellValue(com.toDou(dv[i]["aOffDayOverTime2"].ToString()));//休息日加班時數-2類
                    row.CreateCell(17).SetCellValue(com.toDou(dv[i]["aOffDayOverTime3"].ToString()));//休息日加班時數-3類

                    row.CreateCell(18).SetCellValue(com.toDou(dv[i]["aNationalholidays"].ToString()));//國定假日加班時數
                    row.CreateCell(19).SetCellValue(com.toDou(dv[i]["aNationalholidays1"].ToString()));//國定假日加班時數-1類
                    row.CreateCell(20).SetCellValue(com.toDou(dv[i]["aNationalholidays2"].ToString()));//國定假日加班時數-2類
                    row.CreateCell(21).SetCellValue(com.toDou(dv[i]["aNationalholidays3"].ToString()));//國定假日加班時數-3類

                    row.CreateCell(22).SetCellValue(com.toDou(dv[i]["aSpecialholiday"].ToString()));//特殊假日加班時數
                    row.CreateCell(23).SetCellValue(com.toDou(dv[i]["aSpecialholiday1"].ToString()));//特殊假日加班時數-1類
                    row.CreateCell(24).SetCellValue(com.toDou(dv[i]["aSpecialholiday2"].ToString()));//特殊假日加班時數-2類
                    row.CreateCell(25).SetCellValue(com.toDou(dv[i]["aSpecialholiday3"].ToString()));//特殊假日加班時數-3類

                    row.CreateCell(26).SetCellValue(com.toDou(dv[i]["aAnnualLeave"].ToString()));//年假(時)
                    row.CreateCell(27).SetCellValue(com.toDou(dv[i]["aPersonalLeave"].ToString()));//事假(時)
                }
                Npo.ExporkExcelNew(wk, "Attendance_" + DateTime.Now.ToString("yyyyMMdd"));//下載excel
            }
            else
            {
                context.Response.Write("TimeOut");
            }
        }
        catch (Exception ex)
        {
            ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_AttendanceReport.ashx", ex.Message, USERINFO.MemberName);
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