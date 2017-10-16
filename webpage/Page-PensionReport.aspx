<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="Page-PensionReport.aspx.cs" Inherits="webpage_Page_PensionReport" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10TB">
                <div class="left font-light">首頁 / 報表輸出管理 /<span class="font-black font-bold">保險人名冊LI/NHI</span></div>
            </div>

        </div>

        <div class="fixwidth" style="margin-top: 20px;">
            <div class="statabs margin10T">
                <div class="gentable ">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                        <td class="width13" align="right"><div class="font-title titlebackicon">日期區間</div></td>
                        <td class="width20" colspan="3">
                            <table>
                                <tr>
                            <td colspan="3" >
                                起:<input type="text" class="inputex" id="txt_sDate" runat="server" value="2017/08/01"  />
                               ~迄:<input type="text" class="inputex" id="txt_eDate" runat="server" value="2017/08/30" /></td>   

                                </tr>
                            </table>                                 
                            </td>
                          </tr>  
                         <tr>
                            <td class="width13" align="right"><div class="font-title titlebackicon">工號</div></td>
                            <td class="width20">
                                <asp:TextBox class="inputex" id="txt_PerNo" runat="server"></asp:TextBox>
                            </td>
                            <td class="width13" align="right"><div class="font-title titlebackicon">姓名</div></td>
                            <td class="width20">
                                <asp:TextBox class="inputex" id="txt_PerName" runat="server"></asp:TextBox>
                            </td>
                        </tr>                        
                        <tr>
                            <td class="width13" align="right"><div class="font-title titlebackicon">公司別</div></td>
                            <td class="width20">
                                 <asp:TextBox class="inputex" id="txt_CompanyNo" runat="server"></asp:TextBox>
                            </td>
                            <td class="width13" align="right"><div class="font-title titlebackicon">部門</div></td>
                            <td class="width20">
                                <asp:TextBox class="inputex" id="txt_Dep" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>

                            <td colspan="4" style="text-align:right"><asp:Button  ID="btn_Search" runat="server" CssClass="keybtn" text="查詢" OnClick="btn_Search_Click"/></td>
                        </tr>

                    </table>

                
                </div>
            </div>
            
            <br /><br /><br /><br />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <rsweb:ReportViewer ID="ReportViewer1" runat="server"  Style="width: 100%; height:300px"></rsweb:ReportViewer>

        </div>


    </div>





    <script type="text/javascript">
                document.body.onload = function () {

                $("#" + '<%=txt_eDate.ClientID%>' + ",#" + '<%=txt_sDate.ClientID%>').datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy/mm/dd',
                dayNamesMin: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
                monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
                yearRange: '-100:+0',
                onClose: function (dateText, inst) {
                    $(this).datepicker('option', 'dateFormat', 'yy/mm/dd');
                }
            });
        }

    </script>
    

</asp:Content>

