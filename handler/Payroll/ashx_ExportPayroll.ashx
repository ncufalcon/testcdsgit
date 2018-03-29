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
    Common com = new Common();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string sr_guid = (!string.IsNullOrEmpty(context.Request.QueryString["sr_guid"])) ? context.Request.QueryString["sr_guid"].ToString() : "";
            string PerGuid = (!string.IsNullOrEmpty(context.Request.QueryString["PerGuid"])) ? context.Request.QueryString["PerGuid"].ToString() : "";
            string Leave = (!string.IsNullOrEmpty(context.Request.QueryString["Leave"])) ? context.Request.QueryString["Leave"].ToString() : "";
            string ShouldPay = (!string.IsNullOrEmpty(context.Request.QueryString["ShouldPay"])) ? context.Request.QueryString["ShouldPay"].ToString() : "";
            string Company = (!string.IsNullOrEmpty(context.Request.QueryString["Company"])) ? context.Request.QueryString["Company"].ToString() : "";
            string Dep = (!string.IsNullOrEmpty(context.Request.QueryString["Dep"])) ? context.Request.QueryString["Dep"].ToString() : "";
            string sDate = (!string.IsNullOrEmpty(context.Request.QueryString["sDate"])) ? context.Request.QueryString["sDate"].ToString() : "";
            string eDate = (!string.IsNullOrEmpty(context.Request.QueryString["eDate"])) ? context.Request.QueryString["eDate"].ToString() : "";


            payroll.model.sy_PayRoll pModel = new payroll.model.sy_PayRoll();
            pModel.sr_Guid = sr_guid;
            pModel.pPerGuid = PerGuid;
            pModel.pLeaveStatus = Leave;
            pModel.pShouldPayStatus = ShouldPay;
            pModel.pCompany = Company;
            pModel.pDep = Dep;





            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = dal.SelSy_PaySalaryExport(pModel).DefaultView;


                FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/payroll.xlsx"), FileMode.Open, FileAccess.Read);
                XSSFWorkbook wk = new XSSFWorkbook(fs);
                XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(0);

                IRow HeaderRow = sh.CreateRow(0);
                ICell DateCell = HeaderRow.CreateCell(0);

                XSSFCellStyle cellStyle = (XSSFCellStyle)wk.CreateCellStyle();
                XSSFFont font = (XSSFFont)wk.CreateFont();

                DateCell.CellStyle = cellStyle;
                font.FontHeightInPoints = 10;
                font.Color = NPOI.HSSF.Util.HSSFColor.Red.Index;
                cellStyle.SetFont(font);
                DateCell.SetCellValue("計薪期間：" + sDate + "~" + eDate);
                for (int i = 0; i < dv.Count; i++)
                {
                    int cellN = i + 2;
                    IRow row = sh.CreateRow(cellN);

                    row.CreateCell(0).SetCellValue(i + 1);//流水號
                    row.CreateCell(1).SetCellValue(dv[i]["cbValue"].ToString());//分店編號
                    row.CreateCell(2).SetCellValue(dv[i]["pPerNo"].ToString());//工號
                    row.CreateCell(3).SetCellValue(dv[i]["pPerName"].ToString());//姓名
                    row.CreateCell(4).SetCellValue("");//註記

                    decimal pBasicSalary = (!string.IsNullOrEmpty(dv[i]["pBasicSalary"].ToString())) ? decimal.Parse(dv[i]["pBasicSalary"].ToString()) : 0;
                    decimal pAllowance = (!string.IsNullOrEmpty(dv[i]["pAllowance"].ToString())) ? decimal.Parse(dv[i]["pAllowance"].ToString()) : 0;
                    row.CreateCell(5).SetCellValue(com.toDou((pBasicSalary + pAllowance).ToString()));//底薪
                    row.CreateCell(6).SetCellValue(com.toDou(dv[i]["pAttendanceDays"].ToString()));//出勤天數
                    row.CreateCell(7).SetCellValue(com.toDou((decimal.Parse(dv[i]["pGeneralTime"].ToString()) + decimal.Parse(dv[i]["pNationalholidaysTime1"].ToString())).ToString()));//出勤時數  pNationalholidaysTime1
                    row.CreateCell(8).SetCellValue(com.toDou((decimal.Parse(dv[i]["pWeekdayTime1"].ToString()) + decimal.Parse(dv[i]["pNationalholidaysTime2"].ToString())).ToString()));//平日加班一類
                    row.CreateCell(9).SetCellValue(com.toDou((decimal.Parse(dv[i]["pWeekdayTime2"].ToString()) + decimal.Parse(dv[i]["pNationalholidaysTime3"].ToString())).ToString()));//平日加班二類
                    row.CreateCell(10).SetCellValue(com.toDou((decimal.Parse(dv[i]["pOffDayTime1"].ToString()) + decimal.Parse(dv[i]["pOffDayTime2"].ToString()) + decimal.Parse(dv[i]["pOffDayTime3"].ToString())).ToString()));//休息加班
                    row.CreateCell(11).SetCellValue(com.toDou(dv[i]["pSalary"].ToString()));//本薪
                    row.CreateCell(12).SetCellValue(com.toDou(dv[i]["pOverTimeTaxation"].ToString()));//課稅加班費

                    //給薪假
                    row.CreateCell(15).SetCellValue(com.toDou(dv[i]["pMaternityLeaveSalary"].ToString()));//產假薪資-給薪假
                    row.CreateCell(16).SetCellValue(com.toDou(dv[i]["pAbortionLeaveSalary"].ToString()));//流產假
                    row.CreateCell(17).SetCellValue(com.toDou(dv[i]["pSickLeaveSalary"].ToString()));//病假半薪-給薪假
                    row.CreateCell(18).SetCellValue(com.toDou(dv[i]["pMarriageLeaveSalary"].ToString()));//婚嫁薪資-給薪假
                    row.CreateCell(19).SetCellValue(com.toDou(dv[i]["pFuneralLeaveSalary"].ToString()));//喪假薪資-給薪假
                    row.CreateCell(20).SetCellValue(com.toDou(dv[i]["pProductionLeaveSalary"].ToString()));//陪產產檢假薪資-給薪假
                    row.CreateCell(21).SetCellValue(com.toDou(dv[i]["pAnnualLeaveSalary"].ToString()));//特休假薪資-給薪假

                    row.CreateCell(23).SetCellValue(com.toDou(dv[i]["pMilitaryLeaveSalary"].ToString()));//兵役假薪資-給薪假


                    payroll.model.sy_PayAllowance paModel = new payroll.model.sy_PayAllowance();
                    paModel.psaPerGuid = dv[i]["pPerGuid"].ToString();
                    paModel.psaPsmGuid = dv[i]["pPsmGuid"].ToString();
                    DataView adv = dal.Selsy_PaySalaryAllowance(paModel).DefaultView;
                    row.CreateCell(13).SetCellValue(0);
                    row.CreateCell(14).SetCellValue(0);

                    row.CreateCell(24).SetCellValue(0);
                    row.CreateCell(25).SetCellValue(0);
                    row.CreateCell(26).SetCellValue(0);
                    row.CreateCell(27).SetCellValue(0);

                    row.CreateCell(30).SetCellValue(0);
                    row.CreateCell(32).SetCellValue(0);
                    row.CreateCell(33).SetCellValue(0);
                    row.CreateCell(34).SetCellValue(0);
                    row.CreateCell(35).SetCellValue(0);

                    row.CreateCell(36).SetCellValue(0);
                    row.CreateCell(37).SetCellValue(0);
                    row.CreateCell(38).SetCellValue(0);
                    row.CreateCell(39).SetCellValue(0);
                    row.CreateCell(40).SetCellValue(0);
                    row.CreateCell(41).SetCellValue(0);
                    row.CreateCell(47).SetCellValue(0);
                    row.CreateCell(46).SetCellValue(0);
                        row.CreateCell(22).SetCellValue(0);
                    for (int j = 0; j < adv.Count; j++)
                    {
                        //津貼
                        switch (adv[j]["siItemCode"].ToString())
                        {
                            case "A003":
                            case "A102":
                                //row.CreateCell(13).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//薪資調整-薪資項目
                                if (adv[j]["siItemCode"].ToString() == "A003")
                                    row.CreateCell(13).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//薪資調整-薪資項目
                                if (adv[j]["siItemCode"].ToString() == "A102")
                                    row.CreateCell(13).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//薪資調整-薪資項目
                                break;
                            case "D02":
                            case "D12":
                                if (adv[j]["siItemCode"].ToString() == "D02")
                                    row.CreateCell(14).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//調應稅加班
                                if (adv[j]["siItemCode"].ToString() == "D12")
                                    row.CreateCell(14).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//調應稅加班
                                break;
                            case "S001":
                                row.CreateCell(24).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//BestSA獎金
                                break;
                            case "A001":
                            case "A103":
                                //row.CreateCell(24).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//體檢補助 
                                if (adv[j]["siItemCode"].ToString() == "A001")
                                    row.CreateCell(25).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//體檢補助
                                if (adv[j]["siItemCode"].ToString() == "A103")
                                    row.CreateCell(25).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//A103(體檢補助)
                                break;
                            case "A006":
                                row.CreateCell(26).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//其它津貼
                                break;
                            case "A002":
                                row.CreateCell(27).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//年節禮金
                                break;

                            case "D01":
                            case "D11":
                                //row.CreateCell(29).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//調免稅加班
                                if (adv[j]["siItemCode"].ToString() == "D01")
                                    row.CreateCell(30).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//調免稅加班
                                if (adv[j]["siItemCode"].ToString() == "D11")
                                    row.CreateCell(30).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//調免稅加班

                                break;

                            case "F005":
                                row.CreateCell(33).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//未休特休假  
                                break;
                            case "A007":
                                row.CreateCell(34).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//職災補償
                                break;
                            case "A000":
                                row.CreateCell(35).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//資遣費
                                break;
                            case "A004":
                            case "A104":
                                if (adv[j]["siItemCode"].ToString() == "A004")
                                    row.CreateCell(36).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//代扣勞保費調整
                                if (adv[j]["siItemCode"].ToString() == "A104")
                                    row.CreateCell(36).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//代扣勞保費調整
                                break;
                            case "A005":
                            case "A105":
                                if (adv[j]["siItemCode"].ToString() == "A005")
                                    row.CreateCell(37).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//代扣健保費調整
                                if (adv[j]["siItemCode"].ToString() == "A105")
                                    row.CreateCell(37).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//代扣健保費調整
                                break;
                            case "A010":
                            case "A110":
                                if (adv[j]["siItemCode"].ToString() == "A010")
                                    row.CreateCell(38).SetCellValue(com.toDou(adv[j]["psaCost"].ToString()));//勞退自提調整  項目待補
                                if (adv[j]["siItemCode"].ToString() == "A110")
                                    row.CreateCell(38).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//勞退自提調整  項目待補
                                break;
                            case "A101":
                                row.CreateCell(39).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//代法院執行
                                break;
                            case "A106":
                                row.CreateCell(40).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//代扣繳-捐
                                break;
                            case "A107":
                                row.CreateCell(41).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//代扣繳-訓
                                break;
                            case "S002":
                                row.CreateCell(32).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//颱風天加給
                                break;
                            case "S104":
                                row.CreateCell(46).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//代扣福利金
                                break;
                            case "E03":
                                row.CreateCell(47).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//伙食津貼
                                break;
                            case "F107":
                                row.CreateCell(22).SetCellValue(com.toDou("-" + adv[j]["psaCost"].ToString()));//調特休假薪資
                                break;

                        }

                    }



                    row.CreateCell(48).SetCellValue(com.toDou(dv[i]["pTaxation"].ToString()));//課稅所得
                    row.CreateCell(28).SetCellValue(com.toDou((decimal.Parse(dv[i]["pWeekdaySalary1"].ToString()) + decimal.Parse(dv[i]["pWeekdaySalary2"].ToString()) + decimal.Parse(dv[i]["pWeekdaySalary3"].ToString())).ToString()));//平日免稅加班費
                    row.CreateCell(29).SetCellValue(com.toDou((decimal.Parse(dv[i]["pOffDaySalary1"].ToString()) + decimal.Parse(dv[i]["pOffDaySalary2"].ToString()) + decimal.Parse(dv[i]["pOffDaySalary3"].ToString())).ToString()));//休息日加班費
                    row.CreateCell(31).SetCellValue(com.toDou((decimal.Parse(dv[i]["pNationalholidaysSalary1"].ToString()) + decimal.Parse(dv[i]["pNationalholidaysSalary2"].ToString()) + decimal.Parse(dv[i]["pNationalholidaysSalary3"].ToString()) + decimal.Parse(dv[i]["pNationalholidaysSalary4"].ToString())).ToString()));//國定/假日
                    row.CreateCell(49).SetCellValue(com.toDou(dv[i]["pShouldPay"].ToString()));//應發金額
                    row.CreateCell(42).SetCellValue(com.toDou("-" + dv[i]["pPersonPension"].ToString()));//員工本月提繳金額
                    row.CreateCell(43).SetCellValue(com.toDou("-" + dv[i]["pPersonLabor"].ToString()));//勞保費
                    row.CreateCell(44).SetCellValue(com.toDou("-" + dv[i]["pPersonInsurance"].ToString()));//健保費
                    row.CreateCell(45).SetCellValue(com.toDou("-" + dv[i]["pPremium"].ToString()));//補充保費
                    row.CreateCell(50).SetCellValue(com.toDou(dv[i]["pPay"].ToString()));//實付金額
                    row.CreateCell(51).SetCellValue(com.toDou(dv[i]["pCompanyPension"].ToString()));//公司本月提繳金額
                }


                Npo.ExporkExcelNew(wk, "payroll_" + DateTime.Now.ToString("yyyyMMdd"));//下載excel
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