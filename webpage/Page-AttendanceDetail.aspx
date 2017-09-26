<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="Page-AttendanceDetail.aspx.cs" Inherits="webpage_Page_AttendanceDetail" %>

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
                            <td class="width13" align="right"><div class="font-title titlebackicon">日期區間</div></td>
                            <td colspan="3" >起:<input type="text" class="inputex" id="txt_sDate"  />~迄:<input type="text" class="inputex" id="txt_eDate" /></td>                              
                        </tr>             
                         <tr>
                            <td  align="right"><div class="font-title titlebackicon">工號</div></td>
                            <td ><input type="text" class="inputex" id="txt_PerNo"/></td>                           
                            <td  align="right"><div class="font-title titlebackicon">姓名</div></td>
                            <td ><input type="text" class="inputex" id="txt_PerName"/></td>
                        </tr>                                   
                        
                                   
                        <tr>
                            <td  align="right"><div class="font-title titlebackicon">公司別</div></td>
                            <td ><input type="text" class="inputex" id="txt_CompanyNo" /></td>
                            <td  align="right"><div class="font-title titlebackicon">部門</div></td>
                            <td ><input type="text" class="inputex" id="txt_Dep" name="txt_Dep"/></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- WrapperMain -->






    <script type="text/javascript">


    JsEven = {

        Id: {
            txt_sDate: 'txt_sDate',
            txt_eDate: 'txt_eDate',
            txt_PerNo:'txt_PerNo',
            txt_PerName:'txt_PerName',
            txt_CompanyNo: 'txt_CompanyNo',
            txt_Dep: 'txt_Dep'
        },



        ExportExcel: function () {
            var sDate = $('#' + this.Id.txt_sDate).val();
            var eDate = $('#' + this.Id.txt_eDate).val();
            if (sDate != '' && eDate !='') {
                var PerNo = $('#' + this.Id.txt_PerNo).val();
                var Company = $('#' + this.Id.txt_CompanyNo).val();
                var Dep = $('#' + this.Id.txt_Dep).val();
                var PerName = $('#' + this.Id.txt_PerName).val();

                window.location = "../handler/Report/ashx_AttendanceReport.ashx?"
                        + "sDate=" + sDate
                        + "&eDate=" + eDate
                        + "&PerNo=" + PerNo
                        + "&PerName=" + PerName
                        + "&Company=" + Company
                        + "&Dep=" + Dep;

            } else { alert('請選擇日期起迄'); }
        }

    }




            document.body.onload = function () {

                $("#" + JsEven.Id.txt_eDate + ",#" + JsEven.Id.txt_sDate).datepicker({
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

