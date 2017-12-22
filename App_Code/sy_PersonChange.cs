using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_PersonChange 的摘要描述
/// </summary>
public class sy_PersonChange
{
    #region 全私用
    string str_keyword = string.Empty;
    string str_date = string.Empty;
    string str_status = string.Empty;
    string str_back_per_guid = string.Empty;
    string str_creatid = string.Empty;
    string str_perguid = string.Empty;
    string str_dates = string.Empty;
    string str_datee = string.Empty;
    #endregion
    #region 全公用
    public string _str_keyword
    {
        set { str_keyword = value; }
    }
    public string _str_date
    {
        set { str_date = value; }
    }
    public string _str_status
    {
        set { str_status = value; }
    }
    public string _str_back_per_guid
    {
        set { str_back_per_guid = value; }
    }
    public string _str_creatid
    {
        set { str_creatid = value; }
    }
    public string _str_perguid
    {
        set { str_perguid = value; }
    }
    public string _str_dates
    {
        set { str_dates = value; }
    }
    public string _str_datee
    {
        set { str_datee = value; }
    }
    #endregion

    #region sy_PersonChange 私用
    string pcGuid = string.Empty;
    string pcPerGuid = string.Empty;
    string pcChangeDate = string.Empty;
    string pcChangeName = string.Empty;
    string pcChangeBegin = string.Empty;
    string pcChangeEnd = string.Empty;
    string pcVenifyDate = string.Empty;
    string pcVenify = string.Empty;
    string pcStatus = string.Empty;
    string pcPs = string.Empty;
    string pcCreateId = string.Empty;
    string pcModifyId = string.Empty;
    string pcStatus_d = string.Empty;
    DateTime pcCreateDate;
    DateTime pcModifyDate;
    #endregion
    #region sy_PersonChange 公用
    public string _pcGuid
    {
        set { pcGuid = value; }
    }
    public string _pcPerGuid
    {
        set { pcPerGuid = value; }
    }
    public string _pcChangeDate
    {
        set { pcChangeDate = value; }
    }
    public string _pcChangeName
    {
        set { pcChangeName = value; }
    }
    public string _pcChangeBegin
    {
        set { pcChangeBegin = value; }
    }
    public string _pcChangeEnd
    {
        set { pcChangeEnd = value; }
    }
    public string _pcVenifyDate
    {
        set { pcVenifyDate = value; }
    }
    public string _pcVenify
    {
        set { pcVenify = value; }
    }
    public string _pcStatus
    {
        set { pcStatus = value; }
    }
    public string _pcPs
    {
        set { pcPs = value; }
    }
    public string _pcCreateId
    {
        set { pcCreateId = value; }
    }
    public string _pcModifyId
    {
        set { pcModifyId = value; }
    }
    public string _pcStatus_d
    {
        set { pcStatus_d = value; }
    }
    public DateTime _pcCreateDate
    {
        set { pcCreateDate = value; }
    }
    public DateTime _pcModifyDate
    {
        set { pcModifyDate = value; }
    }
    #endregion

    #region sy_Person 私用
    string perNo = string.Empty;
    string perGuid = string.Empty;
    string perDep = string.Empty;
    string perPosition = string.Empty;
    string perFirstDate = string.Empty;
    string perLastDate = string.Empty;
    #endregion
    #region sy_Person 公用
    public string _perNo
    {
        set { perNo = value; }
    }
    public string _perGuid
    {
        set { perGuid = value; }
    }
    public string _perDep
    {
        set { perDep = value; }
    }
    public string _perPosition
    {
        set { perPosition = value; }
    }
    public string _perFirstDate
    {
        set { perFirstDate = value; }
    }
    public string _perLastDate
    {
        set { perLastDate = value; }
    }
    #endregion

