<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InsertImage.aspx.cs" Inherits="tinymce_js_tinymce_plugins_jbimages_InsertImage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../compat3x/tiny_mce_popup.js" type="text/javascript"></script>
    <script src="jquery-1.7.2.min.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#okbtn").click(function () {
                
                    var data = $("form")[0];
                    var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');

                    $("#postiframe").remove();

                    data.appendChild(iframe[0]);

                    data.setAttribute("action", "ImageUpload.ashx");
                    data.setAttribute("method", "post");
                    data.setAttribute("enctype", "multipart/form-data");
                    data.setAttribute("encoding", "multipart/form-data");
                    data.setAttribute("target", "postiframe");
                    data.submit();

            });

            $("#cancelbtn").click(function () {
                tinyMCEPopup.close();
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
                tinyMCEPopup.execCommand('mceInsertContent', false, ReturnValue);
                tinyMCEPopup.close();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center">
            <tr><td style="font-size:small; color:Green;">請選擇圖片 .JPG、.PNG、.BMP</td></tr>
            <tr>
                <td><input type="file" id="myfile" name="myfile" /></td>
            </tr>
             <tr>
                <td align="right"><br /><input type="button" id="okbtn" value="確定" /><input type="button" id="cancelbtn" value="取消" /></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
