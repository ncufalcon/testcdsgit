<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-SalaryHoliday.aspx.cs" Inherits="webpage_page_SalaryHoliday" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



            <div class="WrapperMain">
  
            <div class="fixwidth">
                <div class="twocol underlineT1 margin10T">
                    <div class="left font-light">首頁 / 薪資管理 / <span class="font-black font-bold">給薪假計算</span></div>
                </div>
                <div class="twocol margin15T">
                    <div class="right">
                        <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.ExportExcel()">依條件匯出</a>
                        <a href="page-SalaryHoliday.aspx" class="keybtn" >清除</a>
                    </div>
                </div>

                <table class="gentable" style="margin-top:15px">
                    <tr>
<%--                        <td class="width13" align="right"><div class="font-title titlebackicon">日期(起)</div></td>
                        <td class="width20"><input type="text" class="inputex" id="txt_DateS" /></td>
                        <td class="width13" align="right"><div class="font-title titlebackicon">日期(迄)</div></td>
                        <td class="width20"><input type="text" class="inputex" id="txt_DateE" /></td>--%>
                        <td class="width13" align="right"><div class="font-title titlebackicon">計薪週期</div></td>
                        <td class="width20" colspan="3">
                            <table>
                                <tr>
                                    <td style="width:150px">日期起:<span id="sp_sDate"></span></td>
                                    <td style="width:150px">日期迄:<span id="sp_eDate"></span></td>
                                    <td><img src="../images/btn-search.gif" id="img_SalaryRange" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                                        <input id="hid_SalaryRangeGuid" type="hidden" />
                                    </td>
                                </tr>
                            </table>                            
                            

                        </td>
                    </tr>
                    <tr>
                        <td class="width13" align="right"><div class="font-title titlebackicon">員工代號</div></td>
                        <td class="width20"><input type="text" class="inputex" id="txt_PerNo" />
                            <img src="../images/btn-search.gif" id="img_Person" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                            <span id="sp_PerName"></span>
                            <input id="hid_PerGuid" type="hidden" />
                        </td>
                        <td class="width13" align="right"><div class="font-title titlebackicon">公司別</div></td>
                        <td class="width20"><input type="text" class="inputex" id="txt_CompanyNo"/>
                            <img src="../images/btn-search.gif" id="img_Company" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                            <span id="sp_CName"></span>
                            <input id="hid_CGuid" type="hidden" />
                            <input id="hid_CStatus" type="hidden" />
                        </td>
                    </tr>
                    <tr>
                        <td class="width13" align="right"><div class="font-title titlebackicon">部門</div></td>
                        <td class="width20">
                            <input type="text" class="inputex" id="txt_Dep" />
                            <img src="../images/btn-search.gif" id="img_Dep" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                            <span id="sp_DepName"></span>
                            <input id="hid_DepGuid" type="hidden" />
                            <input id="hid_Depstatus" type="hidden" />
                        </td>
                        <td class="width13" align="right"><div class="font-title titlebackicon">職務</div></td>
                        <td class="width20">
                            <select id="s_Position" name="s_Position" class="inputex width95"></select>
                        </td>
                    </tr>
