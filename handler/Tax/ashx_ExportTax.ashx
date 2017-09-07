<%@ WebHandler Language="C#" Class="ashx_ExportTax" %>

using System;
using System.Web;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;

public class ashx_ExportTax : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {

    NpoiExcel Npo = new NpoiExcel();
    payroll.gdal dal = new payroll.gdal();
    Common com = new Common();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string yyyy = (!string.IsNullOrEmpty(context.Request.QueryString["yyyy"])) ? context.Request.QueryString["yyyy"].ToString() : "";


            string[] str = { yyyy };
            string sqlinj = com.CheckSqlInJection(str);

            payroll.model.sy_Tax pModel = new payroll.model.sy_Tax();
            pModel.iitPerNo = "";
            pModel.iitPerName = "";
            pModel.iitComName = "";
            pModel.iitPerDep = "";
            pModel.iitYyyy = yyyy;
            pModel.iitGuid = "";

            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = dal.SelSy_Tax(pModel).DefaultView;


                FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/Tax.xlsx"), FileMode.Open, FileAccess.Read);
                XSSFWorkbook wk = new XSSFWorkbook(fs);
                XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(1);

                //IRow HeaderRow = sh.CreateRow(0);
                //ICell DateCell = HeaderRow.CreateCell(0);

                for (int i = 0; i < dv.Count; i++)
                {
                    int cellN = i + 5;

                    //IRow row = sh.GetRow(cellN);
                    IRow row = sh.CreateRow(cellN);
                    row.CreateCell(0).SetCellValue("");
                    row.CreateCell(1).SetCellValue(dv[i]["iitFormat"].ToString());
                    row.CreateCell(2).SetCellValue(dv[i]["iitPerIDNumber"].ToString());
                    row.CreateCell(3).SetCellValue(dv[i]["iitIdentify"].ToString());
                    row.CreateCell(4).SetCellValue(dv[i]["iitPaySum"].ToString());
                    row.CreateCell(5).SetCellValue(dv[i]["iitPayTax"].ToString());
                    row.CreateCell(6).SetCellValue(dv[i]["iitPayAmount"].ToString());
                    row.CreateCell(7).SetCellValue(dv[i]["iitPerNo"].ToString());
                    row.CreateCell(8).SetCellValue(dv[i]["iitErrMark"].ToString());
                    row.CreateCell(9).SetCellValue(dv[i]["iitPerName"].ToString());
                    row.CreateCell(10).SetCellValue(dv[i]["iitPerResidentAddr"].ToString());
                    row.CreateCell(11).SetCellValue((!string.IsNullOrEmpty(dv[i]["iitYearStart"].ToString())) ? dv[i]["iitYearStart"].ToString().Substring(0, 3) : "");//病假加總     iitYearStart
                    row.CreateCell(12).SetCellValue((!string.IsNullOrEmpty(dv[i]["iitYearStart"].ToString())) ? dv[i]["iitYearStart"].ToString().Substring(4, 2) : "");
                    row.CreateCell(13).SetCellValue((!string.IsNullOrEmpty(dv[i]["iitYearEnd"].ToString())) ? dv[i]["iitYearEnd"].ToString().Substring(0, 3) : "");
                    row.CreateCell(14).SetCellValue((!string.IsNullOrEmpty(dv[i]["iitYearEnd"].ToString())) ? dv[i]["iitYearEnd"].ToString().Substring(4, 2) : "");
                    row.CreateCell(15).SetCellValue(dv[i]["iitPension"].ToString());
                    row.CreateCell(16).SetCellValue("");//dv[i]["iitBatchDate"].ToString()
                    row.CreateCell(17).SetCellValue("");//dv[i]["iitBatchPrice"].ToString()
                    row.CreateCell(18).SetCellValue(dv[i]["iitTaxMark"].ToString());
                    row.CreateCell(19).SetCellValue(dv[i]["iitManner"].ToString());
                    row.CreateCell(20).SetCellValue(dv[i]["iitCountryCode"].ToString());
                    row.CreateCell(21).SetCellValue(dv[i]["iitCode"].ToString());
                }


                Npo.ExporkExcelNew(wk, yyyy + "度申報所得稅資料");//下載excel
            }
            else
            {

                context.Response.Write("TimeOut");
            }
        }
        catch (Exception ex)
        {
            ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_ExportTax.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("程式發生錯誤，請聯絡相關管理人員");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}