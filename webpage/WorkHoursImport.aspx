<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkHoursImport.aspx.cs" Inherits="webpage_WorkHoursImport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery-1.10.2.min.js") %>"></script>
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.blockUI.js") %>"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#subbtn").click(function () {
                if ($("#dataFile").val() == "") {
                    alert("請選擇要匯入的檔案");
                    return;
                }
                //parent.$(".fancybox-close").attr("disabled", "disabled");//匯入過程中不能關fancybox
                //parent.$.blockUI({ message: '<img src="../images/loading.gif" />' });
                var exten = $("input[name='dataFile']").val().replace(/^.*\./, '');
                var PassExten = ["xls", "xlsx"];
                if ($.inArray(exten, PassExten) == -1) {
                    alert("請上傳Excel檔");
                    return;
                }
                $("#loadblock").show();
                $("#txtBlock").hide();
                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var form = $("form")[0];

                form.appendChild(iframe[0]);

                form.setAttribute("action", "../handler/WorkHoursImport.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });
        });

        function feedbackFun(msg) {
            alert(msg);
            parent.$.unblockUI();
            parent.$.fancybox.close();
            parent.setReflash();
        }
    </script>
    <style>
        .keybtn {
            background: url(../images/BginfoBtnOut.gif) repeat-x bottom #ffdd98;
            border: 1px solid #ffdd98;
            padding: 5px 15px;
            *padding: 5px;
            _padding: 5px;
            color: #87712e;
            font-size: 15px;
            margin: 0px 2px;
            -webkit-border-radius: 8px;
            -moz-border-radius: 8px;
            border-radius: 8px;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="txtBlock">
            <div style="color: #8b3c31;">出勤管理 / 時數管理 / 匯入工作時數</div>
            <br />
            <div id="fileblock">
                <span style="color: red;">請選擇檔案：</span><input type="file" id="dataFile" name="dataFile" />&nbsp;<input class="keybtn" id="subbtn" type="button" value="確認" />
            </div>
            <br />
            <!--<div>匯入格式範例檔下載：<a href="../Excel_sample/薪資異動批次匯入範例檔.xlsx">下載連結</a></div>
            <br />-->
        </div>
        <div id="loadblock" style="display: none; text-align: center;">
                <img src="../images/loading.gif" />處理的資料較多，需較長時間，請稍待...
            </div>
    </form>
</body>
</html>
