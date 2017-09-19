<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SearchWindow.aspx.cs" Inherits="webpage_SearchWindow" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery-1.10.2.min.js") %>"></script>
<script type="text/javascript" src="<%= ResolveUrl("~/js/downfile.js") %>"></script>
<script type="text/javascript" src="<%= ResolveUrl("~/js/Pager.js") %>"></script>
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
            getData(0);

            $(document).on("click", "#sarchTab tr", function () {
                switch ($.getParamValue('v')) {
                    default:
                        parent.setReturnValue($.getParamValue('v'), $(this).attr("gv"), $(this).attr("str"), $(this).attr("str2"));
                        parent.$.fancybox.close();
                        break;
                    case "LInsPerson":
                    case "HInsPerson":
                    case "PPInsPerson":
                    case "PFInsPerson":
                    case "PGInsPerson":
                        parent.setReturnValue($.getParamValue('v'), $(this).attr("gv"), $(this).attr("str"), $(this).attr("str2"), $(this).attr("str3"));
                        parent.$.fancybox.close();
                        break;
                    case "PFInsFname":
                    case "PGInsFname":
                        parent.setReturnValue($.getParamValue('v'), $(this).attr("gv"), $(this).attr("str"), $(this).attr("str2"), $(this).attr("str3"), $(this).attr("str4"));
                        parent.$.fancybox.close();
                        break;
                    case "SiItem":
                        parent.setReturnValue($.getParamValue('v'), $(this).attr("gv"), $(this).attr("str"), $(this).attr("str2"), $(this).attr("str3"), $(this).attr("str4"));
                        parent.$.fancybox.close();
                        break;
                    case "Branches":
                        parent.setReturnValue($.getParamValue('v'), $(this).attr("gv"), $(this).attr("str"), $(this).attr("str2"), $(this).attr("str3"), $(this).attr("str4"));
                        parent.$.fancybox.close();
                        break;
                    case "CityBankSR":
                        parent.setReturnValue($.getParamValue('v'), $(this).attr("gv"), $(this).attr("str"), $(this).attr("str2"), $(this).attr("str3"), $(this).attr("str4"));
                        parent.$.fancybox.close();
                        break;
                    case "SalaryRange":
                        parent.setReturnValue($.getParamValue('v'), $(this).attr("gv"), $(this).attr("str"), $(this).attr("str2"), $(this).attr("str3"), $(this).attr("str4"));
                        parent.$.fancybox.close();
                        break;
                        
                }
            });
        });

        function getData(p) {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/SearchDialog.ashx",
                data: {
                    CurrentPage: p,
                    SearchStr: $("#SearchStr").val(),
                    type: $.getParamValue('v'),
                    perguid: $.getParamValue('pgv')
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("SearchDialog Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#sarchTab").empty();
                        switch ($.getParamValue('v')) {
                            case "Comp":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">申報公司</th>';
                                tabstr += '<th nowrap="nowrap">工司名稱</th>';
                                tabstr += '<th nowrap="nowrap">統一編號</th>';
                                tabstr += '</tr>';
                                if ($(data).find("data_item").length > 0) {
                                    $(data).find("data_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("comGuid").text() + ' str=' + $(this).children("comAbbreviate").text() + ' str2=' + $(this).children("comAbbreviate").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("comName").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("comAbbreviate").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("comUniform").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                else
                                    tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "Dep":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">代碼</th>';
                                tabstr += '<th nowrap="nowrap">分店</th>';
                                tabstr += '<th nowrap="nowrap">說明</th>';
                                tabstr += '</tr>';
                                if ($(data).find("data_item").length > 0) {
                                    $(data).find("data_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("cbGuid").text() + ' str=' + $(this).children("cbValue").text() + ' str2=' + $(this).children("cbName").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("cbValue").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("cbName").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("cbDesc").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                else
                                    tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "Family":
                            case "LB":
                            case "Heal":
                            case "LaborSL":
                            case "HealSL":
                            case "PFInsSL":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">補助代碼</th>';
                                tabstr += '<th nowrap="nowrap">補助身分說明</th>';
                                tabstr += '</tr>';
                                if ($(data).find("data_item").length > 0) {
                                    $(data).find("data_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("slGuid").text() + ' str=' + $(this).children("slSubsidyCode").text() + ' str2=' + $(this).children("slSubsidyIdentity").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("slSubsidyCode").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("slSubsidyIdentity").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                else
                                    tabstr += '<tr><td colspan="2">查詢無資料</td></tr>';
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "Allowance":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">項目代碼</th>';
                                tabstr += '<th nowrap="nowrap">項目名稱</th>';
                                tabstr += '<th nowrap="nowrap">加/扣項</th>';
                                tabstr += '</tr>';
                                if ($(data).find("data_item").length > 0) {
                                    $(data).find("data_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("siGuid").text() + ' str=' + $(this).children("siItemCode").text() + ' str2=' + $(this).children("siItemName").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("siItemCode").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("siItemName").text() + '</td>';
                                        if ($(this).children("siAdd").text() == "01")
                                            tabstr += '<td nowrap="nowrap" style="cursor: pointer;">加項</td>';
                                        else
                                            tabstr += '<td nowrap="nowrap" style="cursor: pointer;">扣項</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                else
                                    tabstr += '<tr><td colspan="3">查詢無資料</td></tr>';
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "PLv":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap" rowspan="2">身分代碼</th>';
                                tabstr += '<th nowrap="nowrap" rowspan="2">身分名稱</th>';
                                tabstr += '<th nowrap="nowrap" colspan="5">投保項目</th>';
                                tabstr += '<th nowrap="nowrap" rowspan="2">勞退雇主提撥率(%)</th>';
                                tabstr += '</tr><tr>';
                                tabstr += '<th nowrap="nowrap">普通事故</th>';
                                tabstr += '<th nowrap="nowrap">就業保險</th>';
                                tabstr += '<th nowrap="nowrap">職災保險</th>';
                                tabstr += '<th nowrap="nowrap">墊償基金</th>';
                                tabstr += '<th nowrap="nowrap">健保</th>';
                                tabstr += '</tr>';
                                if ($(data).find("data_item").length > 0) {
                                    $(data).find("data_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("iiGuid").text() + ' str=' + $(this).children("iiIdentityCode").text() + ' str2=' + $(this).children("iiIdentity").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("iiIdentityCode").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("iiIdentity").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("iiInsurance1").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("iiInsurance2").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("iiInsurance3").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("iiInsurance4").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("iiInsurance5").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("iiRetirement").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                else
                                    tabstr += '<tr><td colspan="8">查詢無資料</td></tr>';
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "Personnel":
                            case "Personnel2":
                            case "LInsPerson":
                            case "HInsPerson":
                            case "PPInsPerson":
                            case "PFInsPerson":
                            case "PGInsPerson":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">員工編號</th>';
                                tabstr += '<th nowrap="nowrap">員工姓名</th>';
                                tabstr += '<th nowrap="nowrap">公司別</th>';
                                tabstr += '<th nowrap="nowrap">部門</th>';
                                tabstr += '<th nowrap="nowrap">職務</th>';
                                tabstr += '</tr>';
                                if ($(data).find("data_item").length > 0) {
                                    $(data).find("data_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("perGuid").text() + ' str=' + $(this).children("perNo").text() + ' str2=' + $(this).children("perName").text() + ' str3=' + $(this).children("cbName").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perNo").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perName").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("comAbbreviate").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("cbName").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("code_desc").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                else
                                    tabstr += '<tr><td colspan="5">查詢無資料</td></tr>';
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "PFInsFname":
                            case "PGInsFname":
                                var tabstr = '<tr>';
                                if ($.getParamValue('pgv') == "") {
                                    tabstr += '<td nowrap="nowrap">請先輸入員工代號！</td></tr>';
                                }
                                else {
                                    tabstr += '<th nowrap="nowrap">眷屬姓名</th>';
                                    tabstr += '<th nowrap="nowrap">眷屬身分證號</th>';
                                    tabstr += '<th nowrap="nowrap">眷屬生日</th>';
                                    tabstr += '<th nowrap="nowrap">稱謂</th>';
                                    tabstr += '</tr>';
                                    if ($(data).find("data_item").length > 0) {
                                        $(data).find("data_item").each(function (i) {
                                            if ($(data).find("data_item").length == 1 && $(this).children("pfGuid").text().trim() == "")
                                                tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
                                            else {
                                                tabstr += '<tr gv=' + $(this).children("pfGuid").text() + ' str=' + $(this).children("pfName").text() + ' str2=' + $(this).children("pfIDNumber").text() +
                                                    ' str3=' + $(this).children("pfBirthday").text() + ' str4=' + $(this).children("pfTitle").text() + '>';
                                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfName").text() + '</td>';
                                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfIDNumber").text() + '</td>';
                                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfBirthday").text() + '</td>';
                                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfTitle").text() + '</td>';
                                                tabstr += '</tr>';
                                            }
                                        });
                                    }
                                }
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "PG_IC":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">保險代號</th>';
                                tabstr += '<th nowrap="nowrap">保險項目名稱</th>';
                                tabstr += '<th nowrap="nowrap">承保年齡上限</th>';
                                tabstr += '</tr>';
                                if ($(data).find("data_item").length > 0) {
                                    $(data).find("data_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("giGuid").text() + ' str=' + $(this).children("giInsuranceCode").text() + ' str2=' + $(this).children("giInsuranceName").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("giInsuranceCode").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("giInsuranceName").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("giAge").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                else
                                    tabstr += '<tr><td colspan="3">查詢無資料</td></tr>';
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "SiItem":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">項目代碼</th>';
                                tabstr += '<th nowrap="nowrap">項目名稱</th>';
                                tabstr += '</tr>';
                                if ($(data).find("data_item").length > 0) {
                                    $(data).find("data_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("siGuid").text() + ' str=' + $(this).children("siItemCode").text() + ' str2=' + $(this).children("siItemName").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("siItemCode").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("siItemName").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                else
                                    tabstr += '<tr><td colspan="3">查詢無資料</td></tr>';
                                $("#sarchTab").append(tabstr);
                                //PageFun(p, $("total", data).text());
                                break;
                            case "SalaryRange":
                            case "CityBankSR":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">年度</th>';
                                tabstr += '<th nowrap="nowrap">週期起</th>';
                                tabstr += '<th nowrap="nowrap">週期迄</th>';
                                tabstr += '<th nowrap="nowrap">發薪日</th>';
                                tabstr += '</tr>';
                                if ($(data).find("data_item").length > 0) {
                                    $(data).find("data_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("sr_Guid").text() + ' str=' + $(this).children("sr_BeginDate").text() + ' str2=' + $(this).children("sr_Enddate").text() + ' str3=' + $(this).children("sr_Year").text() + ' str4=' + $(this).children("sr_SalaryDate").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("sr_Year").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("sr_BeginDate").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("sr_Enddate").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("sr_SalaryDate").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                else
                                    tabstr += '<tr><td colspan="3">查詢無資料</td></tr>';
                                $("#sarchTab").append(tabstr);
                                break;
                        }
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                    }
                }
            });
        }

        var nowPage = 0; //當前頁
        var listNum = 10; //每頁顯示個數
        var PagesLen; //總頁數 
        var PageNum = 4; //下方顯示分頁數(PageNum+1個)
        function PageFun(PageNow, TotalItem) {
            //Math.ceil -> 無條件進位
            PagesLen = Math.ceil(TotalItem / listNum);
            if (PagesLen <= 1)
                $("#changpage").hide();
            else {
                $("#changpage").show();
                upPage(PageNow, TotalItem);
            }
        }
    </script>
</head>
    <style>
        .stripeMe table{border-collapse:collapse;}
        .stripeMe td{padding:5px; border-collapse:collapse; border:1px solid #8f7c66; border-left-color:#d6d0c9;border-right-color:#d6d0c9; border-bottom-color:#d6d0c9; background-color:#f7f5f2;}
        .stripeMe th{color:#242424; padding:8px; border-collapse:collapse; border:1px solid #8f7c66;border-left-color:#bcb0a1;border-right-color:#bcb0a1; background:#d4c8b9;}
        .stripeMe tr td:first-child{border-left-color:#8f7c66;}
        .stripeMe tr th:first-child{border-left-color:#8f7c66;}
        .stripeMe tr td:last-child{border-right-color:#8f7c66;}
        .stripeMe tr th:last-child{border-right-color:#8f7c66;}
        .stripeMe tr:last-child td{border-bottom-color:#8f7c66;}
        .stripeMe tr.alt td {background-color:#ebe4de;}
        .stripeMe tr.over td { background-color:#fff;}
        .stripeMe tr.total td { background-color:#FEEEB6}
        .stripeMe tr td.total { background-color:#FEEEB6}
        .keybtn{background:url(../images/BginfoBtnOut.gif) repeat-x bottom #ffdd98; border:1px solid #ffdd98; padding:5px 15px;*padding:5px;_padding:5px;color:#87712e; font-size:15px; margin:0px 2px;-webkit-border-radius:8px;-moz-border-radius:8px;border-radius:8px;font-weight:bold;text-decoration:none;}
    </style>
<body>
    <form id="form1" runat="server">
    <div>關鍵字：<input type="text" id="SearchStr" />&nbsp;<input type="button" value="查詢" onclick="getData(0)" class="keybtn" /></div><br />
    <div class="stripeMe">
        <table id="sarchTab" width="100%" border="0" cellspacing="0" cellpadding="0"></table>
    </div><br />
    <div id="changpage" style="text-align:center;"></div>
    </form>
</body>
</html>
