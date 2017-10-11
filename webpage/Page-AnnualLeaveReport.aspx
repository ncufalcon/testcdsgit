<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="Page-AnnualLeaveReport.aspx.cs" Inherits="Page_AnnualLeaveReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                    <a href="javascript:void(0);" class="keybtn"  id="btn_submit">匯出Excel</a>
                    <!--<a href="#" class="keybtn">取消</a>-->
                </div>
            </div>
        </div>

        <div class="fixwidth" style="margin-top: 20px;">
            <div class="statabs margin10T">
                <div class="gentable ">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="width13" align="right">
                                <div class="font-title titlebackicon">年度</div>
                            </td>
                            <td class="width25">
                                <input type="text" class="inputex" maxlength="4" id="txt_year" /><span class="font-red">#2017</span></td>

                            <td class="width13" align="right">
                                <div class="font-title titlebackicon">工號</div>
                            </td>
                            <td class="width20">
                                <input type="text" class="inputex" id="txt_PerNo" />
                                <!--<img src="../images/btn-search.gif" id="img_Per" style="cursor: pointer" />
                                <span id="sp_PerName"></span>
                                <input id="hid_PerGuid" type="hidden" />-->
                            </td>
                            <td class="width13" align="right">
                                <div class="font-title titlebackicon">姓名</div>
                            </td>
                            <td class="width20">
                                <input type="text" class="inputex" id="txt_PerName" />
                                <!--<img src="../images/btn-search.gif" id="img_Per" style="cursor: pointer" />
                                <span id="sp_PerName"></span>
                                <input id="hid_PerGuid" type="hidden" />-->
                            </td>
                        </tr>
                        <tr>
                            <td class="width13" align="right">
                                <div class="font-title titlebackicon">公司別</div>
                            </td>
                            <td class="width20">
                                <input type="text" class="inputex" id="txt_CompanyNo" name="txt_CompanyNo" />
                                <!--<img src="../images/btn-search.gif" id="img_Company" style="cursor: pointer" />
                                <span id="sp_CName"></span>
                                <input id="hid_CGuid" type="hidden" />-->
                            </td>
                            <td class="width13" align="right">
                                <div class="font-title titlebackicon">部門</div>
                            </td>
                            <td class="width20">
                                <input type="text" class="inputex" id="txt_Dep" name="txt_Dep" />
                                <!--<img src="../images/btn-search.gif" id="img_Dep" style="cursor: pointer" />
                                <span id="sp_DepName"></span>
                                <input id="hid_DepGuid" type="hidden" />-->
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- WrapperMain -->
    <script type="text/javascript">
        $(function () {
            $("#btn_submit").click(function () {
                if (chk_val()) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/Page-AnnualLeaveReport.ashx",
                        data: {
                            func: "downloadexcel",
                            str_yyyy: $("#txt_year").val(),
                            str_empno: $("#txt_PerNo").val(),
                            str_cname: $("#txt_PerName").val(),
                            str_com: $("#txt_CompanyNo").val(),
                            str_dep: $("#txt_Dep").val()
                        },
                        error: function (request, error) {
                            alert(error);
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            var reStr = response.split(',');
                            if (reStr[0] != "success") {
                                alert(decodeURIComponent(response));
                            }
                            else {
                                location.href = "../DOWNLOAD.aspx?FlexCel=" + reStr[1];
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end 
                }
            });
        });

        function chk_val(){
            var chk_year = $("#txt_year").val();
            if (chk_year == "") {
                alert("請輸入年度");
                return false;
            } 
            else if (chk_year != "" && chk_year.length!=4) {
                alert("請輸入正確年度");
                return false;
            }
            else if (chk_year != "" && isNaN(chk_year)) {
                alert("請輸入正確年度");
                return false;
            } else {
                return true;
            }
            
        }
    </script>











</asp:Content>

