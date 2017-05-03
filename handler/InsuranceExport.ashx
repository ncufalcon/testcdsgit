﻿<%@ WebHandler Language="C#" Class="InsuranceExport" %>

using System;
using System.Web;
using System.Data;
using System.IO;
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
            string category = (context.Request["category"] != null) ? context.Request["category"].ToString() : "";
            string type = (context.Request["type"] != null) ? context.Request["type"].ToString() : "";
            string item = (context.Request["item"] != null) ? context.Request["item"].ToString() : "";
            string perGv = (context.Request["perGuid"] != null) ? context.Request["perGuid"].ToString() : "";

            //string FileName = DateTime.Now.ToString("yyyy-MM-dd");
            string FileName = string.Empty;
            string fileSpec = string.Empty;
            DataTable dt = new DataTable();
            //context.Response.Clear();
            ExcelFile Xls = new XlsFile(true);

            if (category == "LH")
            {
                if (type == "3")
                {
                    switch (item)
                    {
                        //三合一加保
                        case "01":
                            if (perGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/add_3in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += "加保三合一";
                                    dt = LH_Db.LH_3in1_add(perGv);
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "4");
                                            if (dt.Rows[i - 2]["LaborID"].ToString() != "")
                                                Xls.SetCellValue(i, 2, dt.Rows[i - 2]["LaborID"].ToString().Substring(0, (dt.Rows[i - 2]["LaborID"].ToString().Length - 1)));
                                            if (dt.Rows[i - 2]["LaborID"].ToString() != "")
                                                Xls.SetCellValue(i, 3, dt.Rows[i - 2]["LaborID"].ToString().Substring(dt.Rows[i - 2]["LaborID"].ToString().Length - 1, 1));
                                            Xls.SetCellValue(i, 4, dt.Rows[i - 2]["GanBorID"].ToString());
                                            if (dt.Rows[i - 2]["fID"].ToString() == "")
                                            {
                                                Xls.SetCellValue(i, 5, "2");
                                                Xls.SetCellValue(i, 6, "1");
                                                Xls.SetCellValue(i, 12, dt.Rows[i - 2]["InsLv"].ToString());
                                                Xls.SetCellValue(i, 20, "1");
                                            }
                                            else
                                            {
                                                Xls.SetCellValue(i, 5, "3");
                                                Xls.SetCellValue(i, 6, "2");
                                                Xls.SetCellValue(i, 20, "4");
                                            }
                                            Xls.SetCellValue(i, 8, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            Xls.SetCellValue(i, 9, dt.Rows[i - 2]["perName"].ToString());
                                            Xls.SetCellValue(i, 10, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                            //Xls.SetCellValue(i, 11, dt.Rows[i - 2]["pPay"].ToString());
                                            Xls.SetCellValue(i, 15, dt.Rows[i - 2]["fID"].ToString());
                                            Xls.SetCellValue(i, 16, dt.Rows[i - 2]["fName"].ToString());
                                            Xls.SetCellValue(i, 17, ROC_Date(dt.Rows[i - 2]["fBirth"].ToString()));
                                            //Xls.SetCellValue(i, 18, dt.Rows[i - 2]["fTitle"].ToString());
                                            Xls.SetCellValue(i, 21, ROC_Date(dt.Rows[i - 2]["ChangeDate"].ToString()));
                                            Xls.SetCellValue(i, 24, dt.Rows[i - 2]["ppEmployerRatio"].ToString());
                                            Xls.SetCellValue(i, 25, dt.Rows[i - 2]["ppLarboRatio"].ToString());
                                            //Xls.SetCellValue(i, 26, dt.Rows[i - 2]["ppChangeDate"].ToString());
                                        }
                                    }
                                }
                            }
                            break;
                        //三合一退保
                        case "02":
                            if (perGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/out_3in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += "退保三合一";
                                    dt = LH_Db.LH_3in1_out(perGv);
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "2");
                                            if (dt.Rows[i - 2]["plLaborNo"].ToString() != "")
                                                Xls.SetCellValue(i, 2, dt.Rows[i - 2]["plLaborNo"].ToString().Substring(0, (dt.Rows[i - 2]["plLaborNo"].ToString().Length - 1)));
                                            if (dt.Rows[i - 2]["plLaborNo"].ToString() != "")
                                                Xls.SetCellValue(i, 3, dt.Rows[i - 2]["plLaborNo"].ToString().Substring(dt.Rows[i - 2]["plLaborNo"].ToString().Length - 1, 1));
                                            Xls.SetCellValue(i, 4, dt.Rows[i - 2]["piCardNo"].ToString());
                                            //Xls.SetCellValue(i, 5, "2");
                                            Xls.SetCellValue(i, 6, "2");
                                            Xls.SetCellValue(i, 7, "1");
                                            //Xls.SetCellValue(i, 8, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            Xls.SetCellValue(i, 9, dt.Rows[i - 2]["perName"].ToString());
                                            Xls.SetCellValue(i, 10, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            //Xls.SetCellValue(i, 11, dt.Rows[i - 2]["pPay"].ToString());
                                            Xls.SetCellValue(i, 12, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                            Xls.SetCellValue(i, 13, "1");
                                            Xls.SetCellValue(i, 16, ROC_Date(dt.Rows[i - 2]["piChangeDate"].ToString()));
                                        }
                                    }
                                }
                            }
                            break;
                        //三合一保薪調整
                        case "03":
                            if (perGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/mod_3in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += "保薪調整三合一";
                                    dt = LH_Db.LH_3in1_mod(perGv);
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "3");
                                            if (dt.Rows[i - 2]["LaborID"].ToString() != "")
                                                Xls.SetCellValue(i, 2, dt.Rows[i - 2]["LaborID"].ToString().Substring(0, (dt.Rows[i - 2]["LaborID"].ToString().Length - 1)));
                                            if (dt.Rows[i - 2]["LaborID"].ToString() != "")
                                                Xls.SetCellValue(i, 3, dt.Rows[i - 2]["LaborID"].ToString().Substring(dt.Rows[i - 2]["LaborID"].ToString().Length - 1, 1));
                                            Xls.SetCellValue(i, 4, dt.Rows[i - 2]["GanborID"].ToString());
                                            Xls.SetCellValue(i, 7, dt.Rows[i - 2]["perName"].ToString());
                                            Xls.SetCellValue(i, 8, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            Xls.SetCellValue(i, 10, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                            Xls.SetCellValue(i, 11, dt.Rows[i - 2]["pay_avg"].ToString());
                                            Xls.SetCellValue(i, 12, dt.Rows[i - 2]["b_ganbor"].ToString());
                                            Xls.SetCellValue(i, 13, dt.Rows[i - 2]["pay_i4"].ToString());
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
                            if (perGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/add_2in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += "加保二合一";
                                    dt = LH_Db.LH_2in1_add(perGv);
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "2");
                                            if (dt.Rows[i - 2]["plLaborNo"].ToString() != "")
                                                Xls.SetCellValue(i, 3, dt.Rows[i - 2]["plLaborNo"].ToString().Substring(0, (dt.Rows[i - 2]["plLaborNo"].ToString().Length - 1)));
                                            if (dt.Rows[i - 2]["plLaborNo"].ToString() != "")
                                                Xls.SetCellValue(i, 4, dt.Rows[i - 2]["plLaborNo"].ToString().Substring(dt.Rows[i - 2]["plLaborNo"].ToString().Length - 1, 1));
                                            //Xls.SetCellValue(i, 5, dt.Rows[i - 2]["piCardNo"].ToString());
                                            Xls.SetCellValue(i, 6, dt.Rows[i - 2]["perName"].ToString());
                                            Xls.SetCellValue(i, 7, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            Xls.SetCellValue(i, 8, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                            Xls.SetCellValue(i, 15, dt.Rows[i - 2]["ppEmployerRatio"].ToString());
                                            Xls.SetCellValue(i, 16, dt.Rows[i - 2]["ppLarboRatio"].ToString());
                                        }
                                    }
                                }
                            }
                            break;
                        //二合一退保
                        case "02":
                            if (perGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/out_2in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += "退保二合一";
                                    dt = LH_Db.LH_2in1_out(perGv);
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "2");
                                            if (dt.Rows[i - 2]["plLaborNo"].ToString() != "")
                                                Xls.SetCellValue(i, 2, dt.Rows[i - 2]["plLaborNo"].ToString().Substring(0, (dt.Rows[i - 2]["plLaborNo"].ToString().Length - 1)));
                                            if (dt.Rows[i - 2]["plLaborNo"].ToString() != "")
                                                Xls.SetCellValue(i, 3, dt.Rows[i - 2]["plLaborNo"].ToString().Substring(dt.Rows[i - 2]["plLaborNo"].ToString().Length - 1, 1));
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
                            if (perGv != "")
                            {
                                fileSpec = context.Server.MapPath("~/Template/mod_2in1.xls");
                                using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                                {
                                    Xls.Open(fileSpec);
                                    FileName += "保薪調整二合一";
                                    dt = LH_Db.LH_3in1_mod(perGv);
                                    TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                    if (dt.Rows.Count > 0)
                                    {
                                        for (int i = 2; i < dt.Rows.Count + 2; i++)
                                        {
                                            Xls.SetCellValue(i, 1, "3");
                                            if (dt.Rows[i - 2]["LaborID"].ToString() != "")
                                                Xls.SetCellValue(i, 2, dt.Rows[i - 2]["LaborID"].ToString().Substring(0, (dt.Rows[i - 2]["LaborID"].ToString().Length - 1)));
                                            if (dt.Rows[i - 2]["LaborID"].ToString() != "")
                                                Xls.SetCellValue(i, 3, dt.Rows[i - 2]["LaborID"].ToString().Substring(dt.Rows[i - 2]["LaborID"].ToString().Length - 1, 1));
                                            //Xls.SetCellValue(i, 4, dt.Rows[i - 2]["GanborID"].ToString());
                                            Xls.SetCellValue(i, 5, dt.Rows[i - 2]["perName"].ToString());
                                            Xls.SetCellValue(i, 6, dt.Rows[i - 2]["perIDNumber"].ToString());
                                            Xls.SetCellValue(i, 8, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                            Xls.SetCellValue(i, 9, dt.Rows[i - 2]["pay_avg"].ToString());
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
                        if (perGv != "")
                        {
                            fileSpec = context.Server.MapPath("~/Template/pp_add.xls");
                            using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                            {
                                Xls.Open(fileSpec);
                                FileName += "勞退提繳";
                                dt = PP_Db.pp_add(perGv);
                                TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                if (dt.Rows.Count > 0)
                                {
                                    for (int i = 2; i < dt.Rows.Count + 2; i++)
                                    {
                                        if (dt.Rows[i - 2]["LaborCode"].ToString() != "")
                                            Xls.SetCellValue(i, 1, dt.Rows[i - 2]["LaborCode"].ToString().Substring(0, (dt.Rows[i - 2]["LaborCode"].ToString().Length - 1)));
                                        if (dt.Rows[i - 2]["LaborCode"].ToString() != "")
                                            Xls.SetCellValue(i, 2, dt.Rows[i - 2]["LaborCode"].ToString().Substring(dt.Rows[i - 2]["LaborCode"].ToString().Length - 1, 1));
                                        Xls.SetCellValue(i, 3, "4");
                                        Xls.SetCellValue(i, 4, dt.Rows[i - 2]["perName"].ToString());
                                        Xls.SetCellValue(i, 5, dt.Rows[i - 2]["perIDNumber"].ToString());
                                        Xls.SetCellValue(i, 6, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                        Xls.SetCellValue(i, 7, dt.Rows[i - 2]["InsLv"].ToString());
                                        Xls.SetCellValue(i, 9, dt.Rows[i - 2]["ppEmployerRatio"].ToString());
                                        Xls.SetCellValue(i, 11, dt.Rows[i - 2]["ppLarboRatio"].ToString());
                                    }
                                }
                            }
                        }
                        break;
                    //提繳工資調整
                    case "02":
                        if (perGv != "")
                        {
                            fileSpec = context.Server.MapPath("~/Template/pp_mod.xls");
                            using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                            {
                                Xls.Open(fileSpec);
                                FileName += "勞退提繳工資調整";
                                dt = PP_Db.pp_mod(perGv);
                                TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                if (dt.Rows.Count > 0)
                                {
                                    for (int i = 2; i < dt.Rows.Count + 2; i++)
                                    {
                                        if (dt.Rows[i - 2]["LaborCode"].ToString() != "")
                                            Xls.SetCellValue(i, 1, dt.Rows[i - 2]["LaborCode"].ToString().Substring(0, (dt.Rows[i - 2]["LaborCode"].ToString().Length - 1)));
                                        if (dt.Rows[i - 2]["LaborCode"].ToString() != "")
                                            Xls.SetCellValue(i, 2, dt.Rows[i - 2]["LaborCode"].ToString().Substring(dt.Rows[i - 2]["LaborCode"].ToString().Length - 1, 1));
                                        Xls.SetCellValue(i, 3, "4");
                                        Xls.SetCellValue(i, 4, dt.Rows[i - 2]["perName"].ToString());
                                        Xls.SetCellValue(i, 5, dt.Rows[i - 2]["perIDNumber"].ToString());
                                        Xls.SetCellValue(i, 6, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                        Xls.SetCellValue(i, 7, dt.Rows[i - 2]["ppPayPayroll"].ToString());
                                    }
                                }
                            }
                        }
                        break;
                    //停繳
                    case "03":
                        if (perGv != "")
                        {
                            fileSpec = context.Server.MapPath("~/Template/pp_stop.xls");
                            using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                            {
                                Xls.Open(fileSpec);
                                FileName += "勞退停繳";
                                dt = PP_Db.pp_stop(perGv);
                                TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                if (dt.Rows.Count > 0)
                                {
                                    for (int i = 2; i < dt.Rows.Count + 2; i++)
                                    {
                                        if (dt.Rows[i - 2]["LaborCode"].ToString() != "")
                                            Xls.SetCellValue(i, 1, dt.Rows[i - 2]["LaborCode"].ToString().Substring(0, (dt.Rows[i - 2]["LaborCode"].ToString().Length - 1)));
                                        if (dt.Rows[i - 2]["LaborCode"].ToString() != "")
                                            Xls.SetCellValue(i, 2, dt.Rows[i - 2]["LaborCode"].ToString().Substring(dt.Rows[i - 2]["LaborCode"].ToString().Length - 1, 1));
                                        Xls.SetCellValue(i, 3, "4");
                                        Xls.SetCellValue(i, 4, dt.Rows[i - 2]["perName"].ToString());
                                        Xls.SetCellValue(i, 5, dt.Rows[i - 2]["perIDNumber"].ToString());
                                        Xls.SetCellValue(i, 6, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
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
                        if (perGv != "")
                        {
                            fileSpec = context.Server.MapPath("~/Template/add_3in1.xls");
                            using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                            {
                                Xls.Open(fileSpec);
                                FileName += "眷屬加保三合一";
                                dt = FI_Db.FamilyHeal_3in1_add(perGv);
                                TXlsCellRange myRange = new TXlsCellRange("A2:Z2");
                                if (dt.Rows.Count > 0)
                                {
                                    for (int i = 2; i < dt.Rows.Count + 2; i++)
                                    {
                                        Xls.SetCellValue(i, 1, "4");
                                        if (dt.Rows[i - 2]["LaborID"].ToString() != "")
                                            Xls.SetCellValue(i, 2, dt.Rows[i - 2]["LaborID"].ToString().Substring(0, (dt.Rows[i - 2]["LaborID"].ToString().Length - 1)));
                                        if (dt.Rows[i - 2]["LaborID"].ToString() != "")
                                            Xls.SetCellValue(i, 3, dt.Rows[i - 2]["LaborID"].ToString().Substring(dt.Rows[i - 2]["LaborID"].ToString().Length - 1, 1));
                                        Xls.SetCellValue(i, 4, dt.Rows[i - 2]["GanborID"].ToString());
                                        Xls.SetCellValue(i, 5, "3");
                                        Xls.SetCellValue(i, 6, "2");
                                        Xls.SetCellValue(i, 20, "4");
                                        Xls.SetCellValue(i, 8, dt.Rows[i - 2]["perIDNumber"].ToString());
                                        Xls.SetCellValue(i, 9, dt.Rows[i - 2]["perName"].ToString());
                                        Xls.SetCellValue(i, 10, ROC_Date(dt.Rows[i - 2]["perBirthday"].ToString()));
                                        Xls.SetCellValue(i, 12, dt.Rows[i - 2]["InsLv"].ToString());
                                        Xls.SetCellValue(i, 15, dt.Rows[i - 2]["pfIDNumber"].ToString());
                                        Xls.SetCellValue(i, 16, dt.Rows[i - 2]["pfName"].ToString());
                                        Xls.SetCellValue(i, 17, ROC_Date(dt.Rows[i - 2]["pfBirthday"].ToString()));
                                        Xls.SetCellValue(i, 21, ROC_Date(dt.Rows[i - 2]["pfiChangeDate"].ToString()));
                                    }
                                }
                            }
                        }
                        break;
                }
            } //if category end

            string UpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"];
            if (!Directory.Exists(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\"))))//如果上傳路徑中沒有該目錄，則自動新增
            {
                Directory.CreateDirectory(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\")));
            }
            Xls.Save(System.IO.Path.Combine(ConfigurationManager.AppSettings["UploadFileRootDir"], FileName + ".xls"));
            context.Response.Write(FileName + ".xls");
        }
        catch (Exception ex) { context.Response.Write("error"); }
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