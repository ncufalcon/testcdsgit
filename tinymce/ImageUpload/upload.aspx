<%@ Page Language="C#" AutoEventWireup="true" CodeFile="upload.aspx.cs" Inherits="tinymce_ImageUpload_upload" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<script src="jquery-1.11.2.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#okbtn").click(function () {
                var data = $("form")[0];
                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');

                $("#postiframe").remove();

                data.appendChild(iframe[0]);

                data.setAttribute("action", "imgUpload.ashx");
                data.setAttribute("method", "post");
                data.setAttribute("enctype", "multipart/form-data");
                data.setAttribute("encoding", "multipart/form-data");
                data.setAttribute("target", "postiframe");
                data.submit();

            });
        });

        function feedbackFun(msg) {
            var form = document.body.getElementsByTagName('form')[0];
            form.target = '';
            form.method = "post";
            form.enctype = "application/x-www-form-urlencoded";
            form.encoding = "application/x-www-form-urlencoded";
            form.action = location;

            if (msg == "FormatError") {
                alert("檔案格式錯誤");
            }
            else if (msg.indexOf("Error").length > 0) {
                alert(msg);
            }
            else {
                var ReturnValue = '<img src="' + msg + '" />';
                top.tinymce.activeEditor.insertContent(ReturnValue);
                top.tinymce.activeEditor.windowManager.close();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table width="100%">
                <tr>
                    <td>附檔名限制<span style="color: red;"> .jpg、.png、.bmp</span></td>
                </tr>
                <tr>
                    <td><input type="file" id="myfile" name="myfile" /></td>
                </tr>
                <tr>
                    <td align="right"><input type="button" id="okbtn" value="確定" /></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
