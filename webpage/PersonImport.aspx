<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PersonImport.aspx.cs" Inherits="webpage_PersonImport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<script type="text/javascript" src="<%= ResolveUrl("~/js/jquery-1.10.2.min.js") %>"></script>
<script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.blockUI.js") %>"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
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

                $("#loadblock").show();
                $("#fileblock").hide();
               
                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var form = $("form")[0];

                form.appendChild(iframe[0]);

                form.setAttribute("action", "../handler/PersonImport.ashx");
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
        }
    </script>
    <style>.keybtn{background:url(../images/BginfoBtnOut.gif) repeat-x bottom #ffdd98; border:1px solid #ffdd98; padding:5px 15px;*padding:5px;_padding:5px;color:#87712e; font-size:15px; margin:0px 2px;-webkit-border-radius:8px;-moz-border-radius:8px;border-radius:8px;font-weight:bold;text-decoration:none;}</style>
</head>
<body style="height: 80px; line-height: 80px; text-align: center;">
    <form id="form1" runat="server">
    <div id="fileblock">
        請選擇檔案：<input type="file" id="dataFile" name="dataFile" />&nbsp;<input class="keybtn" id="subbtn" type="button" value="確認" />
    </div>
    <div id="loadblock" style="display:none; text-align:center;"><img src="../images/loading.gif" />處理中，請稍待</div>
    </form>
</body>
</html>
