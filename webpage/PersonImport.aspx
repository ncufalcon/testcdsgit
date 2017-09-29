<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PersonImport.aspx.cs" Inherits="webpage_PersonImport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<script type="text/javascript" src="<%= ResolveUrl("~/js/jquery-1.10.2.min.js") %>"></script>
<script type="text/javascript" src="<%= ResolveUrl("~/js/downfile.js") %>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
            switch($.getParamValue('tp')) {
                case "Person":
                    $("#downSample").attr("href", "../Template/PersonnelInfo.xlsx");
                    break;
                case "LH_Compare":
                    $("#downSample").attr("href", "../Template/LH_Compare.xlsx");
                    $("#srTr").show();
                    Getddl_SalaryRange();
                    break;
            }

            $("#subbtn").click(function () {
                if ($("input[name='dataFile']").val() == "") {
                    alert("請選擇檔案");
                    return false;
                }

                var exten = $("input[name='dataFile']").val().replace(/^.*\./, '');
                var PassExten = ["xls", "xlsx"];
                if ($.inArray(exten, PassExten) == -1) {
                    alert("請上傳Excel檔");
                    return false
                }

                if ($.getParamValue('tp') == "LH_Compare" && $("#ddl_SalaryRange").val() == "") {
                    alert("請選擇計薪週期");
                    return false;
                }

                $("#loadblock").show();
                $("#fileblock").hide();
               
                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var form = $("form")[0];

                form.appendChild(iframe[0]);
                switch ($.getParamValue('tp')) {
                    case "Person":
                        form.setAttribute("action", "../handler/PersonImport.ashx");
                        break;
                    case "LH_Compare":
                        form.setAttribute("action", "../handler/LHCompImport.ashx");
                        break;
                }
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });
        });

        //DDL
        function Getddl_SalaryRange() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/ddlSalaryRange.ashx",
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("ddlSalaryRange Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#ddl_SalaryRange").empty();
                        var ddlstr = '<option value="">-----------請選擇-----------</option>';
                        if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                ddlstr += '<option value="' + $(this).children("sr_BeginDate").text() + ',' + $(this).children("sr_Enddate").text() + '">' + $(this).children("sr_BeginDate").text() + " - " + $(this).children("sr_Enddate").text() + '</option>';
                            });
                        }
                        $("#ddl_SalaryRange").append(ddlstr);
                    }
                }
            });
        }

        function feedbackFun(msg) {
            switch ($.getParamValue('tp')) {
                case "Person":
                    if (msg == "LoginFailed") {
                        alert("請重新登入");
                        parent.location.href = "../webpage/Page-Login.aspx";
                    }
                    else {
                        $("#loadblock").hide();
                        $("#consoleStr").show();
                        $("#consoleStr").append(decodeURIComponent(msg) + '<div style="text-align:right;"><input type="button" value="關閉" class="keybtn" onclick="javascript:parent.$.fancybox.close();" /></div>');
                    }
                    break;
                case "LH_Compare":
                    if (msg == "LoginFailed") {
                        alert("請重新登入");
                        parent.location.href = "../webpage/Page-Login.aspx";
                    }
                    else {
                        alert(msg);
                        parent.$.fancybox.close();
                    }
                    break;
            }
        }
    </script>
    <style>.keybtn{background:url(../images/BginfoBtnOut.gif) repeat-x bottom #ffdd98; border:1px solid #ffdd98; padding:5px 15px;*padding:5px;_padding:5px;color:#87712e; font-size:15px; margin:0px 2px;-webkit-border-radius:8px;-moz-border-radius:8px;border-radius:8px;font-weight:bold;text-decoration:none;}</style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="fileblock">
        <table width="100%">
            <tr>
                <td align="right">請選擇檔案：</td>
                <td><input type="file" id="dataFile" name="dataFile" />&nbsp;<input class="keybtn" id="subbtn" type="button" value="確認" /></td>
            </tr>
            <tr id="srTr" style="display:none;"><td align="right">計薪週期：</td><td><select id="ddl_SalaryRange" name="ddl_SalaryRange"></select></td></tr>
            <tr><td></td><td><a id="downSample">範本下載</a></td></tr>
        </table>
    </div>
    <div id="loadblock" style="display:none; text-align:center;"><img src="../images/loading.gif" />處理中，請稍待</div>
    <div id="consoleStr" style="display:none;"></div>
    </form>
</body>
</html>
