<%@ WebHandler Language="C#" Class="ashx_SelPayrollTmp" %>

using System;
using System.Web;
using System.Data;
public class ashx_SelPayrollTmp : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
      Common com = new Common();
    payroll.gdal dal = new payroll.gdal();  
    public void ProcessRequest (HttpContext context) {
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
                    dv = dal.SelSy_PaySalaryDetailTmp(pModel).DefaultView;

                    //string paging = (Math.Ceiling(decimal.Parse((dvList.Count / 10).ToString())) + 1).ToString();
                    XmlStr += "<dList>";
                    for (int i = 0; i < dv.Count; i++)
                    {
                        XmlStr += "<dView>";
                        XmlStr += "<pGuid>" + dv[i]["pGuid_Tmp"].ToString() + "</pGuid>";
                        XmlStr += "<pPsmGuid>" + dv[i]["pPsmGuid_Tmp"].ToString() + "</pPsmGuid>";
                        XmlStr += "<pPerGuid>" + dv[i]["pPerGuid_Tmp"].ToString() + "</pPerGuid>";
                        XmlStr += "<pPerNo>" + dv[i]["pPerNo_Tmp"].ToString() + "</pPerNo>";
                        XmlStr += "<pPerName>" + dv[i]["pPerName_Tmp"].ToString() + "</pPerName>";
                        XmlStr += "<pPerCompanyName>" + dv[i]["pPerCompanyName_Tmp"].ToString() + "</pPerCompanyName>";
                        XmlStr += "<pPerDep>" + dv[i]["pPerDep_Tmp"].ToString() + "</pPerDep>";

                        XmlStr += "<pWeekdayTime1>" + com.checkNumber(dv[i]["pWeekdayTime1_Tmp"].ToString()) + "</pWeekdayTime1>";
                        XmlStr += "<pWeekdayTime2>" + com.checkNumber(dv[i]["pWeekdayTime2_Tmp"].ToString()) + "</pWeekdayTime2>";
                        XmlStr += "<pWeekdayTime3>" + com.checkNumber(dv[i]["pWeekdayTime3_Tmp"].ToString()) + "</pWeekdayTime3>";
                        XmlStr += "<pWeekdaySalary1>" + com.checkNumber(dv[i]["pWeekdaySalary1_Tmp"].ToString()) + "</pWeekdaySalary1>";
                        XmlStr += "<pWeekdaySalary2>" + com.checkNumber(dv[i]["pWeekdaySalary2_Tmp"].ToString()) + "</pWeekdaySalary2>";
                        XmlStr += "<pWeekdaySalary3>" + com.checkNumber(dv[i]["pWeekdaySalary3_Tmp"].ToString()) + "</pWeekdaySalary3>";

                        XmlStr += "<pOffDayTime1>" + com.checkNumber(dv[i]["pOffDayTime1_Tmp"].ToString()) + "</pOffDayTime1>";
                        XmlStr += "<pOffDayTime2>" + com.checkNumber(dv[i]["pOffDayTime2_Tmp"].ToString()) + "</pOffDayTime2>";
                        XmlStr += "<pOffDayTime3>" + com.checkNumber(dv[i]["pOffDayTime3_Tmp"].ToString()) + "</pOffDayTime3>";
                        XmlStr += "<pOffDaySalary1>" + com.checkNumber(dv[i]["pOffDaySalary1_Tmp"].ToString()) + "</pOffDaySalary1>";
                        XmlStr += "<pOffDaySalary2>" + com.checkNumber(dv[i]["pOffDaySalary2_Tmp"].ToString()) + "</pOffDaySalary2>";
                        XmlStr += "<pOffDaySalary3>" + com.checkNumber(dv[i]["pOffDaySalary3_Tmp"].ToString()) + "</pOffDaySalary3>";

                        XmlStr += "<pHolidayTime1>" + com.checkNumber(dv[i]["pHolidayTime1_Tmp"].ToString()) + "</pHolidayTime1>";
                        XmlStr += "<pHolidayTime2>" + com.checkNumber(dv[i]["pHolidayTime2_Tmp"].ToString()) + "</pHolidayTime2>";
                        XmlStr += "<pHolidayTime3>" + com.checkNumber(dv[i]["pHolidayTime3_Tmp"].ToString()) + "</pHolidayTime3>";
                        XmlStr += "<pHolidayTime4>" + com.checkNumber(dv[i]["pHolidayTime4_Tmp"].ToString()) + "</pHolidayTime4>";
                        XmlStr += "<pHolidaySalary1>" + com.checkNumber(dv[i]["pHolidaySalary1_Tmp"].ToString()) + "</pHolidaySalary1>";
                        XmlStr += "<pHolidaySalary2>" + com.checkNumber(dv[i]["pHolidaySalary2_Tmp"].ToString()) + "</pHolidaySalary2>";
                        XmlStr += "<pHolidaySalary3>" + com.checkNumber(dv[i]["pHolidaySalary3_Tmp"].ToString()) + "</pHolidaySalary3>";
                        XmlStr += "<pHolidaySalary4>" + com.checkNumber(dv[i]["pHolidaySalary4_Tmp"].ToString()) + "</pHolidaySalary4>";
                        XmlStr += "<pHolidayDutyFree>" + com.checkNumber(dv[i]["pHolidayDutyFree_Tmp"].ToString()) + "</pHolidayDutyFree>";
                        XmlStr += "<pHolidayTaxation>" + com.checkNumber(dv[i]["pHolidayTaxation_Tmp"].ToString()) + "</pHolidayTaxation>";

                        XmlStr += "<pNationalholidaysTime1>" + com.checkNumber(dv[i]["pNationalholidaysTime1_Tmp"].ToString()) + "</pNationalholidaysTime1>";
                        XmlStr += "<pNationalholidaysTime2>" + com.checkNumber(dv[i]["pNationalholidaysTime2_Tmp"].ToString()) + "</pNationalholidaysTime2>";
                        XmlStr += "<pNationalholidaysTime3>" + com.checkNumber(dv[i]["pNationalholidaysTime3_Tmp"].ToString()) + "</pNationalholidaysTime3>";
                        XmlStr += "<pNationalholidaysTime4>" + com.checkNumber(dv[i]["pNationalholidaysTime4_Tmp"].ToString()) + "</pNationalholidaysTime4>";
                        XmlStr += "<pNationalholidaysSalary1>" + com.checkNumber(dv[i]["pNationalholidaysSalary1_Tmp"].ToString()) + "</pNationalholidaysSalary1>";
                        XmlStr += "<pNationalholidaysSalary2>" + com.checkNumber(dv[i]["pNationalholidaysSalary2_Tmp"].ToString()) + "</pNationalholidaysSalary2>";
                        XmlStr += "<pNationalholidaysSalary3>" + com.checkNumber(dv[i]["pNationalholidaysSalary3_Tmp"].ToString()) + "</pNationalholidaysSalary3>";
                        XmlStr += "<pNationalholidaysSalary4>" + com.checkNumber(dv[i]["pNationalholidaysSalary4_Tmp"].ToString()) + "</pNationalholidaysSalary4>";
                        XmlStr += "<pNationalholidaysDutyFree>" + com.checkNumber(dv[i]["pNationalholidaysDutyFree_Tmp"].ToString()) + "</pNationalholidaysDutyFree>";
                        XmlStr += "<pNationalholidaysTaxation>" + com.checkNumber(dv[i]["pNationalholidaysTaxation_Tmp"].ToString()) + "</pNationalholidaysTaxation>";

                        XmlStr += "<pSpecialholidaysTime1>" + com.checkNumber(dv[i]["pSpecialholidaysTime1_Tmp"].ToString()) + "</pSpecialholidaysTime1>";
                        XmlStr += "<pSpecialholidaysTime2>" + com.checkNumber(dv[i]["pSpecialholidaysTime2_Tmp"].ToString()) + "</pSpecialholidaysTime2>";
                        XmlStr += "<pSpecialholidaysTime3>" + com.checkNumber(dv[i]["pSpecialholidaysTime3_Tmp"].ToString()) + "</pSpecialholidaysTime3>";
                        XmlStr += "<pSpecialholidaysTime4>" + com.checkNumber(dv[i]["pSpecialholidaysTime4_Tmp"].ToString()) + "</pSpecialholidaysTime4>";
                        XmlStr += "<pSpecialholidaysSalary1>" + com.checkNumber(dv[i]["pSpecialholidaysSalary1_Tmp"].ToString()) + "</pSpecialholidaysSalary1>";
                        XmlStr += "<pSpecialholidaysSalary2>" + com.checkNumber(dv[i]["pSpecialholidaysSalary2_Tmp"].ToString()) + "</pSpecialholidaysSalary2>";
                        XmlStr += "<pSpecialholidaysSalary3>" + com.checkNumber(dv[i]["pSpecialholidaysSalary3_Tmp"].ToString()) + "</pSpecialholidaysSalary3>";
                        XmlStr += "<pSpecialholidaysSalary4>" + com.checkNumber(dv[i]["pSpecialholidaysSalary4_Tmp"].ToString()) + "</pSpecialholidaysSalary4>";
                        XmlStr += "<pSpecialholidaysDutyFree>" + com.checkNumber(dv[i]["pSpecialholidaysDutyFree_Tmp"].ToString()) + "</pSpecialholidaysDutyFree>";
                        XmlStr += "<pSpecialholidaysTaxation>" + com.checkNumber(dv[i]["pSpecialholidaysTaxation_Tmp"].ToString()) + "</pSpecialholidaysTaxation>";

                        XmlStr += "<pHolidaySumDutyFree>" + com.checkNumber(dv[i]["pHolidaySumDutyFree_Tmp"].ToString()) + "</pHolidaySumDutyFree>";
                        XmlStr += "<pHolidaySumTaxation>" + com.checkNumber(dv[i]["pHolidaySumTaxation_Tmp"].ToString()) + "</pHolidaySumTaxation>";

                        XmlStr += "<pAttendanceDays>" + com.checkNumber(dv[i]["pAttendanceDays_Tmp"].ToString()) + "</pAttendanceDays>";
                        XmlStr += "<pAttendanceTimes>" + com.checkNumber(dv[i]["pAttendanceTimes_Tmp"].ToString()) + "</pAttendanceTimes>";
                        XmlStr += "<pPayLeave>" + com.checkNumber(dv[i]["pPayLeave_Tmp"].ToString()) + "</pPayLeave>";

                        XmlStr += "<pAnnualLeaveTimes>" + com.checkNumber(dv[i]["pAnnualLeaveTimes_Tmp"].ToString()) + "</pAnnualLeaveTimes>";
                        XmlStr += "<pAnnualLeaveSalary>" + com.checkNumber(dv[i]["pAnnualLeaveSalary_Tmp"].ToString()) + "</pAnnualLeaveSalary>";
                        XmlStr += "<pSickLeaveTimes>" + com.checkNumber(dv[i]["pSickLeaveTimes_Tmp"].ToString()) + "</pSickLeaveTimes>";
                        XmlStr += "<pSickLeaveSalary>" + com.checkNumber(dv[i]["pSickLeaveSalary_Tmp"].ToString()) + "</pSickLeaveSalary>";
                        XmlStr += "<pMarriageLeaveTimes>" + com.checkNumber(dv[i]["pMarriageLeaveTimes_Tmp"].ToString()) + "</pMarriageLeaveTimes>";
                        XmlStr += "<pMarriageLeaveSalary>" + com.checkNumber(dv[i]["pMarriageLeaveSalary_Tmp"].ToString()) + "</pMarriageLeaveSalary>";
                        XmlStr += "<pFuneralLeaveTimes>" + com.checkNumber(dv[i]["pFuneralLeaveTimes_Tmp"].ToString()) + "</pFuneralLeaveTimes>";
                        XmlStr += "<pFuneralLeaveSalary>" + com.checkNumber(dv[i]["pFuneralLeaveSalary_Tmp"].ToString()) + "</pFuneralLeaveSalary>";
                        XmlStr += "<pMaternityLeaveTimes>" + com.checkNumber(dv[i]["pMaternityLeaveTimes_Tmp"].ToString()) + "</pMaternityLeaveTimes>";
                        XmlStr += "<pMaternityLeaveSalary>" + com.checkNumber(dv[i]["pMaternityLeaveSalary_Tmp"].ToString()) + "</pMaternityLeaveSalary>";

                        XmlStr += "<pHonoraryLeaveTimes>" + com.checkNumber(dv[i]["pHonoraryLeaveTimes_Tmp"].ToString()) + "</pHonoraryLeaveTimes>";
                        XmlStr += "<pHonoraryLeaveSalary>" + com.checkNumber(dv[i]["pHonoraryLeaveSalary_Tmp"].ToString()) + "</pHonoraryLeaveSalary>";
                        XmlStr += "<pAbortionLeaveTimes>" + com.checkNumber(dv[i]["pAbortionLeaveTimes_Tmp"].ToString()) + "</pAbortionLeaveTimes>";
                        XmlStr += "<pAbortionLeaveSalary>" + com.checkNumber(dv[i]["pAbortionLeaveSalary_Tmp"].ToString()) + "</pAbortionLeaveSalary>";
                        XmlStr += "<pMilitaryLeaveTimes>" + com.checkNumber(dv[i]["pMilitaryLeaveTimes_Tmp"].ToString()) + "</pMilitaryLeaveTimes>";
                        XmlStr += "<pMilitaryLeaveSalary>" + com.checkNumber(dv[i]["pMilitaryLeaveSalary_Tmp"].ToString()) + "</pMilitaryLeaveSalary>";
                        XmlStr += "<pProductionLeaveTimes>" + com.checkNumber(dv[i]["pProductionLeaveTimes_Tmp"].ToString()) + "</pProductionLeaveTimes>";
                        XmlStr += "<pProductionLeaveSalary>" + com.checkNumber(dv[i]["pProductionLeaveSalary_Tmp"].ToString()) + "</pProductionLeaveSalary>";

                        XmlStr += "<pTaxDeduction>" + com.checkNumber(dv[i]["pTaxDeduction_Tmp"].ToString()) + "</pTaxDeduction>";
                        XmlStr += "<pPay>" + com.checkNumber(dv[i]["pPay_Tmp"].ToString()) + "</pPay>";
                        XmlStr += "<pTaxation>" + com.checkNumber(dv[i]["pTaxation_Tmp"].ToString()) + "</pTaxation>";
                        XmlStr += "<pTax>" + com.checkNumber(dv[i]["pTax_Tmp"].ToString()) + "</pTax>";
                        XmlStr += "<pPremium>" + com.checkNumber(dv[i]["pPremium_Tmp"].ToString()) + "</pPremium>";
                        XmlStr += "<pOverTimeDutyfree>" + com.checkNumber(dv[i]["pOverTimeDutyfree_Tmp"].ToString()) + "</pOverTimeDutyfree>";
                        XmlStr += "<pOverTimeTaxation>" + com.checkNumber(dv[i]["pOverTimeTaxation_Tmp"].ToString()) + "</pOverTimeTaxation>";

                        XmlStr += "<pPersonInsurance>" + com.checkNumber(dv[i]["pPersonInsurance_Tmp"].ToString()) + "</pPersonInsurance>";
                        XmlStr += "<pPersonLabor>" + com.checkNumber(dv[i]["pPersonLabor_Tmp"].ToString()) + "</pPersonLabor>";
                        XmlStr += "<pPersonPension>" + com.checkNumber(dv[i]["pPersonPension_Tmp"].ToString()) + "</pPersonPension>";
                        XmlStr += "<pCompanyPension>" + com.checkNumber(dv[i]["pCompanyPension_Tmp"].ToString()) + "</pCompanyPension>";
                        XmlStr += "<pPersonPensionSum>" + com.checkNumber(dv[i]["pPersonPensionSum"].ToString()) + "</pPersonPensionSum>";
                        XmlStr += "<pCompanyPensionSum>" + com.checkNumber(dv[i]["pCompanyPensionSum"].ToString()) + "</pCompanyPensionSum>";
                        XmlStr += "<pStatus>" + dv[i]["pStatus_Tmp"].ToString() + "</pStatus>";
                        XmlStr += "<pComInsurance>" + com.checkNumber(dv[i]["pComInsurance_Tmp"].ToString()) + "</pComInsurance>";
                        XmlStr += "<pComLabor>" + com.checkNumber(dv[i]["pComLabor_Tmp"].ToString()) + "</pComLabor>";
                        XmlStr += "<pAnnualLeavePro>" + com.checkNumber(dv[i]["pAnnualLeavePro_Tmp"].ToString()) + "</pAnnualLeavePro>";
                        XmlStr += "<pP1Time>" + com.checkNumber(dv[i]["pP1Time_Tmp"].ToString()) + "</pP1Time>";
                        XmlStr += "<pIntertemporal>" + com.checkNumber(dv[i]["pIntertemporal_Tmp"].ToString()) + "</pIntertemporal>";
                        XmlStr += "<sr_Year>" + com.checkNumber(dv[i]["sr_Year"].ToString()) + "</sr_Year>";
                        XmlStr += "<sr_BeginDate>" + context.Server.HtmlEncode(dv[i]["sr_BeginDate"].ToString()) + "</sr_BeginDate>";
                        XmlStr += "<sr_Enddate>" + context.Server.HtmlEncode(dv[i]["sr_Enddate"].ToString()) + "</sr_Enddate>";
                        XmlStr += "<sr_SalaryDate>" + context.Server.HtmlEncode(dv[i]["sr_SalaryDate"].ToString()) + "</sr_SalaryDate>";
                        XmlStr += "<sr_Guid>" + dv[i]["sr_Guid"].ToString() + "</sr_Guid>";
                        XmlStr += "<pSalary>" + dv[i]["pSalary_Tmp"].ToString() + "</pSalary>";
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