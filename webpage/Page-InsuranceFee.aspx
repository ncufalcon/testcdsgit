<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="Page-InsuranceFee.aspx.cs" Inherits="webpage_Page_InsuranceFee" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



        <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10TB">
                <div class="left font-light">首頁 / 報表輸出管理 /<span class="font-black font-bold">勞健保保費計算</span></div>
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
                        <td class="width13" align="right"><div class="font-title titlebackicon">計薪週期</div></td>
                        <td class="width20" colspan="3">
                            <table>
                                <tr>
                                    <td style="width:150px" ><span class="font-title titlebackicon">日期起</span><span id="sp_sDate"></span></td>
                                    <td style="width:150px" ><span class="font-title titlebackicon">日期迄</span><span id="sp_eDate"></span></td>
                                    <td><img src="../images/btn-search.gif" id="img_SalaryRange" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                                        <input id="hid_SalaryRangeGuid" type="hidden"  />
                                        <input id="hid_SalaryDate" type="hidden"  />
                                    </td>

                            <td class="width13" align="right"><div class="font-title titlebackicon">類別</div></td>
                            <td class="width20">
                                <input type="radio" class="inputex" id="rad_LI" name="Insurance" checked="checked"/>LI
                                <input type="radio" class="inputex" id="rad_NHI" name="Insurance"/>NHI</td>
                                </tr>
                            </table>                                 
                            </td>
                          </tr>                         
                        <tr>
                            <td class="width13" align="right"><div class="font-title titlebackicon">公司別</div></td>
                            <td class="width20"><input type="text" class="inputex" id="txt_CompanyNo" name="txt_CompanyNo"/>
<%--                                <img src="../images/btn-search.gif" id="img_Company" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                                <span id="sp_CName"></span>
                                <input id="hid_CGuid" type="hidden" />    --%>                 
                            </td>
                            <td class="width13" align="right"><div class="font-title titlebackicon">部門</div></td>
                            <td class="width20">
                                <input type="text" class="inputex" id="txt_Dep" name="txt_Dep"/>
