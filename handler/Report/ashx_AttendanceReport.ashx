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

                XSSFCellStyle intStyle2 = wk.CreateCellStyle() as XSSFCellStyle;
                XSSFDataFormat format2 = wk.CreateDataFormat() as XSSFDataFormat;
                intStyle2.DataFormat = format2.GetFormat("0.00");

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
                    }
                    else
                    { row.CreateCell(3).SetCellValue(dv[i]["aAttendanceDate"].ToString()); }//日期)

                    row.CreateCell(4).SetCellValue(com.toDou(dv[i]["aDays"].ToString()));//出勤天數
                    row.CreateCell(5).SetCellValue(com.toDou(dv[i]["aLeave"].ToString()));//休假天數
                                                                                          //row.CreateCell(6).SetCellValue(com.toDou(dv[i]["aTimes"].ToString()));//出勤時數

                    ICell c6 = row.CreateCell(6);
                    c6.CellStyle = intStyle2;
                    c6.SetCellValue(double.Parse(dv[i]["aTimes"].ToString())); //事假／家庭照顧假

                    ICell c7 = row.CreateCell(7);
                    c7.CellStyle = intStyle2;
                    c7.SetCellValue(double.Parse(dv[i]["aGeneralOverTime1"].ToString())); //事假／家庭照顧假

                    ICell c8 = row.CreateCell(8);
                    c8.CellStyle = intStyle2;
                    c8.SetCellValue(double.Parse(dv[i]["aGeneralOverTime2"].ToString())); //事假／家庭照顧假

                    ICell c9 = row.CreateCell(9);
                    c9.CellStyle = intStyle2;
                    c9.SetCellValue(double.Parse(dv[i]["aGeneralOverTime3"].ToString())); //事假／家庭照顧假


                    ICell c10 = row.CreateCell(10);
                    c10.CellStyle = intStyle2;
                    c10.SetCellValue(double.Parse(dv[i]["aHolidayOverTimes"].ToString())); //事假／家庭照顧假

                    ICell c11 = row.CreateCell(11);
                    c11.CellStyle = intStyle2;
                    c11.SetCellValue(double.Parse(dv[i]["aHolidayOverTime1"].ToString())); //事假／家庭照顧假

                    ICell c12 = row.CreateCell(12);
                    c12.CellStyle = intStyle2;
                    c12.SetCellValue(double.Parse(dv[i]["aHolidayOverTime2"].ToString())); //事假／家庭照顧假

                    ICell c13 = row.CreateCell(13);
                    c13.CellStyle = intStyle2;
                    c13.SetCellValue(double.Parse(dv[i]["aHolidayOverTime3"].ToString())); //事假／家庭照顧假


                    ICell c14 = row.CreateCell(14);
                    c14.CellStyle = intStyle2;
                    c14.SetCellValue(double.Parse(dv[i]["aOverTimeSum"].ToString())); //事假／家庭照顧假


                    ICell c15 = row.CreateCell(15);
                    c15.CellStyle = intStyle2;
                    c15.SetCellValue(double.Parse(dv[i]["aOffDayOverTime1"].ToString())); //休息日加班時數-1類

                    ICell c16 = row.CreateCell(16);
                    c16.CellStyle = intStyle2;
                    c16.SetCellValue(double.Parse(dv[i]["aOffDayOverTime2"].ToString())); //休息日加班時數-2類

                    ICell c17 = row.CreateCell(17);
                    c17.CellStyle = intStyle2;
                    c17.SetCellValue(double.Parse(dv[i]["aOffDayOverTime3"].ToString())); //休息日加班時數-3類


                    ICell c18 = row.CreateCell(18);
                    c18.CellStyle = intStyle2;
                    c18.SetCellValue(double.Parse(dv[i]["aNationalholidays"].ToString())); //國定假日加班時數

                    ICell c19 = row.CreateCell(19);
                    c19.CellStyle = intStyle2;
                    c19.SetCellValue(double.Parse(dv[i]["aNationalholidays1"].ToString())); //國定假日加班時數-1類

                    ICell c20 = row.CreateCell(20);
                    c20.CellStyle = intStyle2;
                    c20.SetCellValue(double.Parse(dv[i]["aNationalholidays2"].ToString())); //國定假日加班時數-2類

                    ICell c21 = row.CreateCell(21);
                    c21.CellStyle = intStyle2;
                    c21.SetCellValue(double.Parse(dv[i]["aNationalholidays3"].ToString())); //國定假日加班時數-3類


                    ICell c22 = row.CreateCell(22);
                    c22.CellStyle = intStyle2;
                    c22.SetCellValue(double.Parse(dv[i]["aSpecialholiday"].ToString())); //特殊假日加班時數

                    ICell c23 = row.CreateCell(23);
                    c23.CellStyle = intStyle2;
                    c23.SetCellValue(double.Parse(dv[i]["aSpecialholiday1"].ToString())); //特殊假日加班時數-1類

                    ICell c24 = row.CreateCell(24);
                    c24.CellStyle = intStyle2;
                    c24.SetCellValue(double.Parse(dv[i]["aSpecialholiday2"].ToString())); //特殊假日加班時數-2類

                    ICell c25 = row.CreateCell(25);
                    c25.CellStyle = intStyle2;
                    c25.SetCellValue(double.Parse(dv[i]["aSpecialholiday3"].ToString())); //特殊假日加班時數-3類

                    ICell c26 = row.CreateCell(26);
                    c26.CellStyle = intStyle2;
                    c26.SetCellValue(double.Parse(dv[i]["aAnnualLeave"].ToString())); //年假(時)

                    ICell c27 = row.CreateCell(27);
                    c27.CellStyle = intStyle2;
                    c27.SetCellValue(double.Parse(dv[i]["aPersonalLeave"].ToString())); //事假(時)
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