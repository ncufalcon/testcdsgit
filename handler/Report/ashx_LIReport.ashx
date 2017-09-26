<%@ WebHandler Language="C#" Class="ashx_LIReport" %>

using System;
using System.Web;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;
public class ashx_LIReport : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{

    payroll.gdal dal = new payroll.gdal();
    Common com = new Common();
    NpoiExcel Npo = new NpoiExcel();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string srGuid = (!string.IsNullOrEmpty(context.Request.QueryString["srGuid"])) ? context.Request.QueryString["srGuid"].ToString() : "";
            string PerNo = (!string.IsNullOrEmpty(context.Request.QueryString["PerNo"])) ? context.Request.QueryString["PerNo"].ToString() : "";
            string PerName = (!string.IsNullOrEmpty(context.Request.QueryString["PerName"])) ? context.Request.QueryString["PerName"].ToString() : "";
            string Company = (!string.IsNullOrEmpty(context.Request.QueryString["Company"])) ? context.Request.QueryString["Company"].ToString() : "";
            string Dep = (!string.IsNullOrEmpty(context.Request.QueryString["Dep"])) ? context.Request.QueryString["Dep"].ToString() : "";
            string SalaryDate = (!string.IsNullOrEmpty(context.Request.QueryString["SalaryDate"])) ? context.Request.QueryString["SalaryDate"].ToString() : "";

            payroll.model.sy_PayRoll pModel = new payroll.model.sy_PayRoll();
            pModel.sr_Guid = srGuid;
            pModel.pPerNo = PerNo;
                pModel.pPerName = PerName;
            pModel.pCompanyName = Company;
            pModel.pDepCode = Dep;


            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = dal.SelSy_PaySalaryExport(pModel).DefaultView;


                FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/LI.xlsx"), FileMode.Open, FileAccess.Read);
                XSSFWorkbook wk = new XSSFWorkbook(fs);
                XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(0);

                IRow HeaderRow = sh.CreateRow(3);
                ICell DateCell = HeaderRow.CreateCell(0);
                //ICell DateCell_10 = HeaderRow.CreateCell(10);
                XSSFCellStyle cellStyle = (XSSFCellStyle)wk.CreateCellStyle();
                XSSFFont font = (XSSFFont)wk.CreateFont();

                //DateCell.CellStyle = cellStyle;
                //font.FontHeightInPoints = 10;
                //font.Color = NPOI.HSSF.Util.HSSFColor.Red.Index;
                //cellStyle.SetFont(font);
                DateCell.SetCellValue("製表日期:" + DateTime.Now.ToString("yyyy/MM/dd"));
                //DateCell_10.SetCellValue("核對年月:2017/08:" + DateTime.Now.ToString("yyyy/MM/dd"));
                for (int i = 0; i < dv.Count; i++)
                {
                    int cellN = i + 5;
                    IRow row = sh.CreateRow(cellN);
                    row.CreateCell(0).SetCellValue(dv[i]["pPerDepCode"].ToString());//分店編號
                    row.CreateCell(1).SetCellValue(dv[i]["pPerNo"].ToString());//工號
                    row.CreateCell(2).SetCellValue(dv[i]["pPerName"].ToString());//姓名
                    row.CreateCell(3).SetCellValue(dv[i]["pPerIDNumber"].ToString());//身分證號
                    row.CreateCell(4).SetCellValue(com.toDou(dv[i]["pPerLaborSalary"].ToString()));//勞保薪資
                    row.CreateCell(5).SetCellValue(com.toDou(dv[i]["pPersonLaborDetail1"].ToString()));//勞方普通事故保險費
                    row.CreateCell(6).SetCellValue(com.toDou(dv[i]["pPersonLaborDetail2"].ToString()));//勞方就業保險費
                    row.CreateCell(7).SetCellValue(com.toDou(dv[i]["pPersonLaborDetail3"].ToString()));//資方普通事故保險費 
                    row.CreateCell(8).SetCellValue(com.toDou(dv[i]["pPersonLaborDetail4"].ToString()));//資方就業保險費
                    row.CreateCell(9).SetCellValue(com.toDou(dv[i]["pPersonLaborDetail5"].ToString()));//資方職業災害保險費率
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
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}