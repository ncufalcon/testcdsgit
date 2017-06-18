﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class LoginINFO
{
    string _MemberGuid = string.Empty;
    string _MemberName = string.Empty;
    string _MemberClass = string.Empty;
    string _MemberCompetence = string.Empty;



    public string MemberGuid { get { return _MemberGuid; } set { _MemberGuid = value; } }
    public string MemberName { get { return _MemberName; } set { _MemberName = value; } }
    public string MemberClass { get { return _MemberClass; } set { _MemberClass = value; } }
    public string MemberCompetence { get { return _MemberCompetence; } set { _MemberCompetence = value; } }

}


public class sy_Member
{
    public string mbGuid { get; set; }
    public string mbName { get; set; }
    public string mbJobNumber { get; set; }
    public string mbId { get; set; }
    public string mbPassword { get; set; }
    public string mbCom { get; set; }

}

namespace payroll.model
{
    public class sy_PersonSingleAllowance
    {
        public string paGuid { get; set; }
        public string paPerGuid { get; set; }
        public string paAllowanceCode { get; set; }
        public decimal paPrice { get; set; }
        public decimal paQuantity { get; set; }
        public decimal paCost { get; set; }
        public string paDate { get; set; }
        public string paDateS { get; set; }
        public string paDateE { get; set; }
        public string paPs { get; set; }
        public string paCreateId { get; set; }
        public string paModifyId { get; set; }
        public DateTime paModifyDate { get; set; }
        public string paStatus { get; set; }
        public string perName { get; set; }
        public string perNo { get; set; }
        public string siItemCode { get; set; }
        public string siItemName { get; set; }



    }



    public class sy_PayRoll
    {
        public string psmGuid { get; set; }
        public string psmSalaryRange { get; set; }
        public string psmCreateId { get; set; }
        public DateTime psmCreateDate { get; set; }
        public decimal psmModifyId { get; set; }
        public DateTime psmModifyDate { get; set; }


        public string pGuid { get; set; }
        public string pPsmGuid { get; set; }
        public string pPerGuid { get; set; }
        public string pPerCompanyGuid { get; set; }
        public string pPerDep { get; set; }

        public decimal pWeekdayTime1 { get; set; }
        public decimal pWeekdayTime2 { get; set; }
        public decimal pWeekdayTime3 { get; set; }
        public decimal pWeekdaySalary1 { get; set; }
        public decimal pWeekdaySalary2 { get; set; }
        public decimal pWeekdaySalary3 { get; set; }

        public decimal pOffDayTime1 { get; set; }
        public decimal pOffDayTime2 { get; set; }
        public decimal pOffDayTime3 { get; set; }
        public decimal pOffDaySalary1 { get; set; }
        public decimal pOffDaySalary2 { get; set; }
        public decimal pOffDaySalary3 { get; set; }

        public decimal pHolidayTime1 { get; set; }
        public decimal pHolidayTime2 { get; set; }
        public decimal pHolidayTime3 { get; set; }
        public decimal pHolidayTime4 { get; set; }
        public decimal pHolidaySalary1 { get; set; }
        public decimal pHolidaySalary2 { get; set; }
        public decimal pHolidaySalary3 { get; set; }
        public decimal pHolidaySalary4 { get; set; }
        public decimal pHolidayDutyFree { get; set; }
        public decimal pHolidayTaxation { get; set; }

        public decimal pNationalholidaysTime1 { get; set; }
        public decimal pNationalholidaysTime2 { get; set; }
        public decimal pNationalholidaysTime3 { get; set; }
        public decimal pNationalholidaysTime4 { get; set; }
        public decimal pNationalholidaysSalary1 { get; set; }
        public decimal pNationalholidaysSalary2 { get; set; }
        public decimal pNationalholidaysSalary3 { get; set; }
        public decimal pNationalholidaysSalary4 { get; set; }
        public decimal pNationalholidaysDutyFree { get; set; }
        public decimal pNationalholidaysTaxation { get; set; }


        public decimal pSpecialholidaysTime1 { get; set; }
        public decimal pSpecialholidaysTime2 { get; set; }
        public decimal pSpecialholidaysTime3 { get; set; }
        public decimal pSpecialholidaysTime4 { get; set; }
        public decimal pSpecialholidaysSalary1 { get; set; }
        public decimal pSpecialholidaysSalary2 { get; set; }
        public decimal pSpecialholidaysSalary3 { get; set; }
        public decimal pSpecialholidaysSalary4 { get; set; }
        public decimal pSpecialholidaysDutyFree { get; set; }
        public decimal pSpecialholidaysTaxation { get; set; }


        public decimal pHolidaySumDutyFree { get; set; }
        public decimal pHolidaySumTaxation { get; set; }
        public decimal pAttendanceDays { get; set; }
        public decimal pAttendanceTimes { get; set; }
        public decimal pPayLeave { get; set; }

        public decimal pAnnualLeaveTimes { get; set; }
        public decimal pAnnualLeaveSalary { get; set; }
        public decimal pMarriageLeaveTimes { get; set; }
        public decimal pMarriageLeaveSalary { get; set; }
        public decimal pSickLeaveTimes { get; set; }
        public decimal pSickLeaveSalary { get; set; }
        public decimal pFuneralLeaveTimes { get; set; }
        public decimal pFuneralLeaveSalary { get; set; }
        public decimal pMaternityLeaveTimes { get; set; }
        public decimal pMaternityLeaveSalary { get; set; }
        public decimal pHonoraryLeaveTimes { get; set; }
        public decimal pHonoraryLeaveSalary { get; set; }

        public decimal pTaxDeduction { get; set; }
        public decimal pPay { get; set; }
        public decimal pTaxation { get; set; }
        public decimal pPremium { get; set; }
        public decimal pOverTimeDutyfree { get; set; }
        public decimal pOverTimeTaxation { get; set; }

        public decimal pPersonInsurance { get; set; }
        public decimal pPersonLabor { get; set; }
        public decimal pPersonPension { get; set; }
        public decimal pCompanyPension { get; set; }
        public decimal pIntertemporal { get; set; }
        public string pStatus { get; set; }
        public decimal pComInsurance { get; set; }
        public decimal pComLabor { get; set; }


        public decimal pAnnualLeavePro { get; set; }
        public decimal pP1Time { get; set; }
        public decimal pBuckleCost { get; set; }
        public decimal pBuckleFee { get; set; }



    }

}