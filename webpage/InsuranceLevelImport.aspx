<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InsuranceLevelImport.aspx.cs" Inherits="webpage_InsuranceLevelImport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery-1.10.2.min.js") %>"></script>
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.blockUI.js") %>"></script>
    <script src="<%= ResolveUrl("~/js/jquery.datetimepicker.full.js") %>"></script>
    <link href="<%= ResolveUrl("~/css/jquery.datetimepicker.css") %>" rel="stylesheet" />
    
    <script type="text/javascript">
        $(document).ready(function () {
            //套用datetimepicker
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#import_date").datetimepicker({
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });

            $("#subbtn").click(function () {
                var exten = $("input[name='dataFile']").val().replace(/^.*\./, '');
                var PassExten = ["xls", "xlsx"];
                if ($.inArray(exten, PassExten) == -1) {
                    alert("請上傳Excel檔");
                    return;
                }
                if ($("#import_date").val()=="") {
                    alert("請選擇生效日期");
                }
                $("#loadblock").show();
                $("#infoblock").hide();
                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var form = $("form")[0];
                var textdate = document.createElement('input');

                textdate.setAttribute("id", "textdate");
                textdate.setAttribute("name", "textdate");
                textdate.setAttribute("value", $("#import_date").val());
                textdate.setAttribute("style", "display: none");

                form.appendChild(iframe[0]);
                form.appendChild(textdate);

                form.setAttribute("action", "../handler/InsuranceLevelImport.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });
        });

        function feedbackFun(str) {
            var str_split = str.split(",");
            var msg = str_split[0];
            var str_date = str_split[1];
            alert(msg);
            parent.$.fancybox.close();
            if (str_date!="nodate") {
                parent.setReflash(str_date);
            }
        }
    </script>
    <title></title>
</head>
<body style="height:270px;">
    <form id="form1" runat="server">
        <div id="infoblock">
            <div>匯入格式範例檔下載：<a href="../Excel_sample/投保級距匯入範例.xlsx">下載連結</a></div><br />
            <div id="fileblock">
                <div>
                    <span style="color:red;">生效日期：</span>
                    <span><input type="text" id="import_date" maxlength="10" /></span>
                </div>
                <br />
                <span style="color:red;">請選擇檔案：</span><input type="file" id="dataFile" name="dataFile" />&nbsp;<input class="keybtn" id="subbtn" type="button" value="確認" />
            </div>
        </div>
        <div id="loadblock" style="display: none; text-align: center;">
            <img src="../images/loading.gif" />處理中，請稍待
        </div>
    </form>
</body>
</html>
