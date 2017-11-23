<%@ Page Language="C#" AutoEventWireup="true" CodeFile="print.aspx.cs" Inherits="webpage_print" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style>

        .stripeMenoline table{border-collapse:collapse; border:0}
        .stripeMenoline th{border-collapse:collapse; border:0; padding:0px;}
        .stripeMenoline td{border-collapse:collapse; border:0; padding:0px;}

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>

        <div><input type="button" value="列印" onclick="printpage()"  /></div>
        <div id="div_show" runat="server">

        </div>

    
    </div>
    </form>

 <script type="text/javascript">   
function printpage(){

    var newstr = document.getElementById('<%=div_show.ClientID%>').innerHTML;
    //alert(newstr);
    var oldstr = document.body.innerHTML;
    document.body.innerHTML = newstr;
    window.print();
    document.body.innerHTML = oldstr;
}
</script>
</body>
</html>
