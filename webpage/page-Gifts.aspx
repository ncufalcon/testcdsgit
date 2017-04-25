<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Gifts.aspx.cs" Inherits="webpage_page_Gifts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .stripeMe th {
            border-top:0px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            //$.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
            //套用datepicker
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#search_dates,#search_datee,#txt_add_paydate").datetimepicker({
                lang: 'zh-TW',
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            load_group16();
            //查詢按鈕
            $("#btn_search").click(function () {
                if (chk_search()) {
                    load_data();
                }
            });
            //新增按鈕
            $("#btn_add").click(function () {
                if(chk_add()){
                    add_data();
                }
            });
        });
        function load_data() {
            $("#tbl_list").empty();
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-Gifts.ashx",
                data: {
                    func: "load_data",
                    str_dates: $("#search_dates").val(),
                    str_datee: $("#search_datee").val(),
                    str_hours: $("#search_hours").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    var str_html = "";
                    if (response=="nodata") {
                        str_html += "<tr><td nowrap='nowrap'>查無資料</td></tr>";
                    }else if(response=="error"){
                        alert("系統錯誤");
                    }
                    else {
                        str_html += '<thead>';
                        str_html += '<tr>';
                        str_html += '<th nowrap="nowrap">部門別</th>';
                        str_html += '<th nowrap="nowrap">員工代號</th>';
                        str_html += '<th nowrap="nowrap">員工姓名</th>';
                        str_html += '<th nowrap="nowrap">正常工時</th>';
                        str_html += '<th nowrap="nowrap">加班時數</th>';
                        str_html += '<th nowrap="nowrap">總計時數</th>';
                        str_html += '</tr>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length;i++){
                            str_html += '<tr>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].cbName + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].perNo + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].perName + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].sum_normal + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].sum_other + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].sum_all + '</td>';
                            str_html += '</tr>';
                        }
                        str_html += '</tbody>';
                    } 
                    
                    $("#tbl_list").append(str_html);
                    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                    $(".stripeMe tr:even").addClass("alt");
                    $(".fixTable").tableHeadFixer();
                    $("#hidden_dates").val($("#search_dates").val());
                    $("#hidden_datee").val($("#search_datee").val());
                    $("#hidden_hours").val($("#search_hours").val());
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //檢查查詢條件欄位 每個都必填
        function chk_search(){
            var str_dates = $("#search_dates").val();
            var str_datee = $("#search_datee").val();
            var str_hours = $("#search_hours").val();
            if (str_dates=="") {
                alert("請選擇開始日期");
                return false;
            }
            if (str_datee == "") {
                alert("請選擇結束日期");
                return false;
            }
            if (str_hours == "") {
                alert("請輸入時數");
                return false;
            }
            if (str_dates.length != 10 || str_datee.length != 10) {
                alert("請輸入正確日期格式yyyy/mm/dd");
                return false;
            } else {
                var regExp = /^[\d]+$/;
                var strdates1 = str_dates.substr(0, 4);
                var strdates2 = str_dates.substr(4, 1);
                var strdates3 = str_dates.substr(5, 2);
                var strdates4 = str_dates.substr(7, 1);
                var strdates5 = str_dates.substr(8, 2);
                var strdatee1 = str_datee.substr(0, 4);
                var strdatee2 = str_datee.substr(4, 1);
                var strdatee3 = str_datee.substr(5, 2);
                var strdatee4 = str_datee.substr(7, 1);
                var strdatee5 = str_datee.substr(8, 2);
                if (regExp.test(strdates1) && regExp.test(strdates3) && regExp.test(strdates5) && strdates2 == "/" && strdates4 == "/" && regExp.test(strdatee1) && regExp.test(strdatee3) && regExp.test(strdatee5) && strdatee2 == "/" && strdatee4 == "/") {
                    if (str_dates > str_datee) {
                        alert("請選擇正確起訖日期yyyy/mm/dd");
                        return false;
                    }
                }
                else {
                    alert("請輸入正確日期格式yyyy/mm/dd");
                    return false;
                }
            }
            if (isNaN(str_hours)) {
                alert("時數請勿輸入數字以外的東西");
                return false;
            }
            return true;
        }
        //檢查新增的欄位
        function chk_add(){
            var str_money = $("#txt_add_money").val();
            var str_moneytype = $("#txt_add_moneytype").val();
            var str_moneytype_text = $("#txt_add_moneytype option:selected").text();
            var hidden_dates = $("#hidden_dates").val();
            var hidden_datee = $("#hidden_datee").val();
            var hidden_hours = $("#hidden_hours").val();
            var str_paydate = $("#txt_add_paydate").val();
            if (hidden_dates == "" || hidden_datee == "" || hidden_hours == "") {
                alert("請先查詢出要批次新增的資料");
                return false;
            }
            if (str_money=="") {
                alert("請輸入金額");
                return false;
            }
            if (str_moneytype == "") {
                alert("請選擇禮金名稱");
                return false;
            }
            if (str_paydate == "") {
                alert("請輸入發薪日期");
                return false;
            }
            if (isNaN(str_money)) {
                alert("金額請勿輸入數字以外的東西");
                return false;
            }
            if (str_moneytype == "zzz") {
                alert("請先至設定中設定一筆'" + str_moneytype_text + "'的資料");
                return false;
            }
            if (str_paydate.length != 10) {
                alert("請輸入正確日期格式yyyy/mm/dd");
                return false;
            } else {
                var regExp = /^[\d]+$/;
                var strdates1 = str_paydate.substr(0, 4);
                var strdates2 = str_paydate.substr(4, 1);
                var strdates3 = str_paydate.substr(5, 2);
                var strdates4 = str_paydate.substr(7, 1);
                var strdates5 = str_paydate.substr(8, 2);
                if (regExp.test(strdates1) && regExp.test(strdates3) && regExp.test(strdates5) && strdates2 == "/" && strdates4 == "/") {
                    
                }
                else {
                    alert("請輸入正確日期格式yyyy/mm/dd");
                    return false;
                }
            }
            
            return true;
        }
        //撈禮金名稱 下拉選單選項
        function load_group16() {
            $("#txt_add_moneytype").empty();
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-Gifts.ashx",
                data: {
                    func: "load_group16"
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    var str_html = "<option value=''>---請選擇---</option>";
                     if (response == "error") {
                        alert("系統錯誤");
                    }
                    else {
                         for (var i = 0; i < response.length; i++) {
                             if (response[i].siGuid == "") {
                                 str_html += "<option value='zzz'>" + response[i].code_desc + "</option>";
                             } else {
                                 str_html += "<option value='" + response[i].siGuid + "'>" + response[i].code_desc + "</option>";
                             }
                        }
                    }
                     $("#txt_add_moneytype").append(str_html);
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //新增資料
        function add_data(){
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-Gifts.ashx",
                data: {
                    func: "add_data",
                    add_dates: $("#hidden_dates").val(),
                    add_datee: $("#hidden_datee").val(),
                    add_hours: $("#hidden_hours").val(),
                    add_money: $("#txt_add_money").val(),
                    add_moneytype: $("#txt_add_moneytype").val(),
                    add_paydate: $("#txt_add_paydate").val(),
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response == "error") {
                        alert("新增失敗");
                    } else {
                        alert("新增成功");
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10T">
                <div class="left font-light">首頁 / 薪資管理 / <span class="font-black font-bold">禮金管理</span></div>
            </div>
        </div>
        <br />
        <br />
        <div class="fixwidth">累計時數期間:
            <input type="text" id="search_dates" maxlength="10" size="12" />~<input type="text" id="search_datee" maxlength="10" size="12" /> 
            時數大於<input type="text" id="search_hours" maxlength="10" size="10" /> &nbsp;&nbsp;
            <a href="javascript:void(0);" class="keybtn fancybox" id="btn_search">查詢</a>
        </div>
        <br />
        <div class="fixwidth">
            <div class="stripeMe fixTable" style="height: 175px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_list">
                </table>
            </div>
            <!-- overwidthblock -->
        </div>
        <!-- fixwidth -->
        <div class="fixwidth" style="margin-top: 20px;">
            <div class="twocol margin15TB">
                <div class="right">
                    <a href="javascript:void(0);" class="keybtn" id="btn_add">新增</a>
                </div>
            </div>
        </div>
        <div class="fixwidth" style="margin-top: 20px;">
            <!-- 詳細資料start -->
            <div class="statabs margin10T">
                <div class="gentable">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td class="width15" align="right">
                                <div class="font-title titlebackicon" style="color: Red">金額</div>
                            </td>
                            <td class="width20">
                                <input type="text" class="inputex width95" value="" id="txt_add_money" /></td>
                            <td class="width15" align="right">
                                <div class="font-title titlebackicon" style="color: Red">禮金名稱</div>
                            </td>
                            <td class="width20">
                                <select id="txt_add_moneytype">
                                    
                                </select>
                            </td>
                            <td class="width15" align="right">
                                <div class="font-title titlebackicon" style="color: Red">發薪日期</div>
                            </td>
                            <td class="width20">
                                <input type="text" class="inputex width95" value="" id="txt_add_paydate" /></td>
                        </tr>
                    </table>
                    <div>透過查詢條件，將符合條件之員工批次新增禮金</div>
                    <input type="text" id="hidden_dates" style="display:none;" />
                    <input type="text" id="hidden_datee" style="display:none;" />
                    <input type="text" id="hidden_hours" style="display:none;" />
                </div>
            </div>
            <!-- statabs -->
        </div>
        <!-- fixwidth -->
    </div>
    <!-- WrapperMain -->
</asp:Content>