<%--                    <tr>
                        <td class="width13" align="right"><div class="font-title titlebackicon">勾選匯出欄位</div></td>
                        <td id="td_Holiday">
                            <input type="checkbox" checked="checked" /><span class="font-title">事假／家庭照顧假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">彈性休假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">產假／流產假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">公傷病假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">安胎假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">住院病假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">普通病假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">生理假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">病假加總</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">兵役假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">婚假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">喪假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">產檢假／陪產假</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">特休</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">特休假工時比例</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">特休假代金</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">P1工時</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">病假薪資</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">婚假薪資</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">喪假薪資</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">產檢/陪產</span><br />
                            <input type="checkbox" checked="checked" /><span class="font-title">RMK</span><br />
                        </td>
                    </tr>--%>
                </table>
            </div>



        </div><!-- WrapperMain -->





    <script type="text/javascript">

        JsEven = {
            id: {
                txt_DateS: 'txt_DateS',
                txt_DateE: 'txt_DateE',
                txt_PerNo: 'txt_PerNo',
                txt_CompanyNo: 'txt_CompanyNo',
                txt_Dep: 'txt_Dep',
                s_Position: 's_Position',

                sp_PerName: 'sp_PerName',
                hid_PerGuid: 'hid_PerGuid',
                sp_CName: 'sp_CName',
                hid_CGuid: 'hid_CGuid',
                hid_CStatus:'hid_CStatus',
                sp_DepName: 'sp_DepName',
                hid_DepGuid: 'hid_DepGuid',
                hid_Depstatus: 'hid_Depstatus',
                sp_sDate: 'sp_sDate',
                sp_eDate: 'sp_eDate',
                hid_SalaryRangeGuid: 'hid_SalaryRangeGuid'

            },

            //DDL
            getddl: function getddl(gno, tagName) {
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/GetDDL.ashx",
                    data: {
                        Group: gno
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },
                    success: function (data) {
                        if (data == "error") {
                            alert("GetDDL Error");
                            return false;
                        }

                        if (data != null) {
                            data = $.parseXML(data);
                            $(tagName).empty();
                            var ddlstr = '<option value="">請選擇</option>';
                            if ($(data).find("code").length > 0) {
                                $(data).find("code").each(function (i) {
                                    ddlstr += '<option value="' + $(this).attr("v") + '">' + $(this).attr("desc") + '</option>';
                                });
                            }
                            $(tagName).append(ddlstr);
                        }
                    }
                });
            },

            //查詢視窗
            openfancybox: function (item) {
                switch ($(item).attr("id")) {
                    case "img_Company":
                        link = "SearchWindow.aspx?v=Comp";
                        break;
                    case "img_Dep":
                        link = "SearchWindow.aspx?v=Dep";
                        break;
                    case "img_Person":
                        link = "SearchWindow.aspx?v=Personnel";
                        break;
                    case "img_SalaryRange":
                        link = "SearchWindow.aspx?v=SalaryRange";
                        break;
                }
                $.fancybox({
                    href: link,
                    type: "iframe",
                    minHeight: "400",
                    closeClick: false,
                    openEffect: 'elastic',
                    closeEffect: 'elastic'
                });
            },

            ExportExcel: function () {
                var arGuid = $('#' + this.id.hid_SalaryRangeGuid).val();
                if (arGuid != '') {
                    var PerNo = $('#' + this.id.hid_PerGuid).val();
                    var Company = $('#' + this.id.hid_CGuid).val();
                    var Dep = $('#' + this.id.hid_DepGuid).val();
                    var Position = $('#' + this.id.s_Position).val();
                    var sDate = $('#' + this.id.sp_sDate).html();
                    var eDate = $('#' + this.id.sp_eDate).html();
                    window.location = "../handler/SalaryHoliday/ashx_ExportExcel.ashx?sr_guid=" + arGuid + "&PerNo=" + PerNo + "&Company=" + Company + "&Dep=" + Dep + "&Position=" + Position + "&sDate=" + sDate + "&eDate=" + eDate;
                } else { alert('請選擇計薪週期');}
            }
        }


        //fancybox回傳
        function setReturnValue(type, gv, str, str2) {
            switch (type) {
                case "Comp":
                    $("#" + JsEven.id.txt_CompanyNo).val(str);
                    $("#" + JsEven.id.hid_CGuid).val(gv);
                    $("#" + JsEven.id.sp_CName).html(str2);
                    $("#" + JsEven.id.sp_CName).css("color", "");
                    $("#" + JsEven.id.hid_CStatus).val("Y");
                    break;
                case "Dep":
                    $("#" + JsEven.id.txt_Dep).val(str);
                    $("#" + JsEven.id.hid_DepGuid).val(gv);
                    $("#" + JsEven.id.sp_DepName).html(str2);
                    $("#" + JsEven.id.sp_DepName).css("color", "");
                    $("#" + JsEven.id.hid_Depstatus).val("Y");
                    break;
                case "Personnel":
                    $("#" + JsEven.id.txt_PerNo).val(str);
                    $("#" + JsEven.id.sp_PerName).html(str2);
                    $("#" + JsEven.id.hid_PerGuid).val(str);
                    break;
                case "SalaryRange":
                    $("#" + JsEven.id.sp_sDate).html(str);
                    $("#" + JsEven.id.sp_eDate).html(str2);
                    $("#" + JsEven.id.hid_SalaryRangeGuid).val(gv);
                    break;
            }            
        }





        document.body.onload = function () {
            JsEven.getddl("02", "#s_Position");
            $("#" + JsEven.id.txt_DateS + ",#" + JsEven.id.txt_DateE).datepicker({
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

