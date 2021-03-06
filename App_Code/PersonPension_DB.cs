﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// PersonPension 的摘要描述
/// </summary>
public class PersonPension_DB
{
    string KeyWord = string.Empty;
    string StartDate = string.Empty;
    string EndDate = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    public string _StartDate
    {
        set { StartDate = value; }
    }
    public string _EndDate
    {
        set { EndDate = value; }
    }
    #region 私用
    string ppGuid = string.Empty;
    string ppPerGuid = string.Empty;
    string ppChange = string.Empty;
    string ppChangeDate = string.Empty;
    decimal ppLarboRatio;
    decimal ppEmployerRatio;
    decimal ppPayPayroll;
    string ppPs = string.Empty;
    string ppCreateId = string.Empty;
    string ppModifyId = string.Empty;
    string ppStatus = string.Empty;

    DateTime ppCreateDate;
    DateTime ppModifyDate;
    #endregion
    #region 公用
    public string _ppGuid
    {
        set { ppGuid = value; }
    }
    public string _ppPerGuid
    {
        set { ppPerGuid = value; }
    }
    public string _ppChange
    {
        set { ppChange = value; }
    }
    public string _ppChangeDate
    {
        set { ppChangeDate = value; }
    }
    public decimal _ppLarboRatio
    {
        set { ppLarboRatio = value; }
    }
    public decimal _ppEmployerRatio
    {
        set { ppEmployerRatio = value; }
    }
    public decimal _ppPayPayroll
    {
        set { ppPayPayroll = value; }
    }
    public string _ppPs
    {
        set { ppPs = value; }
    }
    public string _ppCreateId
    {
        set { ppCreateId = value; }
    }
    public string _ppModifyId
    {
        set { ppModifyId = value; }
    }
    public string _ppStatus
    {
        set { ppStatus = value; }
    }
    public DateTime _ppCreateDate
    {
        set { ppCreateDate = value; }
    }
    public DateTime _ppModifyDate
    {
        set { ppModifyDate = value; }
    }
    #endregion

    public DataTable SelectList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT ");
        if (ppChange == "")
            sb.Append(@"top 200 ");

        sb.Append(@"ppGuid,ppPerGuid,perNo,perName,ppChangeDate,ppChange,code_desc,
ppLarboRatio,ppEmployerRatio,ppPayPayroll
from sy_PersonPension
left join sy_Person on perGuid=ppPerGuid
left join sy_codetable on code_group='13' and code_value=ppChange
where ppStatus<>'D' ");

        if (KeyWord != "")
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");

        if (ppChange != "")
            sb.Append(@"and ppChange=@ppChange ");

        if (StartDate != "")
            sb.Append(@"and CONVERT(datetime,ppChangeDate) >= CONVERT(datetime,@StartDate) ");
        if (EndDate != "")
            sb.Append(@"and CONVERT(datetime,ppChangeDate) <= CONVERT(datetime,@EndDate) ");

        sb.Append(@"order by ppChangeDate desc,ppCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@ppChange", ppChange);
        oCmd.Parameters.AddWithValue("@StartDate", StartDate);
        oCmd.Parameters.AddWithValue("@EndDate", EndDate);
        oda.Fill(ds);
        return ds;
    }

