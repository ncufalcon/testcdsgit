<%@ WebHandler Language="C#" Class="ashx_SelPayroll" %>

using System;
using System.Web;
using System.Data;
public class ashx_SelPayroll : IHttpHandler,System.Web.SessionState.IReadOnlySessionState {
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
                string guid = (!string.IsNullOrEmpty(context.Request.Form["guid"])) ? context.Request.Form["guid"].ToString() : "";



                string[] str = { guid };
                string sqlinj = com.CheckSqlInJection(str);

                payroll.model.sy_PayRoll pModel = new payroll.model.sy_PayRoll();
                pModel.pGuid = guid;
                pModel.pPerNo = "";
                pModel.pPerName = "";
                pModel.pPerCompanyName = "";
                pModel.pPerDep = "";
                pModel.sr_Guid = "";

                if (sqlinj == "")
                {
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

                        XmlStr += "<pWeekdayTime1>" + com.checkNumber(dv[i]["pWeekdayTime1"].ToString()) + "</pWeekdayTime1>";
                        XmlStr += "<pWeekdayTime2>" + com.checkNumber(dv[i]["pWeekdayTime2"].ToString()) + "</pWeekdayTime2>";
                        XmlStr += "<pWeekdayTime3>" + com.checkNumber(dv[i]["pWeekdayTime3"].ToString()) + "</pWeekdayTime3>";
                        XmlStr += "<pWeekdaySalary1>" + com.checkNumber(dv[i]["pWeekdaySalary1"].ToString()) + "</pWeekdaySalary1>";
                        XmlStr += "<pWeekdaySalary2>" + com.checkNumber(dv[i]["pWeekdaySalary2"].ToString()) + "</pWeekdaySalary2>";
                        XmlStr += "<pWeekdaySalary3>" + com.checkNumber(dv[i]["pWeekdaySalary3"].ToString()) + "</pWeekdaySalary3>";

                        XmlStr += "<pOffDayTime1>" + com.checkNumber(dv[i]["pOffDayTime1"].ToString()) + "</pOffDayTime1>";
                        XmlStr += "<pOffDayTime2>" + com.checkNumber(dv[i]["pOffDayTime2"].ToString()) + "</pOffDayTime2>";
                        XmlStr += "<pOffDayTime3>" + com.checkNumber(dv[i]["pOffDayTime3"].ToString()) + "</pOffDayTime3>";
                        XmlStr += "<pOffDaySalary1>" + com.checkNumber(dv[i]["pOffDaySalary1"].ToString()) + "</pOffDaySalary1>";
                        XmlStr += "<pOffDaySalary2>" + com.checkNumber(dv[i]["pOffDaySalary2"].ToString()) + "</pOffDaySalary2>";
                        XmlStr += "<pOffDaySalary3>" + com.checkNumber(dv[i]["pOffDaySalary3"].ToString()) + "</pOffDaySalary3>";

                        XmlStr += "<pHolidayTime1>" + com.checkNumber(dv[i]["pHolidayTime1"].ToString()) + "</pHolidayTime1>";
                        XmlStr += "<pHolidayTime2>" + com.checkNumber(dv[i]["pHolidayTime2"].ToString()) + "</pHolidayTime2>";
                        XmlStr += "<pHolidayTime3>" + com.checkNumber(dv[i]["pHolidayTime3"].ToString()) + "</pHolidayTime3>";
                        XmlStr += "<pHolidayTime4>" + com.checkNumber(dv[i]["pHolidayTime4"].ToString()) + "</pHolidayTime4>";
                        XmlStr += "<pHolidaySalary1>" + com.checkNumber(dv[i]["pHolidaySalary1"].ToString()) + "</pHolidaySalary1>";
                        XmlStr += "<pHolidaySalary2>" + com.checkNumber(dv[i]["pHolidaySalary2"].ToString()) + "</pHolidaySalary2>";
                        XmlStr += "<pHolidaySalary3>" + com.checkNumber(dv[i]["pHolidaySalary3"].ToString()) + "</pHolidaySalary3>";
                        XmlStr += "<pHolidaySalary4>" + com.checkNumber(dv[i]["pHolidaySalary4"].ToString()) + "</pHolidaySalary4>";
                        XmlStr += "<pHolidayDutyFree>" + com.checkNumber(dv[i]["pHolidayDutyFree"].ToString()) + "</pHolidayDutyFree>";
                        XmlStr += "<pHolidayTaxation>" + com.checkNumber(dv[i]["pHolidayTaxation"].ToString()) + "</pHolidayTaxation>";

                        XmlStr += "<pNationalholidaysTime1>" + com.checkNumber(dv[i]["pNationalholidaysTime1"].ToString()) + "</pNationalholidaysTime1>";
                        XmlStr += "<pNationalholidaysTime2>" + com.checkNumber(dv[i]["pNationalholidaysTime2"].ToString()) + "</pNationalholidaysTime2>";
                        XmlStr += "<pNationalholidaysTime3>" + com.checkNumber(dv[i]["pNationalholidaysTime3"].ToString()) + "</pNationalholidaysTime3>";
                        XmlStr += "<pNationalholidaysTime4>" + com.checkNumber(dv[i]["pNationalholidaysTime4"].ToString()) + "</pNationalholidaysTime4>";
                        XmlStr += "<pNationalholidaysSalary1>" + com.checkNumber(dv[i]["pNationalholidaysSalary1"].ToString()) + "</pNationalholidaysSalary1>";
                        XmlStr += "<pNationalholidaysSalary2>" + com.checkNumber(dv[i]["pNationalholidaysSalary2"].ToString()) + "</pNationalholidaysSalary2>";
                        XmlStr += "<pNationalholidaysSalary3>" + com.checkNumber(dv[i]["pNationalholidaysSalary3"].ToString()) + "</pNationalholidaysSalary3>";
                        XmlStr += "<pNationalholidaysSalary4>" + com.checkNumber(dv[i]["pNationalholidaysSalary4"].ToString()) + "</pNationalholidaysSalary4>";
                        XmlStr += "<pNationalholidaysDutyFree>" + com.checkNumber(dv[i]["pNationalholidaysDutyFree"].ToString()) + "</pNationalholidaysDutyFree>";
                        XmlStr += "<pNationalholidaysTaxation>" + com.checkNumber(dv[i]["pNationalholidaysTaxation"].ToString()) + "</pNationalholidaysTaxation>";

                        XmlStr += "<pSpecialholidaysTime1>" + com.checkNumber(dv[i]["pSpecialholidaysTime1"].ToString()) + "</pSpecialholidaysTime1>";
                        XmlStr += "<pSpecialholidaysTime2>" + com.checkNumber(dv[i]["pSpecialholidaysTime2"].ToString()) + "</pSpecialholidaysTime2>";
                        XmlStr += "<pSpecialholidaysTime3>" + com.checkNumber(dv[i]["pSpecialholidaysTime3"].ToString()) + "</pSpecialholidaysTime3>";
                        XmlStr += "<pSpecialholidaysTime4>" + com.checkNumber(dv[i]["pSpecialholidaysTime4"].ToString()) + "</pSpecialholidaysTime4>";
                        XmlStr += "<pSpecialholidaysSalary1>" + com.checkNumber(dv[i]["pSpecialholidaysSalary1"].ToString()) + "</pSpecialholidaysSalary1>";
                        XmlStr += "<pSpecialholidaysSalary2>" + com.checkNumber(dv[i]["pSpecialholidaysSalary2"].ToString()) + "</pSpecialholidaysSalary2>";
                        XmlStr += "<pSpecialholidaysSalary3>" + com.checkNumber(dv[i]["pSpecialholidaysSalary3"].ToString()) + "</pSpecialholidaysSalary3>";
                        XmlStr += "<pSpecialholidaysSalary4>" + com.checkNumber(dv[i]["pSpecialholidaysSalary4"].ToString()) + "</pSpecialholidaysSalary4>";
                        XmlStr += "<pSpecialholidaysDutyFree>" + com.checkNumber(dv[i]["pSpecialholidaysDutyFree"].ToString()) + "</pSpecialholidaysDutyFree>";
                        XmlStr += "<pSpecialholidaysTaxation>" + com.checkNumber(dv[i]["pSpecialholidaysTaxation"].ToString()) + "</pSpecialholidaysTaxation>";

                        XmlStr += "<pHolidaySumDutyFree>" + com.checkNumber(dv[i]["pHolidaySumDutyFree"].ToString()) + "</pHolidaySumDutyFree>";
                        XmlStr += "<pHolidaySumTaxation>" + com.checkNumber(dv[i]["pHolidaySumTaxation"].ToString()) + "</pHolidaySumTaxation>";

                        XmlStr += "<pAttendanceDays>" + com.checkNumber(dv[i]["pAttendanceDays"].ToString()) + "</pAttendanceDays>";
                        XmlStr += "<pAttendanceTimes>" + com.checkNumber(dv[i]["pAttendanceTimes"].ToString()) + "</pAttendanceTimes>";
                        XmlStr += "<pPayLeave>" + com.checkNumber(dv[i]["pPayLeave"].ToString()) + "</pPayLeave>";

                        XmlStr += "<pAnnualLeaveTimes>" + com.checkNumber(dv[i]["pAnnualLeaveTimes"].ToString()) + "</pAnnualLeaveTimes>";
                        XmlStr += "<pAnnualLeaveSalary>" + com.checkNumber(dv[i]["pAnnualLeaveSalary"].ToString()) + "</pAnnualLeaveSalary>";
                        XmlStr += "<pSickLeaveTimes>" + com.checkNumber(dv[i]["pSickLeaveTimes"].ToString()) + "</pSickLeaveTimes>";
                        XmlStr += "<pSickLeaveSalary>" + com.checkNumber(dv[i]["pSickLeaveSalary"].ToString()) + "</pSickLeaveSalary>";
                        XmlStr += "<pMarriageLeaveTimes>" + com.checkNumber(dv[i]["pMarriageLeaveTimes"].ToString()) + "</pMarriageLeaveTimes>";
                        XmlStr += "<pMarriageLeaveSalary>" + com.checkNumber(dv[i]["pMarriageLeaveSalary"].ToString()) + "</pMarriageLeaveSalary>";
                        XmlStr += "<pFuneralLeaveTimes>" + com.checkNumber(dv[i]["pFuneralLeaveTimes"].ToString()) + "</pFuneralLeaveTimes>";
                        XmlStr += "<pFuneralLeaveSalary>" + com.checkNumber(dv[i]["pFuneralLeaveSalary"].ToString()) + "</pFuneralLeaveSalary>";
                        XmlStr += "<pMaternityLeaveTimes>" + com.checkNumber(dv[i]["pMaternityLeaveTimes"].ToString()) + "</pMaternityLeaveTimes>";
                        XmlStr += "<pMaternityLeaveSalary>" + com.checkNumber(dv[i]["pMaternityLeaveSalary"].ToString()) + "</pMaternityLeaveSalary>";

                        XmlStr += "<pHonoraryLeaveTimes>" + com.checkNumber(dv[i]["pHonoraryLeaveTimes"].ToString()) + "</pHonoraryLeaveTimes>";
                        XmlStr += "<pHonoraryLeaveSalary>" + com.checkNumber(dv[i]["pHonoraryLeaveSalary"].ToString()) + "</pHonoraryLeaveSalary>";

                        XmlStr += "<pAbortionLeaveTimes>" + com.checkNumber(dv[i]["pAbortionLeaveTimes"].ToString()) + "</pAbortionLeaveTimes>";
                        XmlStr += "<pAbortionLeaveSalary>" + com.checkNumber(dv[i]["pAbortionLeaveSalary"].ToString()) + "</pAbortionLeaveSalary>";
                        XmlStr += "<pTaxDeduction>" + com.checkNumber(dv[i]["pTaxDeduction"].ToString()) + "</pTaxDeduction>";
                        XmlStr += "<pPay>" + com.checkNumber(dv[i]["pPay"].ToString()) + "</pPay>";
                        XmlStr += "<pTaxation>" + com.checkNumber(dv[i]["pTaxation"].ToString()) + "</pTaxation>";
                        XmlStr += "<pTax>" + com.checkNumber(dv[i]["pTax"].ToString()) + "</pTax>";
                        XmlStr += "<pPremium>" + com.checkNumber(dv[i]["pPremium"].ToString()) + "</pPremium>";
                        XmlStr += "<pOverTimeDutyfree>" + com.checkNumber(dv[i]["pOverTimeDutyfree"].ToString()) + "</pOverTimeDutyfree>";
                        XmlStr += "<pOverTimeTaxation>" + com.checkNumber(dv[i]["pOverTimeTaxation"].ToString()) + "</pOverTimeTaxation>";

                        XmlStr += "<pPersonInsurance>" + com.checkNumber(dv[i]["pPersonInsurance"].ToString()) + "</pPersonInsurance>";
                        XmlStr += "<pPersonLabor>" + com.checkNumber(dv[i]["pPersonLabor"].ToString()) + "</pPersonLabor>";
                        XmlStr += "<pPersonPension>" + com.checkNumber(dv[i]["pPersonPension"].ToString()) + "</pPersonPension>";
                        XmlStr += "<pCompanyPension>" + com.checkNumber(dv[i]["pCompanyPension"].ToString()) + "</pCompanyPension>";
                        XmlStr += "<pPersonPensionSum>" + com.checkNumber(dv[i]["pPersonPensionSum"].ToString()) + "</pPersonPensionSum>";
                        XmlStr += "<pCompanyPensionSum>" + com.checkNumber(dv[i]["pCompanyPensionSum"].ToString()) + "</pCompanyPensionSum>";
                        XmlStr += "<pStatus>" + dv[i]["pStatus"].ToString() + "</pStatus>";
                        XmlStr += "<pComInsurance>" + com.checkNumber(dv[i]["pComInsurance"].ToString()) + "</pComInsurance>";
                        XmlStr += "<pComLabor>" + com.checkNumber(dv[i]["pComLabor"].ToString()) + "</pComLabor>";
                        XmlStr += "<pAnnualLeavePro>" + com.checkNumber(dv[i]["pAnnualLeavePro"].ToString()) + "</pAnnualLeavePro>";
                        XmlStr += "<pP1Time>" + com.checkNumber(dv[i]["pP1Time"].ToString()) + "</pP1Time>";
                        XmlStr += "<pIntertemporal>" + com.checkNumber(dv[i]["pIntertemporal"].ToString()) + "</pIntertemporal>";
                        XmlStr += "<sr_Year>" + com.checkNumber(dv[i]["sr_Year"].ToString()) + "</sr_Year>";
                        XmlStr += "<sr_BeginDate>" + context.Server.HtmlEncode(dv[i]["sr_BeginDate"].ToString()) + "</sr_BeginDate>";
                        XmlStr += "<sr_Enddate>" + context.Server.HtmlEncode(dv[i]["sr_Enddate"].ToString()) + "</sr_Enddate>";
                        XmlStr += "<sr_SalaryDate>" + context.Server.HtmlEncode(dv[i]["sr_SalaryDate"].ToString()) + "</sr_SalaryDate>";
                        XmlStr += "<sr_Guid>" + dv[i]["sr_Guid"].ToString() + "</sr_Guid>";
                        XmlStr += "<pSalary>" + dv[i]["pSalary"].ToString() + "</pSalary>";
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

    public bool IsReusable {
        get {
            return false;
        }
    }

}