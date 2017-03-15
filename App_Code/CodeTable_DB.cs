using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// CodeTable_DB 的摘要描述
/// </summary>
public class CodeTable_DB
{
	string KeyWord = string.Empty;
	public string _KeyWord
	{
		set { KeyWord = value; }
	}
	#region 私用
	string code_group = string.Empty;
	string code_desc = string.Empty;
	string code_value = string.Empty;
	string code_ps = string.Empty;
	#endregion
	#region 公用
	public string _code_group
	{
		set { code_group = value; }
	}
	public string _code_desc
	{
		set { code_desc = value; }
	}
	public string _code_value
	{
		set { code_value = value; }
	}
	public string _code_ps
	{
		set { code_ps = value; }
	}
	#endregion

	public DataTable getGroup(string group)
	{
		SqlCommand oCmd = new SqlCommand();
		oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
		StringBuilder sb = new StringBuilder();

		sb.Append(@"SELECT code_desc,code_value from sy_codetable where code_group=@group ");

		oCmd.CommandText = sb.ToString();
		oCmd.CommandType = CommandType.Text;
		SqlDataAdapter oda = new SqlDataAdapter(oCmd);
		DataTable ds = new DataTable();

		oCmd.Parameters.AddWithValue("@group", group);
		oda.Fill(ds);
		return ds;
	}
}