<%@ WebHandler Language="C#" Class="ashx_ExportExcel" %>


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
Common com = new Common();
    public void ProcessRequest(HttpContext context)
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
           DataView  dv = dal.SelSy_Tax(pModel).DefaultView;


            FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/LeaveExport.xlsx"), FileMode.Open, FileAccess.Read);
            XSSFWorkbook wk = new XSSFWorkbook(fs);
            XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(1);

            IRow HeaderRow = sh.CreateRow(0);
            ICell DateCell = HeaderRow.CreateCell(0);

            for (int i = 0; i < dv.Count; i++)
            {
                int cellN = i + 2;

                    //IRow row = sh.GetRow(cellN);
                    IRow row = sh.CreateRow(cellN);
                    row.CreateCell(0).SetCellValue(dv[i][""].ToString());
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
                    row.CreateCell(11).SetCellValue(dv[i]["iitYearStart"].ToString().Substring(0,2));//病假加總     iitYearStart
                    row.CreateCell(12).SetCellValue(dv[i]["iitYearStart"].ToString().Substring(4,5));
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


            Npo.ExporkExcelNew(wk, "給薪假紀錄");//下載excel
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