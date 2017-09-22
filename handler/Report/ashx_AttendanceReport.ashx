<%@ WebHandler Language="C#" Class="ashx_AttendanceReport" %>

using System;
using System.Web;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;
public class ashx_AttendanceReport : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
    
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
                 pModel.perComGuid = Company;
                 pModel.perDep = Dep;

            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = dal.Sel_pr_AttendanceReport(pModel).DefaultView;


                FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/LI.xlsx"), FileMode.Open, FileAccess.Read);
                XSSFWorkbook wk = new XSSFWorkbook(fs);
                XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(0);

                IRow HeaderRow = sh.CreateRow(3);
                ICell DateCell = HeaderRow.CreateCell(0);
                //ICell DateCell_10 = HeaderRow.CreateCell(10);
                XSSFCellStyle cellStyle = (XSSFCellStyle)wk.CreateCellStyle();
                XSSFFont font = (XSSFFont)wk.CreateFont();

                DateCell.SetCellValue("製表日期:" + DateTime.Now.ToString("yyyy/MM/dd"));
                for (int i = 0; i < dv.Count; i++)
                {
                    int cellN = i + 5;
                    IRow row = sh.CreateRow(cellN);
                    row.CreateCell(0).SetCellValue(dv[i]["cbValue"].ToString());//分店編號
                    row.CreateCell(1).SetCellValue(dv[i]["perNo"].ToString());//工號
                    row.CreateCell(2).SetCellValue(dv[i]["perName"].ToString());//姓名
                    row.CreateCell(3).SetCellValue(dv[i]["aAttendanceDate"].ToString());//身分證號
                    row.CreateCell(4).SetCellValue(com.toDou(dv[i]["aDays"].ToString()));//勞保薪資
                    row.CreateCell(5).SetCellValue(com.toDou(dv[i]["aLeave"].ToString()));//勞方普通事故保險費
                    row.CreateCell(6).SetCellValue(com.toDou(dv[i]["aTimes"].ToString()));//勞方就業保險費
                    row.CreateCell(7).SetCellValue(com.toDou(dv[i]["aGeneralOverTime1"].ToString()));//資方普通事故保險費 
                    row.CreateCell(8).SetCellValue(com.toDou(dv[i]["aGeneralOverTime2"].ToString()));//資方就業保險費
                    row.CreateCell(9).SetCellValue(com.toDou(dv[i]["aGeneralOverTime3"].ToString()));//資方職業災害保險費率

                    row.CreateCell(10).SetCellValue(com.toDou(dv[i]["pPersonLaborDetail6"].ToString()));//資方墊償提繳費
                    row.CreateCell(11).SetCellValue(com.toDou(dv[i]["pPersonLabor"].ToString()));//勞保費
                    row.CreateCell(12).SetCellValue(com.toDou(dv[i]["pComInsurance"].ToString()));//資方負擔勞保
                    row.CreateCell(13).SetCellValue(com.toDou(dv[i]["pPerPersonSalary"].ToString()));//產假薪資-給薪假
                    row.CreateCell(14).SetCellValue(com.toDou(dv[i]["pPersonPension"].ToString()));//員工本月提繳金額
                    row.CreateCell(15).SetCellValue(com.toDou(dv[i]["pCompanyPension"].ToString()));//公司本月提繳金額
                }
                Npo.ExporkExcelNew(wk, "LI_" + DateTime.Now.ToString("yyyyMMdd"));//下載excel
            }
            else
            {
                context.Response.Write("TimeOut");
            }
        }
        catch (Exception ex)
        {
            ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_LIReport.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("程式發生錯誤，請聯絡相關管理人員");

        }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}