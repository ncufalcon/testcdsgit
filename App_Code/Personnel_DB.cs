using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Personnel_DB 的摘要描述
/// </summary>
public class Personnel_DB
{
	string KeyWord = string.Empty;
	public string _KeyWord
	{
		set { KeyWord = value; }
	}
	#region 私用
	string perGuid = string.Empty;
	string perNo = string.Empty;
	string perName = string.Empty;
	string perComGuid = string.Empty;
	string perDep = string.Empty;
	string perPosition = string.Empty;
	string perTel = string.Empty;
	string perPhone = string.Empty;
	string perContract = string.Empty;
	string perSex = string.Empty;
	string perbirthday = string.Empty;
	string perIDNumber = string.Empty;
	string perMarriage = string.Empty;
	string perFirstDate = string.Empty;
	string perLastDate = string.Empty;
	string perExaminationDate = string.Empty;
	string perExaminationLastDate = string.Empty;
	string perResidentPermitDate = string.Empty;
	string perContactPerson = string.Empty;
	string perContactTel = string.Empty;
	string perRel = string.Empty;
	string perEmail = string.Empty;
	string perAddr = string.Empty;
	string perPostalCode = string.Empty;
	string perResidentAddr = string.Empty;
	string perResPostalCode = string.Empty;
	string perPs = string.Empty;
	string perLaborProtection = string.Empty;
	string perHealthInsurance = string.Empty;
	string PerHIClass = string.Empty;
	string perInsuranceDes = string.Empty;
	string perGroupInsurance = string.Empty;
	string perLaborID = string.Empty;
	string perInsuranceID = string.Empty;
	string perSalaryClass = string.Empty;
	string perTaxable = string.Empty;
	string perBasicSalary = string.Empty;
	string perAllowance = string.Empty;
	string PerSyAccountName = string.Empty;
	string PerSyNumber = string.Empty;
	string PerSyAccount = string.Empty;
	string perReferenceNumber = string.Empty;
	string perDetentionRatio = string.Empty;
	string perMonthPayroll = string.Empty;
	string perYearEndBonuses = string.Empty;
	string perCreateId = string.Empty;
	string perModifyId = string.Empty;
	string perStatus = string.Empty;

	DateTime perCreateDate;
	DateTime perModifyDate;
	#endregion
	#region 公用
	public string _perGuid
	{
		set { perGuid = value; }
	}
	public string _perNo
	{
		set { perNo = value; }
	}
	public string _perName
	{
		set { perName = value; }
	}
	public string _perComGuid
	{
		set { perComGuid = value; }
	}
	public string _perDep
	{
		set { perDep = value; }
	}
	public string _perPosition
	{
		set { perPosition = value; }
	}
	public string _perTel
	{
		set { perTel = value; }
	}
	public string _perPhone
	{
		set { perPhone = value; }
	}
	public string _perContract
	{
		set { perContract = value; }
	}
	public string _perSex
	{
		set { perSex = value; }
	}
	public string _perbirthday
	{
		set { perbirthday = value; }
	}
	public string _perIDNumber
	{
		set { perIDNumber = value; }
	}
	public string _perMarriage
	{
		set { perMarriage = value; }
	}
	public string _perFirstDate
	{
		set { perFirstDate = value; }
	}
	public string _perLastDate
	{
		set { perLastDate = value; }
	}
	public string _perExaminationDate
	{
		set { perExaminationDate = value; }
	}
	public string _perExaminationLastDate
	{
		set { perExaminationLastDate = value; }
	}
	public string _perResidentPermitDate
	{
		set { perResidentPermitDate = value; }
	}
	public string _perContactPerson
	{
		set { perContactPerson = value; }
	}
	public string _perContactTel
	{
		set { perContactTel = value; }
	}
	public string _perRel
	{
		set { perRel = value; }
	}
	public string _perEmail
	{
		set { perEmail = value; }
	}
	public string _perAddr
	{
		set { perAddr = value; }
	}
	public string _perPostalCode
	{
		set { perPostalCode = value; }
	}
	public string _perResidentAddr
	{
		set { perResidentAddr = value; }
	}
	public string _perResPostalCode
	{
		set { perResPostalCode = value; }
	}
	public string _perPs
	{
		set { perPs = value; }
	}
	public string _perLaborProtection
	{
		set { perLaborProtection = value; }
	}
	public string _perHealthInsurance
	{
		set { perHealthInsurance = value; }
	}
	public string _PerHIClass
	{
		set { PerHIClass = value; }
	}
	public string _perInsuranceDes
	{
		set { perInsuranceDes = value; }
	}
	public string _perGroupInsurance
	{
		set { perGroupInsurance = value; }
	}
	public string _perLaborID
	{
		set { perLaborID = value; }
	}
	public string _perInsuranceID
	{
		set { perInsuranceID = value; }
	}
	public string _perSalaryClass
	{
		set { perSalaryClass = value; }
	}
	public string _perTaxable
	{
		set { perTaxable = value; }
	}
	public string _perBasicSalary
	{
		set { perBasicSalary = value; }
	}
	public string _perAllowance
	{
		set { perAllowance = value; }
	}
	public string _PerSyAccountName
	{
		set { PerSyAccountName = value; }
	}
	public string _PerSyNumber
	{
		set { PerSyNumber = value; }
	}
	public string _PerSyAccount
	{
		set { PerSyAccount = value; }
	}
	public string _perReferenceNumber
	{
		set { perReferenceNumber = value; }
	}
	public string _perDetentionRatio
	{
		set { perDetentionRatio = value; }
	}
	public string _perMonthPayroll
	{
		set { perMonthPayroll = value; }
	}
	public string _perYearEndBonuses
	{
		set { perYearEndBonuses = value; }
	}
	public string _perCreateId
	{
		set { perCreateId = value; }
	}
	public string _perModifyId
	{
		set { perModifyId = value; }
	}
	public string _perStatus
	{
		set { perStatus = value; }
	}
	public DateTime _perCreateDate
	{
		set { perCreateDate = value; }
	}
	public DateTime _perModifyDate
	{
		set { perModifyDate = value; }
	}
	#endregion

}