<%--                                <img src="../images/btn-search.gif" id="img_Dep" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                                <span id="sp_DepName"></span>
                                <input id="hid_DepGuid" type="hidden" />  --%>               
                            </td>
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
                hid_PerGuid: 'hid_PerGuid',
                sp_sDate: 'sp_sDate',
                sp_eDate: 'sp_eDate',
                hid_SalaryRangeGuid: 'hid_SalaryRangeGuid',
                hid_SalaryDate: 'hid_SalaryDate',


                rad_LI: 'rad_LI',
                rad_NHI: 'rad_NHI',
                sp_PerName: 'sp_PerName',
                txt_PerName:'txt_PerName',
                txt_CompanyNo: 'txt_CompanyNo',
                //sp_CName: 'sp_CName',
                //hid_CGuid: 'hid_CGuid',

                txt_Dep: 'txt_Dep',
                //sp_DepName: 'sp_DepName',
                //hid_DepGuid: 'hid_DepGuid',

                txt_PerNo: 'txt_PerNo',
                //sp_PerName: 'sp_PerName',
                //hid_PerGuid: 'hid_PerGuid'
            },


            //查詢視窗
            openfancybox: function (item) {
                switch ($(item).attr("id")) {
                    case "img_SalaryRange":
                        link = "SearchWindow.aspx?v=SalaryRange";
                        break;
                    case "img_Company":
                        link = "SearchWindow.aspx?v=Comp";
                        break;
                    case "img_Dep":
                        link = "SearchWindow.aspx?v=Dep";
                        break;
                    case "img_Per":
                        link = "SearchWindow.aspx?v=Personnel";
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


            //多選查詢視窗
            openMutiBox: function (item) {
                var link = "";
                switch ($(item).attr("id")) {
                    case "mPersonBox":
                        link = "MutiSearch.aspx?v=" + $("#tmpUID").val();
                        break;
                }
                $.fancybox({
                    href: link,
                    type: "iframe",
                    width: "400",
                    minHeight: "600",
                    closeClick: false,
                    openEffect: 'elastic',
                    closeEffect: 'elastic'
                });
            },

            ExportExcel: function () {
                var srGuid = $('#' + this.Id.hid_SalaryRangeGuid).val();
                if (srGuid != '') {
                    var PerNo = $('#' + this.Id.txt_PerNo).val();
                    var PerName = $('#' + this.Id.txt_PerName).val();                    
                    var Company = $('#' + this.Id.txt_CompanyNo).val();
                    var Dep = $('#' + this.Id.txt_Dep).val();

                    var eClass = (document.getElementById(this.Id.rad_LI).checked) ? "Y" : "";
                    var SalaryDate = $('#' + this.Id.hid_SalaryDate).val();

                    if (eClass == "Y") {
                        window.location = "../handler/Report/ashx_LIReport.ashx?sr_guid=" + srGuid
                            + "&PerNo=" + PerNo
                            + "&PerName=" + PerName
                            + "&Company=" + Company
                            + "&Dep=" + Dep
                            + "&srGuid=" + srGuid
                            + "&SalaryDate=" + SalaryDate;
                    } else
                    {
                        window.location = "../handler/Report/ashx_NHIReport.ashx?sr_guid=" + srGuid
                            + "&PerNo=" + PerNo
                            + "&PerName=" + PerName
                            + "&Company=" + Company
                            + "&Dep=" + Dep
                            + "&srGuid=" + srGuid
                            + "&SalaryDate=" + SalaryDate;
                    }
                } else { alert('請選擇計薪週期'); }
            }

        }


        //fancybox回傳
        function setReturnValue(type, gv, str, str2, str3, str4) {
            switch (type) {
                case "Personnel":
                    $("#" + JsEven.Id.txt_PerNo).val(str);
                    $("#" + JsEven.Id.sp_PerName).html(str2);
                    $("#" + JsEven.Id.hid_PerGuid).val(gv);
                    break;
                case "SalaryRange":
                    $("#" + JsEven.Id.sp_sDate).html(str);
                    $("#" + JsEven.Id.sp_eDate).html(str2);
                    $("#" + JsEven.Id.hid_SalaryRangeGuid).val(gv);
                    $("#" + JsEven.Id.hid_SalaryDate).val(str4);                    
                    break;
                case "Comp":
                    $("#" + JsEven.Id.txt_CompanyNo).val(str);
                    $("#" + JsEven.Id.hid_CGuid).val(gv);
                    $("#" + JsEven.Id.sp_CName).html(str2);
                    $("#" + JsEven.Id.sp_CName).css("color", "");
                    $("#" + JsEven.Id.hid_CStatus).val("Y");
                    break;
                case "Dep":
                    $("#" + JsEven.Id.txt_Dep).val(str);
                    $("#" + JsEven.Id.hid_DepGuid).val(gv);
                    $("#" + JsEven.Id.sp_DepName).html(str2);
                    $("#" + JsEven.Id.sp_DepName).css("color", "");
                    $("#" + JsEven.Id.hid_Depstatus).val("Y");
                    break;

            }
        }




        function mutiReturn(str, str2) {
            $("#" + JsEven.Id.hid_PerGuid).val(str);
            $("#tmpName").val(str2);
            str2 = str2.replace(/,/g, "、");
            $("#" + JsEven.Id.sp_PerName).html(str2);
        }



        //確認欄位資料key in是否正確
        function checkData(type, v) {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/checkData.ashx",
                data: {
                    tp: type,
                    str: v
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("checkData Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        if ($(data).find("data_item").length > 1)
                            alert("有兩筆資料")
                        else if ($(data).find("data_item").length > 0) {
                            switch (type) {
                                case "Company":
                                    $("#" + JsEven.Id.sp_CName).html($("comAbbreviate", data).text());
                                    $("#" + JsEven.Id.hid_PerGuid).val($("comGuid", data).text());
                                    $("#" + JsEven.Id.sp_CName).css("color", "");
         
                                    break;
                                case "Dep":
                                    $("#" + JsEven.Id.sp_DepName).html($("cbName", data).text());
                                    $("#" + JsEven.Id.hid_DepGuid).val($("cbGuid", data).text());
                                    $("#" + JsEven.Id.sp_DepName).css("color", "");
                                    break;
  
                            }
                        }
                        else {
                            switch (type) {
                                case "Company":
                                    $("#" + JsEven.Id.sp_CName).html('X');
                                    $("#" + JsEven.Id.hid_PerGuid).val('');
                                    $("#" + JsEven.Id.sp_CName).css("color", "red");
                                    break;
                                case "Dep":
                                    $("#" + JsEven.Id.sp_DepName).html("X");
                                    $("#" + JsEven.Id.hid_DepGuid).val('');
                                    $("#" + JsEven.Id.sp_DepName).css("color", "red");
                                    break;
    
                            }
                        }
                    }
                }
            });
        }




    </script>








</asp:Content>

