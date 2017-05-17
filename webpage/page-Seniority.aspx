<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Seniority.aspx.cs" Inherits="webpage_page_Seniority" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            //套用datepicker
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#txt_date").datetimepicker({
                lang: 'zh-TW',
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            //確定按鈕
            $("#btn_submit").click(function () {
                if (chk_data()) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-Seniority.ashx",
                        data: {
                            func: "update",
                            str_year: $("#txt_year").val(),
                            str_date: $("#txt_date").val(),
                            str_perguid: $("#tmpUID").val(),
                            str_updatetype: $("input[name='cbox_updatetype']:checked").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response == "nodata") {
                                alert("無資料可更新");
                            } else if (response == "error") {
                                alert("更新失敗");
                            } else {
                                alert("更新成功");
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end 
                }

            });
        });
        //檢查查詢欄位
        function chk_data() {
            var chk_year = $("#txt_year").val();
            var chk_date = $("#txt_date").val();
            var chk_empno = $("#tmpUID").val();
            if (chk_year == "") {
                alert("請輸入計算年度");
                return false;
            }
            if (chk_date == "") {
                alert("請選擇年資認定截止日期");
                return false;
            }
            if (chk_empno == "") {
                alert("請挑選人員");
                return false;
            }
            if (isNaN(chk_year)) {
                alert("計算年度只能輸入識字");
                return false;
            }
            if (chk_date.length != 10) {
                alert("請選擇正確的年資認定截止日期yyyy/mm/dd");
                return false;
            } else {
                var regExp = /^[\d]+$/;
                var chk_date1 = chk_date.substr(0, 4);
                var chk_date2 = chk_date.substr(4, 1);
                var chk_date3 = chk_date.substr(5, 2);
                var chk_date4 = chk_date.substr(7, 1);
                var chk_date5 = chk_date.substr(8, 2);
                if (regExp.test(chk_date1) && regExp.test(chk_date3) && regExp.test(chk_date5) && chk_date2 == "/" && chk_date4 == "/") {
                }
                else {
                    alert("請選擇正確的年資認定截止日期yyyy/mm/dd");
                    return false;
                }
            }
            
            return true;
        }
        //多選查詢視窗
        function openMutiBox(item) {
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
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10TB">
                <div class="left font-light">首頁 / 出勤管理 /<span class="font-black font-bold">年資與特休天數計算</span></div>
            </div>
        </div>
        <!-- fixwidth -->
        <div class="fixwidth">
            <div class="twocol margin15TB">
                <div class="right">
                    <a href="javascript:void(0);" class="keybtn" id="btn_submit">確定</a>
                    <!--<a href="#" class="keybtn">取消</a>-->
                </div>
            </div>
        </div>
        <div class="fixwidth" style="margin-top: 20px;">
            <div class="statabs margin10T">
                <div class="gentable ">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="width15" align="right">
                                <div class="font-title titlebackicon">輸入計算年度</div>
                            </td>
                            <td class="width13">
                                <input type="text" class="inputex width95" value="" maxlength="4" id="txt_year" /></td>
                            <td class="width15" align="right">
                                <div class="font-title titlebackicon">選擇年資認定截止日期</div>
                            </td>
                            <td class="width13">
                                <input type="text" class="inputex width95" value="" id="txt_date" /></td>
                            <td class="width15" align="right">
                                <div class="font-title titlebackicon">僅更新員工年資欄位</div>
                            </td>
                            <td class="width13">
                                <input type="checkbox" name="cbox_updatetype" value="Y" /></td>
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

