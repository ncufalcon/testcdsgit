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

        Common com = new Common();
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
        /// 查詢個人津貼Top200
        /// </summary>
        public DataTable SelPersonSingleAllowanceTop200()
        {

            string sql = @"select top 200 * from v_PersonSingleAllowance where 1=1 and paStatus='A' order by paCreateDate desc";


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
            if (!string.IsNullOrEmpty(m.paDateS) && !string.IsNullOrEmpty(m.paDateE))
                sql += "and paDate between @paDateS and @paDateE ";
            if (!string.IsNullOrEmpty(m.paDateS) && string.IsNullOrEmpty(m.paDateE))
                sql += "and paDate >= @paDateS ";
            if (string.IsNullOrEmpty(m.paDateS) && !string.IsNullOrEmpty(m.paDateE))
                sql += "and paDate <= @paDateE ";


            sql += "order by paCreateDate desc";
            SqlCommand cmd = new SqlCommand(sql, Sqlconn);

            cmd.Parameters.AddWithValue("@paGuid", com.cSNull(m.paGuid));
            cmd.Parameters.AddWithValue("@paPerGuid", com.cSNull(m.paPerGuid));
            cmd.Parameters.AddWithValue("@paAllowanceCode", com.cSNull(m.paAllowanceCode));
            cmd.Parameters.AddWithValue("@paDate", com.cSNull(m.paDate));
            cmd.Parameters.AddWithValue("@paDateS", com.cSNull(m.paDateS));
            cmd.Parameters.AddWithValue("@paDateE", com.cSNull(m.paDateE));
            cmd.Parameters.AddWithValue("@perName", com.cSNull(m.perName));
            cmd.Parameters.AddWithValue("@perNo", com.cSNull(m.perNo));
            cmd.Parameters.AddWithValue("@siItemCode", com.cSNull(m.siItemCode));
            cmd.Parameters.AddWithValue("@siItemName", com.cSNull(m.siItemName));
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
            string sql = @"insert sy_PersonSingleAllowance(paPerGuid, paAllowanceCode, paPrice, paQuantity, paCost, paDate, paCreateId,paPs)
                              values(@paPerGuid, @paAllowanceCode, @paPrice, @paQuantity, @paCost, @paDate, @paCreateId,@paPs)";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@paPerGuid", p.paPerGuid);
            cmd.Parameters.AddWithValue("@paAllowanceCode", p.paAllowanceCode);
            cmd.Parameters.AddWithValue("@paPrice", p.paPrice);
            cmd.Parameters.AddWithValue("@paQuantity", p.paQuantity);
            cmd.Parameters.AddWithValue("@paCost", p.paCost);
            cmd.Parameters.AddWithValue("@paDate", p.paDate);
            cmd.Parameters.AddWithValue("@paCreateId", p.paCreateId);
            cmd.Parameters.AddWithValue("@paPs", p.paPs);
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
            cmd.Parameters.AddWithValue("@paGuid", p.paGuid);
            cmd.Parameters.AddWithValue("@paPerGuid", p.paPerGuid);
            cmd.Parameters.AddWithValue("@paAllowanceCode", p.paAllowanceCode);
            cmd.Parameters.AddWithValue("@paPrice", p.paPrice);
            cmd.Parameters.AddWithValue("@paQuantity", p.paQuantity);
            cmd.Parameters.AddWithValue("@paCost", p.paCost);
            cmd.Parameters.AddWithValue("@paDate", p.paDate);
            cmd.Parameters.AddWithValue("@paModifyId", p.paModifyId);
            cmd.Parameters.AddWithValue("@paModifyDate", DateTime.Now);

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
                           paStatus='D',
                           paModifyId=@paModifyId,
                           paModifyDate=@paModifyDate
                           where paGuid=@paGuid";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@paModifyId", p.paModifyId);
            cmd.Parameters.AddWithValue("@paModifyDate", DateTime.Now);
            cmd.Parameters.AddWithValue("@paGuid", p.paGuid);
            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }





        /// <summary>
        /// 新增津貼匯入資料至暫存table
        /// </summary>
        public void InsAllTemp(DataTable dt)
        {
            SqlCommand cmd = new SqlCommand();
            try
            {
                cmd.Connection = Sqlconn;
                cmd.Connection.Open();
                SqlTransaction transaction;
                transaction = cmd.Connection.BeginTransaction();
                cmd.Transaction = transaction;

                string sql = @"";

                //新增Jumper
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    sql = @"insert into sy_AllowanceTemp(atPerNo,atDate,atItem,atCost) 
                            values(@atPerNo" + i + ",@atDate" + i + ",@atItem" + i + ",@atCost" + i + ")";


                    cmd.CommandText = sql;
                    cmd.Parameters.AddWithValue("@atPerNo" + i, dt.Rows[i]["員工編號"].ToString());
                    cmd.Parameters.AddWithValue("@atDate" + i, dt.Rows[i]["日期(YYYYMMDD)"].ToString());
                    cmd.Parameters.AddWithValue("@atItem" + i, dt.Rows[i]["津貼項目"].ToString());
                    cmd.Parameters.AddWithValue("@atCost" + i, dt.Rows[i]["金額"].ToString());
                    cmd.ExecuteNonQuery();
                }


                //cmd.ExecuteNonQuery();
                transaction.Commit();
            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }
        }



        /// <summary>
        /// 刪除個人津貼暫存檔
        /// </summary>
        public void DelsyAllowanceTemp()
        {
            string sql = @"delete from sy_AllowanceTemp";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }



        /// <summary>
        /// 查詢個人津貼匯入暫存檔_AllowanceTemp
        /// </summary>
        public DataTable SelAllowanceTemp()
        {

            string sql = @"select * FROM v_AllowanceTemp ";

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
        /// 刪除個人津貼暫存檔
        /// </summary>
        public void DelsyAllowanceTempOne(string guid)
        {
            string sql = @"delete from sy_AllowanceTemp where atGuid=@atGuid";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@atGuid", guid);
            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }


        /// <summary>
        /// 將暫存檔資料匯入津貼sy_PersonSingleAllowance
        /// </summary>
        public void InsImportsyAllowance(string CreateId)
        {
            string sql = @"insert into sy_PersonSingleAllowance(paPerGuid,paAllowanceCode,paPrice ,paQuantity,paCost,paDate,paCreateId,paImport,paImportDate)
                           SELECT perGuid,siGuid ,atCost,1,atCost,atDate,@paCreateId,'Y',CONVERT(varchar, getdate(), 111)  FROM v_AllowanceTemp";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@paCreateId", CreateId);
            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }





        /// <summary>
        /// 呼叫sp pr_LeaveExport
        /// </summary>
        public DataTable Call_pr_LeaveExport(string sr_guid, string perNo, string company, string Dep, string Position)
        {
            string sql = @"pr_LeaveExport";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@sr_Guid", sr_guid);
            cmd.Parameters.AddWithValue("@perNo", perNo);
            cmd.Parameters.AddWithValue("@company", company);
            cmd.Parameters.AddWithValue("@Dep", Dep);
            cmd.Parameters.AddWithValue("@Position", Position);
            try
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection.Open();
                DataTable dt = new DataTable();
                new SqlDataAdapter(cmd).Fill(dt);
                return dt;
            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }
        }


        /// <summary>
        /// 查詢分店資訊
        /// </summary>
        public DataTable SelSy_SalaryRange(string str)
        {

            string sql = @"select * FROM sy_SalaryRange where sr_Status='A' ";

            if (!string.IsNullOrEmpty(str))
                sql += "and ((sr_BeginDate like '%'+ @str+ '%') or (sr_Enddate like '%' + @str + '%')   or (sr_SalaryDate like '%' + @str + '%') or (sr_Ps like '%' + @str + '%')) ";

            sql += "order by convert(datetime,sr_SalaryDate ) desc ";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@str", str);
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
        /// 發薪紀錄
        /// </summary>
        public DataTable SelSy_PaySalaryDetail(payroll.model.sy_PayRoll p)
        {

            string sql = @"select * from v_PaySalaryDetail where pStatus='A' ";

            if (!string.IsNullOrEmpty(p.pPerNo))
                sql += "and pPerNo like '%'+ @pPerNo +'%' ";

            if (!string.IsNullOrEmpty(p.pPerName))
                sql += "and pPerName like '%'+ @pPerName +'%' ";

            if (!string.IsNullOrEmpty(p.pPerCompanyName))
                sql += "and pPerCompanyName like '%'+ @pPerNo +'%' ";

            if (!string.IsNullOrEmpty(p.pPerDep))
                sql += "and pPerDep like '%'+ @pPerNo +'%' ";

            if (!string.IsNullOrEmpty(p.sr_Guid))
                sql += "and sr_Guid=@sr_Guid ";

            if (!string.IsNullOrEmpty(p.pGuid))
                sql += "and pGuid = @pGuid ";

            sql += "order by convert(datetime,sr_SalaryDate) desc ";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@pPerNo", com.cSNull(p.pPerNo));
            cmd.Parameters.AddWithValue("@pPerName", com.cSNull(p.pPerName));
            cmd.Parameters.AddWithValue("@pPerCompanyName", com.cSNull(p.pPerCompanyName));
            cmd.Parameters.AddWithValue("@pPerDep", com.cSNull(p.pPerDep));
            cmd.Parameters.AddWithValue("@psmSalaryRange", com.cSNull(p.psmSalaryRange));
            cmd.Parameters.AddWithValue("@pGuid", com.cSNull(p.pGuid));
            cmd.Parameters.AddWithValue("@sr_Guid", com.cSNull(p.sr_Guid));
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
        /// 發薪紀錄
        /// </summary>
        public DataTable SelSy_PaySalaryDetailTop200()
        {

            string sql = @"select * from v_PaySalaryDetail where pStatus='A' ";

            //if (!string.IsNullOrEmpty(str))
            //    sql += "and ((sr_BeginDate like '%'+ @str+ '%') or (sr_Enddate like '%' + @str + '%')   or (sr_SalaryDate like '%' + @str + '%') or (sr_Ps like '%' + @str + '%')) ";

            //sql += "order by convert(datetime,sr_SalaryDate ) desc ";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            //cmd.Parameters.AddWithValue("@str", str);
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
        /// 發薪紀錄-津貼項
        /// </summary>
        public DataTable Selsy_PaySalaryAllowance(payroll.model.sy_PayAllowance p)
        {

            string sql = @"select *, case siAdd when '01' then '加項' when '02' then '扣項' else '' end as siAddstr from sy_PaySalaryAllowance left join sy_SalaryItem on psaAllowanceCode=siGuid where psaStatus='A' ";

            if (!string.IsNullOrEmpty(p.psaPerGuid))
                sql += "and psaPerGuid=@psaPerGuid ";

            if (!string.IsNullOrEmpty(p.psaPsmGuid))
                sql += "and psaPsmGuid=@psaPsmGuid ";
            //sql += "order by convert(datetime,sr_SalaryDate ) desc ";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@psaPerGuid", com.cSNull(p.psaPerGuid));
            cmd.Parameters.AddWithValue("@psaPsmGuid", com.cSNull(p.psaPsmGuid));
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
        /// 發薪紀錄-法扣
        /// </summary>
        public DataTable Selsy_PaySalaryBuckle(payroll.model.sy_PayBuckle p)
        {

            string sql = @"select * from sy_PaySalaryBuckle where psbStatus='A' ";

            if (!string.IsNullOrEmpty(p.psbPerGuid))
                sql += "and psbPerGuid=@psbPerGuid ";

            if (!string.IsNullOrEmpty(p.psbPsmGuid))
                sql += "and psbPsmGuid=@psbPsmGuid ";
            //sql += "order by convert(datetime,sr_SalaryDate ) desc ";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@psbPerGuid", p.psbPerGuid);
            cmd.Parameters.AddWithValue("@psbPsmGuid", p.psbPsmGuid);
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

    }
}