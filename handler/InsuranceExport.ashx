<%@ WebHandler Language="C#" Class="InsuranceExport" %>

using System;
using System.Web;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;
using FlexCel.Core;
using FlexCel.XlsAdapter;
using System.Configuration;

public class InsuranceExport : IHttpHandler {
    LaborHealth_DB LH_Db = new LaborHealth_DB();
    PersonPension_DB PP_Db = new PersonPension_DB();
    FamilyInsurance_DB FI_Db = new FamilyInsurance_DB();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            //保險類別
            string category = (context.Request["category"] != null) ? context.Request["category"].ToString() : "";
            //本人or眷屬
            string type = (context.Request["type"] != null) ? context.Request["type"].ToString() : "";
            //匯出類別(加退保..等等)
            string item = (context.Request["item"] != null) ? context.Request["item"].ToString() : "";
            string itemGv = (context.Request["itemGuid"] != null) ? context.Request["itemGuid"].ToString() : "";

            //string FileName = DateTime.Now.ToString("yyyy-MM-dd");
            string ToDate = ROC_Date(DateTime.Now.ToString("yyyy/MM/dd"));
            string FileName = string.Empty;
            string fileSpec = string.Empty;
            DataTable dt = new DataTable();
            //context.Response.Clear();
            ExcelFile Xls = new XlsFile(true);

