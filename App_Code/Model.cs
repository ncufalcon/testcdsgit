using System;
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

        public string pPerNo { get; set; }
        public string pPerName { get; set; }
        public string pPerCompanyName { get; set; }
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

        public decimal pProductionLeaveTimes { get; set; }
        public decimal pProductionLeaveSalary { get; set; }
        public decimal pMilitaryLeaveTimes { get; set; }
        public decimal pMilitaryLeaveSalary { get; set; }
        public decimal pAbortionLeaveTimes { get; set; }
        public decimal pAbortionLeaveSalary { get; set; }

        public decimal pTaxDeduction { get; set; }
        public decimal pPay { get; set; }
        public decimal pTaxation { get; set; }
        public decimal pTax { get; set; }        
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

        public decimal pWelfare { get; set; }
        public string sr_Guid { get; set; }
        public string pShouldPayStatus { get; set; }
        public string pLeaveStatus { get; set; }
        public string pCompany { get; set; }
        public string pCompanyName { get; set; }
        public string pDep { get; set; }
        public string pDepCode { get; set; }

        public decimal pSalary { get; set; }
        
        public string UserInfo { get; set; }

    }



    public class sy_PayAllowance
    {
        public string psaGuid { get; set; }
        public string psaPerGuid { get; set; }
        public string psaPsmGuid { get; set; }
        public string psaAllowanceCode { get; set; }
        public decimal psaPrice { get; set; }
        public decimal psaQuantity { get; set; }
        public decimal psaCost { get; set; }
        public string psaStatus { get; set; }


    }



    public class sy_PayBuckle
    {
        public string psbGuid { get; set; }
        public string psbPerGuid { get; set; }
        public string psbPsmGuid { get; set; }
        public string psbCreditor { get; set; }
        public decimal psbCreditorCost { get; set; }
        public decimal psbRatio { get; set; }
        public string psaCpsbIssuedost { get; set; }
        public string psbPayment { get; set; }
        public string psbIntoName { get; set; }
        public string psbIntoNumber { get; set; }
        public string psbIntoAccount { get; set; }
        public string psbContractor { get; set; }
        public string psbTel { get; set; }
        public decimal psbFee { get; set; }
        public decimal psbCost { get; set; }
        public string psbStatus { get; set; }

    }



    public class sy_Tax
    {
        public string iitGuid { get; set; }
        public string iitComGuid { get; set; }
        public string iitComName { get; set; }
        public string iitComUniform { get; set; }
        public string iitPerGuid { get; set; }
        public string iitPerName { get; set; }
        public string iitPerNo { get; set; }
        public string iitPerIDNumber { get; set; }
        public string iitPerAdds { get; set; }
        public string iitPerDep { get; set; }
        public string iitPassPort { get; set; }
        public string iitMark { get; set; }
        public string iitFormat { get; set; }
        public decimal iiPayRatio { get; set; }
        public decimal iitPaySum { get; set; }
        public decimal iitPayAmount { get; set; }
        public decimal iitPayTax { get; set; }
        public string iitYearStart { get; set; }
        public string iitYearEnd { get; set; }
        public decimal iitStock { get; set; }
        public string iitStockDate { get; set; }
        public decimal iitStockPrice { get; set; }
        public string iitTaxMark { get; set; }
        public string iitManner { get; set; }
        public string iitCountryCode { get; set; }
        public string iitCode { get; set; }        
        public string iitModdifyId { get; set; }
        public string iitStatus { get; set; }

        public string iitYyyy { get; set; }
        public decimal iitPension { get; set; }
        public string iitIdentify { get; set; }
        public string iitErrMark { get; set; }
        public string iitHouseTax { get; set; }
        public string iitIndustryCode { get; set; }
        public decimal iitDistribution { get; set; }
        public decimal iitDividend { get; set; }
        public decimal iitDeductedTax { get; set; }
        public decimal iitDeductedRaito { get; set; }
        public decimal iitNetAmount { get; set; }
        public string iitInstitutionCode { get; set; }

        public decimal iitStockNumber { get; set; }
        public string iitBatchDate { get; set; }
        public decimal iitBatchPrice { get; set; }
        public string UserInfo { get; set; }

    }


    public class sy_Member
    {
        public string gpCode { get; set; }
        public string gpName { get; set; }
        public string gpCName { get; set; }
        public string gpIndex { get; set; }


    }



    public class sy_Person
    {
        public string perGuid { get; set; }
        public string perNo { get; set; }
        public string perName { get; set; }
        public string perComGuid { get; set; }
        public string perCompanyName { get; set; }
        public string perDep { get; set; }

        public string pfPerGuid { get; set; }
        public string pfName { get; set; }


        public string sDate { get; set; }
        public string eDate { get; set; }

    }



    public class sy_FamilyInsurance
    {
        public string psfiPfGuid { get; set; }
        public string psfiPsmGuid { get; set; }
        public string psfiPerGuid { get; set; }

        public string srGuid { get; set; }


    }


}