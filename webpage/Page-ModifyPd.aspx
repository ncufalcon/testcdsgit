<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="Page-ModifyPd.aspx.cs" Inherits="webpage_Page_ModifyPd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


                <div class="fixwidth " style="position:relative;">
                <div class="twocol underlineT1 margin10T" >
                    <div class="left font-light">首頁 / <span class="font-black font-bold">修改個人密碼</span></div>
                </div>

                        <div class="gentable" style="margin-top: 100px">
                            <table width="43%" border="0" cellspacing="0" cellpadding="0" style="margin-left: 350px">
                                <tr>
                                    <td class="width25" colspan="2">
                                        <div class="font-bold font-size5 ">修改個人密碼</div>
                                    </td>
                              
                                </tr>
                                <tr>
                                    <td class="width30" align="right">
                                        <div class="font-title titlebackicon">舊密碼</div>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_Id" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" CssClass="font-red" ControlToValidate="txt_Id" runat="server" ErrorMessage="*" Display="dynamic" SetFocusOnError="true" ValidationGroup="Member"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <div class="font-title titlebackicon">新密碼</div>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_Pd" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="font-red" ControlToValidate="txt_Pd" runat="server" ErrorMessage="*" Display="dynamic" SetFocusOnError="true" ValidationGroup="Member"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <div class="font-title titlebackicon">再輸入一次新密碼</div>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txt_Pd_again" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" CssClass="font-red" ControlToValidate="txt_Pd_again" runat="server" ErrorMessage="*" Display="dynamic" SetFocusOnError="true" ValidationGroup="Member"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td id="td_msg" runat="server" class="font-red"></td>
                                    <td style="text-align:right"><asp:LinkButton ID="lkb_Send" CssClass="keybtn" runat="server" OnClick="lkb_Send_Click" ValidationGroup="Member">確認</asp:LinkButton></td>

                                </tr>
                            </table>

                        </div>




                    </div>







</asp:Content>

