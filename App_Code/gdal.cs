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


        public DataTable SelMemberGroup(payroll.model.sy_Member m)
        {

            //string sql = @"select * from v_MbList where 1=1 ";

            string sql = @"SELECT * FROM sy_MemberGroup where 1=1 ";

            if (!string.IsNullOrEmpty(m.gpCode))
                sql += "and gpCode=@gpCode ";


            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@gpCode", m.gpCode);


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

                string sql = "";
                //產生temp table
                sql = @"CREATE TABLE #temp (
                         columns0 nvarchar(50),
                         columns2 nvarchar(50),
                         columns3 nvarchar(50),
                         columns4 decimal(10, 0)
                       )
                       ;";

                cmd.CommandText = sql;
                cmd.ExecuteNonQuery();


                // 利用 SqlBulkCopy 新增資料到temp table
                SqlBulkCopyOptions setting = SqlBulkCopyOptions.CheckConstraints | SqlBulkCopyOptions.TableLock;
                using (SqlBulkCopy sqlBC = new SqlBulkCopy(cmd.Transaction.Connection, setting, cmd.Transaction))
                {
                    sqlBC.BulkCopyTimeout = 600; ///設定逾時的秒數
                    //sqlBC.BatchSize = 1000; ///設定一個批次量寫入多少筆資料, 設定值太小會影響效能 
                    ////設定 NotifyAfter 屬性，以便在每複製 10000 個資料列至資料表後，呼叫事件處理常式。
                    //sqlBC.NotifyAfter = 10000;
                    ///設定要寫入的資料庫
                    sqlBC.DestinationTableName = "#temp";

                    /// 對應來源與目標資料欄位
                    sqlBC.ColumnMappings.Add("columns0", "columns0");
                    sqlBC.ColumnMappings.Add("columns2", "columns2");
                    sqlBC.ColumnMappings.Add("columns3", "columns3");
                    sqlBC.ColumnMappings.Add("columns4", "columns4");

                    /// 開始寫入資料
                    sqlBC.WriteToServer(dt);
                }


                    //insert 資料
                    sql = @"insert into sy_AllowanceTemp(atPerNo,atDate,atItem,atCost) 
                            select columns0,columns2,columns3,columns4 from #temp ";

                    cmd.CommandText = sql;
                    cmd.ExecuteNonQuery();


                    //cmd.Connection = Sqlconn;
                    //cmd.Connection.Open();
                    //SqlTransaction transaction;
                    //transaction = cmd.Connection.BeginTransaction();
                    //cmd.Transaction = transaction;

                    //string sql = @"";

                    ////新增Jumper
                    //for (int i = 0; i < dt.Rows.Count; i++)
                    //{

                    //    sql = @"insert into sy_AllowanceTemp(atPerNo,atDate,atItem,atCost) 
                    //            values(@atPerNo" + i + ",@atDate" + i + ",@atItem" + i + ",@atCost" + i + ")";


                    //    cmd.CommandText = sql;
                    //    cmd.Parameters.AddWithValue("@atPerNo" + i, dt.Rows[i]["員工編號"].ToString());
                    //    cmd.Parameters.AddWithValue("@atDate" + i, dt.Rows[i]["日期(YYYYMMDD)"].ToString());
                    //    cmd.Parameters.AddWithValue("@atItem" + i, dt.Rows[i]["津貼項目"].ToString());
                    //    cmd.Parameters.AddWithValue("@atCost" + i, dt.Rows[i]["金額"].ToString());
                    //    cmd.ExecuteNonQuery();
                    //}


                    ////cmd.ExecuteNonQuery();
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
        public DataTable SelAllowanceTempTop200()
        {

            string sql = @"select top 200 * FROM v_AllowanceTemp order by atPerNo ";

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
        /// 查詢個人津貼匯入暫存檔_AllowanceTemp
        /// </summary>
        public DataTable SelAllowanceTemp(string pNo, string pName, string pCom, string pDep)
        {

            string sql = @"select * FROM v_AllowanceTemp where 1=1 ";

            if (!string.IsNullOrEmpty(pNo))
                sql += "and atPerNo like '%'+ @pNo +'%' ";

            if (!string.IsNullOrEmpty(pName))
                sql += "and perName like '%'+ @pName +'%' ";

            if (!string.IsNullOrEmpty(pCom))
                sql += "and comName like '%'+ @pCom +'%' ";

            if (!string.IsNullOrEmpty(pDep))
                sql += "and (cbName like '%'+ @pDep +'%' and cbValue like '%'+ @pDep +'%') ";


            sql += "order by atPerNo";
            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@pNo", pNo);
            cmd.Parameters.AddWithValue("@pName", pName);
            cmd.Parameters.AddWithValue("@pCom", pCom);
            cmd.Parameters.AddWithValue("@pDep", pDep);
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

            string sql = @"select *
                           ,(select sum(b.pPersonPension) from v_PaySalaryDetail as b where b.pPerGuid=a.pPerGuid and b.sr_Salarydate <= sr_Salarydate) as pPersonPensionSum
                           ,(select sum(b.pCompanyPension) from v_PaySalaryDetail as b where b.pPerGuid=a.pPerGuid and b.sr_Salarydate <= sr_Salarydate) as pCompanyPensionSum
                           from v_PaySalaryDetail as a where pStatus='A' ";

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
        /// 發薪紀錄匯出
        /// </summary>
        public DataTable SelSy_PaySalaryExport(payroll.model.sy_PayRoll p)
        {

            string sql = @"select *
                           ,(select sum(b.pPersonPension) from v_PaySalaryDetail as b where a.pGuid=b.pGuid and b.sr_Salarydate <= sr_Salarydate) as pPersonPensionSum
                           ,(select sum(b.pCompanyPension) from v_PaySalaryDetail as b where a.pGuid=b.pGuid and b.sr_Salarydate <= sr_Salarydate) as pCompanyPensionSum
                           from v_PaySalaryDetail as a  left join sy_CodeBranches on a.pDepGuid=cbGuid and cbStatus<>'D'   where pStatus='A'  ";

            if (!string.IsNullOrEmpty(p.sr_Guid))
                sql += "and sr_Guid=@sr_Guid ";

            if (!string.IsNullOrEmpty(p.pPerGuid))
                sql += "and pPerGuid=@pPerGuid ";

            if (p.pLeaveStatus != "Y")
                sql += "and isnull(rtrim(perLastDate),'') = '' ";

            if (p.pShouldPayStatus != "Y")
                sql += "and pShouldPay <> 0 ";


            if (!string.IsNullOrEmpty(p.pCompany))
                sql += "and pCompanyGuid= @pCompany ";

            if (!string.IsNullOrEmpty(p.pDep))
                sql += "and pDepGuid = @pDep ";

            sql += "order by cbValue, pPerNo ";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@sr_Guid", com.cSNull(p.sr_Guid));
            cmd.Parameters.AddWithValue("@pPerGuid", com.cSNull(p.pPerGuid));
            cmd.Parameters.AddWithValue("@pCompany", com.cSNull(p.pCompany));
            cmd.Parameters.AddWithValue("@pDep", com.cSNull(p.pDep));
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

            string sql = @"select top 200 * from v_PaySalaryDetail where pStatus='A' ";

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

            string sql = @"select *, case siAdd when '01' then N'加項' when '02' then N'扣項' else '' end as siAddstr from sy_PaySalaryAllowance left join sy_SalaryItem on psaAllowanceCode=siGuid where psaStatus='A' ";

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

        /// <summary>
        /// 計算薪資
        /// </summary>
        /// <param name="Class"></param>
        /// <param name="Region"></param>
        /// <param name="Dep"></param>
        /// <returns></returns>
        public void GenRayroll(string rGuid,string UserInfo)
        {
            string sql = @"pr_GenPayroll";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.CommandTimeout = 600;
            cmd.Parameters.AddWithValue("@sr_Guid", rGuid);
            cmd.Parameters.AddWithValue("@UserInfo", UserInfo);
            try
            {
                cmd.Connection.Open();
                SqlTransaction transaction;
                transaction = cmd.Connection.BeginTransaction();
                cmd.Transaction = transaction;
                cmd.CommandType = CommandType.StoredProcedure;


                //DataTable dt = new DataTable();
                //new SqlDataAdapter(cmd).Fill(dt);        
                cmd.ExecuteNonQuery();
                transaction.Commit();
                //return dt;
            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }
        }




        /// <summary>
        /// 修改個人津貼
        /// </summary>
        public void Upsy_PaySalary(payroll.model.sy_PayRoll p)
        {
            string sql = @"insert into sy_PaySalaryDetailLog (plogPGuid
                                                             ,plogPsmGuid
                                                             ,plogPerGuid
                                                             ,plogPerNo
                                                             ,plogPerName
                                                             ,plogPerCompanyName
                                                             ,plogPerDep
                                                             ,plogWeekdayTime1
                                                             ,plogWeekdaySalary1
                                                             ,plogWeekdayTime2
                                                             ,plogWeekdaySalary2
                                                             ,plogWeekdayTime3
                                                             ,plogWeekdaySalary3
                                                             ,plogOffDayTime1
                                                             ,plogOffDaySalary1
                                                             ,plogOffDayTime2
                                                             ,plogOffDaySalary2
                                                             ,plogOffDayTime3
                                                             ,plogOffDaySalary3
                                                             ,plogHolidayTime1
                                                             ,plogHolidaySalary1
                                                             ,plogHolidayTime2
                                                             ,plogHolidaySalary2
                                                             ,plogHolidayTime3
                                                             ,plogHolidaySalary3
                                                             ,plogHolidayTime4
                                                             ,plogHolidaySalary4
                                                             ,plogHolidayDutyFree
                                                             ,plogHolidayTaxation
                                                             ,plogNationalholidaysTime1
                                                             ,plogNationalholidaysSalary1
                                                             ,plogNationalholidaysTime2
                                                             ,plogNationalholidaysSalary2
                                                             ,plogNationalholidaysTime3
                                                             ,plogNationalholidaysSalary3
                                                             ,plogNationalholidaysTime4
                                                             ,plogNationalholidaysSalary4
                                                             ,plogNationalholidaysDutyFree
                                                             ,plogNationalholidaysTaxation
                                                             ,plogSpecialholidaysTime1
                                                             ,plogSpecialholidaysSalary1
                                                             ,plogSpecialholidaysTime2
                                                             ,plogSpecialholidaysSalary2
                                                             ,plogSpecialholidaysTime3
                                                             ,plogSpecialholidaysSalary3
                                                             ,plogSpecialholidaysTime4
                                                             ,plogSpecialholidaysSalary4
                                                             ,plogSpecialholidaysDutyFree
                                                             ,plogSpecialholidaysTaxation
                                                             ,plogHolidaySumDutyFree
                                                             ,plogHolidaySumTaxation
                                                             ,plogAttendanceDays
                                                             ,plogAttendanceTimes
                                                             ,plogPayLeave
                                                             ,plogAnnualLeaveTimes
                                                             ,plogAnnualLeaveSalary
                                                             ,plogMarriageLeaveTimes
                                                             ,plogMarriageLeaveSalary
                                                             ,plogSickLeaveTimes
                                                             ,plogSickLeaveSalary
                                                             ,plogFuneralLeaveTimes
                                                             ,plogFuneralLeaveSalary
                                                             ,plogMaternityLeaveTimes
                                                             ,plogMaternityLeaveSalary
                                                             ,plogHonoraryLeaveTimes
                                                             ,plogHonoraryLeaveSalary
                                                             ,plogTaxDeduction
                                                             ,plogPay
                                                             ,plogTaxation
                                                             ,plogTax
                                                             ,plogPremium
                                                             ,plogOverTimeDutyfree
                                                             ,plogOverTimeTaxation
                                                             ,plogPersonInsurance
                                                             ,plogPersonLabor
                                                             ,plogPersonPension
                                                             ,plogCompanyPension
                                                             ,plogComInsurance
                                                             ,plogComLabor
                                                             ,plogAnnualLeavePro
                                                             ,plogP1Time
                                                             ,plogIntertemporal
                                                             ,plogBuckleCost
                                                             ,plogBuckleFee
                                                             ,plogWelfare
                                                             ,plogStatus                                         
                                                             ,plogModdifyId
                                                             ,plogProductionLeaveTimes
                                                             ,plogProductionLeaveSalary
                                                             ,plogMilitaryLeaveTimes
                                                             ,plogMilitaryLeaveSalary
                                                             ,plogAbortionLeaveTimes
                                                             ,plogAbortionLeaveSalary
                                                             ,plogShouldPay
                                                             ,plogBasicSalary
                                                             ,plogAllowance
                                                             ,plogCompanyGuid
                                                             ,plogDepGuid,plogSalary)
                                                            select pGuid
                                                                  ,pPsmGuid
                                                                  ,pPerGuid
                                                                  ,pPerNo
                                                                  ,pPerName
                                                                  ,pPerCompanyName
                                                                  ,pPerDep
                                                                  ,pWeekdayTime1
                                                                  ,pWeekdaySalary1
                                                                  ,pWeekdayTime2
                                                                  ,pWeekdaySalary2
                                                                  ,pWeekdayTime3
                                                                  ,pWeekdaySalary3
                                                                  ,pOffDayTime1
                                                                  ,pOffDaySalary1
                                                                  ,pOffDayTime2
                                                                  ,pOffDaySalary2
                                                                  ,pOffDayTime3
                                                                  ,pOffDaySalary3
                                                                  ,pHolidayTime1
                                                                  ,pHolidaySalary1
                                                                  ,pHolidayTime2
                                                                  ,pHolidaySalary2
                                                                  ,pHolidayTime3
                                                                  ,pHolidaySalary3
                                                                  ,pHolidayTime4
                                                                  ,pHolidaySalary4
                                                                  ,pHolidayDutyFree
                                                                  ,pHolidayTaxation
                                                                  ,pNationalholidaysTime1
                                                                  ,pNationalholidaysSalary1
                                                                  ,pNationalholidaysTime2
                                                                  ,pNationalholidaysSalary2
                                                                  ,pNationalholidaysTime3
                                                                  ,pNationalholidaysSalary3
                                                                  ,pNationalholidaysTime4
                                                                  ,pNationalholidaysSalary4
                                                                  ,pNationalholidaysDutyFree
                                                                  ,pNationalholidaysTaxation
                                                                  ,pSpecialholidaysTime1
                                                                  ,pSpecialholidaysSalary1
                                                                  ,pSpecialholidaysTime2
                                                                  ,pSpecialholidaysSalary2
                                                                  ,pSpecialholidaysTime3
                                                                  ,pSpecialholidaysSalary3
                                                                  ,pSpecialholidaysTime4
                                                                  ,pSpecialholidaysSalary4
                                                                  ,pSpecialholidaysDutyFree
                                                                  ,pSpecialholidaysTaxation
                                                                  ,pHolidaySumDutyFree
                                                                  ,pHolidaySumTaxation
                                                                  ,pAttendanceDays
                                                                  ,pAttendanceTimes
                                                                  ,pPayLeave
                                                                  ,pAnnualLeaveTimes
                                                                  ,pAnnualLeaveSalary
                                                                  ,pMarriageLeaveTimes
                                                                  ,pMarriageLeaveSalary
                                                                  ,pSickLeaveTimes
                                                                  ,pSickLeaveSalary
                                                                  ,pFuneralLeaveTimes
                                                                  ,pFuneralLeaveSalary
                                                                  ,pMaternityLeaveTimes
                                                                  ,pMaternityLeaveSalary
                                                                  ,pHonoraryLeaveTimes
                                                                  ,pHonoraryLeaveSalary
                                                                  ,pTaxDeduction
                                                                  ,pPay
                                                                  ,pTaxation
                                                                  ,pTax
                                                                  ,pPremium
                                                                  ,pOverTimeDutyfree
                                                                  ,pOverTimeTaxation
                                                                  ,pPersonInsurance
                                                                  ,pPersonLabor
                                                                  ,pPersonPension
                                                                  ,pCompanyPension
                                                                  ,pComInsurance
                                                                  ,pComLabor
                                                                  ,pAnnualLeavePro
                                                                  ,pP1Time
                                                                  ,pIntertemporal
                                                                  ,pBuckleCost
                                                                  ,pBuckleFee
                                                                  ,pWelfare
                                                                  ,'Update'
                                                                  ,@UserInfo
                                                                  ,pProductionLeaveTimes
                                                                  ,pProductionLeaveSalary
                                                                  ,pMilitaryLeaveTimes
                                                                  ,pMilitaryLeaveSalary
                                                                  ,pAbortionLeaveTimes
                                                                  ,pAbortionLeaveSalary
                                                                  ,pShouldPay
                                                                  ,pBasicSalary
                                                                  ,pAllowance
                                                                  ,pCompanyGuid
                                                                  ,pDepGuid,pSalary
                                                                   from sy_PaySalaryDetail where pGuid=@pGuid 

                                                                  update sy_PaySalaryDetail set                                                               
                                                                  pWeekdayTime1=@pWeekdayTime1
                                                                  ,pWeekdaySalary1=@pWeekdaySalary1
                                                                  ,pWeekdayTime2=@pWeekdayTime2
                                                                  ,pWeekdaySalary2=@pWeekdaySalary2
                                                                  ,pWeekdayTime3=@pWeekdayTime3
                                                                  ,pWeekdaySalary3=@pWeekdaySalary3
                                                                  ,pOffDayTime1=@pOffDayTime1
                                                                  ,pOffDaySalary1=@pOffDaySalary1
                                                                  ,pOffDayTime2=@pOffDayTime2
                                                                  ,pOffDaySalary2=@pOffDaySalary2
                                                                  ,pOffDayTime3=@pOffDayTime3
                                                                  ,pOffDaySalary3=@pOffDaySalary3
                                                                  ,pHolidayTime1=@pHolidayTime1
                                                                  ,pHolidaySalary1=@pHolidaySalary1
                                                                  ,pHolidayTime2=@pHolidayTime2
                                                                  ,pHolidaySalary2=@pHolidaySalary2
                                                                  ,pHolidayTime3=@pHolidayTime3
                                                                  ,pHolidaySalary3=@pHolidaySalary3
                                                                  ,pHolidayTime4=@pHolidayTime4
                                                                  ,pHolidaySalary4=@pHolidaySalary4
                                                                  ,pHolidayDutyFree=@pHolidayDutyFree
                                                                  ,pHolidayTaxation=@pHolidayTaxation
                                                                  ,pNationalholidaysTime1=@pNationalholidaysTime1
                                                                  ,pNationalholidaysSalary1=@pNationalholidaysSalary1
                                                                  ,pNationalholidaysTime2=@pNationalholidaysTime2
                                                                  ,pNationalholidaysSalary2=@pNationalholidaysSalary2
                                                                  ,pNationalholidaysTime3=@pNationalholidaysTime3
                                                                  ,pNationalholidaysSalary3=@pNationalholidaysSalary3
                                                                  ,pNationalholidaysTime4=@pNationalholidaysTime4
                                                                  ,pNationalholidaysSalary4=@pNationalholidaysSalary4

                                                                  ,pNationalholidaysDutyFree=@pNationalholidaysDutyFree
                                                                  ,pNationalholidaysTaxation=@pNationalholidaysTaxation
                                                           
                                                                  ,pHolidaySumDutyFree=@pHolidaySumDutyFree
                                                                  ,pHolidaySumTaxation=@pHolidaySumTaxation

                                                                  ,pAttendanceDays=@pAttendanceDays
                                                                  ,pAttendanceTimes=@pAttendanceTimes
                                                                  ,pPayLeave=@pPayLeave
                                                                  ,pAnnualLeaveTimes=@pAnnualLeaveTimes
                                                                  ,pAnnualLeaveSalary=@pAnnualLeaveSalary
                                                                  ,pMarriageLeaveTimes=@pMarriageLeaveTimes
                                                                  ,pMarriageLeaveSalary=@pMarriageLeaveSalary
                                                                  ,pSickLeaveTimes=@pSickLeaveTimes
                                                                  ,pSickLeaveSalary=@pSickLeaveSalary
                                                                  ,pFuneralLeaveTimes=@pFuneralLeaveTimes
                                                                  ,pFuneralLeaveSalary=@pFuneralLeaveSalary
                                                                  ,pMaternityLeaveTimes=@pMaternityLeaveTimes
                                                                  ,pMaternityLeaveSalary=@pMaternityLeaveSalary
                                                                  ,pHonoraryLeaveTimes=@pHonoraryLeaveTimes
                                                                  ,pHonoraryLeaveSalary=@pHonoraryLeaveSalary

                                                                  ,pProductionLeaveTimes=@pProductionLeaveTimes
                                                                  ,pProductionLeaveSalary=@pProductionLeaveSalary
                                                                  ,pMilitaryLeaveTimes=@pMilitaryLeaveTimes
                                                                  ,pMilitaryLeaveSalary=@pMilitaryLeaveSalary
                                                                  ,pAbortionLeaveTimes=@pAbortionLeaveTimes
                                                                  ,pAbortionLeaveSalary=@pAbortionLeaveSalary

                                                                  ,pTaxDeduction=@pTaxDeduction
                                                                  ,pPay=@pPay
                                                                  ,pTaxation=@pTaxation
                                                                  ,pTax=@pTax
                                                                  ,pPremium=@pPremium
                                                                  ,pOverTimeDutyfree=@pOverTimeDutyfree
                                                                  ,pOverTimeTaxation=@pOverTimeTaxation
                                                                  ,pPersonInsurance=@pPersonInsurance
                                                                  ,pPersonLabor=@pPersonLabor
                                                                  ,pPersonPension=@pPersonPension
                                                                  ,pCompanyPension=@pCompanyPension
                                                                  ,pComInsurance=@pComInsurance
                                                                  ,pComLabor=@pComLabor
                                                                  ,pAnnualLeavePro=@pAnnualLeavePro
                                                                  ,pP1Time=@pP1Time
                                                                  ,pIntertemporal=@pIntertemporal
                                                                  ,pBuckleCost=@pBuckleCost
                                                                  ,pBuckleFee=@pBuckleFee
                                                                  ,pWelfare=@pWelfare 
                                                                  ,pSalary=@pSalary where pGuid=@pGuid";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@pGuid", p.pGuid);
            cmd.Parameters.AddWithValue("@pWeekdayTime1", p.pWeekdayTime1);
            cmd.Parameters.AddWithValue("@pWeekdayTime2", p.pWeekdayTime2);
            cmd.Parameters.AddWithValue("@pWeekdayTime3", p.pWeekdayTime3);
            cmd.Parameters.AddWithValue("@pWeekdaySalary1", p.pWeekdaySalary1);
            cmd.Parameters.AddWithValue("@pWeekdaySalary2", p.pWeekdaySalary2);
            cmd.Parameters.AddWithValue("@pWeekdaySalary3", p.pWeekdaySalary3);

            cmd.Parameters.AddWithValue("@pOffDayTime1", p.pOffDayTime1);
            cmd.Parameters.AddWithValue("@pOffDayTime2", p.pOffDayTime2);
            cmd.Parameters.AddWithValue("@pOffDayTime3", p.pOffDayTime3);
            cmd.Parameters.AddWithValue("@pOffDaySalary1", p.pOffDaySalary1);
            cmd.Parameters.AddWithValue("@pOffDaySalary2", p.pOffDaySalary2);
            cmd.Parameters.AddWithValue("@pOffDaySalary3", p.pOffDaySalary3)
                ;
            cmd.Parameters.AddWithValue("@pHolidayTime1", p.pHolidayTime1);
            cmd.Parameters.AddWithValue("@pHolidayTime2", p.pHolidayTime2);
            cmd.Parameters.AddWithValue("@pHolidayTime3", p.pHolidayTime3);
            cmd.Parameters.AddWithValue("@pHolidayTime4", p.pHolidayTime4);
            cmd.Parameters.AddWithValue("@pHolidaySalary1", p.pHolidaySalary1);
            cmd.Parameters.AddWithValue("@pHolidaySalary2", p.pHolidaySalary2);
            cmd.Parameters.AddWithValue("@pHolidaySalary3", p.pHolidaySalary3);
            cmd.Parameters.AddWithValue("@pHolidaySalary4", p.pHolidaySalary4);
            cmd.Parameters.AddWithValue("@pHolidayDutyFree", p.pHolidayDutyFree);
            cmd.Parameters.AddWithValue("@pHolidayTaxation", p.pHolidayTaxation);

            cmd.Parameters.AddWithValue("@pNationalholidaysTime1", p.pNationalholidaysTime1);
            cmd.Parameters.AddWithValue("@pNationalholidaysTime2", p.pNationalholidaysTime2);
            cmd.Parameters.AddWithValue("@pNationalholidaysTime3", p.pNationalholidaysTime3);
            cmd.Parameters.AddWithValue("@pNationalholidaysTime4", p.pNationalholidaysTime4);

            cmd.Parameters.AddWithValue("@pNationalholidaysSalary1", p.pNationalholidaysSalary1);
            cmd.Parameters.AddWithValue("@pNationalholidaysSalary2", p.pNationalholidaysSalary2);
            cmd.Parameters.AddWithValue("@pNationalholidaysSalary3", p.pNationalholidaysSalary3);
            cmd.Parameters.AddWithValue("@pNationalholidaysSalary4", p.pNationalholidaysSalary4);

            cmd.Parameters.AddWithValue("@pNationalholidaysDutyFree", p.pNationalholidaysDutyFree);
            cmd.Parameters.AddWithValue("@pNationalholidaysTaxation", p.pNationalholidaysTaxation);
            cmd.Parameters.AddWithValue("@pHolidaySumDutyFree", p.pHolidaySumDutyFree);
            cmd.Parameters.AddWithValue("@pHolidaySumTaxation", p.pHolidaySumTaxation);

            cmd.Parameters.AddWithValue("@pAttendanceDays", p.pAttendanceDays);
            cmd.Parameters.AddWithValue("@pAttendanceTimes", p.pAttendanceTimes);
            cmd.Parameters.AddWithValue("@pPayLeave", p.pPayLeave);
            cmd.Parameters.AddWithValue("@pAnnualLeaveTimes", p.pAnnualLeaveTimes);
            cmd.Parameters.AddWithValue("@pAnnualLeaveSalary", p.pAnnualLeaveSalary);
            cmd.Parameters.AddWithValue("@pMarriageLeaveTimes", p.pMarriageLeaveTimes);
            cmd.Parameters.AddWithValue("@pMarriageLeaveSalary", p.pMarriageLeaveSalary);
            cmd.Parameters.AddWithValue("@pSickLeaveTimes", p.pSickLeaveTimes);
            cmd.Parameters.AddWithValue("@pSickLeaveSalary", p.pSickLeaveSalary);
            cmd.Parameters.AddWithValue("@pFuneralLeaveTimes", p.pFuneralLeaveTimes);
            cmd.Parameters.AddWithValue("@pFuneralLeaveSalary", p.pFuneralLeaveSalary);
            cmd.Parameters.AddWithValue("@pMaternityLeaveTimes", p.pMaternityLeaveTimes);
            cmd.Parameters.AddWithValue("@pMaternityLeaveSalary", p.pMaternityLeaveSalary);
            cmd.Parameters.AddWithValue("@pHonoraryLeaveTimes", p.pHonoraryLeaveTimes);
            cmd.Parameters.AddWithValue("@pHonoraryLeaveSalary", p.pHonoraryLeaveSalary);

            cmd.Parameters.AddWithValue("@pProductionLeaveTimes", p.pProductionLeaveTimes);
            cmd.Parameters.AddWithValue("@pProductionLeaveSalary", p.pProductionLeaveSalary);
            cmd.Parameters.AddWithValue("@pMilitaryLeaveTimes", p.pMilitaryLeaveTimes);
            cmd.Parameters.AddWithValue("@pMilitaryLeaveSalary", p.pMilitaryLeaveSalary);
            cmd.Parameters.AddWithValue("@pAbortionLeaveTimes", p.pAbortionLeaveTimes);
            cmd.Parameters.AddWithValue("@pAbortionLeaveSalary", p.pAbortionLeaveSalary);

            cmd.Parameters.AddWithValue("@pTaxDeduction", p.pTaxDeduction);
            cmd.Parameters.AddWithValue("@pPay", p.pPay);
            cmd.Parameters.AddWithValue("@pTaxation", p.pTaxation);
            cmd.Parameters.AddWithValue("@pTax", p.pTax);
            cmd.Parameters.AddWithValue("@pPremium", p.pPremium);
            cmd.Parameters.AddWithValue("@pOverTimeDutyfree", p.pOverTimeDutyfree);
            cmd.Parameters.AddWithValue("@pOverTimeTaxation", p.pOverTimeTaxation);
            cmd.Parameters.AddWithValue("@pPersonInsurance", p.pPersonInsurance);
            cmd.Parameters.AddWithValue("@pPersonLabor", p.pPersonLabor);
            cmd.Parameters.AddWithValue("@pPersonPension", p.pPersonPension);
            cmd.Parameters.AddWithValue("@pCompanyPension", p.pCompanyPension);
            cmd.Parameters.AddWithValue("@pComInsurance", p.pComInsurance);
            cmd.Parameters.AddWithValue("@pComLabor", p.pComLabor);
            cmd.Parameters.AddWithValue("@pAnnualLeavePro", p.pAnnualLeavePro);
            cmd.Parameters.AddWithValue("@pP1Time", p.pP1Time);
            cmd.Parameters.AddWithValue("@pIntertemporal", p.pIntertemporal);
            cmd.Parameters.AddWithValue("@pBuckleCost", p.pBuckleCost);
            cmd.Parameters.AddWithValue("@pBuckleFee", p.pBuckleFee);
            cmd.Parameters.AddWithValue("@pWelfare", p.pWelfare);
            cmd.Parameters.AddWithValue("@UserInfo", p.UserInfo);
            cmd.Parameters.AddWithValue("@pSalary", p.pSalary);

            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }

        }





        /// <summary>
        /// 發薪紀錄-法扣
        /// </summary>
        public DataTable Selsy_PaySalaryPrint()
        {

            string sql = @"select top 1 * from sy_PaySalaryPrint ";


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
        /// 計算薪資
        /// </summary>
        /// <param name="Class"></param>
        /// <param name="Region"></param>
        /// <param name="Dep"></param>
        /// <returns></returns>
        public void GenTax(string yyyy, string UserInfo)
        {
            string sql = @"pr_GenTax";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.CommandTimeout = 600;
            cmd.Parameters.AddWithValue("@yyyy", yyyy);
            cmd.Parameters.AddWithValue("@UserGuid", UserInfo);
            try
            {
                cmd.Connection.Open();
                SqlTransaction transaction;
                transaction = cmd.Connection.BeginTransaction();
                cmd.Transaction = transaction;
                cmd.CommandType = CommandType.StoredProcedure;


                //DataTable dt = new DataTable();
                //new SqlDataAdapter(cmd).Fill(dt);        
                cmd.ExecuteNonQuery();
                transaction.Commit();
                //return dt;
            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }
        }


        /// <summary>
        /// 所得稅資料Top200
        /// </summary>
        public DataTable SelSy_TaxTop200()
        {

            string sql = @"select top 100 * from sy_IndividualIncomeTax where iitStatus='A' ";

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
        /// 所得稅資料
        /// </summary>
        public DataTable SelSy_Tax(payroll.model.sy_Tax p)
        {

            string sql = @"select * from sy_IndividualIncomeTax where iitStatus='A' ";

            if (!string.IsNullOrEmpty(p.iitPerNo))
                sql += "and iitPerNo like '%'+ @iitPerNo +'%' ";

            if (!string.IsNullOrEmpty(p.iitPerName))
                sql += "and iitPerName like '%'+ @iitPerName +'%' ";

            if (!string.IsNullOrEmpty(p.iitComName))
                sql += "and iitComName like '%'+ @iitComName +'%' ";

            if (!string.IsNullOrEmpty(p.iitPerDep))
                sql += "and iitPerDep like '%'+ @iitPerDep +'%' ";

            if (!string.IsNullOrEmpty(p.iitYyyy))
                sql += "and iitYyyy=@iitYyyy ";

            if (!string.IsNullOrEmpty(p.iitGuid))
                sql += "and iitGuid = @iitGuid ";

            sql += "order by iitYyyy desc, iitComName, iitPerDep ";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@iitPerNo", p.iitPerNo);
            cmd.Parameters.AddWithValue("@iitPerName", p.iitPerName);
            cmd.Parameters.AddWithValue("@iitComName", p.iitComName);
            cmd.Parameters.AddWithValue("@iitPerDep", p.iitPerDep);
            cmd.Parameters.AddWithValue("@iitYyyy", p.iitYyyy);
            cmd.Parameters.AddWithValue("@iitGuid", p.iitGuid);
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
        /// 修改個人津貼
        /// </summary>
        public void Upsy_Tax(payroll.model.sy_Tax p)
        {
            string sql = @"update sy_IndividualIncomeTax set                                                               
                                iitFormat=@iitFormat
                                ,iitMark=@iitMark
                                ,iitManner=@iitManner
                                ,iitPaySum=@iitPaySum
                                ,iitPayTax=@iitPayTax
                                ,iitPayAmount=@iitPayAmount
                                ,iitYearStart=@iitYearStart
                                ,iitYearEnd=@iitYearEnd
                                ,iitStock=@iitStock
                                ,iitIdentify=@iitIdentify
                                ,iitErrMark=@iitErrMark
                                ,iitHouseTax=@iitHouseTax
                                ,iitIndustryCode=@iitIndustryCode 
                                ,iitCode=@iitCode 
                            where iitGuid=@iitGuid";

            SqlCommand cmd = new SqlCommand(sql, Sqlconn);
            cmd.Parameters.AddWithValue("@iitGuid", p.iitGuid);
            cmd.Parameters.AddWithValue("@iitFormat", p.iitFormat);
            cmd.Parameters.AddWithValue("@iitMark", p.iitMark);
            cmd.Parameters.AddWithValue("@iitManner", p.iitManner);
            cmd.Parameters.AddWithValue("@iitPaySum", p.iitPaySum);
            cmd.Parameters.AddWithValue("@iitPayTax", p.iitPayTax);
            cmd.Parameters.AddWithValue("@iitPayAmount", p.iitPayAmount);
            cmd.Parameters.AddWithValue("@iitYearStart", p.iitYearStart);
            cmd.Parameters.AddWithValue("@iitYearEnd", p.iitYearEnd);
            cmd.Parameters.AddWithValue("@iitStock", p.iitStock);
            cmd.Parameters.AddWithValue("@iitIdentify", p.iitIdentify);
            cmd.Parameters.AddWithValue("@iitErrMark", p.iitErrMark);
            cmd.Parameters.AddWithValue("@iitHouseTax", p.iitHouseTax)                ;
            cmd.Parameters.AddWithValue("@iitIndustryCode", p.iitIndustryCode);
            cmd.Parameters.AddWithValue("@iitCode", p.iitCode);       

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