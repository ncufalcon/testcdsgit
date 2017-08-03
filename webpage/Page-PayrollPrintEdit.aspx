<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page-PayrollPrintEdit.aspx.cs" Inherits="webpage_Page_PayrollPrintEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../js/jquery-1.11.2.min.js"></script>
    <script src="../tinymce/tinymce.min.js" type="text/javascript"></script>


    

<script type="text/javascript">
    tinymce.init({
        selector: "textarea",
        language: "zh_TW",
        //menubar: false, //上方工具列顯示or隱藏
        file_browser_callback: function (field_name, url, type, win) {
            if (type == "image") {
                tinymce.activeEditor.windowManager.close();
                tinymce.activeEditor.windowManager.open({
                    title: "圖片上傳",
                    url: '<%= ResolveUrl("~/tinymce/ImageUpload/upload.aspx") %>',
                    width: 300,
                    height: 120
                });
            }
        },
        plugins: ["advlist autolink lists image link charmap print preview searchreplace visualblocks code fullscreen insertdatetime table contextmenu paste pagebreak textcolor image"],
        font_formats: "新細明體=新細明體;標楷體=標楷體;微軟正黑體=微軟正黑體;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Comic Sans MS=comic sans ms,sans-serif;Times New Roman=times new roman,times;",
        pagebreak_separator: "<!--pagebreak-->",
        image_advtab: true, //圖片進階選項
        relative_urls: false,
        remove_script_host: false,
        convert_urls: true,
        toolbar1: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link pagebreak table image | forecolor backcolor | fontselect fontsizeselect"
    });
</script>
</head>
<body>
    <form id="form1" runat="server">
    <div> 


                    <textarea id="tex_designContent" rows="800" cols="50" style="height:500px; width:500px;z-index:100000"  >

                    </textarea>
    </div>
    </form>
</body>
</html>
