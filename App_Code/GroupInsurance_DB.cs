using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// GroupInsurance_DB 的摘要描述
/// </summary>
public class GroupInsurance_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    #region 私用
    string pgiGuid = string.Empty;
    string pgiPerGuid = string.Empty;
    string pgiPfGuid = string.Empty;
    string pgiType = string.Empty;
    string pgiChange = string.Empty;
    string pgiChangeDate = string.Empty;
    string pgiInsuranceCode = string.Empty;
    string pgiPs = string.Empty;
    string pgiCreateId = string.Empty;
    string pgiModifyId = string.Empty;
    string pgiStatus = string.Empty;

    DateTime pgiCreateDate;
    DateTime pgiModifyDate;
    #endregion
    #region 公用
    public string _pgiGuid
    {
        set { pgiGuid = value; }
    }
    public string _pgiPerGuid
    {
        set { pgiPerGuid = value; }
    }
    public string _pgiPfGuid
    {
        set { pgiPfGuid = value; }
    }
    public string _pgiType
    {
        set { pgiType = value; }
    }
    public string _pgiChange
    {
        set { pgiChange = value; }
    }
    public string _pgiChangeDate
    {
        set { pgiChangeDate = value; }
    }
    public string _pgiInsuranceCode
    {
        set { pgiInsuranceCode = value; }
    }
    public string _pgiPs
    {
        set { pgiPs = value; }
    }
    public string _pgiCreateId
    {
        set { pgiCreateId = value; }
    }
    public string _pgiModifyId
    {
        set { pgiModifyId = value; }
    }
    public string _pgiStatus
    {
        set { pgiStatus = value; }
    }
    public DateTime _pgiCreateDate
    {
        set { pgiCreateDate = value; }
    }
    public DateTime _pgiModifyDate
    {
        set { pgiModifyDate = value; }
    }
    #endregion

    public DataTable SelectList(string EffectiveDate)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select pgiPerGuid,pgiPfGuid,pgiType,CONVERT(nvarchar(7),pgiChangeDate) as dateM into #tmp1 from sy_PersonGroupInsurance where pgiStatus<>'D' and pgiChange='01' ");
        if (pgiChangeDate != "")
        {
            sb.Append(@"and CONVERT(nvarchar(7),pgiChangeDate)=@pgiChangeDate  ");
        }

        sb.Append(@"select pgiPerGuid,pgiPfGuid,pgiType,CONVERT(nvarchar(7),pgiChangeDate) as dateM into #tmp2 from sy_PersonGroupInsurance where pgiStatus<>'D' and pgiChange='02' ");
        if (pgiChangeDate != "")
        {
            sb.Append(@"and CONVERT(nvarchar(7),pgiChangeDate)=@pgiChangeDate  ");
        }

        sb.Append(@"--先過濾掉兩張表有同月份重複加退保的資料
select a.pgiPerGuid,a.pgiPfGuid,a.pgiType,tmp.dateM,Max(a.pgiChangeDate) as masxdate into #tmptmp from (
	select * from (
		select * from #tmp1
		except
		select * from #tmp2
	)tmp
	union all
	select * from (
		select * from #tmp2
		except
		select * from #tmp1
	)tmp
)tmp
left join sy_PersonGroupInsurance a 
on tmp.pgiPerGuid = a.pgiPerGuid and isnull(tmp.pgiPfGuid,'') = isnull(a.pgiPfGuid,'') and tmp.pgiType = a.pgiType
	and tmp.dateM=CONVERT(nvarchar(7),a.pgiChangeDate)
group by a.pgiPerGuid,a.pgiPfGuid,a.pgiType,tmp.dateM 

--再根據沒有同月份重複加退保的資料去join出所有資料
select top 200 a.*,b.perNo,b.perName,c.pfName,d.pgiGuid,d.pgiInsuranceCode,d.pgiType,d.pgiChangeDate 
,(select code_desc from sy_codetable where code_group='14' and code_value=d.pgiChange) pgiChange
,(select code_desc from sy_codetable where code_group='17' and code_value=c.pfTitle) pfTitle
from #tmptmp a 
left join sy_Person b on  a.pgiPerGuid=b.perGuid 
left join sy_PersonFamily c on a.pgiPfGuid=c.pfGuid
left join sy_PersonGroupInsurance d on a.pgiPerGuid=d.pgiPerGuid and isnull(a.pgiPfGuid,'')=isnull(d.pgiPfGuid,'') and a.pgiType=d.pgiType and a.masxdate=d.pgiChangeDate
left join sy_GroupInsurance e on d.pgiInsuranceCode=e.giGuid
where d.pgiStatus='A' ");
        if (pgiChangeDate != "")
        {
            sb.Append(@"and a.dateM=@pgiChangeDate  ");
        }

        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(b.perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(b.perName) LIKE '%' + upper(@KeyWord) + '%') or (upper(c.pfName) LIKE '%' + upper(@KeyWord) + '%')
 or (upper(c.pfIDNumber) LIKE '%' + upper(@KeyWord) + '%')) ");
        }
        sb.Append(@"order by d.pgiChange,d.pgiChangeDate desc,d.pgiCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pgiChangeDate", pgiChangeDate);
        oCmd.Parameters.AddWithValue("@EffectiveDate", EffectiveDate);
        oda.Fill(ds);
        return ds;
    }

    public void addGroupInsurance()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"insert into sy_PersonGroupInsurance (
