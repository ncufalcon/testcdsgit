<%@ WebHandler Language="C#" Class="ashx_PayList" %>

using System;
using System.Web;
using System.Data;

public class ashx_PayList : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "text/xml";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {


                string XmlStr = "";
                DataView dv = new DataView();
                string PerNo = (!string.IsNullOrEmpty(context.Request.Form["PerNo"])) ? context.Request.Form["PerNo"].ToString() : "";
                string PerName = (!string.IsNullOrEmpty(context.Request.Form["PerName"])) ? context.Request.Form["PerName"].ToString() : "";
                string Company = (!string.IsNullOrEmpty(context.Request.Form["Company"])) ? context.Request.Form["Company"].ToString() : "";
                string Dep = (!string.IsNullOrEmpty(context.Request.Form["Dep"])) ? context.Request.Form["Dep"].ToString() : "";
                string SalaryRang = (!string.IsNullOrEmpty(context.Request.Form["SalaryRang"])) ? context.Request.Form["SalaryRang"].ToString() : "";
                string typ = (!string.IsNullOrEmpty(context.Request.Form["typ"])) ? context.Request.Form["typ"].ToString() : "";


                string[] str = { PerNo, PerName, Company, Dep, SalaryRang };
                string sqlinj = com.CheckSqlInJection(str);