    public sy_PersonChange()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region 撈 sy_PersonChange 條件 keyword or date(yyyy/mm/dd) or GUID or 異動項目名稱 or 狀態(已未/確認)
    public DataTable SelectPersonChange()
    {
        DataTable dt = new DataTable();
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            thisConnection.Open();
            show_value.Append(@"  
                select pcGuid,pcPerGuid,pcChangeDate,pcChangeName,pcChangeBegin,pcChangeEnd,pcVenifyDate,pcVenify,pcStatus,pcPs,perNo,perName,e.code_desc ChangeCName
                        ,a.code_desc begin_jobname,b.code_desc after_jobname,c.cbName begin_storename,d.cbName after_storename,mbName,perLastDate
                from sy_PersonChange
                left join sy_Person on pcPerGuid = perGuid
                left join sy_codetable a on a.code_group='02' and pcChangeBegin = a.code_value
                left join sy_codetable b on b.code_group='02' and pcChangeEnd = b.code_value
                left join sy_codetable e on e.code_group='10' and pcChangeName = e.code_value
                left join sy_CodeBranches c on pcChangeBegin = c.cbGuid
                left join sy_CodeBranches d on pcChangeEnd = d.cbGuid
                left join sy_Member on pcVenify=mbGuid
                where pcStatus_d='A'
            ");

            if (str_keyword != "")
            {
                show_value.Append(@" and (upper(perNo) LIKE '%' + upper(@str_keyword) + '%' or upper(perName) LIKE '%' + upper(@str_keyword) + '%' )  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (pcChangeDate != "")
            {
                show_value.Append(@" and pcChangeDate=@pcChangeDate  ");
                thisCommand.Parameters.AddWithValue("@pcChangeDate", pcChangeDate);
            }
            if (pcGuid != "")
            {
                show_value.Append(@" and pcGuid=@pcGuid  ");
                thisCommand.Parameters.AddWithValue("@pcGuid", pcGuid);
            }
            if (pcStatus != "")
            {
                show_value.Append(@" and pcStatus=@pcStatus  ");
                thisCommand.Parameters.AddWithValue("@pcStatus", pcStatus);
            }
            if (pcChangeName != "")
            {
                show_value.Append(@" and pcChangeName=@pcChangeName  ");
                thisCommand.Parameters.AddWithValue("@pcChangeName", pcChangeName);
            }
            if (str_dates!="" && str_datee!="") {
                show_value.Append(@" and pcChangeDate between  @str_dates and @str_datee ");
                thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
                thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
            }
            show_value.Append(@" order by pcStatus DESC, pcCreateDate DESC,pcChangeDate DESC  ");

            thisCommand.CommandType = CommandType.Text;
            thisCommand.CommandText = show_value.ToString();
            oda.SelectCommand = thisCommand;
            oda.Fill(dt);
        }
        catch (Exception)
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }
        return dt;

    }
    #endregion

    #region 撈 sy_Person 條件 perNo
    public DataTable SelectPersonByperNo()
    {
        DataTable dt = new DataTable();
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            thisConnection.Open();
            show_value.Append(@" 
                select perGuid,perNo,perName,perPosition,code_desc as PositionName,perDep,cbName,perFirstDate,perBasicSalary,perAllowance,perLastDate
                from sy_Person
                left join sy_codetable on code_group = '02' and  perPosition = code_value
                left join sy_CodeBranches on perDep = cbGuid
                where perNo=@perNo and perStatus<>'D'
            ");
            thisCommand.Parameters.AddWithValue("@perNo", perNo);

            thisCommand.CommandType = CommandType.Text;
            thisCommand.CommandText = show_value.ToString();
            oda.SelectCommand = thisCommand;
            oda.Fill(dt);
        }
        catch (Exception)
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }
        return dt;

    }
    #endregion

    #region 新增 sy_PersonChange
    public void InsertPersonChange()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_PersonChange(pcGuid,pcPerGuid,pcChangeDate,pcChangeName,pcChangeBegin,pcChangeEnd,pcVenifyDate,pcVenify,pcStatus,pcPs,pcCreateId,pcCreateDate,pcStatus_d) 
                values(@pcGuid,@pcPerGuid,@pcChangeDate,@pcChangeName,@pcChangeBegin,@pcChangeEnd,@pcVenifyDate,@pcVenify,@pcStatus,@pcPs,@pcCreateId,@pcCreateDate,'A') 
            ");

