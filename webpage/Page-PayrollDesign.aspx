<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page-PayrollDesign.aspx.cs" Inherits="webpage_Page_PayrollDesign" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>CDS薪資管理系統</title>
    <link href="../css/myITRIproject/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
    <link href="../css/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
    <link href="../css/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/noheader.css" rel="stylesheet" type="text/css" />
    <link href="../css/jquery.datepick.css" rel="stylesheet" />

    <script type="text/javascript" src="../js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="../js/jquery-ui-1.10.2.custom.min.js"></script>
    <script type="text/javascript" src="../js/navigation.js"></script><!-- 下拉選單 -->
    <script type='text/javascript' src='../js/jquery.fancybox.pack.js'></script><!-- fancybox -->
    <script type="text/javascript" src="../js/jquery.mCustomScrollbar.concat.min.js"></script><!-- 捲軸美化 -->
    <script type="text/javascript" src="../js/tableHeadFixer.js"></script>
    <script type="text/javascript" src="../js/GCommon.js"></script>
    <script type="text/javascript" src="../js/CmFmCommon.js"></script>
    <script type="text/javascript" src="../js/TableSorting.js"></script>
    <script type="text/javascript" src="../js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../js/jquery.datepick.js"></script>
    <script type="text/javascript" src="../js/downfile.js"></script>
    <link href="../css/jquery.datetimepicker.css" rel="stylesheet" />
    <script src="../js/jquery.datetimepicker.full.js"></script>
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


        <textarea id="tea" rows="40" cols="120"></textarea>





    
    </div>
    </form>
</body>
</html>