                payroll.model.sy_PayRoll pModel = new payroll.model.sy_PayRoll();
                pModel.pPerNo = PerNo;
                pModel.pPerName = PerName;
                pModel.pPerCompanyName = Company;
                pModel.pPerDep = Dep;
                pModel.sr_Guid = SalaryRang;
                pModel.pGuid = "";
                if (sqlinj == "")
                {
                    if (typ == "Y") //代表第一次進入畫面 Top 200
                        dv = dal.SelSy_PaySalaryDetailTop200().DefaultView;
                    else
                        dv = dal.SelSy_PaySalaryDetail(pModel).DefaultView;

                    //string paging = (Math.Ceiling(decimal.Parse((dvList.Count / 10).ToString())) + 1).ToString();
                    XmlStr += "<dList>";
                    for (int i = 0; i < dv.Count; i++)
                    {
                        XmlStr += "<dView>";
                        XmlStr += "<pGuid>" + dv[i]["pGuid"].ToString() + "</pGuid>";
                        XmlStr += "<pPsmGuid>" + dv[i]["pPsmGuid"].ToString() + "</pPsmGuid>";
                        XmlStr += "<pPerGuid>" + dv[i]["pPerGuid"].ToString() + "</pPerGuid>";
                        XmlStr += "<pPerNo>" + dv[i]["pPerNo"].ToString() + "</pPerNo>";
                        XmlStr += "<pPerName>" + dv[i]["pPerName"].ToString() + "</pPerName>";
                        XmlStr += "<pPerCompanyName>" + dv[i]["pPerCompanyName"].ToString() + "</pPerCompanyName>";
                        XmlStr += "<pPerDep>" + dv[i]["pPerDep"].ToString() + "</pPerDep>";

                        XmlStr += "<pWeekdayTime1>" + dv[i]["pWeekdayTime1"].ToString() + "</pWeekdayTime1>";
                        XmlStr += "<pWeekdayTime2>" + dv[i]["pWeekdayTime1"].ToString() + "</pWeekdayTime2>";
                        XmlStr += "<pWeekdayTime3>" + dv[i]["pWeekdayTime1"].ToString() + "</pWeekdayTime3>";
                        XmlStr += "<pWeekdaySalary1>" + dv[i]["pWeekdaySalary1"].ToString() + "</pWeekdaySalary1>";
                        XmlStr += "<pWeekdaySalary2>" + dv[i]["pWeekdaySalary2"].ToString() + "</pWeekdaySalary2>";
                        XmlStr += "<pWeekdaySalary3>" + dv[i]["pWeekdaySalary3"].ToString() + "</pWeekdaySalary3>";

                        XmlStr += "<pOffDayTime1>" + dv[i]["pOffDayTime1"].ToString() + "</pOffDayTime1>";
                        XmlStr += "<pOffDayTime2>" + dv[i]["pOffDayTime2"].ToString() + "</pOffDayTime2>";
                        XmlStr += "<pOffDayTime3>" + dv[i]["pOffDayTime3"].ToString() + "</pOffDayTime3>";
                        XmlStr += "<pOffDaySalary1>" + dv[i]["pOffDaySalary1"].ToString() + "</pOffDaySalary1>";
                        XmlStr += "<pOffDaySalary2>" + dv[i]["pOffDaySalary2"].ToString() + "</pOffDaySalary2>";
                        XmlStr += "<pOffDaySalary3>" + dv[i]["pOffDaySalary3"].ToString() + "</pOffDaySalary3>";

                        XmlStr += "<pHolidayTime1>" + dv[i]["pHolidayTime1"].ToString() + "</pHolidayTime1>";
                        XmlStr += "<pHolidayTime2>" + dv[i]["pHolidayTime2"].ToString() + "</pHolidayTime2>";
                        XmlStr += "<pHolidayTime3>" + dv[i]["pHolidayTime3"].ToString() + "</pHolidayTime3>";
                        XmlStr += "<pHolidayTime4>" + dv[i]["pHolidayTime4"].ToString() + "</pHolidayTime4>";
                        XmlStr += "<pHolidaySalary1>" + dv[i]["pHolidaySalary1"].ToString() + "</pHolidaySalary1>";
                        XmlStr += "<pHolidaySalary2>" + dv[i]["pHolidaySalary2"].ToString() + "</pHolidaySalary2>";
                        XmlStr += "<pHolidaySalary3>" + dv[i]["pHolidaySalary3"].ToString() + "</pHolidaySalary3>";
                        XmlStr += "<pHolidaySalary4>" + dv[i]["pHolidaySalary4"].ToString() + "</pHolidaySalary4>";
                        XmlStr += "<pHolidayDutyFree>" + dv[i]["pHolidayDutyFree"].ToString() + "</pHolidayDutyFree>";
                        XmlStr += "<pHolidayTaxation>" + dv[i]["pHolidayTaxation"].ToString() + "</pHolidayTaxation>";

                        XmlStr += "<pNationalholidaysTime1>" + dv[i]["pNationalholidaysTime1"].ToString() + "</pNationalholidaysTime1>";
                        XmlStr += "<pNationalholidaysTime2>" + dv[i]["pNationalholidaysTime2"].ToString() + "</pNationalholidaysTime2>";
                        XmlStr += "<pNationalholidaysTime3>" + dv[i]["pNationalholidaysTime3"].ToString() + "</pNationalholidaysTime3>";
                        XmlStr += "<pNationalholidaysTime4>" + dv[i]["pNationalholidaysTime4"].ToString() + "</pNationalholidaysTime4>";
                        XmlStr += "<pNationalholidaysSalary1>" + dv[i]["pNationalholidaysSalary1"].ToString() + "</pNationalholidaysSalary1>";
                        XmlStr += "<pNationalholidaysSalary2>" + dv[i]["pNationalholidaysSalary2"].ToString() + "</pNationalholidaysSalary2>";
                        XmlStr += "<pNationalholidaysSalary3>" + dv[i]["pNationalholidaysSalary3"].ToString() + "</pNationalholidaysSalary3>";
                        XmlStr += "<pNationalholidaysSalary4>" + dv[i]["pNationalholidaysSalary4"].ToString() + "</pNationalholidaysSalary4>";
                        XmlStr += "<pNationalholidaysDutyFree>" + dv[i]["pNationalholidaysDutyFree"].ToString() + "</pNationalholidaysDutyFree>";
                        XmlStr += "<pNationalholidaysTaxation>" + dv[i]["pNationalholidaysTaxation"].ToString() + "</pNationalholidaysTaxation>";

                        XmlStr += "<pSpecialholidaysTime1>" + dv[i]["pSpecialholidaysTime1"].ToString() + "</pSpecialholidaysTime1>";
                        XmlStr += "<pSpecialholidaysTime2>" + dv[i]["pSpecialholidaysTime2"].ToString() + "</pSpecialholidaysTime2>";
                        XmlStr += "<pSpecialholidaysTime3>" + dv[i]["pSpecialholidaysTime3"].ToString() + "</pSpecialholidaysTime3>";
                        XmlStr += "<pSpecialholidaysTime4>" + dv[i]["pSpecialholidaysTime4"].ToString() + "</pSpecialholidaysTime4>";
                        XmlStr += "<pSpecialholidaysSalary1>" + dv[i]["pSpecialholidaysSalary1"].ToString() + "</pSpecialholidaysSalary1>";
                        XmlStr += "<pSpecialholidaysSalary2>" + dv[i]["pSpecialholidaysSalary2"].ToString() + "</pSpecialholidaysSalary2>";
                        XmlStr += "<pSpecialholidaysSalary3>" + dv[i]["pSpecialholidaysSalary3"].ToString() + "</pSpecialholidaysSalary3>";
                        XmlStr += "<pSpecialholidaysSalary4>" + dv[i]["pSpecialholidaysSalary4"].ToString() + "</pSpecialholidaysSalary4>";
                        XmlStr += "<pSpecialholidaysDutyFree>" + dv[i]["pSpecialholidaysDutyFree"].ToString() + "</pSpecialholidaysDutyFree>";
                        XmlStr += "<pSpecialholidaysTaxation>" + dv[i]["pSpecialholidaysTaxation"].ToString() + "</pSpecialholidaysTaxation>";

                        XmlStr += "<pHolidaySumDutyFree>" + dv[i]["pHolidaySumDutyFree"].ToString() + "</pHolidaySumDutyFree>";
                        XmlStr += "<pHolidaySumTaxation>" + dv[i]["pHolidaySumTaxation"].ToString() + "</pHolidaySumTaxation>";

                        XmlStr += "<pAttendanceDays>" + dv[i]["pAttendanceDays"].ToString() + "</pAttendanceDays>";
                        XmlStr += "<pAttendanceTimes>" + dv[i]["pAttendanceTimes"].ToString() + "</pAttendanceTimes>";
                        XmlStr += "<pPayLeave>" + dv[i]["pPayLeave"].ToString() + "</pPayLeave>";

                        XmlStr += "<pAnnualLeaveTimes>" + dv[i]["pAnnualLeaveTimes"].ToString() + "</pAnnualLeaveTimes>";
                        XmlStr += "<pAnnualLeaveSalary>" + dv[i]["pAnnualLeaveSalary"].ToString() + "</pAnnualLeaveSalary>";
                        XmlStr += "<pSickLeaveTimes>" + dv[i]["pSickLeaveTimes"].ToString() + "</pSickLeaveTimes>";
                        XmlStr += "<pSickLeaveSalary>" + dv[i]["pSickLeaveSalary"].ToString() + "</pSickLeaveSalary>";
                        XmlStr += "<pMarriageLeaveTimes>" + dv[i]["pMarriageLeaveTimes"].ToString() + "</pMarriageLeaveTimes>";
                        XmlStr += "<pMarriageLeaveSalary>" + dv[i]["pMarriageLeaveSalary"].ToString() + "</pMarriageLeaveSalary>";
                        XmlStr += "<pFuneralLeaveTimes>" + dv[i]["pFuneralLeaveTimes"].ToString() + "</pFuneralLeaveTimes>";
                        XmlStr += "<pFuneralLeaveSalary>" + dv[i]["pFuneralLeaveSalary"].ToString() + "</pFuneralLeaveSalary>";
                        XmlStr += "<pMaternityLeaveTimes>" + dv[i]["pMaternityLeaveTimes"].ToString() + "</pMaternityLeaveTimes>";
                        XmlStr += "<pMaternityLeaveSalary>" + dv[i]["pMaternityLeaveSalary"].ToString() + "</pMaternityLeaveSalary>";

                        XmlStr += "<pProductionLeaveTimes>" + dv[i]["pProductionLeaveTimes"].ToString() + "</pProductionLeaveTimes>";
                        XmlStr += "<pProductionLeaveSalary>" + dv[i]["pProductionLeaveSalary"].ToString() + "</pProductionLeaveSalary>";
                        XmlStr += "<pMilitaryLeaveTimes>" + dv[i]["pMilitaryLeaveTimes"].ToString() + "</pMilitaryLeaveTimes>";
                        XmlStr += "<pMilitaryLeaveSalary>" + dv[i]["pMilitaryLeaveSalary"].ToString() + "</pMilitaryLeaveSalary>";

                        XmlStr += "<pHonoraryLeaveTimes>" + dv[i]["pHonoraryLeaveTimes"].ToString() + "</pHonoraryLeaveTimes>";
                        XmlStr += "<pHonoraryLeaveSalary>" + dv[i]["pHonoraryLeaveSalary"].ToString() + "</pHonoraryLeaveSalary>";
                        XmlStr += "<pTaxDeduction>" + dv[i]["pTaxDeduction"].ToString() + "</pTaxDeduction>";
                        XmlStr += "<pPay>" + dv[i]["pPay"].ToString() + "</pPay>";
                        XmlStr += "<pTaxation>" + dv[i]["pTaxation"].ToString() + "</pTaxation>";
                        XmlStr += "<pPremium>" + dv[i]["pPremium"].ToString() + "</pPremium>";
                        XmlStr += "<pOverTimeDutyfree>" + dv[i]["pOverTimeDutyfree"].ToString() + "</pOverTimeDutyfree>";
                        XmlStr += "<pOverTimeTaxation>" + dv[i]["pOverTimeTaxation"].ToString() + "</pOverTimeTaxation>";

                        XmlStr += "<pPersonInsurance>" + dv[i]["pPersonInsurance"].ToString() + "</pPersonInsurance>";
                        XmlStr += "<pPersonLabor>" + dv[i]["pPersonLabor"].ToString() + "</pPersonLabor>";
                        XmlStr += "<pPersonPension>" + dv[i]["pPersonPension"].ToString() + "</pPersonPension>";
                        XmlStr += "<pCompanyPension>" + dv[i]["pCompanyPension"].ToString() + "</pCompanyPension>";
                        XmlStr += "<pStatus>" + dv[i]["pStatus"].ToString() + "</pStatus>";
                        XmlStr += "<pComInsurance>" + dv[i]["pComInsurance"].ToString() + "</pComInsurance>";
                        XmlStr += "<pComLabor>" + dv[i]["pComLabor"].ToString() + "</pComLabor>";
                        XmlStr += "<pAnnualLeavePro>" + dv[i]["pAnnualLeavePro"].ToString() + "</pAnnualLeavePro>";
                        XmlStr += "<pP1Time>" + dv[i]["pP1Time"].ToString() + "</pP1Time>";
                        XmlStr += "<pIntertemporal>" + dv[i]["pIntertemporal"].ToString() + "</pIntertemporal>";
                        XmlStr += "<sr_Year>" + dv[i]["sr_Year"].ToString() + "</sr_Year>";
                        XmlStr += "<sr_BeginDate>" + context.Server.HtmlEncode(dv[i]["sr_BeginDate"].ToString()) + "</sr_BeginDate>";
                        XmlStr += "<sr_Enddate>" +context.Server.HtmlEncode( dv[i]["sr_Enddate"].ToString()) + "</sr_Enddate>";
                        XmlStr += "<sr_SalaryDate>" + context.Server.HtmlEncode(dv[i]["sr_SalaryDate"].ToString()) + "</sr_SalaryDate>";
                        XmlStr += "</dView>";
                    }
                    XmlStr += "</dList>";

                    context.Response.Write(XmlStr);
                }
                else { context.Response.Write("<dList>DangerWord</dList>"); }
            }
            else { context.Response.Write("<dList>Timeout</dList>"); }
        }
        catch (Exception ex)
        {
            //ErrorLog err = new ErrorLog();
            //err.InsErrorLog("ashx_NewStaffList.ashx", ex.Message, USERINFO.MemberEmpno);
            context.Response.Write("<dList>error</dList>");
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