            thisCommand.Parameters.AddWithValue("@pcGuid", pcGuid);
            thisCommand.Parameters.AddWithValue("@pcPerGuid", pcPerGuid);
            thisCommand.Parameters.AddWithValue("@pcChangeDate", pcChangeDate);
            thisCommand.Parameters.AddWithValue("@pcChangeName", pcChangeName);
            thisCommand.Parameters.AddWithValue("@pcChangeBegin", pcChangeBegin);
            thisCommand.Parameters.AddWithValue("@pcChangeEnd", pcChangeEnd);
            thisCommand.Parameters.AddWithValue("@pcVenifyDate", pcVenifyDate);
            thisCommand.Parameters.AddWithValue("@pcVenify", pcVenify);
            thisCommand.Parameters.AddWithValue("@pcStatus", pcStatus);
            thisCommand.Parameters.AddWithValue("@pcPs", pcPs);
            thisCommand.Parameters.AddWithValue("@pcCreateId", pcCreateId);
            thisCommand.Parameters.AddWithValue("@pcCreateDate", DateTime.Now);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

    #region 修改 sy_PersonChange
    public void UpdatePersonChange()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_PersonChange set pcPerGuid=@pcPerGuid,pcChangeDate=@pcChangeDate,pcChangeName=@pcChangeName,pcChangeBegin=@pcChangeBegin,pcChangeEnd=@pcChangeEnd,pcVenifyDate=@pcVenifyDate,pcVenify=@pcVenify,pcStatus=@pcStatus,pcPs=@pcPs,pcModifyId=@pcModifyId,pcModifyDate=@pcModifyDate
                where  pcGuid=@pcGuid               
            ");

            thisCommand.Parameters.AddWithValue("@pcGuid", pcGuid);
            thisCommand.Parameters.AddWithValue("@pcPerGuid", pcPerGuid);
            thisCommand.Parameters.AddWithValue("@pcChangeDate", pcChangeDate);
            thisCommand.Parameters.AddWithValue("@pcChangeName", pcChangeName);
            thisCommand.Parameters.AddWithValue("@pcChangeBegin", pcChangeBegin);
            thisCommand.Parameters.AddWithValue("@pcChangeEnd", pcChangeEnd);
            thisCommand.Parameters.AddWithValue("@pcVenifyDate", pcVenifyDate);
            thisCommand.Parameters.AddWithValue("@pcVenify", pcVenify);
            thisCommand.Parameters.AddWithValue("@pcStatus", pcStatus);
            thisCommand.Parameters.AddWithValue("@pcPs", pcPs);
            thisCommand.Parameters.AddWithValue("@pcModifyId", pcModifyId);
            thisCommand.Parameters.AddWithValue("@pcModifyDate", DateTime.Now);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

    #region 刪除 sy_PersonChange 不是真的刪除 update set 
    public void DeletePersonChange()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_PersonChange set pcStatus_d='D' where  pcGuid=@pcGuid               
            ");

            thisCommand.Parameters.AddWithValue("@pcGuid", pcGuid);
            thisCommand.Parameters.AddWithValue("@pcModifyId", pcModifyId);
            thisCommand.Parameters.AddWithValue("@pcModifyDate", DateTime.Now);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

    #region 更新人事資料 sy_Person. perDep
    public void UpdatperDep()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Person set perDep=@perDep
                where  perGuid=@perGuid               
            ");

            thisCommand.Parameters.AddWithValue("@perGuid", perGuid);
            thisCommand.Parameters.AddWithValue("@perDep", perDep);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

    #region 更新人事資料 sy_Person. perPosition
    public void UpdatperPosition()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Person set perPosition=@perPosition
                where  perGuid=@perGuid              
            ");

            thisCommand.Parameters.AddWithValue("@perGuid", perGuid);
            thisCommand.Parameters.AddWithValue("@perPosition", perPosition);
            
            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

