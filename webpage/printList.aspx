<%@ Page Language="C#" AutoEventWireup="true" CodeFile="printList.aspx.cs" Inherits="webpage_printList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    
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
</head>
<body>
    <form id="form1" runat="server">
    <div>

        <div><input type="button" value="列印" onclick="printpage()"  /></div>
        <div id="div_show" runat="server">

        </div>

    
    </div>
    </form>

</body>



</html>
