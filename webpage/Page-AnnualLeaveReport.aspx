<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="Page-AnnualLeaveReport.aspx.cs" Inherits="Page_AnnualLeaveReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


        <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10TB">
                <div class="left font-light">首頁 / 統計查詢 /<span class="font-black font-bold">員工特休統計表</span></div>
            </div>

        </div>
        <!-- fixwidth -->
        <div class="fixwidth">
            <div class="twocol margin15TB">
                <div class="right">
                    <a href="javascript:void(0);" class="keybtn" onclick="JsEven.ExportExcel()" id="btn_submit">匯出Excel</a>
                    <!--<a href="#" class="keybtn">取消</a>-->
                </div>
            </div>
        </div>

        <div class="fixwidth" style="margin-top: 20px;">
            <div class="statabs margin10T">
                <div class="gentable ">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                        <td class="width13" align="right"><div class="font-title titlebackicon">年度</div></td>
                        <td class="width20" ><input type="text" class="inputex" maxlength="4" /><span class="font-red">#2017</span></td>

                            <td class="width13" align="right"><div class="font-title titlebackicon">工號</div></td>
                            <td class="width20">
                                <input type="text" class="inputex" id="txt_PerNo"/>
                                <img src="../images/btn-search.gif" id="img_Per" style="cursor:pointer"/>
                                <span id="sp_PerName"></span>
                                <input id="hid_PerGuid" type="hidden" /> 
                            </td>
                        </tr>                        
                        <tr>
                            <td class="width13" align="right"><div class="font-title titlebackicon">公司別</div></td>
                            <td class="width20"><input type="text" class="inputex" id="txt_CompanyNo" name="txt_CompanyNo"/>
                                <img src="../images/btn-search.gif" id="img_Company" style="cursor:pointer"/>
                                <span id="sp_CName"></span>
                                <input id="hid_CGuid" type="hidden" />                     
                            </td>
                            <td class="width13" align="right"><div class="font-title titlebackicon">部門</div></td>
                            <td class="width20">
                                <input type="text" class="inputex" id="txt_Dep" name="txt_Dep"/>
                                <img src="../images/btn-search.gif" id="img_Dep" style="cursor:pointer"/>
                                <span id="sp_DepName"></span>
                                <input id="hid_DepGuid" type="hidden" />                 
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- WrapperMain -->












</asp:Content>