            if (category == "L" || category == "H")
            {
                if (type == "3")
                {
                    switch (item)
                    {
                        //三合一加保
                        case "01":
                            if (itemGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/add_3in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += ToDate + "加保三合一";
                                    if (category == "L")
                                        dt = LH_Db.L_3in1_add(itemGv);
                                    else
                                        dt = LH_Db.H_3in1_add(itemGv);
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "4");
                                            Xls.SetCellValue(i, 2, dt.Rows[i - 2]["LaborID1"].ToString());
                                            Xls.SetCellValue(i, 3, dt.Rows[i - 2]["LaborID2"].ToString());
                                            Xls.SetCellValue(i, 4, dt.Rows[i - 2]["GanBorID"].ToString());
                                            if (dt.Rows[i - 2]["fID"].ToString() == "")
                                            {
                                                Xls.SetCellValue(i, 5, "2");
                                                Xls.SetCellValue(i, 6, "1");
                                                Xls.SetCellValue(i, 20, "1");
                                            }
                                            else
                                            {
                                                Xls.SetCellValue(i, 5, "3");
                                                Xls.SetCellValue(i, 6, "2");
                                                Xls.SetCellValue(i, 18, dt.Rows[i - 2]["fTitle"].ToString());
                                                Xls.SetCellValue(i, 20, "4");
                                            }
                                            //判斷外籍,身份證前兩碼為英文 
                                            Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                            if (reg1.IsMatch(dt.Rows[i - 2]["perIDNumber"].ToString().Substring(0, 2)))
                                            {
                                                Xls.SetCellValue(i, 7, "2");
                                                Xls.SetCellValue(i, 22, dt.Rows[i - 2]["perSex"].ToString());
                                            }
                                            Xls.SetCellValue(i, 8, dt.Rows[i - 2]["perIDNumber"].ToString().Trim());
                                            Xls.SetCellValue(i, 9, dt.Rows[i - 2]["perName"].ToString().Trim());
                                            Xls.SetCellValue(i, 10, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                            Xls.SetCellValue(i, 11, dt.Rows[i - 2]["plLaborPayroll"].ToString());
                                            Xls.SetCellValue(i, 12, dt.Rows[i - 2]["piInsurancePayroll"].ToString());
                                            Xls.SetCellValue(i, 13, "1");
                                            if (dt.Rows[i - 2]["iiIdentityCode"].ToString() == "2")
                                                Xls.SetCellValue(i, 14, "0");
                                            Xls.SetCellValue(i, 15, dt.Rows[i - 2]["fID"].ToString());
                                            Xls.SetCellValue(i, 16, dt.Rows[i - 2]["fName"].ToString().Trim());
                                            Xls.SetCellValue(i, 17, ROC_Date(dt.Rows[i - 2]["fBirth"].ToString()));
                                            Xls.SetCellValue(i, 19, "1");
                                            Xls.SetCellValue(i, 21, ROC_Date(dt.Rows[i - 2]["ChangeDate"].ToString()));
                                            Xls.SetCellValue(i, 23, dt.Rows[i - 2]["perPensionIdentity"].ToString());
                                            string ColX = (dt.Rows[i - 2]["ppEmployerRatio"].ToString() == "0" ? "" : dt.Rows[i - 2]["ppEmployerRatio"].ToString());
                                            Xls.SetCellValue(i, 24, ColX);
                                            string ColY = (dt.Rows[i - 2]["ppLarboRatio"].ToString() == "0" ? "" : dt.Rows[i - 2]["ppLarboRatio"].ToString());
                                            Xls.SetCellValue(i, 25, ColY);
                                            if (dt.Rows[i - 2]["ppChangeDate"].ToString() != dt.Rows[i - 2]["plChangeDate"].ToString())
                                                Xls.SetCellValue(i, 26, ROC_Date(dt.Rows[i - 2]["ppChangeDate"].ToString()));
                                        }
                                    }
                                }
                            }
                            break;
                        //三合一退保
                        case "02":
                            if (itemGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/out_3in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += ToDate + "退保三合一";
                                    if (category == "L")
                                        dt = LH_Db.L_3in1_out(itemGv);
                                    else
                                        dt = LH_Db.H_3in1_out(itemGv);
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "2");
                                            Xls.SetCellValue(i, 2, dt.Rows[i - 2]["comLaborProtection1"].ToString());
                                            Xls.SetCellValue(i, 3, dt.Rows[i - 2]["comLaborProtection2"].ToString());
                                            Xls.SetCellValue(i, 4, dt.Rows[i - 2]["comHealthInsuranceCode"].ToString());
                                            Xls.SetCellValue(i, 5, "1");
                                            Xls.SetCellValue(i, 6, "2");
                                            Xls.SetCellValue(i, 7, "1");
                                            //判斷外籍,身份證前兩碼為英文 
                                            Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                            if (reg1.IsMatch(dt.Rows[i - 2]["perIDNumber"].ToString().Substring(0, 2)))
                                            {
                                                Xls.SetCellValue(i, 8, "2");
                                                Xls.SetCellValue(i, 11, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            }
                                            Xls.SetCellValue(i, 9, dt.Rows[i - 2]["perName"].ToString());
                                            Xls.SetCellValue(i, 10, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            Xls.SetCellValue(i, 12, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                            Xls.SetCellValue(i, 13, "2");
                                            Xls.SetCellValue(i, 14, dt.Rows[i - 2]["piDropOutReason"].ToString());
                                            string strDOR = (dt.Rows[i - 2]["DORStr1"].ToString() != "") ? dt.Rows[i - 2]["DORStr1"].ToString() : dt.Rows[i - 2]["DORStr2"].ToString();
                                            Xls.SetCellValue(i, 15, strDOR);
                                            if (dt.Rows[i - 2]["piChangeDate"].ToString() == "") //勞保有退保資料,健保沒有退保資料時
                                                Xls.SetCellValue(i, 16, ROC_Date(dt.Rows[i - 2]["plChangeDate"].ToString()));
                                            else
                                                Xls.SetCellValue(i, 16, ROC_Date(dt.Rows[i - 2]["piChangeDate"].ToString()));
                                        }
                                    }
                                }
                            }
                            break;
                        //三合一保薪調整
                        case "03":
                            if (itemGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/mod_3in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += ToDate + "保薪調整三合一";
                                    DataSet ds31 = LH_Db.LH_3in1_mod(itemGv,category);
                                    dt = ds31.Tables[0];
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "3");
                                            Xls.SetCellValue(i, 2, dt.Rows[i - 2]["LaborID1"].ToString());
                                            Xls.SetCellValue(i, 3, dt.Rows[i - 2]["LaborID2"].ToString());
                                            Xls.SetCellValue(i, 4, dt.Rows[i - 2]["GanborID"].ToString());
                                            Xls.SetCellValue(i, 5, "1");
                                            //判斷外籍,身份證前兩碼為英文 
                                            Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                            if (reg1.IsMatch(dt.Rows[i - 2]["perIDNumber"].ToString().Substring(0, 2)))
                                            {
                                                Xls.SetCellValue(i, 6, "2");
                                                Xls.SetCellValue(i, 9, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            }
                                            Xls.SetCellValue(i, 7, dt.Rows[i - 2]["perName"].ToString());
                                            Xls.SetCellValue(i, 8, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            Xls.SetCellValue(i, 10, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                            Xls.SetCellValue(i, 11, Math.Round(double.Parse(dt.Rows[i - 2]["PayAvg"].ToString()), 0));
                                            DataView dv = ds31.Tables[1].DefaultView;
                                            dv.RowFilter = "piPerGuid='" + dt.Rows[i - 2]["perGuid"].ToString() + "'";
                                            Xls.SetCellValue(i, 12, dv[1]["piInsurancePayroll"].ToString());
                                            Xls.SetCellValue(i, 13, dv[0]["piInsurancePayroll"].ToString());
                                            if (double.Parse(dt.Rows[i - 2]["PayAvg"].ToString()) < double.Parse(dv[0]["piInsurancePayroll"].ToString()))
                                                Xls.SetCellValue(i, 14, "1");
                                        }
                                    }
                                }
                            }
                            break;
                    }
                }
                else
                {
                    switch (item)
                    {
                        //二合一加保
                        case "01":
                            if (itemGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/add_2in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += ToDate + "加保二合一";
                                    dt = LH_Db.L_2in1_add(itemGv);
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "2");
                                            string IDCode = (dt.Rows[i - 2]["iiIdentityCode"].ToString() != "4") ? "1" : "2";
                                            Xls.SetCellValue(i, 2, dt.Rows[i - 2]["comLaborProtection1"].ToString());
                                            Xls.SetCellValue(i, 3, dt.Rows[i - 2]["comLaborProtection2"].ToString());
                                            //判斷外籍,身份證前兩碼為英文 
                                            Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                            if (reg1.IsMatch(dt.Rows[i - 2]["perIDNumber"].ToString().Substring(0, 2)))
                                            {
                                                Xls.SetCellValue(i, 5, "2");
                                                Xls.SetCellValue(i, 13, dt.Rows[i - 2]["perSex"].ToString());
                                            }
                                            Xls.SetCellValue(i, 6, dt.Rows[i - 2]["perName"].ToString());
                                            Xls.SetCellValue(i, 7, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            Xls.SetCellValue(i, 8, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                            Xls.SetCellValue(i, 9, dt.Rows[i - 2]["plLaborPayroll"].ToString());
                                            Xls.SetCellValue(i, 10, "1");
                                            if (dt.Rows[i - 2]["iiIdentityCode"].ToString() == "2")
                                                Xls.SetCellValue(i, 11, "0");
                                            Xls.SetCellValue(i, 12, "1");
                                            Xls.SetCellValue(i, 14, dt.Rows[i - 2]["perPensionIdentity"].ToString());
                                            string ColO = (dt.Rows[i - 2]["ppEmployerRatio"].ToString() == "0" ? "" : dt.Rows[i - 2]["ppEmployerRatio"].ToString());
                                            Xls.SetCellValue(i, 15, ColO);
                                            string ColP = (dt.Rows[i - 2]["ppLarboRatio"].ToString() == "0" ? "" : dt.Rows[i - 2]["ppLarboRatio"].ToString());
                                            Xls.SetCellValue(i, 16, ColP);
                                            if (dt.Rows[i - 2]["ppChangeDate"].ToString() != dt.Rows[i - 2]["plChangeDate"].ToString())
                                                Xls.SetCellValue(i, 17, ROC_Date(dt.Rows[i - 2]["ppChangeDate"].ToString()));
                                        }
                                    }
                                }
                            }
                            break;
                        //二合一退保
                        case "02":
                            if (itemGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/out_2in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += ToDate + "退保二合一";
                                    dt = LH_Db.L_2in1_out(itemGv);
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "2");
                                            Xls.SetCellValue(i, 2, dt.Rows[i - 2]["comLaborProtection1"].ToString());
                                            Xls.SetCellValue(i, 3, dt.Rows[i - 2]["comLaborProtection2"].ToString());
                                            //判斷外籍,身份證前兩碼為英文 
                                            Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                            if (reg1.IsMatch(dt.Rows[i - 2]["perIDNumber"].ToString().Substring(0, 2)))
                                            {
                                                Xls.SetCellValue(i, 4, "2");
                                                Xls.SetCellValue(i, 7, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            }
                                            Xls.SetCellValue(i, 5, dt.Rows[i - 2]["perName"].ToString());
                                            Xls.SetCellValue(i, 6, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            Xls.SetCellValue(i, 8, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                        }
                                    }
                                }
                            }
                            break;
                        //二合一保薪調整
                        case "03":
                            if (itemGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/mod_2in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += ToDate + "保薪調整二合一";
                                    DataSet ds21 = LH_Db.LH_3in1_mod(itemGv,category);
                                    dt = ds21.Tables[0];
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "3");
                                            Xls.SetCellValue(i, 2, dt.Rows[i - 2]["LaborID1"].ToString());
                                            Xls.SetCellValue(i, 3, dt.Rows[i - 2]["LaborID2"].ToString());
                                            //判斷外籍,身份證前兩碼為英文 
                                            Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                            if (reg1.IsMatch(dt.Rows[i - 2]["perIDNumber"].ToString().Substring(0, 2)))
                                            {
                                                Xls.SetCellValue(i, 4, "2");
                                                Xls.SetCellValue(i, 7, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            }
                                            Xls.SetCellValue(i, 5, dt.Rows[i - 2]["perName"].ToString());
                                            Xls.SetCellValue(i, 6, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            Xls.SetCellValue(i, 8, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                            Xls.SetCellValue(i, 9, Math.Round(double.Parse(dt.Rows[i - 2]["PayAvg"].ToString()), 0));
                                            DataView dv = ds21.Tables[1].DefaultView;
                                            dv.RowFilter = "piPerGuid='" + dt.Rows[i - 2]["perGuid"].ToString() + "'";
                                            if (double.Parse(dt.Rows[i - 2]["PayAvg"].ToString()) < double.Parse(dv[0]["piInsurancePayroll"].ToString()))
                                                Xls.SetCellValue(i, 10, "1");
                                        }
                                    }
                                }
                            }
                            break;
                    }
                } //if type end
            }
            else if (category == "Pension")
            {
                switch (item)
                {
                    //提繳
                    case "01":
                        if (itemGv != "")
                        {
                            fileSpec = context.Server.MapPath("~/Template/pp_add.xls");
                            using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                            {
                                Xls.Open(fileSpec);
                                FileName += ToDate + "勞退提繳";
                                dt = PP_Db.pp_add(itemGv);
                                TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                if (dt.Rows.Count > 0)
                                {
                                    for (int i = 2; i < dt.Rows.Count + 2; i++)
                                    {
                                        Xls.SetCellValue(i, 1, dt.Rows[i - 2]["comLaborProtection1"].ToString());
                                        Xls.SetCellValue(i, 2, dt.Rows[i - 2]["comLaborProtection2"].ToString());
                                        Xls.SetCellValue(i, 3, "4");
                                        Xls.SetCellValue(i, 4, dt.Rows[i - 2]["perName"].ToString());
                                        Xls.SetCellValue(i, 5, dt.Rows[i - 2]["perIDNumber"].ToString());
                                        Xls.SetCellValue(i, 6, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                        Xls.SetCellValue(i, 7, dt.Rows[i - 2]["ppPayPayroll"].ToString());
                                        Xls.SetCellValue(i, 8, dt.Rows[i - 2]["perPensionIdentity"].ToString());
                                        Xls.SetCellValue(i, 9, dt.Rows[i - 2]["ppEmployerRatio"].ToString());
                                        Xls.SetCellValue(i, 10, ROC_Date(dt.Rows[i - 2]["perFirstDate"].ToString()));
                                        //20170927 自願提繳，年資未滿兩年沒有強制，兩年以後才有強制提繳，未滿兩年的空白
                                        if (Int32.Parse(dt.Rows[i - 2]["perYears"].ToString()) >= 2)
                                        {
                                            Xls.SetCellValue(i, 11, dt.Rows[i - 2]["ppLarboRatio"].ToString());
                                            Xls.SetCellValue(i, 12, dt.Rows[i - 2]["ppChangeDate"].ToString());
                                        }
                                        //勞退低於健保最低，則部份工時設"Y"
                                        if (double.Parse(dt.Rows[i - 2]["ppPayPayroll"].ToString()) < double.Parse(dt.Rows[i - 2]["InsLv"].ToString()))
                                            Xls.SetCellValue(i, 15, "Y");
                                        //判斷外籍,身份證前兩碼為英文 
                                        Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                        if (reg1.IsMatch(dt.Rows[i - 2]["perIDNumber"].ToString().Substring(0, 2)))
                                        {
                                            Xls.SetCellValue(i, 16, "2");
                                        }
                                    }
                                }
                            }
                        }
                        break;
                    //提繳工資調整
                    case "02":
                        if (itemGv != "")
                        {
                            fileSpec = context.Server.MapPath("~/Template/pp_mod.xls");
                            using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                            {
                                Xls.Open(fileSpec);
                                FileName += ToDate + "勞退提繳工資調整";
                                dt = PP_Db.pp_mod(itemGv);
                                TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                if (dt.Rows.Count > 0)
                                {
                                    for (int i = 2; i < dt.Rows.Count + 2; i++)
                                    {
                                        Xls.SetCellValue(i, 1, dt.Rows[i - 2]["comLaborProtection1"].ToString());
                                        Xls.SetCellValue(i, 2, dt.Rows[i - 2]["comLaborProtection2"].ToString());
                                        Xls.SetCellValue(i, 3, "4");
                                        Xls.SetCellValue(i, 4, dt.Rows[i - 2]["perName"].ToString());
                                        Xls.SetCellValue(i, 5, dt.Rows[i - 2]["perIDNumber"].ToString());
                                        Xls.SetCellValue(i, 6, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                        Xls.SetCellValue(i, 7, dt.Rows[i - 2]["ppPayPayroll"].ToString());
                                        //勞退低於健保最低，則部份工時設"Y"
                                        if (double.Parse(dt.Rows[i - 2]["ppPayPayroll"].ToString()) < double.Parse(dt.Rows[i - 2]["InsLv"].ToString()))
                                            Xls.SetCellValue(i, 15, "Y");
                                        //判斷外籍,身份證前兩碼為英文 
                                        Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                        if (reg1.IsMatch(dt.Rows[i - 2]["perIDNumber"].ToString().Substring(0, 2)))
                                        {
                                            Xls.SetCellValue(i, 16, "2");
                                        }
                                    }
                                }
                            }
                        }
                        break;
                    //停繳
                    case "03":
                        if (itemGv != "")
                        {
                            fileSpec = context.Server.MapPath("~/Template/pp_stop.xls");
                            using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                            {
                                Xls.Open(fileSpec);
                                FileName += ToDate + "勞退停繳";
                                dt = PP_Db.pp_stop(itemGv);
                                TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                if (dt.Rows.Count > 0)
                                {
                                    for (int i = 2; i < dt.Rows.Count + 2; i++)
                                    {
                                        Xls.SetCellValue(i, 1, dt.Rows[i - 2]["comLaborProtection1"].ToString());
                                        Xls.SetCellValue(i, 2, dt.Rows[i - 2]["comLaborProtection2"].ToString());
                                        Xls.SetCellValue(i, 3, "4");
                                        Xls.SetCellValue(i, 4, dt.Rows[i - 2]["perName"].ToString());
                                        Xls.SetCellValue(i, 5, dt.Rows[i - 2]["perIDNumber"].ToString());
                                        Xls.SetCellValue(i, 6, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                        //判斷外籍,身份證前兩碼為英文 
                                        Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                        if (reg1.IsMatch(dt.Rows[i - 2]["perIDNumber"].ToString().Substring(0, 2)))
                                        {
                                            Xls.SetCellValue(i, 16, "2");
                                        }
                                    }
                                }
                            }
                        }
                        break;
                }
            }
            else if (category == "PFI")
            {
                switch (item)
                {
                    //眷屬三合一加保
                    case "01":
                        if (itemGv != "")
                        {
                            fileSpec = context.Server.MapPath("~/Template/add_3in1.xls");
                            using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                            {
                                Xls.Open(fileSpec);
                                FileName += ToDate + "眷屬加保三合一";
                                dt = FI_Db.FamilyHeal_3in1_add(itemGv);
                                TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                if (dt.Rows.Count > 0)
                                {
                                    for (int i = 2; i < dt.Rows.Count + 2; i++)
                                    {
                                        Xls.SetCellValue(i, 1, "4");
                                        Xls.SetCellValue(i, 2, dt.Rows[i - 2]["comLaborProtection1"].ToString());
                                        Xls.SetCellValue(i, 3, dt.Rows[i - 2]["comLaborProtection2"].ToString());
                                        Xls.SetCellValue(i, 4, dt.Rows[i - 2]["GanborID"].ToString());
                                        Xls.SetCellValue(i, 5, "3");
                                        Xls.SetCellValue(i, 6, "2");
                                        //判斷外籍,身份證前兩碼為英文 
                                        Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                        if (reg1.IsMatch(dt.Rows[i - 2]["perIDNumber"].ToString().Substring(0, 2)))
                                        {
                                            Xls.SetCellValue(i, 7, "2");
                                            Xls.SetCellValue(i, 22, dt.Rows[i - 2]["perSex"].ToString());
                                        }
                                        Xls.SetCellValue(i, 8, dt.Rows[i - 2]["perIDNumber"].ToString());
                                        Xls.SetCellValue(i, 9, dt.Rows[i - 2]["perName"].ToString());
                                        Xls.SetCellValue(i, 10, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                        Xls.SetCellValue(i, 11, dt.Rows[i - 2]["minLaborLv"].ToString());
                                        Xls.SetCellValue(i, 12, dt.Rows[i - 2]["minInsLv"].ToString());
                                        Xls.SetCellValue(i, 13, "1");
                                        if (dt.Rows[i - 2]["iiIdentityCode"].ToString() == "2")
                                            Xls.SetCellValue(i, 14, "0");
                                        Xls.SetCellValue(i, 15, dt.Rows[i - 2]["pfIDNumber"].ToString());
                                        Xls.SetCellValue(i, 16, dt.Rows[i - 2]["pfName"].ToString());
                                        Xls.SetCellValue(i, 17, ROC_Date(dt.Rows[i - 2]["pfBirthday"].ToString()));
                                        Xls.SetCellValue(i, 18, dt.Rows[i - 2]["pfTitle"].ToString());
                                        Xls.SetCellValue(i, 19, "1");
                                        Xls.SetCellValue(i, 20, "4");
                                        Xls.SetCellValue(i, 21, ROC_Date(dt.Rows[i - 2]["pfiChangeDate"].ToString()));
                                        //Xls.SetCellValue(i, 23, dt.Rows[i - 2]["perPensionIdentity"].ToString());
                                        //Xls.SetCellValue(i, 24, dt.Rows[i - 2]["ppEmployerRatio"].ToString());
                                        //Xls.SetCellValue(i, 25, dt.Rows[i - 2]["ppLarboRatio"].ToString());
                                        //Xls.SetCellValue(i, 26, dt.Rows[i - 2]["ppChangeDate"].ToString());
                                    }
                                }
                            }
                        }
                        break;
                    //眷屬三合一退保
                    case "02":
                        if (itemGv != "")
                        {
                            fileSpec = context.Server.MapPath("~/Template/out_3in1.xls");
                            using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                            {
                                Xls.Open(fileSpec);
                                FileName += ToDate + "眷屬退保三合一";
                                dt = FI_Db.FamilyHeal_3in1_out(itemGv);
                                TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                if (dt.Rows.Count > 0)
                                {
                                    for (int i = 2; i < dt.Rows.Count + 2; i++)
                                    {
                                        Xls.SetCellValue(i, 1, "2");
                                        Xls.SetCellValue(i, 2, dt.Rows[i - 2]["comLaborProtection1"].ToString());
                                        Xls.SetCellValue(i, 3, dt.Rows[i - 2]["comLaborProtection2"].ToString());
                                        Xls.SetCellValue(i, 4, dt.Rows[i - 2]["GanBorID"].ToString());
                                        Xls.SetCellValue(i, 5, "1");
                                        Xls.SetCellValue(i, 6, "2");
                                        Xls.SetCellValue(i, 7, "1");
                                        //判斷外籍,身份證前兩碼為英文 
                                        Regex reg1 = new Regex(@"^[A-Za-z]+$");
                                        if (reg1.IsMatch(dt.Rows[i - 2]["pfIDNumber"].ToString().Substring(0, 2)))
                                        {
                                            Xls.SetCellValue(i, 8, "2");
                                            Xls.SetCellValue(i, 11, dt.Rows[i - 2]["pfIDNumber"].ToString());
                                        }
                                        Xls.SetCellValue(i, 9, dt.Rows[i - 2]["pfName"].ToString());
                                        Xls.SetCellValue(i, 10, dt.Rows[i - 2]["pfIDNumber"].ToString());
                                        Xls.SetCellValue(i, 12, ROC_Date(dt.Rows[i - 2]["pfBirthday"].ToString()));
                                        Xls.SetCellValue(i, 13, "2");
                                        Xls.SetCellValue(i, 14, dt.Rows[i - 2]["pfiDropOutReason"].ToString());
                                        string strDOR = (dt.Rows[i - 2]["DORStr1"].ToString() != "") ? dt.Rows[i - 2]["DORStr1"].ToString() : dt.Rows[i - 2]["DORStr2"].ToString();
                                        Xls.SetCellValue(i, 15, strDOR);
                                        Xls.SetCellValue(i, 16, ROC_Date(dt.Rows[i - 2]["pfiChangeDate"].ToString()));
                                    }
                                }
                            }
                        }
                        break;
                }
            }
            else if (category == "PGI")
            {
                fileSpec = context.Server.MapPath("~/Template/pgi_add.xls");
                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                {
                    Xls.Open(fileSpec);
                    FileName += ToDate + "團保";
                    dt = FI_Db.Pgi_Export(itemGv);
                    TXlsCellRange myRange = new TXlsCellRange("A4:Z4");
                    if (dt.Rows.Count > 0)
                    {
                        for (int i = 4; i < dt.Rows.Count + 4; i++)
                        {
                            string birthYear = DateTime.Parse(dt.Rows[i - 4]["perBirthday"].ToString()).ToString("yyyy");
                            Xls.SetCellValue(i, 1, dt.Rows[i - 4]["perDep"].ToString());
                            Xls.SetCellValue(i, 2, dt.Rows[i - 4]["perNo"].ToString());
                            Xls.SetCellValue(i, 3, dt.Rows[i - 4]["perName"].ToString());
                            Xls.SetCellValue(i, 4, dt.Rows[i - 4]["perIDNumber"].ToString());
                            Xls.SetCellValue(i, 5, ROC_Date(dt.Rows[i - 4]["perBirthday"].ToString()));
                            Xls.SetCellValue(i, 6, dt.Rows[i - 4]["perPosition"].ToString());
                            Xls.SetCellValue(i, 7, "B");
                            if (dt.Rows[i - 4]["pgiChange"].ToString() != "02")
                                Xls.SetCellValue(i, 8, dt.Rows[i - 4]["startDate"].ToString());
                            if (dt.Rows[i - 4]["pgiChange"].ToString() == "02")
                                Xls.SetCellValue(i, 9, dt.Rows[i - 4]["pgiChangeDate"].ToString());
                            if (dt.Rows[i - 4]["pgiType"].ToString() == "02")
                            {
                                Xls.SetCellValue(i, 10, dt.Rows[i - 4]["pfTitle"].ToString());
                                Xls.SetCellValue(i, 11, dt.Rows[i - 4]["pfName"].ToString());
                                Xls.SetCellValue(i, 12, dt.Rows[i - 4]["pfIDNumber"].ToString());
                                Xls.SetCellValue(i, 13, ROC_Date(dt.Rows[i - 4]["pfBirthday"].ToString()));
                                if (dt.Rows[i - 4]["pfBirthday"].ToString() != "")
                                    birthYear = DateTime.Parse(dt.Rows[i - 4]["pfBirthday"].ToString()).ToString("yyyy");
                                else
                                    birthYear = "0";
                            }
                            string age = (Int32.Parse(DateTime.Now.ToString("yyyy")) - Int32.Parse(birthYear)).ToString();
                            if (Int32.Parse(age) > 23 && dt.Rows[i - 4]["pfTitle"].ToString().Trim() == "子女")
                                Xls.SetCellValue(i, 14, ">23歲");
                            else
                                Xls.SetCellValue(i, 14, age);
                        }
                    }
                }
            }//if category end

            string UpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"];
            if (!Directory.Exists(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\"))))//如果上傳路徑中沒有該目錄，則自動新增
            {
                Directory.CreateDirectory(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\")));
            }
            Xls.Save(System.IO.Path.Combine(ConfigurationManager.AppSettings["UploadFileRootDir"], FileName + ".xls"));
            context.Response.Write("success," + FileName + ".xls");
        }
        catch (Exception ex) { context.Response.Write("error," + context.Server.UrlEncode(ex.Message).Replace("+", " ")); }
    }

    private string ROC_Date(string dateStr)
    {
        string TaiwanDate = string.Empty;
        if (dateStr == "")
            TaiwanDate = "";
        else
        {
            var ROC_Calendar = new System.Globalization.TaiwanCalendar();
            TaiwanDate = ROC_Calendar.GetYear(DateTime.Parse(dateStr)).ToString().PadLeft(3, '0') +
                    DateTime.Parse(dateStr).Month.ToString().PadLeft(2, '0') +
                    DateTime.Parse(dateStr).Day.ToString().PadLeft(2, '0');
        }
        return TaiwanDate;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}