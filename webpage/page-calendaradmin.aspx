<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-calendaradmin.aspx.cs" Inherits="webpage_page_Calendar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../css/jquery.datetimepicker.css" rel="stylesheet" />
    <script src="../js/jquery.datetimepicker.full.js"></script>
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
                    <li><a href="#tabs-2">記薪週期</a></li>
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
                    <div class="tabfixwidth" style="overflow: auto;">
                        <div class="stripeMe fixTable" style="max-height: 175px;">
                            <table id="div_holiday_list" width="100%" border="0" cellspacing="0" cellpadding="0"></table>
                        </div>
                        <!-- overwidthblock -->
                    </div>
                    <!-- fixwidth END-->
                    <br />
                    <div class="twocol margin15T">
                        <div class="right">
                            <a href="Javascript:void(0)" id="btn_holiday_submit" class="keybtn fancybox">儲存</a>
                        </div>
                    </div>
                    <div class="tbsfixwidth" style="margin-top: 20px;">
                        <div class="statabs margin10T">
                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb_Data">
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
                                            <input type="text" class="inputex width95" id="txt_holiday_date" value="" />
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
                                            <input type="text" class="inputex width99" id="txt_holiday_ps" />
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
                    
                </div>
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
    
    <script type="text/javascript">
        $(function () {
            //國定假日 搜尋預設隱藏
            $("#div_holiday_Search").hide();
            //國定假日 外面的查詢按鈕
            $("#span_search").hide();
            $("#btn_holiday_search").click(function () {
                $("#span_search").show();
                $("#btn_holiday_search").hide();
            });
            //國定假日 查詢裡面的 查詢按鈕
            $("#btn_holiday_inner_search").click(function () {
                call_holidaydata();
            });
            //套用datepicker
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#txt_holiday_date,#search_date").datetimepicker({
                lang: 'zh-TW',
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false    //false關閉時間選項
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
            call_holidaydata();

            //國定假日 點tr 編輯
            $(document).on("click", "#div_holiday_list tr", function () {
                //alert($(this).attr("guid"));
                $("#hidden_holiday_guid").val($(this).attr("guid"));
                $("#txt_holiday_name").val("");
                $("#txt_holiday_date").val("");
                $("#txt_holiday_ps").val("");
                $("#span_Status").text("修改");
                call_holidaydata_byguid();
            });
            //國定假日 刪除
            $(document).on("click", "a[name='del_holiday_a']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/calendaradmin.ashx",
                        data: {
                            func: "del_holidaydata",
                            str_holiday_del_guid: $(this).attr("guid")
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        success: function (response) {
                            if (response == "OK") {
                                alert("刪除成功");
                                call_holidaydata();
                            } else {
                                alert("刪除失敗");
                            }
                        }//success end
                    });//ajax end 
                }
            });

            //撈假日資料
            function call_holidaydata() {
                $("#div_holiday_list").empty();
                if (chk_date("search", $("#search_date").val())) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/calendaradmin.ashx",
                        data: {
                            func: "call_holidaydata",
                            str_date: $("#search_date").val(),
                            str_keyword: $("#search_keyword").val()
                        },
                        error: function (xhr) {
                            alert("error");
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
                                    str_html += "<tr guid='" + response[i].dayGuid + "'>";
                                    str_html += "<td align='center' nowrap='nowrap' class='font-normal'><a href='javascript:void(0);' name='del_holiday_a' guid='" + response[i].dayGuid + "'>刪除</a></td>";
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
                        }//success end
                    });//ajax end 
                } 
            }

            //撈假日資料 BY GUID
            function call_holidaydata_byguid() {
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/calendaradmin.ashx",
                    data: {
                        func: "call_holidaydata",
                        str_guid: $("#hidden_holiday_guid").val()
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    success: function (response) {
                        var str_html = "";
                        if (response != "nodata") {
                            $("#txt_holiday_name").val(response[0].dayName);
                            $("#txt_holiday_date").val(response[0].dayDate);
                            $("#txt_holiday_ps").val(response[0].dayPs);
                            $("#hidden_holiday_guid").val(response[0].dayGuid);
                        }
                    }//success end
                });//ajax end
            }

            //新增or修改 國定假日資料
            function mod_holliday() {
                if (chk_date("mod", $("#txt_holiday_date").val())) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
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
                        success: function (response) {
                            var str_html = "";
                            if (response != "error") {
                                call_holidaydata();
                            }
                        }//success end
                    });//ajax end
                }
            }


            //撈記薪週期
            function call_rangedata() {

            }

            //檢查日期欄位
            function chk_date(search_type, chk_date) {
                if (search_type=="mod") {
                    if (chk_date == null || chk_date == "") {
                        alert("請選擇日期");
                        return false;
                    } else {
                        if (chk_date.length != 10) {
                            alert("請輸入正確日期格式");
                            return false;
                        } else {
                            return true;
                        }
                    }
                }
                if (search_type == "search") {
                    if (chk_date != null && chk_date != "") {
                        if (chk_date.length != 10) {
                            alert("請輸入正確日期格式");
                            return false;
                        } else {
                            return true;
                        }
                    } else { return true; }
                }
            }
        });
    </script>
</asp:Content>

