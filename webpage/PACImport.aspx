<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PACImport.aspx.cs" Inherits="webpage_PACImport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery-1.10.2.min.js") %>"></script>
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.blockUI.js") %>"></script>
    <link href="../css/jquery.datetimepicker.css" rel="stylesheet" />
    <script src="../js/jquery.datetimepicker.full.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#import_changedate").datetimepicker({
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            $("#subbtn").click(function () {
                if ($("#import_changedate").val() == "") {
                    alert("請選擇異動日期");
                    return;
                }
                if ($("#import_change_siRef").val()=="") {
                    alert("請選擇異動項目");
                    return;
                }
                if ($("#dataFile").val()=="") {
                    alert("請選擇要匯入的檔案");
                    return;
                }
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
                var textdate = document.createElement('input');
                var textsiref = document.createElement('input');

                textdate.setAttribute("id", "textdate");
                textdate.setAttribute("name", "textdate");
                textdate.setAttribute("value", $("#import_changedate").val());
                textdate.setAttribute("style", "display: none");

                textsiref.setAttribute("id", "textsiref");
                textsiref.setAttribute("name", "textsiref");
                textsiref.setAttribute("value", $("#import_change_siRef").val());
                textsiref.setAttribute("style", "display: none");

                form.appendChild(iframe[0]);
                form.appendChild(textdate);
                form.appendChild(textsiref);

                form.setAttribute("action", "../handler/PACImport.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });
        });

        function feedbackFun(msg) {
            alert(msg);
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
<body style="width:430px;height:280px;">
    <form id="form1" runat="server">
        <div id="txtBlock">
            <div style="color:#8b3c31;">人事資料管理 / 異動管理 / 批次匯入</div><br />
            <div><span style="color:red;">異動日期：</span><input type="text" id="import_changedate" /></div><br />
            <div>
                <span style="color:red;">異動項目：</span>
                <select id="import_change_siRef">
                    <option value="01">底薪</option>
                    <option value="02">職能加給</option>
                </select>
            </div><br />
            <div id="fileblock">
                <span style="color:red;">請選擇檔案：</span><input type="file" id="dataFile" name="dataFile" />&nbsp;<input class="keybtn" id="subbtn" type="button" value="確認" />
            </div><br />
            <div>匯入格式範例檔下載：<a href="../Excel_sample/薪資異動批次匯入範例檔.xlsx">下載連結</a></div><br />

            <div id="loadblock" style="display: none; text-align: center;">
                <img src="../images/loading.gif" />處理中，請稍待
            </div>
        </div>
        
    </form>
</body>
</html>
