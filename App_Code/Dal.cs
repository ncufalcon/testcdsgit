using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Dal 的摘要描述
/// </summary>
public class Dal
{
    string connectionStr = ConfigurationManager.ConnectionStrings["ConnString"].ToString();


    //城市代碼檔
    public DataTable city()
    {
        string sql = @"select code_value,code_desc from sy_codetable where code_group ='01'";

        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);
        //cmd.Parameters.AddWithValue("@A_id", A_id);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }
    //角色
    public DataTable Member()
    {
        string sql = @"select cmClass,cmName from sy_MemberCom order by cmClass asc";

        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);
        //cmd.Parameters.AddWithValue("@A_id", A_id);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }
    //角色中文名
    public string MemberName(string cmClass)
    {
        string sql = @"select cmName from sy_MemberCom where cmClass =@cmClass";
        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.Parameters.AddWithValue("@cmClass", cmClass);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            if (dt.Rows.Count == 1)
                return dt.Rows[0]["cmName"].ToString();
            else
                return "";
            
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
        
    }
    #region 公司資料設定 page-company

    //新增主資料
    public void insertCompanyData(string comName,string comAbbreviate,string comUniform,
                                  string comNTA,string comLaborProtection1,string comLaborProtection2,
                                  string comBIT,string comNTB,string comLaborProtectionCode,
                                  string comHouseTax,string comCity,string comHealthInsuranceCode,
                                  string comBusinessEntity,string comResponsible,string comTel,
                                  string comAddress1,string comAddress2,string comPs,
                                  string comMail, string comOfficeNumber, string comAccountNumber,
                                  string comCreatId)
    {
        string sql = @"insert sy_Company (
  comName,comAbbreviate,comUniform,
  comNTA,comLaborProtection1,comLaborProtection2,
  comBIT,comNTB,comLaborProtectionCode,
  comHouseTax,comCity,comHealthInsuranceCode,
  comBusinessEntity,comResponsible,comTel,
  comAddress1,comAddress2,comPs,
  comMail,comOfficeNumber,comAccountNumber,
  comCreatId,comStatus)
  values (
  @comName,@comAbbreviate,@comUniform,
  @comNTA,@comLaborProtection1,@comLaborProtection2,
  @comBIT,@comNTB,@comLaborProtectionCode,
  @comHouseTax,@comCity,@comHealthInsuranceCode,
  @comBusinessEntity,@comResponsible,@comTel,
  @comAddress1,@comAddress2,@comPs,
  @comMail,@comOfficeNumber,@comAccountNumber,
  @comCreatId,@comStatus)";
        SqlConnection AD = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, AD);
        cmd.Parameters.AddWithValue("@comName", comName);
        cmd.Parameters.AddWithValue("@comAbbreviate", comAbbreviate);
        cmd.Parameters.AddWithValue("@comUniform", comUniform);

        cmd.Parameters.AddWithValue("@comNTA", comNTA);
        cmd.Parameters.AddWithValue("@comLaborProtection1", comLaborProtection1);
        cmd.Parameters.AddWithValue("@comLaborProtection2", comLaborProtection2);

        cmd.Parameters.AddWithValue("@comBIT", comBIT);
        cmd.Parameters.AddWithValue("@comNTB", comNTB);
        cmd.Parameters.AddWithValue("@comLaborProtectionCode", comLaborProtectionCode);

        cmd.Parameters.AddWithValue("@comHouseTax", comHouseTax);
        cmd.Parameters.AddWithValue("@comCity", comCity);
        cmd.Parameters.AddWithValue("@comHealthInsuranceCode", comHealthInsuranceCode);

        cmd.Parameters.AddWithValue("@comBusinessEntity", comBusinessEntity);
        cmd.Parameters.AddWithValue("@comResponsible", comResponsible);
        cmd.Parameters.AddWithValue("@comTel", comTel);

        cmd.Parameters.AddWithValue("@comAddress1", comAddress1);
        cmd.Parameters.AddWithValue("@comAddress2", comAddress2);
        cmd.Parameters.AddWithValue("@comPs", comPs);

        cmd.Parameters.AddWithValue("@comMail", comMail);
        cmd.Parameters.AddWithValue("@comOfficeNumber", comOfficeNumber);
        cmd.Parameters.AddWithValue("@comAccountNumber", comAccountNumber);

        cmd.Parameters.AddWithValue("@comCreatId", comCreatId);
        cmd.Parameters.AddWithValue("@comStatus", "I");//狀態 新增:I
        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }

    //top 200 List
    public DataTable SelCompanyData()
    {
        string sql = @"select top 200 * from sy_Company where comStatus <> 'D' order by comCreatDate desc";

        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }

    //查詢 where 申報公司&統一編號
    public DataTable SearchCompanyData(string comName, string comUniform)
    {
        string sql = @"select * from sy_Company where comStatus <> 'D' ";

        if (!string.IsNullOrEmpty(comName))
            sql += "and comName like '%'+@comName+'%' ";

        if (!string.IsNullOrEmpty(comUniform))
            sql += "and comUniform like '%'+@comUniform+'%' ";

        sql += "order by comCreatDate desc";
        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);

        cmd.Parameters.AddWithValue("@comName", comName);
        cmd.Parameters.AddWithValue("@comUniform", comUniform);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }

    //取得主資料
    public DataTable GetCompanyData(string comGuid)
    {
        string sql = @"select * from sy_Company where comGuid = @comGuid";

        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);

        cmd.Parameters.AddWithValue("@comGuid", comGuid);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }
    //修改主資料
    public void UpdateCompanyData(string comName, string comAbbreviate, string comUniform,
                                  string comNTA, string comLaborProtection1, string comLaborProtection2,
                                  string comBIT, string comNTB, string comLaborProtectionCode,
                                  string comHouseTax, string comCity, string comHealthInsuranceCode,
                                  string comBusinessEntity, string comResponsible, string comTel,
                                  string comAddress1, string comAddress2, string comPs,
                                  string comMail, string comOfficeNumber, string comAccountNumber,
                                  string comModifyId, DateTime comModifyDate,
                                  string comGuid)
    {
        string sql = @"update sy_Company set comName =@comName,comAbbreviate =@comAbbreviate,comUniform =@comUniform,
  comNTA =@comNTA,comLaborProtection1 =@comLaborProtection1,comLaborProtection2 =@comLaborProtection2,
  comBIT =@comBIT,comNTB =@comNTB,comLaborProtectionCode =@comLaborProtectionCode,
  comHouseTax =@comHouseTax,comCity =@comCity ,comHealthInsuranceCode =@comHealthInsuranceCode,
  comBusinessEntity =@comBusinessEntity,comResponsible =@comResponsible,comTel =@comTel,
  comAddress1 = @comAddress1,comAddress2 =@comAddress2,comPs =@comPs,
  comMail = @comMail,comOfficeNumber =@comOfficeNumber,comAccountNumber =@comAccountNumber,
  comModifyId = @comModifyId ,comModifyDate =@comModifyDate ,comStatus =@comStatus
  where comGuid = @comGuid";
        SqlConnection AD = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, AD);
        cmd.Parameters.AddWithValue("@comName", comName);
        cmd.Parameters.AddWithValue("@comAbbreviate", comAbbreviate);
        cmd.Parameters.AddWithValue("@comUniform", comUniform);

        cmd.Parameters.AddWithValue("@comNTA", comNTA);
        cmd.Parameters.AddWithValue("@comLaborProtection1", comLaborProtection1);
        cmd.Parameters.AddWithValue("@comLaborProtection2", comLaborProtection2);

        cmd.Parameters.AddWithValue("@comBIT", comBIT);
        cmd.Parameters.AddWithValue("@comNTB", comNTB);
        cmd.Parameters.AddWithValue("@comLaborProtectionCode", comLaborProtectionCode);

        cmd.Parameters.AddWithValue("@comHouseTax", comHouseTax);
        cmd.Parameters.AddWithValue("@comCity", comCity);
        cmd.Parameters.AddWithValue("@comHealthInsuranceCode", comHealthInsuranceCode);

        cmd.Parameters.AddWithValue("@comBusinessEntity", comBusinessEntity);
        cmd.Parameters.AddWithValue("@comResponsible", comResponsible);
        cmd.Parameters.AddWithValue("@comTel", comTel);

        cmd.Parameters.AddWithValue("@comAddress1", comAddress1);
        cmd.Parameters.AddWithValue("@comAddress2", comAddress2);
        cmd.Parameters.AddWithValue("@comPs", comPs);

        cmd.Parameters.AddWithValue("@comMail", comMail);
        cmd.Parameters.AddWithValue("@comOfficeNumber", comOfficeNumber);
        cmd.Parameters.AddWithValue("@comAccountNumber", comAccountNumber);

        cmd.Parameters.AddWithValue("@comModifyId", comModifyId);
        cmd.Parameters.AddWithValue("@comModifyDate", comModifyDate);
        cmd.Parameters.AddWithValue("@comStatus", "M");//狀態 修改:M

        cmd.Parameters.AddWithValue("@comGuid", comGuid);
        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }

    //刪除資料
    public void Up_Status_CompanyData(string comGuid, string comModifyId, DateTime comModifyDate)
    {
        string sql = @"update sy_Company set 
comStatus =@comStatus,comModifyId = @comModifyId ,comModifyDate =@comModifyDate
where comGuid =@comGuid";
        SqlConnection AD = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, AD);

        cmd.Parameters.AddWithValue("@comStatus", "D");//狀態 刪除:D
        cmd.Parameters.AddWithValue("@comModifyId", comModifyId);
        cmd.Parameters.AddWithValue("@comModifyDate", comModifyDate);
        cmd.Parameters.AddWithValue("@comGuid", comGuid);
        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }
    #endregion

    #region 分店管理 page-regionadmin

    //新增分店
    public void insertRegionadmin(string cbValue,string cbName,string cbDesc,string cbCreateId)
    {
        string sql = @"insert sy_CodeBranches (
cbValue,cbName,cbDesc,cbCreateId,cbStatus) 
values (
@cbValue,@cbName,@cbDesc,@cbCreateId,@cbStatus)";
        SqlConnection AD = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, AD);


        cmd.Parameters.AddWithValue("@cbValue", cbValue);
        cmd.Parameters.AddWithValue("@cbName", cbName);
        cmd.Parameters.AddWithValue("@cbDesc", cbDesc);
        cmd.Parameters.AddWithValue("@cbCreateId", cbCreateId);
        cmd.Parameters.AddWithValue("@cbStatus", "I");//狀態 新增:I
        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }

    //top 200 List
    public DataTable SelRegionadminData()
    {
        string sql = @"select top 200 * from sy_CodeBranches where cbStatus <> 'D' order by cbValue asc";

        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }

    //查詢 where 代碼&店名
    public DataTable SearchRegionadminData(string cbValue, string cbName)
    {
        string sql = @"select * from sy_CodeBranches where cbStatus <> 'D' ";

        if (!string.IsNullOrEmpty(cbValue))
            sql += "and cbValue =@cbValue ";

        if (!string.IsNullOrEmpty(cbName))
            sql += "and cbName like '%'+@cbName+'%' ";

        sql += "order by cbValue desc";
        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);

        cmd.Parameters.AddWithValue("@cbValue", cbValue);
        cmd.Parameters.AddWithValue("@cbName", cbName);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }

    //取得主資料
    public DataTable GetRegionadminData(string cbGuid)
    {
        string sql = @"select * from sy_CodeBranches where cbGuid = @cbGuid";

        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);

        cmd.Parameters.AddWithValue("@cbGuid", cbGuid);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }

    //修改資料
    public void Up_RegionadminData(string cbGuid, string cbValue, string cbName, string cbDesc, string cbModifyId, DateTime cbModifyDate)
    {
        string sql = @"update sy_CodeBranches set 
cbValue=@cbValue,cbName=@cbName ,cbDesc=@cbDesc,
cbModifyId=@cbModifyId,cbModifyDate=@cbModifyDate,cbStatus=@cbStatus 
where cbGuid =@cbGuid";
        SqlConnection AD = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, AD);

        cmd.Parameters.AddWithValue("@cbStatus", "M");//狀態 修改:M
        cmd.Parameters.AddWithValue("@cbValue", cbValue);
        cmd.Parameters.AddWithValue("@cbName", cbName);
        cmd.Parameters.AddWithValue("@cbDesc", cbDesc);
        cmd.Parameters.AddWithValue("@cbModifyId", cbModifyId);
        cmd.Parameters.AddWithValue("@cbModifyDate", cbModifyDate);
        cmd.Parameters.AddWithValue("@cbGuid", cbGuid);
        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }

    //刪除資料
    public void Up_Status_RegionadminData(string cbGuid, string cbModifyId, DateTime cbModifyDate)
    {
        string sql = @"update sy_CodeBranches set 
cbStatus =@cbStatus,cbModifyId=@cbModifyId,cbModifyDate=@cbModifyDate
where cbGuid =@cbGuid";
        SqlConnection AD = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, AD);

        cmd.Parameters.AddWithValue("@cbStatus", "D");//狀態 刪除:D
        cmd.Parameters.AddWithValue("@cbModifyId", cbModifyId);
        cmd.Parameters.AddWithValue("@cbModifyDate", cbModifyDate);
        cmd.Parameters.AddWithValue("@cbGuid", cbGuid);
        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }
    #endregion

    #region 管理者資料 page-admin
    
    //新增主資料
    public void insertAdmin(string mbName, string mbJobNumber, string mbId, 
        string mbPassword,string mbPs, string mbCom,
        string mbCreatId)
    {
        string sql = @"insert sy_Member (
mbName,mbJobNumber,mbId,
mbPassword,mbPs,mbCom,
mbCreatId,mbStatus)
values(
@mbName,@mbJobNumber,@mbId,
@mbPassword,@mbPs,@mbCom,
@mbCreatId,@mbStatus)";

        SqlConnection AD = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, AD);


        cmd.Parameters.AddWithValue("@mbName", mbName);
        cmd.Parameters.AddWithValue("@mbJobNumber", mbJobNumber);
        cmd.Parameters.AddWithValue("@mbId", mbId);

        cmd.Parameters.AddWithValue("@mbPassword", mbPassword);
        cmd.Parameters.AddWithValue("@mbPs", mbPs);
        cmd.Parameters.AddWithValue("@mbCom", mbCom);

        cmd.Parameters.AddWithValue("@mbCreatId", mbCreatId);
        cmd.Parameters.AddWithValue("@mbStatus", "I");//狀態 新增:I
        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }

    //top 200 List
    public DataTable SelAdmin()
    {
        string sql = @"select top 200 * from sy_Member where mbStatus <> 'D' order by mbId asc";

        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }
    //查詢 where 姓名&工號&角色
    public DataTable SearchAdminData(string mbName, string mbJobNumber, string mbCom, string mbId)
    {
        string sql = @"select * from sy_Member where mbStatus <> 'D' ";

        if (!string.IsNullOrEmpty(mbName))
            sql += "and mbName like '%'+@mbName+'%' ";

        if (!string.IsNullOrEmpty(mbJobNumber))
            sql += "and mbJobNumber =@mbJobNumber ";

        if (!string.IsNullOrEmpty(mbCom))
            sql += "and mbCom =@mbCom ";

        if (!string.IsNullOrEmpty(mbId))
            sql += "and mbId =@mbId ";

        sql += "order by mbId desc";
        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);

        cmd.Parameters.AddWithValue("@mbName", mbName);
        cmd.Parameters.AddWithValue("@mbJobNumber", mbJobNumber);
        cmd.Parameters.AddWithValue("@mbCom", mbCom);
        cmd.Parameters.AddWithValue("@mbId", mbId);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }

    //取得主資料
    public DataTable GetAdminData(string mbGuid)
    {
        string sql = @"select * from sy_Member where mbGuid = @mbGuid";

        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);

        cmd.Parameters.AddWithValue("@mbGuid", mbGuid);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }

    //修改資料
    public void Up_AdminData(string mbName, string mbJobNumber, string mbId,
        string mbPassword, string mbPs, string mbCom,
        string mbModifyId, DateTime mbModifyDate, string mbGuid)
    {
        string sql = @"update sy_Member set 
mbName=@mbName,mbJobNumber=@mbJobNumber,mbId=@mbId,
mbPassword=@mbPassword,mbPs=@mbPs,mbCom=@mbCom,
mbModifyId=@mbModifyId,mbModifyDate=@mbModifyDate,mbStatus=@mbStatus
where mbGuid =@mbGuid";
        SqlConnection AD = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, AD);

        cmd.Parameters.AddWithValue("@mbStatus", "M");//狀態 修改:M

        cmd.Parameters.AddWithValue("@mbName", mbName);
        cmd.Parameters.AddWithValue("@mbJobNumber", mbJobNumber);
        cmd.Parameters.AddWithValue("@mbId", mbId);

        cmd.Parameters.AddWithValue("@mbPassword", mbPassword);
        cmd.Parameters.AddWithValue("@mbPs", mbPs);
        cmd.Parameters.AddWithValue("@mbCom", mbCom);

        cmd.Parameters.AddWithValue("@mbModifyId", mbModifyId);
        cmd.Parameters.AddWithValue("@mbModifyDate", mbModifyDate);
        cmd.Parameters.AddWithValue("@mbGuid", mbGuid);
        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }

    //刪除資料
    public void Up_Status_AdminData(string mbGuid, string mbModifyId, DateTime mbModifyDate)
    {
        string sql = @"update sy_Member set 
mbStatus =@mbStatus,mbModifyId=@mbModifyId,mbModifyDate=@mbModifyDate
where mbGuid =@mbGuid";
        SqlConnection AD = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, AD);

        cmd.Parameters.AddWithValue("@mbStatus", "D");//狀態 刪除:D
        cmd.Parameters.AddWithValue("@mbModifyId", mbModifyId);
        cmd.Parameters.AddWithValue("@mbModifyDate", mbModifyDate);
        cmd.Parameters.AddWithValue("@mbGuid", mbGuid);
        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }

    #endregion

    #region 角色管理 page-Competence

    //checkbox 權限
    public DataTable MemberGroup()
    {
        string sql = @"select * from sy_MemberGroup ";
        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);
        //cmd.Parameters.AddWithValue("@cmClass", cmClass);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;            

        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }

    //新增主資料
    public void insertCompetence(string cmClass, string cmName, string cmCompetence,
        string cmDesc, string cmCreateId)
    {
        string sql = @"insert sy_MemberCom (
cmClass,cmName,cmCompetence,cmDesc,cmCreateId,cmStatus) 
values(
@cmClass,@cmName,@cmCompetence,@cmDesc,@cmCreateId,cmStatus)";

        SqlConnection AD = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, AD);


        cmd.Parameters.AddWithValue("@cmClass", cmClass);
        cmd.Parameters.AddWithValue("@cmName", cmName);
        cmd.Parameters.AddWithValue("@cmCompetence", cmCompetence);
        cmd.Parameters.AddWithValue("@cmDesc", cmDesc);
        cmd.Parameters.AddWithValue("@cmCreateId", cmCreateId);
        cmd.Parameters.AddWithValue("@cmStatus", "I");//狀態 新增:I
        try
        {
            cmd.Connection.Open();
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }

    //top 200 List
    public DataTable SelCompetence()
    {
        string sql = @"select top 200 * from sy_MemberCom where cmStatus <> 'D' order by cmClass ASC";

        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);
        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }

    //查詢 where 姓名&工號&角色
    public DataTable SearchCompetenceData(string cmClass)
    {
        string sql = @"select * from sy_MemberCom where cmStatus <> 'D' ";

        if (!string.IsNullOrEmpty(cmClass))
            sql += "and cmClass =@cmClass ";        

        sql += "order by cmClass ASC";
        SqlConnection conn = new SqlConnection(connectionStr);
        SqlCommand cmd = new SqlCommand(sql, conn);

        cmd.Parameters.AddWithValue("@cmClass", cmClass);

        try
        {
            DataTable dt = new DataTable();
            new SqlDataAdapter(cmd).Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally
        {
            cmd.Dispose();
        }
    }
    #endregion
}