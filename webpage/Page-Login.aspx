<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Page-Login.aspx.cs" Inherits="webpage_Page_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/myITRIproject/jquery-ui-1.10.2.custom.css" rel="stylesheet" type="text/css" />
    <link href="../css/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
    <link href="../css/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/noheader.css" rel="stylesheet" type="text/css" />
    <link href="../css/jquery.datepick.css" rel="stylesheet" />

    <script type="text/javascript" src="../js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="../js/jquery-ui-1.10.2.custom.min.js"></script>
    <script type="text/javascript" src="../js/navigation.js"></script>
    <!-- 下拉選單 -->
    <script type='text/javascript' src='../js/jquery.fancybox.pack.js'></script>
    <!-- fancybox -->
    <script type="text/javascript" src="../js/jquery.mCustomScrollbar.concat.min.js"></script>
    <!-- 捲軸美化 -->
    <script type="text/javascript" src="../js/tableHeadFixer.js"></script>
    <script type="text/javascript" src="../js/GCommon.js"></script>
    <script type="text/javascript" src="../js/CmFmCommon.js"></script>
    <script type="text/javascript" src="../js/TableSorting.js"></script>
    <script type="text/javascript" src="../js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="../js/jquery.datepick.js"></script>
    <script type="text/javascript" src="../js/downfile.js"></script>
    <link href="../css/jquery.datetimepicker.css" rel="stylesheet" />
    <script src="../js/jquery.datetimepicker.full.js"></script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="lkb_Send">
        <div>
            <div class="WrapperBody">
                <div class="WrapperContent">
                    <div class="WrapperHeader fixwidth">
                        <div class="logo"><a href="#">
                            <img src="../images/logo.png" border="0" /></a></div>

                        <div class="infolink font-black">
                            登入者：Lynn   <a href="#">管理者</a> |  <a href="http://leave.encirclize.com/admin/login">請假系統</a>
                        </div>
                        <!-- infolink -->
                        <!--<div class="staffmenucontrol font-black font-bold"><a href="#staffmenu" id="staffmenubtn" target="_self">統計資訊</a></div>-->
                        <div class="basemenu font-white">
                            <!--{* 選單start *}-->
                            <div class="nav">
                                <ul id='nav_js'>
                                    <li><a href="~/webpage/Page-Login.aspx" title="使用者登入">使用者登入</a></li>
                                </ul>
                            </div>
                            <!--{* 選單end *}-->
                        </div>
                        <!-- basemenu -->
                            <img src="D:\I020000001.jpg" width="1000" height="1000" />
                    </div>
                    <!-- WrapperHeader -->
                    <div class="fixwidth">
                        <div class="twocol underlineT1 margin10T">
                            <div class="left font-light"><span class="font-black font-bold">使用者登入</span></div>
                        </div>
                        <div class="gentable" style="margin-top: 100px">
                            <table width="35%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 350px">
                                <tr>
                                    <td class="width25" colspan="2">
                                        <div class="font-bold font-size5 ">使用者登入</div>
                                    </td>
                              
                                </tr>
                                <tr>
                                    <td class="width30" align="right">
                                        <div class="font-title titlebackicon">帳號</div>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_Id" runat="server"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" CssClass="font-red" ControlToValidate="txt_Id" runat="server" ErrorMessage="*" Display="dynamic" SetFocusOnError="true" ValidationGroup="Member"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <div class="font-title titlebackicon">密碼</div>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_Pd" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="font-red" ControlToValidate="txt_Pd" runat="server" ErrorMessage="*" Display="dynamic" SetFocusOnError="true" ValidationGroup="Member"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_msg" runat="server" class="font-red"></td>
                                    <td style="text-align:right"><asp:LinkButton ID="lkb_Send" CssClass="keybtn" runat="server" OnClick="lkb_Send_Click" ValidationGroup="Member">登入</asp:LinkButton></td>

                                </tr>
                            </table>

                        </div>
                    </div>

                </div>
                <!-- WrapperContent -->
            </div>
            <!-- WrapperBody -->
        </div>
    </form>
</body>
</html>
