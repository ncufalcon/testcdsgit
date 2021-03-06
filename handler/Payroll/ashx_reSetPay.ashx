﻿<%@ WebHandler Language="C#" Class="ashx_reSetPay" %>

using System;
using System.Web;

public class ashx_reSetPay : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
    
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                //xml 解析
                string pGuid = (!string.IsNullOrEmpty(context.Request.Form["pGuid"])) ? context.Request.Form["pGuid"].ToString() : "";
                decimal pWeekdayTime1 = (!string.IsNullOrEmpty(context.Request.Form["pWeekdayTime1"])) ? decimal.Parse(context.Request.Form["pWeekdayTime1"].ToString()) : 0;
                decimal pWeekdayTime2 = (!string.IsNullOrEmpty(context.Request.Form["pWeekdayTime2"])) ? decimal.Parse(context.Request.Form["pWeekdayTime2"].ToString()) : 0;
                decimal pWeekdayTime3 = (!string.IsNullOrEmpty(context.Request.Form["pWeekdayTime3"])) ? decimal.Parse(context.Request.Form["pWeekdayTime3"].ToString()) : 0;
                decimal pWeekdaySalary1 = (!string.IsNullOrEmpty(context.Request.Form["pWeekdaySalary1"])) ? decimal.Parse(context.Request.Form["pWeekdaySalary1"].ToString()) : 0;
                decimal pWeekdaySalary2 = (!string.IsNullOrEmpty(context.Request.Form["pWeekdaySalary2"])) ? decimal.Parse(context.Request.Form["pWeekdaySalary2"].ToString()) : 0;
                decimal pWeekdaySalary3 = (!string.IsNullOrEmpty(context.Request.Form["pWeekdaySalary3"])) ? decimal.Parse(context.Request.Form["pWeekdaySalary3"].ToString()) : 0;

                decimal pOffDayTime1 = (!string.IsNullOrEmpty(context.Request.Form["pOffDayTime1"])) ? decimal.Parse(context.Request.Form["pOffDayTime1"].ToString()) : 0;
                decimal pOffDayTime2 = (!string.IsNullOrEmpty(context.Request.Form["pOffDayTime2"])) ? decimal.Parse(context.Request.Form["pOffDayTime2"].ToString()) : 0;
                decimal pOffDayTime3 = (!string.IsNullOrEmpty(context.Request.Form["pOffDayTime3"])) ? decimal.Parse(context.Request.Form["pOffDayTime3"].ToString()) : 0;
                decimal pOffDaySalary1 = (!string.IsNullOrEmpty(context.Request.Form["pOffDaySalary1"])) ? decimal.Parse(context.Request.Form["pOffDaySalary1"].ToString()) : 0;
                decimal pOffDaySalary2 = (!string.IsNullOrEmpty(context.Request.Form["pOffDaySalary2"])) ? decimal.Parse(context.Request.Form["pOffDaySalary2"].ToString()) : 0;
                decimal pOffDaySalary3 = (!string.IsNullOrEmpty(context.Request.Form["pOffDaySalary3"])) ? decimal.Parse(context.Request.Form["pOffDaySalary3"].ToString()) : 0;

                decimal pHolidayTime1 = (!string.IsNullOrEmpty(context.Request.Form["pHolidayTime1"])) ? decimal.Parse(context.Request.Form["pHolidayTime1"].ToString()) : 0;
                decimal pHolidayTime2 = (!string.IsNullOrEmpty(context.Request.Form["pHolidayTime2"])) ? decimal.Parse(context.Request.Form["pHolidayTime2"].ToString()) : 0;
                decimal pHolidayTime3 = (!string.IsNullOrEmpty(context.Request.Form["pHolidayTime3"])) ? decimal.Parse(context.Request.Form["pHolidayTime3"].ToString()) : 0;
                decimal pHolidayTime4 = (!string.IsNullOrEmpty(context.Request.Form["pHolidayTime4"])) ? decimal.Parse(context.Request.Form["pHolidayTime4"].ToString()) : 0;
                decimal pHolidaySalary1 = (!string.IsNullOrEmpty(context.Request.Form["pHolidaySalary1"])) ? decimal.Parse(context.Request.Form["pHolidaySalary1"].ToString()) : 0;
                decimal pHolidaySalary2 = (!string.IsNullOrEmpty(context.Request.Form["pHolidaySalary2"])) ? decimal.Parse(context.Request.Form["pHolidaySalary2"].ToString()) : 0;
                decimal pHolidaySalary3 = (!string.IsNullOrEmpty(context.Request.Form["pHolidaySalary3"])) ? decimal.Parse(context.Request.Form["pHolidaySalary3"].ToString()) : 0;
                decimal pHolidaySalary4 = (!string.IsNullOrEmpty(context.Request.Form["pHolidaySalary4"])) ? decimal.Parse(context.Request.Form["pHolidaySalary4"].ToString()) : 0;
                decimal pNationalholidaysTime1 = (!string.IsNullOrEmpty(context.Request.Form["pNationalholidaysTime1"])) ? decimal.Parse(context.Request.Form["pNationalholidaysTime1"].ToString()) : 0;
                decimal pNationalholidaysTime2 = (!string.IsNullOrEmpty(context.Request.Form["pNationalholidaysTime2"])) ? decimal.Parse(context.Request.Form["pNationalholidaysTime2"].ToString()) : 0;
                decimal pNationalholidaysTime3 = (!string.IsNullOrEmpty(context.Request.Form["pNationalholidaysTime3"])) ? decimal.Parse(context.Request.Form["pNationalholidaysTime3"].ToString()) : 0;
                decimal pNationalholidaysTime4 = (!string.IsNullOrEmpty(context.Request.Form["pNationalholidaysTime4"])) ? decimal.Parse(context.Request.Form["pNationalholidaysTime4"].ToString()) : 0;
                decimal pNationalholidaysSalary1 = (!string.IsNullOrEmpty(context.Request.Form["pNationalholidaysSalary1"])) ? decimal.Parse(context.Request.Form["pNationalholidaysSalary1"].ToString()) : 0;
                decimal pNationalholidaysSalary2 = (!string.IsNullOrEmpty(context.Request.Form["pNationalholidaysSalary2"])) ? decimal.Parse(context.Request.Form["pNationalholidaysSalary2"].ToString()) : 0;
                decimal pNationalholidaysSalary3 = (!string.IsNullOrEmpty(context.Request.Form["pNationalholidaysSalary3"])) ? decimal.Parse(context.Request.Form["pNationalholidaysSalary3"].ToString()) : 0;
                decimal pNationalholidaysSalary4 = (!string.IsNullOrEmpty(context.Request.Form["pNationalholidaysSalary4"])) ? decimal.Parse(context.Request.Form["pNationalholidaysSalary4"].ToString()) : 0;
                decimal pAnnualLeaveTimes = (!string.IsNullOrEmpty(context.Request.Form["pAnnualLeaveTimes"])) ? decimal.Parse(context.Request.Form["pAnnualLeaveTimes"].ToString()) : 0;
                decimal pAnnualLeaveSalary = (!string.IsNullOrEmpty(context.Request.Form["pAnnualLeaveSalary"])) ? decimal.Parse(context.Request.Form["pAnnualLeaveSalary"].ToString()) : 0;
                decimal pMarriageLeaveTimes = (!string.IsNullOrEmpty(context.Request.Form["pMarriageLeaveTimes"])) ? decimal.Parse(context.Request.Form["pMarriageLeaveTimes"].ToString()) : 0;
                decimal pMarriageLeaveSalary = (!string.IsNullOrEmpty(context.Request.Form["pMarriageLeaveSalary"])) ? decimal.Parse(context.Request.Form["pMarriageLeaveSalary"].ToString()) : 0;
                decimal pSickLeaveTimes = (!string.IsNullOrEmpty(context.Request.Form["pSickLeaveTimes"])) ? decimal.Parse(context.Request.Form["pSickLeaveTimes"].ToString()) : 0;
                decimal pSickLeaveSalary = (!string.IsNullOrEmpty(context.Request.Form["pSickLeaveSalary"])) ? decimal.Parse(context.Request.Form["pSickLeaveSalary"].ToString()) : 0;
                decimal pFuneralLeaveTimes = (!string.IsNullOrEmpty(context.Request.Form["pFuneralLeaveTimes"])) ? decimal.Parse(context.Request.Form["pFuneralLeaveTimes"].ToString()) : 0;
                decimal pFuneralLeaveSalary = (!string.IsNullOrEmpty(context.Request.Form["pFuneralLeaveSalary"])) ? decimal.Parse(context.Request.Form["pFuneralLeaveSalary"].ToString()) : 0;
                decimal pMaternityLeaveTimes = (!string.IsNullOrEmpty(context.Request.Form["pMaternityLeaveTimes"])) ? decimal.Parse(context.Request.Form["pMaternityLeaveTimes"].ToString()) : 0;
                decimal pMaternityLeaveSalary = (!string.IsNullOrEmpty(context.Request.Form["pMaternityLeaveSalary"])) ? decimal.Parse(context.Request.Form["pMaternityLeaveSalary"].ToString()) : 0;

                decimal pProductionLeaveTimes = (!string.IsNullOrEmpty(context.Request.Form["pProductionLeaveTimes"])) ? decimal.Parse(context.Request.Form["pProductionLeaveTimes"].ToString()) : 0;
                decimal pProductionLeaveSalary = (!string.IsNullOrEmpty(context.Request.Form["pProductionLeaveSalary"])) ? decimal.Parse(context.Request.Form["pProductionLeaveSalary"].ToString()) : 0;
                decimal pMilitaryLeaveTimes = (!string.IsNullOrEmpty(context.Request.Form["pMilitaryLeaveTimes"])) ? decimal.Parse(context.Request.Form["pMilitaryLeaveTimes"].ToString()) : 0;
                decimal pMilitaryLeaveSalary = (!string.IsNullOrEmpty(context.Request.Form["pMilitaryLeaveSalary"])) ? decimal.Parse(context.Request.Form["pMilitaryLeaveSalary"].ToString()) : 0;
                decimal pAbortionLeaveTimes = (!string.IsNullOrEmpty(context.Request.Form["pAbortionLeaveTimes"])) ? decimal.Parse(context.Request.Form["pAbortionLeaveTimes"].ToString()) : 0;
                decimal pAbortionLeaveSalary = (!string.IsNullOrEmpty(context.Request.Form["pAbortionLeaveSalary"])) ? decimal.Parse(context.Request.Form["pAbortionLeaveSalary"].ToString()) : 0;
                decimal pHolidayDutyFree = (!string.IsNullOrEmpty(context.Request.Form["pHolidayDutyFree"])) ? decimal.Parse(context.Request.Form["pHolidayDutyFree"].ToString()) : 0;
                decimal pHolidayTaxation = (!string.IsNullOrEmpty(context.Request.Form["pHolidayTaxation"])) ? decimal.Parse(context.Request.Form["pHolidayTaxation"].ToString()) : 0;
                decimal pNationalholidaysTaxation = (!string.IsNullOrEmpty(context.Request.Form["pNationalholidaysTaxation"])) ? decimal.Parse(context.Request.Form["pNationalholidaysTaxation"].ToString()) : 0;
                decimal pNationalholidaysDutyFree = (!string.IsNullOrEmpty(context.Request.Form["pNationalholidaysDutyFree"])) ? decimal.Parse(context.Request.Form["pNationalholidaysDutyFree"].ToString()) : 0;
                decimal pHolidaySumDutyFree = (!string.IsNullOrEmpty(context.Request.Form["pHolidaySumDutyFree"])) ? decimal.Parse(context.Request.Form["pHolidaySumDutyFree"].ToString()) : 0;
                decimal pHolidaySumTaxation = (!string.IsNullOrEmpty(context.Request.Form["pHolidaySumTaxation"])) ? decimal.Parse(context.Request.Form["pHolidaySumTaxation"].ToString()) : 0;
                decimal pAttendanceDays = (!string.IsNullOrEmpty(context.Request.Form["pAttendanceDays"])) ? decimal.Parse(context.Request.Form["pAttendanceDays"].ToString()) : 0;
                decimal pAttendanceTimes = (!string.IsNullOrEmpty(context.Request.Form["pAttendanceTimes"])) ? decimal.Parse(context.Request.Form["pAttendanceTimes"].ToString()) : 0;
                decimal pOverTimeDutyfree = (!string.IsNullOrEmpty(context.Request.Form["pOverTimeDutyfree"])) ? decimal.Parse(context.Request.Form["pOverTimeDutyfree"].ToString()) : 0;
                decimal pOverTimeTaxation = (!string.IsNullOrEmpty(context.Request.Form["pOverTimeTaxation"])) ? decimal.Parse(context.Request.Form["pOverTimeTaxation"].ToString()) : 0;
                decimal pIntertemporal = (!string.IsNullOrEmpty(context.Request.Form["pIntertemporal"])) ? decimal.Parse(context.Request.Form["pOverTimeTaxation"].ToString()) : 0;
                decimal pSalary = (!string.IsNullOrEmpty(context.Request.Form["pSalary"])) ? decimal.Parse(context.Request.Form["pSalary"].ToString()) : 0;

                string[] str = { "" };
                string sqlinj = com.CheckSqlInJection(str);

                if (sqlinj == "")
                {
                    payroll.model.sy_PayRoll p = new payroll.model.sy_PayRoll();
                    p.pGuid = pGuid;
                    p.pWeekdayTime1 = pWeekdayTime1;
                    p.pWeekdayTime2 = pWeekdayTime2;
                    p.pWeekdayTime3 = pWeekdayTime3;
                    p.pWeekdaySalary1 = pWeekdaySalary1;
                    p.pWeekdaySalary2 = pWeekdaySalary2;
                    p.pWeekdaySalary3 = pWeekdaySalary3;
                    p.pOffDayTime1 = pOffDayTime1;
                    p.pOffDayTime2 = pOffDayTime2;
                    p.pOffDayTime3 = pOffDayTime3;
                    p.pOffDaySalary1 = pOffDaySalary1;
                    p.pOffDaySalary2 = pOffDaySalary2;
                    p.pOffDaySalary3 = pOffDaySalary3;
                    p.pHolidayTime1 = pHolidayTime1;
                    p.pHolidayTime2 = pHolidayTime2;
                    p.pHolidayTime3 = pHolidayTime3;
                    p.pHolidayTime4 = pHolidayTime4;
                    p.pHolidaySalary1 = pHolidaySalary1;
                    p.pHolidaySalary2 = pHolidaySalary2;
                    p.pHolidaySalary3 = pHolidaySalary3;
                    p.pHolidaySalary4 = pHolidaySalary4;
                    p.pNationalholidaysSalary1 = pNationalholidaysSalary1;
                    p.pNationalholidaysSalary2 = pNationalholidaysSalary2;
                    p.pNationalholidaysSalary3 = pNationalholidaysSalary3;
                    p.pNationalholidaysSalary4 = pNationalholidaysSalary4;

                    p.pAnnualLeaveTimes = pAnnualLeaveTimes;
                    p.pAnnualLeaveSalary = pAnnualLeaveSalary;
                    p.pMarriageLeaveTimes = pMarriageLeaveTimes;
                    p.pMarriageLeaveSalary = pMarriageLeaveSalary;
                    p.pSickLeaveTimes = pSickLeaveTimes;
                    p.pSickLeaveSalary = pSickLeaveSalary;
                    p.pFuneralLeaveTimes = pFuneralLeaveTimes;
                    p.pFuneralLeaveSalary = pFuneralLeaveSalary;
                    p.pMaternityLeaveTimes = pMaternityLeaveTimes;
                    p.pMaternityLeaveSalary = pMaternityLeaveSalary;
                    p.pProductionLeaveTimes = pProductionLeaveTimes;
                    p.pProductionLeaveSalary = pProductionLeaveSalary;
                    p.pMilitaryLeaveTimes = pMilitaryLeaveTimes;
                    p.pMilitaryLeaveSalary = pMilitaryLeaveSalary;
                    p.pAbortionLeaveTimes = pAbortionLeaveTimes;
                    p.pAbortionLeaveSalary = pAbortionLeaveSalary;
                    p.pHolidayDutyFree = pHolidayDutyFree;
                    p.pHolidayTaxation = pHolidayTaxation;
                    p.pNationalholidaysTaxation = pNationalholidaysTaxation;
                    p.pNationalholidaysDutyFree = pNationalholidaysDutyFree;
                    p.pHolidaySumDutyFree = pHolidaySumDutyFree;
                    p.pHolidaySumTaxation = pHolidaySumTaxation;
                    p.pAttendanceDays = pAttendanceDays;
                    p.pAttendanceTimes = pAttendanceTimes;
                    p.pOverTimeDutyfree = pOverTimeDutyfree;
                    p.pOverTimeTaxation = pOverTimeTaxation;
                    p.pIntertemporal = pIntertemporal;
                    p.pSalary = pSalary;
                    p.UserInfo = USERINFO.MemberGuid;
                    dal.reSetPayroll(p);
                    context.Response.Write("ok");
                }
                else { context.Response.Write("d"); }
            }
            else { context.Response.Write("t"); }
        }
        catch (Exception ex)
        {
            ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_reSetPay.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("e");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}