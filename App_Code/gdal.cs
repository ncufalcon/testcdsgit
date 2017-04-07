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
    }
}