pgiGuid,
pgiPerGuid,
pgiPfGuid,
pgiType,
pgiChange,
pgiChangeDate,
pgiInsuranceCode,
pgiPs,
pgiCreateId,
pgiModifyDate,
pgiModifyId,
pgiStatus
) values (
@pgiGuid,
@pgiPerGuid,
@pgiPfGuid,
@pgiType,
@pgiChange,
@pgiChangeDate,
@pgiInsuranceCode,
@pgiPs,
@pgiCreateId,
@pgiModifyDate,
@pgiModifyId,
@pgiStatus
) ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pgiGuid", pgiGuid);
        oCmd.Parameters.AddWithValue("@pgiPerGuid", pgiPerGuid);
        oCmd.Parameters.AddWithValue("@pgiPfGuid", pgiPfGuid);
        oCmd.Parameters.AddWithValue("@pgiType", pgiType);
        oCmd.Parameters.AddWithValue("@pgiChange", pgiChange);
        oCmd.Parameters.AddWithValue("@pgiChangeDate", pgiChangeDate);
        oCmd.Parameters.AddWithValue("@pgiInsuranceCode", pgiInsuranceCode);
        oCmd.Parameters.AddWithValue("@pgiPs", pgiPs);
        oCmd.Parameters.AddWithValue("@pgiCreateId", pgiCreateId);
        oCmd.Parameters.AddWithValue("@pgiModifyId", pgiModifyId);
        oCmd.Parameters.AddWithValue("@pgiModifyDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@pgiStatus", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modGroupInsurance()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonGroupInsurance set
pgiPerGuid=@pgiPerGuid,
pgiPfGuid=@pgiPfGuid,
pgiType=@pgiType,
pgiChange=@pgiChange,
pgiChangeDate=@pgiChangeDate,
pgiInsuranceCode=@pgiInsuranceCode,
pgiPs=@pgiPs,
pgiModifyId=@pgiModifyId,
pgiModifyDate=@pgiModifyDate
where pgiGuid=@pgiGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pgiGuid", pgiGuid);
        oCmd.Parameters.AddWithValue("@pgiPerGuid", pgiPerGuid);
        oCmd.Parameters.AddWithValue("@pgiPfGuid", pgiPfGuid);
        oCmd.Parameters.AddWithValue("@pgiType", pgiType);
        oCmd.Parameters.AddWithValue("@pgiChange", pgiChange);
        oCmd.Parameters.AddWithValue("@pgiChangeDate", pgiChangeDate);
        oCmd.Parameters.AddWithValue("@pgiInsuranceCode", pgiInsuranceCode);
        oCmd.Parameters.AddWithValue("@pgiPs", pgiPs);
        oCmd.Parameters.AddWithValue("@pgiModifyId", pgiModifyId);
        oCmd.Parameters.AddWithValue("@pgiModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }
    public void deleteGroupInsurance()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonGroupInsurance set 
pgiStatus='D',
pgiModifyId=@pgiModifyId,
pgiModifyDate=@pgiModifyDate
where pgiGuid=@pgiGuid ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pgiGuid", pgiGuid);
        oCmd.Parameters.AddWithValue("@pgiModifyId", pgiModifyId);
        oCmd.Parameters.AddWithValue("@pgiModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable getGroupInsByGuid()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonGroupInsurance 
left join sy_Person on perGuid=pgiPerGuid
left join sy_PersonFamily on pfGuid=pgiPfGuid
left join sy_GroupInsurance on giGuid=pgiInsuranceCode
left join sy_CodeBranches on cbGuid=perDep
where  pgiStatus<>'D' and pgiGuid=@pgiGuid ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pgiGuid", pgiGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkPerGroupIns()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonGroupInsurance where pgiChange='01' and pgiPerGuid=@pgiPerGuid and pgiStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pgiPerGuid", pgiPerGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkPerLastStatus(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * from sy_PersonGroupInsurance where pgiStatus='A' and pgiPerGuid=@perGuid and pgiType='01'
and pgiChangeDate=(select MAX(pgiChangeDate) from sy_PersonGroupInsurance where pgiStatus='A' and pgiPerGuid=@perGuid and pgiType='01') 
and pgiCreateDate=(select MAX(pgiCreateDate) from sy_PersonGroupInsurance where pgiStatus='A' and pgiPerGuid=@perGuid and pgiType='01') ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkPFLastStatus(string pfGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * from sy_PersonGroupInsurance where pgiStatus='A' and pgiPfGuid=@pgiPfGuid
and pgiChangeDate=(select MAX(pgiChangeDate) from sy_PersonGroupInsurance where pgiStatus='A' and pgiPfGuid=@pgiPfGuid) 
and pgiCreateDate=(select MAX(pgiCreateDate) from sy_PersonGroupInsurance where pgiStatus='A' and pgiPfGuid=@pgiPfGuid) ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pgiPfGuid", pfGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable getGInsYM()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select distinct convert(varchar(7),pgiChangeDate,121) v from sy_PersonGroupInsurance order by v desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@pgiPfGuid", pfGuid);
        oda.Fill(ds);
        return ds;
    }
}