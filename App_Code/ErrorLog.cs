using System;
using System.Data.SqlClient;


/// <summary>
/// ErrorLog 的摘要描述
/// </summary>
public class ErrorLog
{

    SqlConnection Sqlconn = new payroll_sqlconn().conn;

    /// <summary>
    ///  新增error msg
    /// </summary>
    /// <param name="errLogPage"></param>
    /// <param name="errLogMsg"></param>
    /// <param name="errLogUse"></param>
    public void InsErrorLog(string errLogPage, string errLogMsg, string errLogUse)
    {
        string sql = @"insert sy_ErrorLog(errLogPage, errLogMsg, errLogUse)
                              values(@errLogPage, @errLogMsg, @errLogUse)";

        SqlCommand cmd = new SqlCommand(sql, Sqlconn);
        cmd.Parameters.AddWithValue("@errLogPage", errLogPage);
        cmd.Parameters.AddWithValue("@errLogMsg", errLogMsg);
        cmd.Parameters.AddWithValue("@errLogUse", errLogUse);

        try
        {

            cmd.Connection.Open();
            cmd.ExecuteNonQuery();

        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
    }





}