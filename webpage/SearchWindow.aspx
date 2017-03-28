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
                        parent.setReturnValue($.getParamValue('v'), $(this).attr("gv"), $(this).attr("str"));
                        parent.$.fancybox.close();
                        break;
                    case "Personnel":
                        parent.setReturnValue($(this).attr("gv"), $(this).attr("pno"), $(this).attr("pname"));
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
                    type: $.getParamValue('v')
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
                                if ($(data).find("comp_item").length > 0) {
                                    $(data).find("comp_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("comGuid").text() + ' str=' + $(this).children("comAbbreviate").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("comName").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("comAbbreviate").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("comUniform").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "Dep":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">代碼</th>';
                                tabstr += '<th nowrap="nowrap">分店</th>';
                                tabstr += '<th nowrap="nowrap">說明</th>';
                                tabstr += '</tr>';
                                if ($(data).find("dep_item").length > 0) {
                                    $(data).find("dep_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("cbGuid").text() + ' str=' + $(this).children("cbValue").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("cbValue").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("cbName").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("cbDesc").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "Family":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">補助代碼</th>';
                                tabstr += '<th nowrap="nowrap">補助身分說明</th>';
                                tabstr += '</tr>';
                                if ($(data).find("a_item").length > 0) {
                                    $(data).find("a_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("slGuid").text() + ' str=' + $(this).children("slSubsidyCode").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("slSubsidyCode").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("slSubsidyIdentity").text() + '</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "Allowance":
                                var tabstr = '<tr>';
                                tabstr += '<th nowrap="nowrap">項目代碼</th>';		
                                tabstr += '<th nowrap="nowrap">項目名稱</th>';
                                tabstr += '<th nowrap="nowrap">加/扣項</th>';
                                tabstr += '</tr>';
                                if ($(data).find("a_item").length > 0) {
                                    $(data).find("a_item").each(function (i) {
                                        tabstr += '<tr gv=' + $(this).children("siGuid").text() + ' str=' + $(this).children("siItemCode").text() + '>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("siItemCode").text() + '</td>';
                                        tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("siItemName").text() + '</td>';
                                        if ($(this).children("siAdd").text()=="01")
                                            tabstr += '<td nowrap="nowrap" style="cursor: pointer;">加項</td>';
                                       else
                                            tabstr += '<td nowrap="nowrap" style="cursor: pointer;">扣項</td>';
                                        tabstr += '</tr>';
                                    });
                                }
                                $("#sarchTab").append(tabstr);
                                PageFun(p, $("total", data).text());
                                break;
                            case "Personnel":
                                    var tabstr = '<tr>';
                                    tabstr += '<th nowrap="nowrap">員工編號</th>';
                                    tabstr += '<th nowrap="nowrap">員工姓名</th>';
                                    tabstr += '<th nowrap="nowrap">公司別</th>';
                                    tabstr += '<th nowrap="nowrap">部門</th>';
                                    tabstr += '<th nowrap="nowrap">職務</th>';
                                    tabstr += '</tr>';
                                    if ($(data).find("p_item").length > 0) {
                                        $(data).find("p_item").each(function (i) {
                                            tabstr += '<tr gv=' + $(this).children("perGuid").text() + ' pno=' + $(this).children("perNo").text() + ' pname=' + $(this).children("perName").text() + '>';
                                            tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perNo").text() + '</td>';
                                            tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perName").text() + '</td>';
                                            tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("comAbbreviate").text() + '</td>';
                                            tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("cbName").text() + '</td>';
                                            tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("code_desc").text() + '</td>';
                                            tabstr += '</tr>';
                                        });
                                    }
                                    $("#sarchTab").append(tabstr);
                                    PageFun(p, $("total", data).text());
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