    #region 退保 勞保 健保 團保 勞退 眷屬 
    public void UpdatePersonLabor()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            //順序 勞保 健保 團保 勞退 眷屬
            //20170926調整  健保&團保是轉出piChange='07' pfiChange='03'  勞保 團保 勞退 三個依舊維持是退保
            //20171017 調整 所有備註都不要帶過去 都insert 空值
            show_value.Append(@" 
                declare @chk_type nvarchar(5);

                --勞保
                select top 1 @chk_type=plChange
                from sy_PersonLabor 
                where plPerGuid=@str_back_per_guid and plStatus='A' 
                order by plChangeDate DESC,plCreateDate DESC
                if @chk_type is not null and @chk_type <>'' and @chk_type<>'02' and @chk_type<>'04' and (@chk_type='01' or @chk_type='03')
	                begin 
		                insert into sy_PersonLabor (plGuid,plPerGuid,plSubsidyLevel,plLaborNo,plChangeDate,plChange,plLaborPayroll,plPs,plCreateId,plStatus)
	                    select top 1 NEWID(),plPerGuid,plSubsidyLevel,plLaborNo,@str_date,'02',plLaborPayroll,'',@str_creatid,'A'
	                    from sy_PersonLabor 
	                    where plPerGuid=@str_back_per_guid and plStatus='A' 
                        order by plChangeDate DESC,plCreateDate DESC
	                end
            
                --健保
                set @chk_type='';
                select top 1 @chk_type=piChange
                from sy_PersonInsurance 
                where piPerGuid=@str_back_per_guid and piStatus='A'
                order by piChangeDate DESC,piCreateDate DESC
                if @chk_type is not null and @chk_type <>'' and @chk_type<>'02' and @chk_type<>'04' and @chk_type<>'06' and @chk_type<>'07' and (@chk_type='01' or @chk_type='03' or @chk_type='05')
                    begin
                        insert into sy_PersonInsurance (piGuid,piPerGuid,piSubsidyLevel,piCardNo,piChangeDate,piChange,piInsurancePayroll,piPs,piCreateId,piStatus,piDropOutReason)
                        select top 1 NEWID(),piPerGuid,piSubsidyLevel,piCardNo,@str_date,'07',piInsurancePayroll,'',@str_creatid,'A','1'
	                    from sy_PersonInsurance 
	                    where piPerGuid=@str_back_per_guid and piStatus='A'
                        order by piChangeDate DESC,piCreateDate DESC
                    end
                
                --勞退
                set @chk_type='';
                select top 1 @chk_type=ppChange
                from sy_PersonPension 
                where ppPerGuid=@str_back_per_guid and ppStatus='A'
                order by ppChangeDate DESC,ppCreateDate DESC
                if @chk_type is not null and @chk_type <>'' and @chk_type<>'03' and (@chk_type='01' or @chk_type='02')
                    begin
                        insert into sy_PersonPension (ppGuid,ppPerGuid,ppChange,ppChangeDate,ppLarboRatio,ppEmployerRatio,ppPayPayroll,ppPs,ppCreateId,ppStatus)
                        select top 1 NEWID(),ppPerGuid,'03',@str_date,ppLarboRatio,ppEmployerRatio,ppPayPayroll,'',@str_creatid,'A'
	                    from sy_PersonPension 
	                    where ppPerGuid=@str_back_per_guid and ppStatus='A'
	                    order by ppChangeDate DESC,ppCreateDate DESC
                    end

                --團保
                set @chk_type='';
                declare @pgirowcount int;
                declare @while_pgiPerGuid nvarchar(50);
                declare @while_pgiPfGuid nvarchar(50);
                --先撈出該GUID底下在sy_PersonGroupInsurance裡面有多少人屬於他
                select pgiPerGuid,pgiPfGuid
                into #tmp_pgi
                from sy_PersonGroupInsurance 
                where pgiPerGuid=@str_back_per_guid and pgiStatus='A'
                group by pgiPerGuid,pgiPfGuid
                select @pgirowcount=COUNT(*) from #tmp_pgi
                if @pgirowcount>0
	                begin 
		                while @pgirowcount>0
			                begin
                                --根據屬於該GUID底下的人員一個一個找最新一筆資料是加保還是退保，如果是退保就不新增
				                select top 1 @while_pgiPerGuid=pgiPerGuid,@while_pgiPfGuid=pgiPfGuid from #tmp_pgi
				                select top 1 @chk_type=pgiChange from sy_PersonGroupInsurance
				                where pgiPerGuid=@while_pgiPerGuid and pgiPfGuid=@while_pgiPfGuid and pgiStatus='A'
				                order by pgiChangeDate DESC,pgiCreateDate DESC
				                if @chk_type is not null and @chk_type<>'' and @chk_type<>'02' and @chk_type='01'
					                begin
						                insert into sy_PersonGroupInsurance (pgiGuid,pgiPerGuid,pgiType,pgiPfGuid,pgiChange,pgiChangeDate,pgiInsuranceCode,pgiPs,pgiCreateId,pgiStatus)
                                        select NEWID(),pgiPerGuid,pgiType,pgiPfGuid,'02',@str_date,pgiInsuranceCode,'',@str_creatid,'A'
	                                    from sy_PersonGroupInsurance 
	                                    where pgiPerGuid=@str_back_per_guid and pgiStatus='A' and pgiPerGuid=@while_pgiPerGuid and pgiPfGuid=@while_pgiPfGuid
	                                    order by pgiChangeDate DESC,pgiCreateDate DESC
					                end
				                delete from #tmp_pgi where pgiPerGuid=@while_pgiPerGuid and pgiPfGuid=@while_pgiPfGuid
				                set @pgirowcount = @pgirowcount-1;
				                set @chk_type=''
			                end
	                end
                    drop table #tmp_pgi

                    --眷屬
                    --先撈出該GUID底下在sy_PersonFamilyInsurance裡面有多少人屬於他
                    declare @pfirowcount int;
                    declare @while_pfiPerGuid nvarchar(50);
                    declare @while_pfiPfGuid nvarchar(50);
                    select pfiPerGuid,pfiPfGuid
                    into #tmp_pfi
                    from sy_PersonFamilyInsurance 
                    where pfiPerGuid=@str_back_per_guid and pfiStatus='A'
                    group by pfiPerGuid,pfiPfGuid
                    select @pfirowcount=COUNT(*) from #tmp_pfi
                    if @pfirowcount>0
	                    begin 
		                    while @pfirowcount>0
			                    begin
                                    --根據屬於該GUID底下的人員一個一個找最新一筆資料是加保還是退保，如果是退保就不新增
				                    select top 1 @while_pfiPerGuid=pfiPerGuid,@while_pfiPfGuid=pfiPfGuid from #tmp_pfi
				                    select top 1 @chk_type=pfiChange from sy_PersonFamilyInsurance
				                    where pfiPerGuid=@while_pfiPerGuid and pfiPfGuid=@while_pfiPfGuid and pfiStatus='A'
				                    order by pfiChangeDate DESC,pfiCreateDate DESC
				                    if @chk_type is not null and @chk_type<>'' and @chk_type<>'02' and @chk_type<>'03' and @chk_type='01'
					                    begin
						                    insert into sy_PersonFamilyInsurance (pfiGuid,pfiPerGuid,pfiPfGuid,pfiChange,pfiChangeDate,pfiSubsidyLevel,pfiCardNo,pfiAreaPerson,pfiPs,pfiCreateId,pfiStatus,pfiDropOutReason)
                                            select top 1 NEWID(),pfiPerGuid,pfiPfGuid,'03',@str_date,pfiSubsidyLevel,pfiCardNo,pfiAreaPerson,'',@str_creatid,'A','5'
	                                        from sy_PersonFamilyInsurance 
	                                        where pfiPerGuid=@str_back_per_guid and pfiStatus='A' and  pfiPerGuid=@while_pfiPerGuid and pfiPfGuid=@while_pfiPfGuid
	                                        order by pfiChangeDate DESC,pfiCreateDate DESC
					                    end
				                    delete from #tmp_pfi where pfiPerGuid=@while_pfiPerGuid and pfiPfGuid=@while_pfiPfGuid
				                    set @pfirowcount = @pfirowcount-1;
				                    set @chk_type=''
			                    end
	                    end
                    drop table #tmp_pfi

                ");

            thisCommand.Parameters.AddWithValue("@str_back_per_guid", str_back_per_guid);
            thisCommand.Parameters.AddWithValue("@str_date", str_date);
            thisCommand.Parameters.AddWithValue("@str_creatid", str_creatid);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
            
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

    #region 判斷同一個人在同一個異動日期是否有重複的異動項目
    public DataTable CheckPersonChangeIten()
    {
        DataTable dt = new DataTable();
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            thisConnection.Open();
            if (pcGuid != null && pcGuid != "")
            {
                show_value.Append(@" 
                    select * from sy_PersonChange
                    where pcPerGuid=@pcPerGuid and pcChangeDate=@pcChangeDate and pcChangeName=@pcChangeName and pcGuid=@pcGuid
                ");
                thisCommand.Parameters.AddWithValue("@pcGuid", pcGuid);
                thisCommand.Parameters.AddWithValue("@pcPerGuid", pcPerGuid);
                thisCommand.Parameters.AddWithValue("@pcChangeDate", pcChangeDate);
                thisCommand.Parameters.AddWithValue("@pcChangeName", pcChangeName);
            }
            else
            {
                show_value.Append(@" 
                    select * from sy_PersonChange
                    where pcPerGuid=@pcPerGuid and pcChangeDate=@pcChangeDate and pcChangeName=@pcChangeName
                ");
                thisCommand.Parameters.AddWithValue("@pcPerGuid", pcPerGuid);
                thisCommand.Parameters.AddWithValue("@pcChangeDate", pcChangeDate);
                thisCommand.Parameters.AddWithValue("@pcChangeName", pcChangeName);
            }
            

            thisCommand.CommandType = CommandType.Text;
            thisCommand.CommandText = show_value.ToString();
            oda.SelectCommand = thisCommand;
            oda.Fill(dt);
        }
        catch (Exception)
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }
        return dt;

    }
    #endregion

    #region 更新人事資料 sy_Person. perLastDate
    public void UpdatperLastdate()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Person set perLastDate =@perLastDate 
                where  perGuid=@perGuid              
            ");

            thisCommand.Parameters.AddWithValue("@perGuid", perGuid);
            thisCommand.Parameters.AddWithValue("@perLastDate ", perLastDate);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

    #region 更新人事資料 sy_Person. perLastDate perFirstDate
    public void UpdatperFirstdateLastdate()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Person set perLastDate ='' ,perFirstDate=@perFirstDate
                where  perGuid=@perGuid              
            ");

            thisCommand.Parameters.AddWithValue("@perGuid", perGuid);
            thisCommand.Parameters.AddWithValue("@perFirstDate ", perFirstDate);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

    #region 回任加保  撈sy_SetStartInsurance
    public void AddStartInsurance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                --新進到職勞保 健保 勞退預設值
                declare @labor decimal(10, 0)
                declare @ganbor decimal(10, 0)
                declare @tahui decimal(10, 0)
                select @labor=ssi_labor,@ganbor=ssi_ganbor,@tahui=ssi_tahui from sy_SetStartInsurance
                --雇主提撥率
                declare @EmployerRatio decimal(10, 0)
                select @EmployerRatio=iiRetirement 
                from sy_Person left join sy_InsuranceIdentity on perInsuranceDes=iiGuid 
                where perGuid = @perGuid
                
                --建保加保
                declare @add_piSubsidyLevel nvarchar(50)
                declare @add_comHealthInsuranceCode nvarchar(20)
                select @add_piSubsidyLevel = perInsuranceID from sy_Person where perGuid=@perGuid
                select @add_comHealthInsuranceCode = comHealthInsuranceCode from sy_Person left join sy_Company on perComGuid = comGuid where perGuid=@perGuid
                insert into sy_PersonInsurance(piGuid,piPerGuid,piSubsidyLevel,piCardNo,piChangeDate,piChange,piInsurancePayroll,piPs,piCreateId,piStatus)
                values(NEWID(),@perGuid,@add_piSubsidyLevel,@add_comHealthInsuranceCode,@perFirstDate,'01',@ganbor,'',@str_creatid,'A')    
            
                --勞保加保
                declare @add_perLaborID  nvarchar(50)
                declare @add_perLaborProtection  nvarchar(20)
                select @add_perLaborID =perLaborID from sy_Person where perGuid=@perGuid and perStatus<>'D'
                select @add_perLaborProtection=comLaborProtectionCode from sy_Person left join  sy_Company on  perGuid=@perGuid  and perStatus<>'D' and  perComGuid=comGuid
                insert into sy_PersonLabor (plGuid,plPerGuid,plSubsidyLevel,plLaborNo,plChangeDate,plChange,plLaborPayroll,plPs,plCreateId,plStatus)
	            values(NEWID(),@perGuid,@add_perLaborID ,@add_perLaborProtection,@perFirstDate,'01',@labor,'',@str_creatid,'A')
                
                --勞退加保
                insert into sy_PersonPension (ppGuid,ppPerGuid,ppChange,ppChangeDate,ppLarboRatio,ppEmployerRatio,ppPayPayroll,ppPs,ppCreateId,ppStatus)
                values( NEWID(),@perGuid,'01',@perFirstDate,0,@EmployerRatio,@tahui,'',@str_creatid,'A')
                
            ");

            thisCommand.Parameters.AddWithValue("@str_creatid", str_creatid);
            thisCommand.Parameters.AddWithValue("@perGuid", perGuid);
            thisCommand.Parameters.AddWithValue("@perFirstDate", perFirstDate);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

}