    public void addPension()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"insert into sy_PersonPension (
ppGuid,
ppPerGuid,
ppChange,
ppChangeDate,
ppLarboRatio,
ppEmployerRatio,
ppPayPayroll,
ppPs,
ppCreateId,
ppModifyDate,
ppModifyId,
ppStatus
) values (
@ppGuid,
@ppPerGuid,
@ppChange,
@ppChangeDate,
@ppLarboRatio,
@ppEmployerRatio,
@ppPayPayroll,
@ppPs,
@ppCreateId,
@ppModifyDate,
@ppModifyId,
@ppStatus
) ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@ppGuid", ppGuid);
        oCmd.Parameters.AddWithValue("@ppPerGuid", ppPerGuid);
        oCmd.Parameters.AddWithValue("@ppChange", ppChange);
        oCmd.Parameters.AddWithValue("@ppChangeDate", ppChangeDate);
        oCmd.Parameters.AddWithValue("@ppLarboRatio", ppLarboRatio);
        oCmd.Parameters.AddWithValue("@ppEmployerRatio", ppEmployerRatio);
        oCmd.Parameters.AddWithValue("@ppPayPayroll", ppPayPayroll);
        oCmd.Parameters.AddWithValue("@ppPs", ppPs);
        oCmd.Parameters.AddWithValue("@ppCreateId", ppCreateId);
        oCmd.Parameters.AddWithValue("@ppModifyId", ppModifyId);
        oCmd.Parameters.AddWithValue("@ppModifyDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@ppStatus", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modPension()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonPension set
ppPerGuid=@ppPerGuid,
ppChange=@ppChange,
ppChangeDate=@ppChangeDate,
ppLarboRatio=@ppLarboRatio,
ppEmployerRatio=@ppEmployerRatio,
ppPayPayroll=@ppPayPayroll,
ppPs=@ppPs,
ppModifyId=@ppModifyId,
ppModifyDate=@ppModifyDate
where ppGuid=@ppGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@ppGuid", ppGuid);
        oCmd.Parameters.AddWithValue("@ppPerGuid", ppPerGuid);
        oCmd.Parameters.AddWithValue("@ppChange", ppChange);
        oCmd.Parameters.AddWithValue("@ppChangeDate", ppChangeDate);
        oCmd.Parameters.AddWithValue("@ppLarboRatio", ppLarboRatio);
        oCmd.Parameters.AddWithValue("@ppEmployerRatio", ppEmployerRatio);
        oCmd.Parameters.AddWithValue("@ppPayPayroll", ppPayPayroll);
        oCmd.Parameters.AddWithValue("@ppPs", ppPs);
        oCmd.Parameters.AddWithValue("@ppModifyId", ppModifyId);
        oCmd.Parameters.AddWithValue("@ppModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }
    public void deletePension()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonPension set 
ppStatus='D',
ppModifyId=@ppModifyId,
ppModifyDate=@ppModifyDate
where ppGuid=@ppGuid ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@ppGuid", ppGuid);
        oCmd.Parameters.AddWithValue("@ppModifyId", ppModifyId);
        oCmd.Parameters.AddWithValue("@ppModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable getPensionByGuid()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonPension 
left join sy_Person on perGuid=ppPerGuid
left join sy_CodeBranches on cbGuid=perDep
where  ppStatus<>'D' and ppGuid=@ppGuid  ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@ppGuid", ppGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkPerPension()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonPension where ppPerGuid=@ppPerGuid and ppStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@ppPerGuid", ppPerGuid);
        oda.Fill(ds);
        return ds;
    }


    public DataTable pp_add(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,perFirstDate,perPensionIdentity,perYears,comLaborProtection1,comLaborProtection2,ppEmployerRatio,ppLarboRatio,ppChangeDate,ppPayPayroll,
(select min(ilItem4) from sy_InsuranceLevel where ilEffectiveDate=(select MAX(ilEffectiveDate) from sy_InsuranceLevel) and ilItem4<>'0') InsLv
from sy_PersonPension
left join sy_Person on perGuid=ppPerGuid 
left join sy_Company on comGuid=perComGuid
where ppGuid in (" + perGuid + @") ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable pp_stop(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,comLaborProtection1,comLaborProtection2,ppEmployerRatio,ppLarboRatio,ppChangeDate
from sy_PersonPension 
left join sy_Person on perGuid=ppPerGuid
left join sy_Company on comGuid=perComGuid
where ppGuid in (" + perGuid + @") ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable pp_mod(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,comLaborProtection1,comLaborProtection2,ppPayPayroll,
(select min(ilItem4) from sy_InsuranceLevel where ilEffectiveDate=(select MAX(ilEffectiveDate) from sy_InsuranceLevel) and ilItem4<>'0') InsLv
from sy_PersonPension
left join sy_Person on perGuid=ppPerGuid
left join sy_Company on comGuid=perComGuid
where ppGuid in (" + perGuid + @") ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkLastStatus(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * from sy_PersonPension with(nolock) where ppStatus='A' and ppPerGuid=@perGuid 
and ppChangeDate=(select MAX(ppChangeDate) from sy_PersonPension with(nolock) where ppStatus='A' and ppPerGuid=@perGuid) 
and ppCreateDate=(select MAX(ppCreateDate) from sy_PersonPension with(nolock) where ppStatus='A' and ppPerGuid=@perGuid) ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable getPPRatio(string pNo, string pName, string pDep, string pYear)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();
        //有套計算年資的Function
        //        sb.Append(@"select * into #tmp from getYears((Select Convert(varchar(10),Getdate(),111)))
        //SELECT perGuid,perNo,perName,perDep,
        //perYears,ppLarboRatio,ppEmployerRatio,ppPayPayroll
        //from #tmp
        //left join sy_PersonPension on perGuid=ppPerGuid and (select MAX(ppChangeDate) from sy_PersonPension where perGuid=ppPerGuid and ppStatus='A')=ppChangeDate
        // and (select MAX(ppCreateDate) from sy_PersonPension where perGuid=ppPerGuid and ppStatus='A')=ppCreateDate and ppStatus='A'
        //where perStatus='A' and perLastDate='' and ppChange<>'03' and ppStatus='A' 
        // and ((CONVERT(int,perYears)>=2 and CONVERT(int,perYears)<3  and CONVERT(float,ppEmployerRatio)<=6) or 
        //(CONVERT(int,perYears)>=3 and CONVERT(float,ppEmployerRatio)<=6.5)) ");

        //年資直接撈sy_person 資料表 perYears 欄位
        sb.Append(@"SELECT perGuid,perNo,perName,
(select cbName from sy_CodeBranches where cbGuid=perDep) perDep,
perYears,ppLarboRatio,ppEmployerRatio,ppPayPayroll
from sy_Person
left join sy_PersonPension on perGuid=ppPerGuid and (select MAX(ppChangeDate) from sy_PersonPension where perGuid=ppPerGuid and ppStatus='A')=ppChangeDate
	and (select MAX(ppCreateDate) from sy_PersonPension where perGuid=ppPerGuid and ppStatus='A')=ppCreateDate and ppStatus='A'
where perStatus='A' and perLastDate='' and ppChange<>'03' and ppStatus='A' 
 and ((CONVERT(int,perYears)>=2 and CONVERT(int,perYears)<3 and CONVERT(float,ppEmployerRatio)<=6) or 
(CONVERT(int,perYears)>=3 and CONVERT(float,ppEmployerRatio)<=6.5)) ");
        if (pNo != "")
        {
            sb.Append(@"and (upper(perNo) LIKE '%' + upper(@pNo) + '%') ");
        }
        if (pName != "")
        {
            sb.Append(@"and (upper(perName) LIKE '%' + upper(@pName) + '%') ");
        }
        if (pDep != "")
        {
            sb.Append(@"and (upper((select cbName from sy_CodeBranches where cbGuid=perDep)) LIKE '%' + upper(@pDep) + '%') ");
        }
        if (pYear != "")
        {
            sb.Append(@"and (upper(perYears) LIKE '%' + upper(@pYear) + '%') ");
        }
        sb.Append(@"order by perDep,perNo ");
        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pNo", pNo);
        oCmd.Parameters.AddWithValue("@pName", pName);
        oCmd.Parameters.AddWithValue("@pDep", pDep);
        oCmd.Parameters.AddWithValue("@pYear", pYear);
        oda.Fill(ds);
        return ds;
    }
}