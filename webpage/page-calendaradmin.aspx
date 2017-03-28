<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-calendaradmin.aspx.cs" Inherits="webpage_page_Calendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(function () {
            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
            //套用datepicker
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#txt_holiday_date,#search_date,#search_sr_paydate,#search_sr_dates,#search_sr_datee,#txt_sr_paydate,#txt_sr_dates,#txt_sr_datee").datetimepicker({
                lang: 'zh-TW',
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            call_holidaydata();
            call_srdata();
            
            var clktype = "";//判斷現在是否點刪除 因為刪除也包在tr內會修怕

            //國定假日 搜尋&外面的查詢按鈕 預設隱藏
            $("#span_search").hide();
            $("#btn_holiday_search").click(function () {
                $("#span_search").show();
                $("#btn_holiday_search").hide();
                $("div[name=div_holiday_data]").hide();
            });

            //國定假日 查詢裡面的 查詢按鈕
            $("#btn_holiday_inner_search").click(function () {
                call_holidaydata();
            });
            
            //國定假日 新增假日按鈕
            $("#btn_holiday_add").click(function () {
                $("#txt_holiday_name").val("");
                $("#txt_holiday_date").val("");
                $("#txt_holiday_ps").val("");
                $("#hidden_holiday_guid").val("");
                $("#span_Status").text("新增");
            });
            //國定假日 儲存按鈕
            $("#btn_holiday_submit").click(function () {
                mod_holliday();
            });

            //國定假日 點tr 編輯
            $(document).on("click", "#div_holiday_list tr", function () {
                if (clktype == "01") {//表示現在點的是delete ""為點tr修改狀態
                    clktype = "";//然後改為空 
                }else{//點tr修改
                    $("#hidden_holiday_guid").val($(this).attr("trguid"));
                    $("#txt_holiday_name").val("");
                    $("#txt_holiday_date").val("");
                    $("#txt_holiday_ps").val("");
                    $("#span_Status").text("修改");
                    call_holidaydata_byguid();
                }
            });

            //國定假日 刪除
            $(document).on("click", "a[name='del_holiday_a']", function () {
                clktype = "01";
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/calendaradmin.ashx",
                        data: {
                            func: "del_holidaydata",
                            str_holiday_del_guid: $(this).attr("aguid")
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response == "OK") {
                                alert("刪除成功");
                                call_holidaydata();
                            } else {
                                alert("刪除失敗");
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end 
                }//if confirm end
            });

            //記薪週期 搜尋&外面的查詢按鈕 預設隱藏
            $("#span_sr_search").hide();
            $("#btn_sr_search").click(function () {
                $("#span_sr_search").show();
                $("#btn_sr_search").hide();
                $("div[name=div_sr_data]").hide();
            });

            //記薪週期 查詢裡面的 查詢按鈕
            $("#btn_sr_inner_search").click(function () {
                call_srdata();
            });

            //記薪週期 新增記薪週期按鈕
            $("#btn_sr_add").click(function () {
                $("#txt_sr_year").val("");
                $("#txt_sr_paydate").val("");
                $("#txt_sr_dates").val("");
                $("#txt_sr_datee").val("");
                $("#txt_sr_ps").val("");
                $("#hidden_sr_guid").val("");
                $("#span_sr_status").text("新增");
            });
            //記薪週期 儲存按鈕
            $("#btn_sr_submit").click(function () {
                mod_sr();
            });
            //記薪週期 點tr 編輯
            $(document).on("click", "#div_sr_list tr", function () {
                if (clktype == "01") {//表示現在點的是delete ""為點tr修改狀態
                    clktype = "";//然後改為空 
                } else{//點tr修改
                    $("#txt_sr_year").val("");
                    $("#txt_sr_paydate").val("");
                    $("#txt_sr_dates").val("");
                    $("#txt_sr_datee").val("");
                    $("#txt_sr_ps").val("");
                    $("#hidden_sr_guid").val($(this).attr("trguid"));
                    $("#span_sr_status").text("修改");
                    call_srdata_byguid();
                }
            });

            //計薪週期 刪除
            $(document).on("click", "a[name='del_sr_a']", function () {
                clktype = "01";
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/calendaradmin.ashx",
                        data: {
                            func: "del_srdata",
                            str_sr_del_guid: $(this).attr("aguid")
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response == "OK") {
                                alert("刪除成功");
                                call_srdata();
                            } else {
                                alert("刪除失敗");
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end 
                }//if confirm end
            });

            //撈國定假日資料
            function call_holidaydata() {
                $("#div_holiday_list").empty();
                if (chk_date($("#search_date").val())) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/calendaradmin.ashx",
                        data: {
                            func: "call_holidaydata",
                            str_date: $("#search_date").val(),
                            str_keyword: $("#search_keyword").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            var str_html = "";
                            if (response != "nodata") {
                                str_html += "<thead>";
                                str_html += "<tr>";
                                str_html += "<th nowrap='nowrap'>操作</th>";
                                str_html += "<th nowrap='nowrap'>假日名稱</th>";
                                str_html += "<th nowrap='nowrap'>日期</th>";
                                str_html += "<th nowrap='nowrap'>備註</th>";
                                str_html += "</tr>";
                                str_html += "</thead>";
                                str_html += "<tbody>";
                                for (var i = 0; i < response.length; i++) {
                                    str_html += "<tr trguid='" + response[i].dayGuid + "'>";
                                    str_html += "<td align='center' nowrap='nowrap' class='font-normal'><a href='javascript:void(0);' name='del_holiday_a' aguid='" + response[i].dayGuid + "'>刪除</a></td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].dayName + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].dayDate + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].dayPs + "</td>";
                                    str_html += "</tr>";
                                }
                                str_html += "</tbody>";
                            } else {
                                str_html += "<td colspan='4' nowrap='nowrap' style='cursor: pointer;'>查無資料</td>";
                            }
                            $("#div_holiday_list").append(str_html);
                            $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                            $(".stripeMe tr:even").addClass("alt");
                            $("#span_search").hide();
                            $("#btn_holiday_search").show();
                            $("div[name=div_holiday_data]").show();
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end 
                } 
            }

            //撈國定假日資料 BY GUID
            function call_holidaydata_byguid() {
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/calendaradmin.ashx",
                    data: {
                        func: "call_holidaydata",
                        str_guid: $("#hidden_holiday_guid").val()
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        var str_html = "";
                        if (response != "nodata") {
                            $("#txt_holiday_name").val(response[0].dayName);
                            $("#txt_holiday_date").val(response[0].dayDate);
                            $("#txt_holiday_ps").val(response[0].dayPs);
                            $("#hidden_holiday_guid").val(response[0].dayGuid);
                        }
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }

            //新增or修改 國定假日資料
            function mod_holliday() {
                if (chk_holiday_column()) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/calendaradmin.ashx",
                        data: {
                            func: "mod_holidaydata",
                            str_mod_type: $("#span_Status").text(),
                            str_mod_guid: $("#hidden_holiday_guid").val(),
                            str_mod_date: $("#txt_holiday_date").val(),
                            str_mod_ps: $("#txt_holiday_ps").val(),
                            str_mod_datename: $("#txt_holiday_name").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            var str_html = "";
                            if (response != "error") {
                                if ($("#span_Status").text() == "新增") {
                                    alert("新增成功");
                                }
                                if ($("#span_Status").text() == "修改") {
                                    alert("新增成功");
                                }
                                call_holidaydata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            }

            //撈計薪週期資料
            function call_srdata() {
                $("#div_sr_list").empty();
                if (chk_date($("#search_sr_paydate").val()) && chk_date($("#search_sr_dates").val()) && chk_date($("#search_sr_datee").val()) && chk_year($("#search_sr_year").val())) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/calendaradmin.ashx",
                        data: {
                            func: "call_srdata",
                            str_sr_year: $("#search_sr_year").val(),
                            str_sr_paydate: $("#search_sr_paydate").val(),
                            str_sr_dates: $("#search_sr_dates").val(),
                            str_sr_datee: $("#search_sr_datee").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            var str_html = "";
                            if (response != "nodata") {
                                str_html += "<thead>";
                                str_html += "<tr>";
                                str_html += "<th nowrap='nowrap'>操作</th>";
                                str_html += "<th nowrap='nowrap'>年度</th>";
                                str_html += "<th nowrap='nowrap'>週期起</th>";
                                str_html += "<th nowrap='nowrap'>週期迄</th>";
                                str_html += "<th nowrap='nowrap'>發薪日</th>";
                                str_html += "<th nowrap='nowrap'>備註</th>";
                                str_html += "</tr>";
                                str_html += "</thead>";
                                str_html += "<tbody>";
                                for (var i = 0; i < response.length; i++) {
                                    str_html += "<tr trguid='" + response[i].sr_Guid + "'>";
                                    str_html += "<td align='center' nowrap='nowrap' class='font-normal'><a href='javascript:void(0);' name='del_sr_a' aguid='" + response[i].sr_Guid + "'>刪除</a></td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].sr_Year + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].sr_BeginDate + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].sr_Enddate + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].sr_SalaryDate + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].sr_Ps + "</td>";
                                    str_html += "</tr>";
                                }
                                str_html += "</tbody>";
                            } else {
                                str_html += "<td colspan='4' nowrap='nowrap' style='cursor: pointer;'>查無資料</td>";
                            }
                            $("#div_sr_list").append(str_html);
                            $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                            $(".stripeMe tr:even").addClass("alt");
                            $("#span_sr_search").hide();
                            $("#btn_sr_search").show();
                            $("div[name=div_sr_data]").show();
                            //$.unblockUI();
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end 
                }
            }

            //新增or修改 計薪週期資料
            function mod_sr() {
                if (chk_sr_column()) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/calendaradmin.ashx",
                        data: {
                            func: "mod_srdata",
                            str_mod_type: $("#span_sr_status").text(),
                            str_mod_guid: $("#hidden_sr_guid").val(),
                            str_mod_year: $("#txt_sr_year").val(),
                            str_mod_paydate: $("#txt_sr_paydate").val(),
                            str_mod_dates: $("#txt_sr_dates").val(),
                            str_mod_datee: $("#txt_sr_datee").val(),
                            str_mod_ps: $("#txt_sr_ps").val(),
                            str_mod_datename: $("#txt_holiday_name").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            var str_html = "";
                            if (response != "error") {
                                if ($("#span_sr_status").text() == "新增") {
                                    alert("新增成功");
                                }
                                if ($("#span_sr_status").text() == "修改") {
                                    alert("修改成功");
                                }
                                call_srdata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            }

            //撈計薪週期資料 BY GUID
            function call_srdata_byguid() {
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/calendaradmin.ashx",
                    data: {
                        func: "call_srdata",
                        str_mod_guid: $("#hidden_sr_guid").val()
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        var str_html = "";
                        if (response != "nodata") {
                            $("#txt_sr_year").val(response[0].sr_Year);
                            $("#txt_sr_paydate").val(response[0].sr_SalaryDate);
                            $("#txt_sr_dates").val(response[0].sr_BeginDate);
                            $("#txt_sr_datee").val(response[0].sr_Enddate);
                            $("#txt_sr_ps").val(response[0].sr_Ps);
                            $("#span_sr_status").text("修改");
                        }
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }


            //檢查國定假日送出欄位欄位
            function chk_holiday_column() {
                var chk_datename = $("#txt_holiday_name").val();
                var chk_date = $("#txt_holiday_date").val();
                if (chk_datename==null ||chk_datename == "") {
                    alert("請輸入假日名稱");
                    return false;
                }
                else if (chk_date == null || chk_date == "") {
                    alert("請選擇日期");
                    return false;
                }
                else if (chk_date.length != 10) {
                    alert("請輸入正確日期格式");
                    return false;
                }
                else if (chk_date != null && chk_date != ""){
                    var regExp = /^[\d]+$/;
                    var str1 = chk_date.substr(0, 4);
                    var str2 = chk_date.substr(4, 1);
                    var str3 = chk_date.substr(5, 2);
                    var str4 = chk_date.substr(7, 1);
                    var str5 = chk_date.substr(8, 2);
                    if (regExp.test(str1) && regExp.test(str3) && regExp.test(str5) && str2 == "/" && str4 == "/"){
                        return true;
                    } 
                    else{
                        alert("請輸入正確日期格式");
                        return false;
                    }
                } else {
                    return true;
                }
            }

            //檢查計薪週期送出欄位欄位
            function chk_sr_column() {
                var chk_year = $("#txt_sr_year").val();
                var chk_paydate = $("#txt_sr_paydate").val();
                var chk_dates = $("#txt_sr_dates").val();
                var chk_datee = $("#txt_sr_datee").val();
                var regExp = /^[\d]+$/;
                if (chk_year == null || chk_year == "") {
                    alert("請輸入年度");
                    return false;
                }
                else if (chk_year.length != 4) {
                    alert("請輸入正確年度格式");
                    return false;
                } else if (!regExp.test(chk_year)) {
                    alert("請輸入正確年度格式");
                    return false;
                }
                else if (chk_paydate == null || chk_paydate == "") {
                    alert("請選擇發薪日期");
                    return false;
                }
                else if (chk_dates == null || chk_dates == "") {
                    alert("請選擇週期起");
                    return false;
                } else if (chk_datee == null || chk_datee == "") {
                    alert("請選擇週期迄");
                    return false;
                }
                else if (chk_paydate.length != 10 || chk_dates.length != 10 || chk_datee.length != 10) {
                    alert("請輸入正確日期格式");
                    return false;
                }
                else{
                    var regExp = /^[\d]+$/;
                    var strpaydate1 = chk_paydate.substr(0, 4);
                    var strpaydate2 = chk_paydate.substr(4, 1);
                    var strpaydate3 = chk_paydate.substr(5, 2);
                    var strpaydate4 = chk_paydate.substr(7, 1);
                    var strpaydate5 = chk_paydate.substr(8, 2);
                    var strdates1 = chk_dates.substr(0, 4);
                    var strdates2 = chk_dates.substr(4, 1);
                    var strdates3 = chk_dates.substr(5, 2);
                    var strdates4 = chk_dates.substr(7, 1);
                    var strdates5 = chk_dates.substr(8, 2);
                    var strdatee1 = chk_datee.substr(0, 4);
                    var strdatee2 = chk_datee.substr(4, 1);
                    var strdatee3 = chk_datee.substr(5, 2);
                    var strdatee4 = chk_datee.substr(7, 1);
                    var strdatee5 = chk_datee.substr(8, 2);
                    if (regExp.test(strpaydate1) && regExp.test(strpaydate3) && regExp.test(strpaydate5) && strpaydate2 == "/" && strpaydate4 == "/" && regExp.test(strdates1) && regExp.test(strdates3) && regExp.test(strdates5) && strdates2 == "/" && strdates4 == "/" && regExp.test(strdatee1) && regExp.test(strdatee3) && regExp.test(strdatee5) && strdatee2 == "/" && strdatee4 == "/") {
                        if (chk_dates > chk_datee) {
                            alert("請選擇正確起訖日期");
                            return false;
                        } else {
                            return true;
                        }
                    }
                    else {
                        alert("請輸入正確日期格式");
                        return false;
                    }
                } 
            }

            //檢查計薪週期送出欄位欄位
            function chk_holiday_column() {
                var chk_datename = $("#txt_holiday_name").val();
                var chk_date = $("#txt_holiday_date").val();
                if (chk_datename == null || chk_datename == "") {
                    alert("請輸入假日名稱");
                    return false;
                }
                else if (chk_date == null || chk_date == "") {
                    alert("請選擇日期");
                    return false;
                }
                else if (chk_date != null && chk_date != "") {
                    var regExp = /^[\d]+$/;
                    var str1 = chk_date.substr(0, 4);
                    var str2 = chk_date.substr(4, 1);
                    var str3 = chk_date.substr(5, 2);
                    var str4 = chk_date.substr(7, 1);
                    var str5 = chk_date.substr(8, 2);
                    if (regExp.test(str1) && regExp.test(str3) && regExp.test(str5) && str2 == "/" && str4 == "/" && chk_date.length == 10) {
                        return true;
                    }
                    else {
                        alert("請輸入正確日期格式");
                        return false;
                    }
                } else {
                    return true;
                }
            }

            //檢查日期格式
            function chk_date(str) {
                var regExp = /^[\d]+$/;
                if (str != null && str != "") {
                    if (str.length != 10) {
                        alert("請輸入正確日期格式");
                        return false;
                    } else {
                        var str1 = str.substr(0, 4);
                        var str2 = str.substr(4, 1);
                        var str3 = str.substr(5, 2);
                        var str4 = str.substr(7, 1);
                        var str5 = str.substr(8, 2);
                        if (regExp.test(str1) && regExp.test(str3) && regExp.test(str5) && str2 == "/" && str4 == "/") {
                            return true;
                        } else {
                            alert("請輸入正確日期格式");
                            return false;
                        }
                    }
                    
                } else {
                    return true;
                }
            }

            //檢查年格式
            function chk_year(str) {
                var regExp = /^[\d]+$/;
                if (str != null && str != "") {
                    if (str.length != 4) {
                        alert("請輸入正確年度格式");
                        return false;
                    } else {
                        if (regExp.test(str)) {
                            return true;
                        } else {
                            alert("請輸入正確年度格式");
                            return false;
                        }
                    }

                } else {
                    return true;
                }
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10T">
                <div class="left font-light">首頁 / 系統設定 / <span class="font-black font-bold">行事曆設定</span></div>
            </div>
        </div>

        <div class="fixwidth" id="div_Edit">
            <!-- 詳細資料start -->
            <div class="statabs margin10T">
                <ul>
                    <li><a href="#tabs-1">國定假日</a></li>
                    <li><a href="#tabs-2">計薪週期</a></li>
                </ul>
                <div id="tabs-1">
                    <div class="twocol margin15T" id="div_holiday_btn">
                        <div class="right">
                            <span id="span_search">
                                假日名稱：<input id="search_keyword" />&nbsp;&nbsp;
                                日期：<input id="search_date" maxlength="10" />
                                <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_holiday_inner_search">查詢</a>
                            </span>
                            <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_holiday_search">查詢</a>
                            <a href="Javascript:void(0)" class="keybtn" id="btn_holiday_add">新增假日</a>
                        </div>
                    </div>
                    <br />
                    <div class="tabfixwidth" style="overflow: auto;" name="div_holiday_data">
                        <div class="stripeMe fixTable" style="max-height: 175px;">
                            <table id="div_holiday_list" width="100%" border="0" cellspacing="0" cellpadding="0"></table>
                        </div>
                        <!-- overwidthblock -->
                    </div>
                    <!-- fixwidth END-->
                    <br />
                    <div class="twocol margin15T" name="div_holiday_data">
                        <div class="right">
                            <a href="Javascript:void(0)" id="btn_holiday_submit" class="keybtn fancybox">儲存</a>
                        </div>
                    </div>
                    <div class="tbsfixwidth" style="margin-top: 20px;" name="div_holiday_data">
                        <div class="statabs margin10T">
                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">假日名稱</div>
                                        </td>
                                        <td class="width20">
                                            <input type="text" class="inputex width95" id="txt_holiday_name" value="" />
                                        </td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">日期</div>
                                        </td>
                                        <td class="width20">
                                            <input type="text" class="inputex width95" id="txt_holiday_date" maxlength="10" value="" />
                                        </td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon">維護狀態</div>
                                        </td>
                                        <td class="width20">
                                            <span id="span_Status">新增</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <div class="font-title titlebackicon">備註</div>
                                        </td>
                                        <td colspan="5">
                                            <input type="text" class="inputex width99" maxlength="50" id="txt_holiday_ps" />
                                        </td>
                                    </tr>

                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <input type="text" style="display:none;" id="hidden_holiday_guid" />
                <!-- tabs-1 -->

                <div id="tabs-2">
                    <div class="twocol margin15T" id="div_sr_btn">
                        <div class="right">
                            <span id="span_sr_search">
                                年度：<input id="search_sr_year" size="10" />&nbsp;&nbsp;
                                發薪日：<input id="search_sr_paydate" maxlength="10" size="10" />&nbsp;&nbsp;
                                週期(起迄)：<input id="search_sr_dates" maxlength="10" size="10" />-<input id="search_sr_datee" size="10" maxlength="10" />
                                <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_sr_inner_search">查詢</a>
                            </span>
                            <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_sr_search">查詢</a>
                            <a href="Javascript:void(0)" class="keybtn" id="btn_sr_add">新增計薪週期</a>
                        </div>
                    </div>
                    <br />
                    <div class="tabfixwidth" style="overflow: auto;" name="div_sr_data">
                        <div class="stripeMe fixTable" style="max-height: 175px;">
                            <table id="div_sr_list" width="100%" border="0" cellspacing="0" cellpadding="0"></table>
                        </div>
                        <!-- overwidthblock -->
                    </div>
                    <!-- fixwidth END-->
                    <br />
                    <div class="twocol margin15T" name="div_sr_data">
                        <div class="right">
                            <a href="Javascript:void(0)" id="btn_sr_submit" class="keybtn fancybox">儲存</a>
                        </div>
                    </div>
                    <div class="tbsfixwidth" style="margin-top: 20px;" name="div_sr_data">
                        <div class="statabs margin10T">
                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">年度</div>
                                        </td>
                                        <td class="width20">
                                            <input type="text" class="inputex width95" id="txt_sr_year" value="" />
                                        </td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">發薪日</div>
                                        </td>
                                        <td class="width20">
                                            <input type="text" class="inputex width95" id="txt_sr_paydate" maxlength="10" value="" />
                                        </td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon">維護狀態</div>
                                        </td>
                                        <td class="width20">
                                            <span id="span_sr_status">新增</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">日期起</div>
                                        </td>
                                        <td class="width20">
                                            <input type="text" class="inputex width95" id="txt_sr_dates" maxlength="10" value="" />
                                        </td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">日期迄</div>
                                        </td>
                                        <td class="width20">
                                            <input type="text" class="inputex width95" id="txt_sr_datee" maxlength="10" value="" />
                                        </td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon">備註</div>
                                        </td>
                                        <td class="width20">
                                            <input type="text" class="inputex width99" maxlength="50" id="txt_sr_ps" />
                                        </td>
                                    </tr>

                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="text" style="display:none;" id="hidden_sr_guid" />
                <!-- tabs-2 -->

            </div>
            <!-- statabs -->
            <!-- 詳細資料end -->
            <br />
            <br />
        </div>
        <!-- fixwidth END-->

    </div>
    <!--WrapperMain-->
    
    
</asp:Content>

