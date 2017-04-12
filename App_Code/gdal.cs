using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
namespace payroll
{
    /// <summary>
    /// gdal 的摘要描述
    /// </summary>
    public class gdal
    {
        SqlConnection Sqlconn = new payroll_sqlconn().conn;


        /// <summary>
        /// 查詢
        /// </summary>
        public DataTable SelMember(sy_Member m)
        {
            
            //string sql = @"select * from v_MbList where 1=1 ";

            string sql = @"SELECT mbGuid, mbName, mbJobNumber, mbId, mbPassword, mbPs, mbCom
                           ,cmCompetence FROM sy_Member left join sy_MemberCom on mbCom=cmClass where 1=1 ";

            if (!string.IsNullOrEmpty(m.mbGuid))
                sql += "and mbGuid=@mbGuid ";
            if (!string.IsNullOrEmpty(m.mbId))
                sql += "and mbId=@mbId ";
            if (!string.IsNullOrEmpty(m.mbPassword))
                sql += "and mbPassword=@mbPassword ";
            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@mbGuid", m.mbGuid);
            cmd.Parameters.AddWithValue("@mbPassword", m.mbPassword);

            try
            {
                cmd.Connection.Open();
                DataTable dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                return dt;
            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }





        /// <summary>
        /// 新增管理者
        /// </summary>
        public void InsFac()
        {
            string sql = @"insert tel_Fac(facEmpno, facNo, facStatus, facCallArea, facPS, facRegion, facCreateid)
                              values(@facEmpno, @facNo, @facStatus, @facCallArea, @facPS, @facRegion, @facCreateid)";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            //cmd.Parameters.AddWithValue("@facEmpno", facEmpno);
            //cmd.Parameters.AddWithValue("@facNo", facNo);
            //cmd.Parameters.AddWithValue("@facStatus", "A");
            //cmd.Parameters.AddWithValue("@facCallArea", facCallArea);
            //cmd.Parameters.AddWithValue("@facPS", facPS);
            //cmd.Parameters.AddWithValue("@facRegion", facRegion);
            //cmd.Parameters.AddWithValue("@facCreateid", facCreateid);
            try
            {

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }
        }


        /// <summary>
        /// 修改個人密碼
        /// </summary>
        public void UpMemberPd(sy_Member m)
        {
            string sql = @"update sy_Member set
                           mbPassword=@mbPassword
                           where mbGuid=@mbGuid";
            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@mbPassword", m.mbPassword);
            cmd.Parameters.AddWithValue("@mbGuid", m.mbGuid);


            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }

        /// <summary>
        /// 刪除管理者
        /// </summary>
        public void DelFac()
        {
            string sql = @"delete from tel_Fac where facGuid=@facGuid ";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            //cmd.Parameters.AddWithValue("@facGuid", facGuid);

            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }











        /// <summary>
        /// 查詢個人津貼Top200
        /// </summary>
        public DataTable SelPersonSingleAllowanceTop200()
        {

            string sql = @"select top 200 * from v_PersonSingleAllowance where 1=1 and paStatus='A' order by paModifyDate";

      
            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            try
            {
                cmd.Connection.Open();
                DataTable dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                return dt;
            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }


        /// <summary>
        /// 查詢個人津貼
        /// </summary>
        public DataTable SelPersonSingleAllowance(payroll.model.sy_PersonSingleAllowance m)
        {

            string sql = @"SELECT * FROM v_PersonSingleAllowance where 1=1 and paStatus='A' ";

            if (!string.IsNullOrEmpty(m.paGuid))
                sql += "and paGuid=@paGuid ";
            if (!string.IsNullOrEmpty(m.paPerGuid))
                sql += "and paPerGuid=@paPerGuid ";
            if (!string.IsNullOrEmpty(m.paAllowanceCode))
                sql += "and paAllowanceCode=@paAllowanceCode ";
            if (!string.IsNullOrEmpty(m.paDate))
                sql += "and paDate=@paDate ";
            if (!string.IsNullOrEmpty(m.perName))
                sql += "and perName=@perName ";
            if (!string.IsNullOrEmpty(m.perNo))
                sql += "and perNo=@perNo ";
            if (!string.IsNullOrEmpty(m.siItemCode))
                sql += "and siItemCode=@siItemCode ";
            if (!string.IsNullOrEmpty(m.siItemName))
                sql += "and siItemName=@siItemName ";

            sql += "order by paModifyDate";
            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@paGuid", m.paGuid);
            cmd.Parameters.AddWithValue("@paPerGuid", m.paPerGuid);
            cmd.Parameters.AddWithValue("@paAllowanceCode", m.paAllowanceCode);
            cmd.Parameters.AddWithValue("@paDate", m.paDate);
            cmd.Parameters.AddWithValue("@perName", m.perName);
            cmd.Parameters.AddWithValue("@perNo", m.perNo);
            cmd.Parameters.AddWithValue("@siItemCode", m.siItemCode);
            cmd.Parameters.AddWithValue("@siItemName", m.siItemName);
            try
            {
                cmd.Connection.Open();
                DataTable dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                return dt;
            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }



        /// <summary>
        /// 新增個人津貼
        /// </summary>
        public void InsPersonSingleAllowance(payroll.model.sy_PersonSingleAllowance p)
        {
            string sql = @"insert sy_PersonSingleAllowance(paPerGuid, paAllowanceCode, paPrice, paQuantity, paCost, paDate, paCreateId)
                              values(@paPerGuid, @paAllowanceCode, @paPrice, @paQuantity, @paCost, @paDate, @paCreateId)";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@paPerGuid", p.paPerGuid);
            cmd.Parameters.AddWithValue("@paAllowanceCode", p.paAllowanceCode);
            cmd.Parameters.AddWithValue("@paPrice", p.paPrice);
            cmd.Parameters.AddWithValue("@paQuantity", p.paQuantity);
            cmd.Parameters.AddWithValue("@paCost", p.paCost);
            cmd.Parameters.AddWithValue("@paDate", p.paDate);
            cmd.Parameters.AddWithValue("@paCreateId", p.paCreateId);
            try
            {

                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }
        }


        /// <summary>
        /// 修改個人津貼
        /// </summary>
        public void UpPersonSingleAllowance(payroll.model.sy_PersonSingleAllowance p)
        {
            string sql = @"update sy_PersonSingleAllowance set
                           paPerGuid=@paPerGuid,
                           paAllowanceCode=@paAllowanceCode,
                           paPrice=@paPrice,
                           paQuantity=@paQuantity,
                           paCost=@paCost,
                           paDate=@paDate,
                           paModifyId=@paModifyId,
                           paModifyDate=@paModifyDate
                           where paGuid=@paGuid";
            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@paPerGuid", p.paPerGuid);
            cmd.Parameters.AddWithValue("@paAllowanceCode", p.paAllowanceCode);
            cmd.Parameters.AddWithValue("@paPrice", p.paPrice);
            cmd.Parameters.AddWithValue("@paQuantity", p.paQuantity);
            cmd.Parameters.AddWithValue("@paCost", p.paCost);
            cmd.Parameters.AddWithValue("@paDate", p.paDate);
            cmd.Parameters.AddWithValue("@paModifyId", p.paModifyId);
            cmd.Parameters.AddWithValue("@paModifyDate", p.paModifyDate);

            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }

        /// <summary>
        /// 刪除個人津貼
        /// </summary>
        public void DelPersonSingleAllowance(payroll.model.sy_PersonSingleAllowance p)
        {
            string sql = @"update sy_PersonSingleAllowance set 
                           paStatus='D,
                           paModifyId=@paModifyId,
                           paModifyDate=@paModifyDate
                           where paGuid=@paGuid";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@paModifyId", p.paModifyId);
            cmd.Parameters.AddWithValue("@paModifyDate", p.paModifyDate);
            cmd.Parameters.AddWithValue("@paGuid", p.paGuid);
            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }

    }
}