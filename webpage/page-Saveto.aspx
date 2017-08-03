<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Saveto.aspx.cs" Inherits="webpage_page_Saveto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            $("#txt_filename").val(getDate_yyyymmdd() + "-");
            //套用datepicker
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#txt_turnsavedate").datetimepicker({
                lang: 'zh-TW',
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            //薪資轉存花旗媒體產生按鈕(下載TXT)
            $("#btn_downloadtxt").click(function () {
                if (chk_data()) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-Saveto.ashx",
                        data: {
                            func: "downloadtxt",
                            str_filename: $("#txt_filename").val(),
                            str_paydate: $("#txt_paydate").val(),
                            str_perguid: $("#tmpUID").val(),
                            str_comno: $("#txt_comno").val(),
                            str_exporttype: $("input[name='radio_export_type']:checked").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response == "nodata") {
                                alert("查無資料");
                            } else if (response == "error") {
                                alert("轉出失敗");
                            } else {
                                location.href = "../DOWNLOADTXT.aspx?txt=" + response;
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end 
                }

            });
        });
        //*******************日期格式化yyyyMMdd********************//
        function getDate_yyyymmdd() {
            d = new Date();
            var yyyy = d.getFullYear().toString();
            var MM = pad(d.getMonth() + 1, 2);
            var dd = pad(d.getDate(), 2);
            return yyyy + MM + dd;
        }
        function pad(number, length) {
            var str = '' + number;
            while (str.length < length) {
                str = '0' + str;
            }
            return str;
        }
        //*******************日期格式化yyyyMMdd  END********************//
        //查詢視窗
        function openfancybox(item) {
            var link = "";
            switch ($(item).attr("id")) {
                case "citybkBox":
                    link = "SearchWindow.aspx?v=CityBankSR";
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
        }

        //檢查查詢欄位
        function chk_data(){
            var chk_filename = $("#txt_filename").val();
            var chk_paydate = $("#txt_paydate").val();
            var chk_comno = $("#txt_comno").val();
            var chk_turnsavedate = $("#txt_turnsavedate").val();
            var chk_exporttype = $("input[name='radio_export_type']:checked").val();
            if (chk_paydate=="") {
                alert("請從發先年月挑選一個發薪日");
                return false;
            }
            if (chk_filename=="") {
                alert("請輸入媒體檔案名稱");
                return false;
            }
            if (chk_turnsavedate=="") {
                alert("請挑選一個轉存日期");
                return false;
            }
            if (chk_comno=="") {
                alert("請輸入公司代馬");
                return false;
            }
            if (chk_paydate.length != 10) {
                alert("請輸入或挑選正確發薪年月yyyy/mm/dd");
                return false;
            } else {
                var regExp = /^[\d]+$/;
                var chk_paydate1 = chk_paydate.substr(0, 4);
                var chk_paydate2 = chk_paydate.substr(4, 1);
                var chk_paydate3 = chk_paydate.substr(5, 2);
                var chk_paydate4 = chk_paydate.substr(7, 1);
                var chk_paydate5 = chk_paydate.substr(8, 2);
                if (regExp.test(chk_paydate1) && regExp.test(chk_paydate3) && regExp.test(chk_paydate5) && chk_paydate2 == "/" && chk_paydate4 == "/") {
                }
                else {
                    alert("請輸入或挑選正確發薪年月yyyy/mm/dd");
                    return false;
                }
            }
            if (chk_turnsavedate.length != 10) {
                alert("請輸入正確轉存日期格式yyyy/mm/dd");
                return false;
            } else {
                var regExp = /^[\d]+$/;
                var chk_turnsavedate1 = chk_turnsavedate.substr(0, 4);
                var chk_turnsavedate2 = chk_turnsavedate.substr(4, 1);
                var chk_turnsavedate3 = chk_turnsavedate.substr(5, 2);
                var chk_turnsavedate4 = chk_turnsavedate.substr(7, 1);
                var chk_turnsavedate5 = chk_turnsavedate.substr(8, 2);
                if (regExp.test(chk_turnsavedate1) && regExp.test(chk_turnsavedate3) && regExp.test(chk_turnsavedate5) && chk_turnsavedate2 == "/" && chk_turnsavedate4 == "/") {
                }
                else {
                    alert("請輸入正確轉存日期格式yyyy/mm/dd");
                    return false;
                }
            }
            return true;
        }

        //fancybox回傳
        function setReturnValue(type, gv, str, str2, str3, str4) {
            switch (type) {
                case "CityBankSR":
                    $("#txt_paydate").val(str4);
                    break;
            }
        }

        //多選查詢視窗
        function openMutiBox(item) {
            $("#uName").empty();
            $("#tmpUID").val("");
            $("#tmpName").val("");
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
        }

        function mutiReturn(str, str2) {
            $("#tmpUID").val(str);
            $("#tmpName").val(str2);
            str2 = str2.replace(/,/g, "、");
            $("#uName").html(str2)
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="hidden" id="tmpUID" />
    <input type="hidden" id="tmpName" />
    <div class="WrapperMain">


        <div class="fixwidth">

            <div class="twocol underlineT1 margin10TB">
                <div class="left font-light">首頁 / 薪資管理 /<span class="font-black font-bold">薪資轉存花旗媒體產生</span></div>
            </div>

        </div>
        <!-- fixwidth -->
        <div class="fixwidth">
            <div class="twocol margin15TB">
                <div class="right">
                    <a href="javascript:void(0);" class="keybtn" id="btn_downloadtxt">依查詢條件轉成txt</a>
                    <!--<a href="#" class="keybtn">取消</a>-->
                </div>
            </div>
        </div>
        <div class="fixwidth" style="margin-top: 20px;">
            <div class="statabs margin10T">
                <div class="gentable ">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td align="right">
                                <div class="font-title titlebackicon">發薪年月</div>
                            </td>
                            <td><input type="text" class="inputex width80" value="" id="txt_paydate" /><img id="citybkBox" src="../images/btn-search.gif" onclick="openfancybox(this)" style="cursor:pointer;" /></td>
                            <!--<td align="right"><div class="font-title titlebackicon" >選擇發放日期</div></td>
                                    <td><input type="text" class="inputex width95" /></td>-->
                            <td align="right">
                                <div class="font-title titlebackicon">媒體檔案名稱</div>
                            </td>
                            <td>
                                <input type="text" class="inputex width95" id="txt_filename" /></td>
                            <td align="right">
                                <div class="font-title titlebackicon">轉存日期</div>
                            </td>
                            <td>
                                <input type="text" class="inputex width95" id="txt_turnsavedate" value="" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><div class="font-title titlebackicon" >公司代碼</div></td>
                            <td><input type="text" class="inputex width45" value="046552" id="txt_comno" /></td>
                            <td align="right">
                                <div class="font-title titlebackicon">匯出類別</div>
                            </td>
                            <td>
                                <input type="radio" name="radio_export_type" value="0" checked />薪資
                                <input type="radio" name="radio_export_type" value="1" />法扣
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><div class="font-title titlebackicon">選擇人員</div></td>
                            <td colspan="5">
                                <img id="mPersonBox" src="../images/btn-search.gif" onclick="openMutiBox(this)" style="cursor: pointer;" />
                                <span id="uName"></span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </div>
    <!-- WrapperMain -->
</asp:Content>

