<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-WorkHours.aspx.cs" Inherits="webpage_page_WorkHours" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.js?v=2.1.5") %>"></script>
    <link href="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.css?v=2.1.5") %>" rel="stylesheet" type="text/css" />
    <style>
        .stripeMe th {
            border-top: 0px;
        }
    </style>
    <script type="text/javascript">
        var order_column = "";//表頭排序欄位
        var order_status = "";//表頭排序升/降冪
        $(function () {
            $("div[name='div_hours']").show();
            $("span[name='span_hours_search']").hide();
            //套用datetimepicker
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#search_hours_dates,#search_hours_datee,#txt_aAttendanceDate,#mod_aAttendanceDate,#search_old_dates,#search_old_datee").datetimepicker({
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            load_oldhours();

            //頁簽點擊事件
            $(".li_clk").click(function () {
                var this_id = $(this).attr("id");
                switch (this_id) {
                    case "li_1":
                        load_oldhours();
                        break;
                    case "li_2":
                        load_hoursdata();
                        break;
                }
            });

            //工號欄位 change事件
            $(document).on("change", "#mod_perno", function () {
                load_thispeopledata($(this).val());
            });

            //匯入按鈕
            $("#btn_import").click(function () {
                $.fancybox({
                    href: "WorkHoursImport.aspx",
                    type: "iframe",
                    width: "430",
                    height: "150",
                    closeClick: false,
                    openEffect: 'elastic',
                    closeEffect: 'elastic',
                    helpers: {
                        overlay: false
                    },
                });
            });
            //工時歷史資料外面查詢按鈕
            $("#btn_search").click(function () {
                $("div[name='div_hours']").hide();
                $("span[name='span_hours_search']").show();
            });
            //工時歷史資料裡面的查詢按鈕
            $("#btn_hours_inner_search").click(function () {
                $("div[name='div_hours']").show();
                $("span[name='span_hours_search']").hide();
                load_hoursdata();
            });
            //工時歷史資料資料 tr 點擊事件
            $(document).on("click", "#tbl_hours_list tbody tr td:not(:nth-child(1))", function () {
                $("#txt_type").text("修改");
                load_hoursdata_byguid($(this).closest('tr').attr("trguid"));
                load_leave($(this).closest('tr').attr("trperguid"), $(this).closest('tr').attr("trdate"));
                load_historyhours($(this).closest('tr').attr("trperguid"), $(this).closest('tr').attr("trdate"));
            });
            //原始工時資料資料 tr 點擊事件
            $(document).on("click", "#tbl_oldhours_list tbody tr td:not(:nth-child(1))", function () {
                $("#span_Status").text("修改");
                load_oldhours_byguid($(this).closest('tr').attr("trguid"));//修改才會有
            });
            //新增按鈕
            $("#btn_add").click(function () {
                $("#hidden_aguid").val("");
                $("#hidden_perguid").val("");
                $("#mod_perno").val("");
                $("#mod_pername").text("");
                $("#span_Status").text("新增");
                $("#mod_aAttendanceDate").val("");
                $("#mod_aRemark").val("");
                $("#mod_aTimes").val("");
                $("input[name='mod_aItme']").removeAttr("checked");
            });
            //儲存按鈕
            $("#btn_hours").click(function () {
                if (chk_data() && chk_num()) {
                    mod_data();
                }
            });
            //刪除
            $(document).on("click", "a[name='a_del']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-WorkHours.ashx",
                        data: {
                            func: "del_hours",
                            del_guid: $(this).attr("aguid")
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response != "error") {
                                alert("刪除成功");
                                load_oldhours();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            });
            //原始時數資料查詢
            $("span[name='div_inner']").hide();
            $("#btn_oldhours_out_search").click(function () {
                $("span[name='div_inner']").show();
                $("div[name='div_out']").hide();
            });
            $("#btn_oldhours_search").click(function () {
                $("span[name='div_inner']").hide();
                $("div[name='div_out']").show();
                load_oldhours();
            });
            //時數計算
            $("#btn_go").click(function () {
                $("#div_fbox_out").show();
                $("#loadblock").hide();
                $.fancybox({
                    href: "#fancybox_go",
                    closeClick: false,
                    openEffect: 'elastic',
                    closeEffect: 'elastic'
                });
                load_payrange();
            });
            //時數計算 確認按鈕
            $("#subbtn").click(function () {
                if ($("#sel_daterange").val() == "") {
                    alert("請先選擇一個計薪週期");
                } else {
                    $("#loadblock").show();
                    $("#div_fbox_out").hide();
                    $(".fancybox-close").attr("disabled", "disabled");//過程中不能關fancybox
                    //$("#loadblock").show();
                    //$("#div_fbox_out").hide();
                    //alert($("#sel_daterange").find(":selected").attr("value_s"));
                    //alert($("#sel_daterange").find(":selected").attr("value_s"));
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-WorkHours.ashx",
                        data: {
                            func: "hours_go",
                            str_ranges: $("#sel_daterange").find(":selected").attr("value_s"),
                            str_rangee: $("#sel_daterange").find(":selected").attr("value_e")
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            //$.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response == "ok") {
                                alert("計算成功，請至工時歷史資料查詢");
                                $.fancybox.close();
                            } else {
                                alert("計算失敗");
                                $("#loadblock").hide();
                                $("#div_fbox_out").show();
                                $(".fancybox-close").removeAttr("disabled");//恢復可以關閉
                            }
                        },//success end
                        complete: function () {
                            //$.unblockUI();
                        }
                    });//ajax end
                }
            });

            //原始資料table 表頭排序
            $(document).on("click", "a[name='order_column']", function () {
                if (order_status == "ASC") {
                    order_status = "DESC";
                } else {
                    order_status = "ASC";
                }
                order_column =$(this).attr("id");
                load_oldhours();
            });
        });

        //匯入 回傳
        function setReflash() {
            load_oldhours();
        }
        //撈時數資料
        function load_hoursdata() {
            $("#tbl_hours_list").empty();
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-WorkHours.ashx",
                data: {
                    func: "load_hoursdata",
                    str_keywords: $("#search_hours_keyword").val(),
                    str_dates: $("#search_hours_dates").val(),
                    str_datee: $("#search_hours_datee").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    var str_html = "";
                    if (response == "nodata") {
                        str_html += "<tr><td nowrap='nowrap' colspan='7'>查無資料</td></tr>";
                    } else if (response == "error") {
                        alert("系統錯誤");
                    }
                    else {
                        str_html += '<thead>';
                        str_html += '<tr>';
                        //str_html += '<th width="60" nowrap="nowrap">操作</th>';
                        str_html += '<th nowrap="nowrap" width="60">員工編號</th>';
                        str_html += '<th nowrap="nowrap" width="150">姓名</th>';
                        //str_html += '<th nowrap="nowrap" width="40">加扣別</th>';
                        str_html += '<th nowrap="nowrap" width="80">日期</th>';
                        str_html += '<th nowrap="nowrap" width="55">出勤天數</th>';
                        str_html += '<th nowrap="nowrap" width="55">出勤時數</th>';
                        //str_html += '<th nowrap="nowrap">備註</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr trguid="' + response[i].aGuid + '" trperno="' + response[i].perNo + '" trleave="' + response[i].aLeave + '" trdate="' + response[i].aAttendanceDate + '" trperguid="' + response[i].aperGuid + '">';
                            //str_html += '<td align="center" nowrap="nowrap" class="font-normal"><a name="a_del" aguid="' + response[i].aGuid + '" href="javascript:void(0);">刪除</a></td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].perNo + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].perName + '</td>';
                            //if (response[i].aItme == "01") {
                            //    str_html += '<td align="center" nowrap="nowrap">加項</td>';
                            //}
                            //if (response[i].aItme == "02") {
                            //    str_html += '<td align="center" nowrap="nowrap">扣項</td>';
                            //}
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].aAttendanceDate + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].aDays + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].aTimes + '</td>';
                            //str_html += '<td align="center" nowrap="nowrap">' + response[i].aRemark + '</td>';
                            str_html += '</tr>';
                        }
                        str_html += '</tbody>';
                    }
                    $("#tbl_hours_list").append(str_html);
                    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                    $(".stripeMe tr:even").addClass("alt");
                    $(".fixTable").tableHeadFixer();
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //撈時數資料 by guid
        function load_hoursdata_byguid(pguid) {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-WorkHours.ashx",
                data: {
                    func: "load_hoursdata",
                    str_guid: pguid
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response == "error") {

                    } else if (response == "nodata") {

                    } else {
                        $("#hidden_aguid").val(response[0].aGuid);
                        $("#hidden_perguid").val(response[0].aperGuid);
                        $("#txt_perno").val(response[0].perNo);
                        $("#txt_pername").text(response[0].perName);
                        $("#txt_dept").text(response[0].cbName);
                        $("#txt_aAttendanceDate").val(response[0].aAttendanceDate);
                        $("#txt_aDays").val(response[0].aDays),
                        $("#txt_aTimes").val(response[0].aTimes),
                        $("#txt_aLeave").val(response[0].aLeave),
                        $("#txt_aGeneralOverTime1").val(response[0].aGeneralOverTime1);
                        $("#txt_aGeneralOverTime2").val(response[0].aGeneralOverTime2);
                        $("#txt_aGeneralOverTime3").val(response[0].aGeneralOverTime3);
                        $("#txt_aOffDayOverTime1").val(response[0].aOffDayOverTime1);
                        $("#txt_aOffDayOverTime2").val(response[0].aOffDayOverTime2);
                        $("#txt_aOffDayOverTime3").val(response[0].aOffDayOverTime3);
                        $("#txt_aHolidayOverTimes").val(response[0].aHolidayOverTimes);
                        $("#txt_aHolidayOverTime1").val(response[0].aHolidayOverTime1);
                        $("#txt_aHolidayOverTime2").val(response[0].aHolidayOverTime2);
                        $("#txt_aHolidayOverTime3").val(response[0].aHolidayOverTime3);
                        $("#txt_aNationalholidays").val(response[0].aNationalholidays);
                        $("#txt_aNationalholidays1").val(response[0].aNationalholidays1);
                        $("#txt_aNationalholidays2").val(response[0].aNationalholidays2);
                        $("#txt_aNationalholidays3").val(response[0].aNationalholidays3);
                        $("#txt_aSpecialholiday").val(response[0].aSpecialholiday);
                        $("#txt_aSpecialholiday1").val(response[0].aSpecialholiday1);
                        $("#txt_aSpecialholiday2").val(response[0].aSpecialholiday2);
                        $("#txt_aSpecialholiday3").val(response[0].aSpecialholiday3);
                        //$("#txt_aRemark").val(response[0].aRemark);
                        //$("input[name='txt_aItme'][value='" + response[0].aItme + "']").prop("checked", true);
                        //load_person("per", response[0].aperGuid);
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //檢查輸入欄位
        function chk_data() {
            var chk_perguid = $("#hidden_perguid").val();
            var chk_pername = $("#mod_pername").text();
            var chk_adate = $("#mod_aAttendanceDate").val();
            var chk_atimes = $("#mod_aTimes").val();
            var chk_item = $("input[name='mod_aItme']:checked").val();
            if (chk_perguid == "" || chk_pername == "" || chk_pername == "無資料") {
                alert("請挑選一個正確的人員");
                return false;
            }
            if (chk_adate == "") {
                alert("請選擇日期");
                return false;
            }
            if (chk_item != "01" && chk_item != "02") {
                alert("請選擇加/扣項");
                return false;
            }
            if (chk_atimes=="") {
                alert("請輸入時數");
                return false;
            }
            return true;
        }
        //撈休假資料
        function load_leave(gv, str_date) {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-WorkHours.ashx",
                data: {
                    func: "load_leave",
                    leave_perguid: gv,
                    leave_date: str_date
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    var str_html = "";
                    if (response == "nodata") {
                        $("#tbl_leave").empty();
                        $("#tbl_leave").append("<tr><td>無請假資料</td></tr>");
                    } else if (response == "error") {
                        alert("error");
                    } else {
                        $("#tbl_leave").empty();
                        str_html += '<thead>';
                        str_html += '<tr>';
                        //str_html += '<th nowrap="nowrap">假單編號</th>';
                        str_html += '<th nowrap="nowrap">員工代號</th>';
                        str_html += '<th nowrap="nowrap">員工姓名</th>';
                        str_html += '<th nowrap="nowrap">日期起</th>';
                        str_html += '<th nowrap="nowrap">日期迄</th>';
                        str_html += '<th nowrap="nowrap">天數</th>';
                        str_html += '<th nowrap="nowrap">假別</th>';
                        str_html += '<th nowrap="nowrap">事由</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].leaAppilcantId + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].perName + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].leaStratFrom + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].leaEndAt + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].leaDuration + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].phName + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].leaRemark + '</td>';
                            str_html += '</tr>';
                        }
                        str_html += '</tbody>';
                        $("#tbl_leave").append(str_html);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                        $(".fixTable").tableHeadFixer();
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //點放大鏡 查詢視窗
        function openfancybox(item) {
            switch ($(item).attr("id")) {
                case "Pbox"://人事異動 人員挑選
                    link = "SearchWindow.aspx?v=Personnel";
                    fbox(link);
                    break;
            }
        }
        function fbox(link) {
            $.fancybox({
                href: link,
                type: "iframe",
                minHeight: "400",
                closeClick: false,
                openEffect: 'elastic',
                closeEffect: 'elastic'
            });
        }
        //fancybox回傳
        function setReturnValue(v, gv, pno, pname, refcode) {
            switch (v) {
                case "Personnel":
                    $("#mod_perno").val(pno);
                    $("#mod_pername").text(pname);
                    $("#hidden_perguid").val(gv);
                    //load_person("dept", gv);
                    break;
            }
        }
        //撈人員資料
        function load_person(stype, gv) {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-WorkHours.ashx",
                data: {
                    func: "load_person",
                    dept_perguid: gv
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response == "nodata") {
                        if (stype == "dept") {
                            //$("#txt_dept").empty();
                            //$("#txt_dept").append("無資料");
                        }
                    } else if (response == "error") {
                        alert("error");
                    } else {
                        if (stype == "per") {
                            $("#mod_perno").val(response[0].perNo);
                            $("#mod_pername").text(response[0].perName);
                        }
                        //$("#txt_dept").empty();
                        //$("#txt_dept").append(response[0].cbName);
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //取的該員工號碼的資料
        function load_thispeopledata(thisno) {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-WorkHours.ashx",
                data: {
                    func: "load_thispeopledata",
                    str_thisno: thisno
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response == "nodata") {
                        $("#mod_pername").text("無資料");
                        $("#hidden_perguid").val("");
                        //$("#txt_dept").empty();
                    } else if (response == "error") {
                        alert("error");
                    } else {
                        var split_data = response.split(",");
                        $("#mod_pername").text(split_data[1]);
                        $("#hidden_perguid").val(split_data[0]);
                        //load_person("per", split_data[1]);
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //檢查數字
        function chk_num() {
            var input_num = $("input[name='num']");
            for (var i = 0; i < input_num.length; i++) {
                if (input_num[i].value != "") {
                    if (!isNaN(input_num[i].value)) {
                        continue;
                    } else {
                        alert("請檢查時數欄位是否輸入其他字元!");
                        return false;
                    }
                }
            }
            return true;
        }
        //撈原始時數資料
        function load_oldhours(){
            $("#tbl_oldhours_list").empty();
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-WorkHours.ashx",
                data: {
                    func: "load_oldhours",
                    str_keywords: $("#search_old_keyword").val(),
                    str_dates: $("#search_old_dates").val(),
                    str_datee: $("#search_old_datee").val(),
                    str_datatype: $("#search_old_datatype").val(),
                    str_order_status: order_status,
                    str_order_column: order_column
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    var str_html = "";
                    if (response == "nodata") {
                        str_html += "<tr><td nowrap='nowrap' colspan='7'>查無資料</td></tr>";
                    } else if (response == "error") {
                        alert("系統錯誤");
                    }
                    else {
                        //str_html += '<thead>';
                        //str_html += '<tr>';
                        //str_html += '<th width="60" nowrap="nowrap">操作</th>';
                        //str_html += '<th nowrap="nowrap" width="60"><a href="javascript:void(0);" style="color:blue;" name="order_column" id="cno">員工編號</a></th>';
                        //str_html += '<th nowrap="nowrap" width="150"><a href="javascript:void(0);" style="color:blue;" name="order_column" id="cname">姓名</a></th>';
                        //str_html += '<th nowrap="nowrap" width="40">加扣別</th>';
                        //str_html += '<th nowrap="nowrap" width="80"><a href="javascript:void(0);" style="color:blue;" name="order_column" id="cdate">日期</a></th>';
                        //str_html += '<th nowrap="nowrap" width="55">出勤時數</th>';
                        //str_html += '<th nowrap="nowrap">備註</th>';
                        //str_html += '</tr>';
                        //str_html += '</thead>';
                        //str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr trguid="' + response[i].ah_guid + '">';
                            str_html += '<td align="center" nowrap="nowrap" class="font-normal"><a name="a_del" aguid="' + response[i].ah_guid + '" href="javascript:void(0);">刪除</a></td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ah_perNo + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].perName + '</td>';
                            if (response[i].ah_Itme == "01") {
                                str_html += '<td align="center" nowrap="nowrap">加項</td>';
                            }
                            if (response[i].ah_Itme == "02") {
                                str_html += '<td align="center" nowrap="nowrap">扣項</td>';
                            }
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ah_AttendanceDate + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ah_Times + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ah_Remark + '</td>';
                            str_html += '</tr>';
                        }
                        //str_html += '</tbody>';
                    }
                    $("#tbl_oldhours_list").append(str_html);
                    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                    $(".stripeMe tr:even").addClass("alt");
                    //$(".fixTable").tableHeadFixer();
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //撈原始時數資料 by guid
        function load_oldhours_byguid(pguid) {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-WorkHours.ashx",
                data: {
                    func: "load_oldhours",
                    str_guid: pguid
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response == "error") {
                        alert("error");
                    } else if (response == "nodata") {

                    } else {
                        $("#hidden_aguid").val(response[0].ah_guid);
                        $("#hidden_perguid").val(response[0].ah_perGuid);
                        $("#mod_perno").val(response[0].ah_perNo);
                        $("#mod_pername").text(response[0].perName);
                        $("#mod_aAttendanceDate").val(response[0].ah_AttendanceDate);
                        $("#mod_aTimes").val(response[0].ah_Times);
                        $("#mod_aRemark").val(response[0].ah_Remark);
                        $("input[name='mod_aItme'][value='" + response[0].ah_Itme + "']").prop("checked", true);
                        //load_person("per", response[0].aperGuid);
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //新增/修改
        function mod_data() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-WorkHours.ashx",
                data: {
                    func: "mod_hours",
                    mod_aGuid: $("#hidden_aguid").val(),
                    mod_aPerGuid: $("#hidden_perguid").val(),
                    mod_perno: $("#mod_perno").val(),
                    mod_aAttendanceDate: $("#mod_aAttendanceDate").val(),
                    mod_aTimes: $("#mod_aTimes").val(),
                    mod_aRemark: $("#mod_aRemark").val(),
                    mod_aItme: $("input[name='mod_aItme']:checked").val(),
                    mod_type: $("#span_Status").text()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response != "error") {
                        if ($("#span_Status").text() == "新增") {
                            alert("新增成功");
                        } else {
                            alert("修改成功");
                        }
                        load_oldhours();
                    } else {
                        if ($("#span_Status").text() == "新增") {
                            alert("新增失敗");
                        } else {
                            alert("修改失敗");
                        }
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //撈計薪週期 下拉選單資料
        function load_payrange() {
            $("#sel_daterange").empty();
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-WorkHours.ashx",
                data: {
                    func: "load_payrange_workinghours"
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    var str_html = "<option value=''>----------請選擇-----------</option>";
                    if (response == "nodata") {
                        str_html += "";
                    } else if (response == "error") {
                        alert("系統錯誤");
                    }
                    else {
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<option value="' + response[i].sr_BeginDate_c + '" value_s="' + response[i].sr_BeginDate + '" value_e="' + response[i].sr_Enddate + '" >' + response[i].sr_BeginDate + '-' + response[i].sr_Enddate + '</option>';
                        }
                        str_html += '</tbody>';
                    }
                    $("#sel_daterange").append(str_html);
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //工時歷史資料查詢 點TR 帶出他原本的工時紀錄 by pguid date
        function load_historyhours(pguid, ddate) {
            $("#tbl_historyhours").empty();
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-WorkHours.ashx",
                data: {
                    func: "load_historyhours",
                    str_guid: pguid,
                    str_date: ddate
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    var str_html = "";
                    if (response == "error") {
                        alert("系統錯誤");
                    } else if (response == "nodata") {
                        str_html += "<tr><td nowrap='nowrap'>查無資料</td></tr>";
                    } else {
                        //tbl_historyhours
                        str_html += '<thead>';
                        str_html += '<tr>';
                        str_html += '<th nowrap="nowrap" width="60">員工編號</th>';
                        str_html += '<th nowrap="nowrap" width="150">姓名</th>';
                        str_html += '<th nowrap="nowrap" width="40">加扣別</th>';
                        str_html += '<th nowrap="nowrap" width="80">日期</th>';
                        str_html += '<th nowrap="nowrap" width="55">出勤時數</th>';
                        str_html += '<th nowrap="nowrap">備註</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr trguid="' + response[i].ah_guid + '">';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ah_perNo + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].perName + '</td>';
                            if (response[i].ah_Itme == "01") {
                                str_html += '<td align="center" nowrap="nowrap">加項</td>';
                            }
                            if (response[i].ah_Itme == "02") {
                                str_html += '<td align="center" nowrap="nowrap">扣項</td>';
                            }
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ah_AttendanceDate + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ah_Times + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ah_Remark + '</td>';
                            str_html += '</tr>';
                        }
                        str_html += '</tbody>';
                    }
                    $("#tbl_historyhours").append(str_html);
                    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                    $(".stripeMe tr:even").addClass("alt");
                    $(".fixTable").tableHeadFixer();
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="text" id="hidden_perguid" style="display: none;" />
    <input type="text" id="hidden_aguid" style="display: none;" />
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10TB">
                <div class="left font-light">首頁 / 出勤管理 /<span class="font-black font-bold">時數管理</span></div>
            </div>
            <div class="fixwidth" style="margin-top: 10px;">
                <!-- 詳細資料start -->
                <div class="statabs margin10T">
                    <ul>
                        <li class="li_clk" id="li_1"><a href="#tabs-1">工時設定</a></li>
                        <li class="li_clk" id="li_2"><a href="#tabs-2">工時歷史資料</a></li>
                    </ul>
                    <!-- tabs-1 薪資計算公式-->
                    <div id="tabs-1">
                        <div class="statabs margin10T">
                            <div class="twocol margin15T">
                                <span name="div_inner" class="right">
                                    日期起：<input type="text" size="10" id="search_old_dates" />
                                    日期迄：<input type="text" size="10" id="search_old_datee" />
                                    關鍵字：<input type="text" size="10" id="search_old_keyword"  />
                                    資料別：
                                    <select id="search_old_datatype">
                                        <option value="all" selected="selected">全部</option>
                                        <option value="N">手動新增</option>
                                        <option value="Y">匯入資料</option>
                                    </select>
                                    <a href="javascript:void(0);" class="keybtn" id="btn_oldhours_search">查詢</a>
                                </span>
                                <br />
                                <div style=" text-align: right;" name="div_out">
                                    <a href="javascript:void(0);" class="keybtn" id="btn_oldhours_out_search">查詢</a>
                                    <a href="javascript:void(0);" class="keybtn" id="btn_add">新增</a>
                                    <a href="javascript:void(0);" class="keybtn" id="btn_import">匯入工作時數</a>
                                    <a href="javascript:void(0);" class="keybtn" id="btn_go">時數計算</a>
                                </div>
                            </div>
                            <br />
                            <br />
                            <div class="tabfixwidth">
                                <div class="stripeMe fixTable" style="max-height: 175px;">
                                    <table width="99%" border="0" cellspacing="0" cellpadding="0">
                                        <thead>
                                        <tr>
                                        <th width="60" nowrap="nowrap">操作</th>
                                        <th nowrap="nowrap" width="60"><a href="javascript:void(0);" style="color:blue;" name="order_column" id="cno">員工編號</a></th>
                                        <th nowrap="nowrap" width="150"><a href="javascript:void(0);" style="color:blue;" name="order_column" id="cname">姓名</a></th>
                                        <th nowrap="nowrap" width="40">加扣別</th>
                                        <th nowrap="nowrap" width="80"><a href="javascript:void(0);" style="color:blue;" name="order_column" id="cdate">日期</a></th>
                                        <th nowrap="nowrap" width="55">出勤時數</th>
                                        <th nowrap="nowrap">備註</th>
                                        </tr>
                                        </thead>
                                        <tbody id="tbl_oldhours_list"></tbody>
                                    </table>
                                </div>
                            </div>
                            <br />
                            <div class="twocol margin15TB">
                                <div class="right">
                                    <a href="javascript:void(0);" class="keybtn" id="btn_hours">儲存</a>
                                </div>
                            </div>
                            <div class="tabfixwidth gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="right">
                                            <div class="font-title titlebackicon font-red">員工代號</div>
                                        </td>
                                        <td>
                                            <input type="text" class="inputex width50" id="mod_perno" /><img src="../images/btn-search.gif" style="cursor: pointer;" onclick="openfancybox(this)" id="Pbox" />
                                            <span id="mod_pername"></span>
                                        </td>
                                        <td align="right">
                                            <div class="font-title titlebackicon font-red">日期</div>
                                        </td>
                                        <td>
                                            <input type="text" size="10" id="mod_aAttendanceDate" />
                                        </td>
                                        <td align="right">
                                            <div class="font-title titlebackicon font-red">時數</div>
                                        </td>
                                        <td>
                                            <input type="text" size="10" id="mod_aTimes" name="num" />
                                        </td>
                                        <td>
                                            <div class="font-title titlebackicon" style="text-align:right;">維護狀態</div>
                                        </td>
                                        <td>
                                            <span id="span_Status">新增</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <div class="font-title titlebackicon">加扣別</div>
                                        </td>
                                        <td>
                                            <input type="radio" name="mod_aItme" value="01" />加<input type="radio" name="mod_aItme" value="02" />扣
                                        </td>
                                        <td class="width17" align="right">
                                            <div class="font-title titlebackicon font-red" >備註</div>
                                        </td>
                                        <td colspan="7">
                                            <input type="text" id="mod_aRemark" size ="60" />
                                        </td>
                                    </tr>

                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- tabs-1 end -->
                    <!-- tabs-2 -->
                    <div id="tabs-2">
                        <div class="statabs margin10T">
                            <div class="twocol margin15T">
                                <span name="span_hours_search" class="right">日期起：<input type="text" id="search_hours_dates" />
                                    日期迄：<input type="text" id="search_hours_datee" />
                                    關鍵字：<input id="search_hours_keyword" size="10" />&nbsp;&nbsp;
                                    <a href="Javascript:void(0)" class="keybtn" id="btn_hours_inner_search">查詢</a>
                                </span>
                                <div class="right" name="div_hours">
                                    <a href="javascript:void(0);" class="keybtn" id="btn_search">查詢</a>
                                </div>
                            </div>
                            <br />
                            <div class="tabfixwidth">
                                <div class="stripeMe fixTable" style="max-height: 175px;">
                                    <table width="99%" border="0" cellspacing="0" cellpadding="0" id="tbl_hours_list"></table>
                                </div>
                            </div>
                            <br />
                            <ul>
                                <li class="li_clk" id="li_2-1"><a href="#tabs-2-1">時數詳細資料</a></li>
                                <li class="li_clk" id="li_2-2"><a href="#tabs-2-2">請假紀錄</a></li>
                                <li class="li_clk" id="li_2-3"><a href="#tabs-2-3">原始時數</a></li>
                            </ul>
                            <div id="tabs-2-1">
                                <div class="tabfixwidth gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="width17" align="right">
                                                <div class="font-title titlebackicon font-red">員工代號</div>
                                            </td>
                                            <td class="width13">
                                                <input type="text" class="inputex width50" id="txt_perno" disabled="disabled" /><span id="txt_pername"></span>
                                            </td>
                                            <td class="width17" align="right">
                                                <div class="font-title titlebackicon font-red">日期</div>
                                            </td>
                                            <td class="width13">
                                                <input type="text" size="10" id="txt_aAttendanceDate" disabled="disabled" />
                                            </td>
                                            <td class="width17" align="right">
                                                <div class="font-title titlebackicon">部門別</div>
                                            </td>
                                            <td class="width10" id="txt_dept"></td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">出勤天數</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aDays" disabled="disabled" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">出勤時數</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aTimes" disabled="disabled" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">休假天數</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aLeave" disabled="disabled" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon ">平常加班時數-1類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aGeneralOverTime1" disabled="disabled" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">休息加班時數-1類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aOffDayOverTime1" disabled="disabled" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">平常加班時數-2類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aGeneralOverTime2" disabled="disabled" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">休息加班時數-2類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aOffDayOverTime2" disabled="disabled" />
                                            </td>
                                        </tr>

                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">平常加班時數-3類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aGeneralOverTime3" disabled="disabled" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">休息加班時數-3類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aOffDayOverTime3" disabled="disabled" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">例假日加班時數(正常)</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aHolidayOverTimes" disabled="disabled" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">國定假日加班時數(正常)</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aNationalholidays" disabled="disabled" />
                                            </td>
                                            <!--<td align="right">
                                                <div class="font-title titlebackicon">特殊假日加班時數(正常)</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aSpecialholiday" disabled="disabled" />
                                            </td>-->
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">例假日加班時數-1類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aHolidayOverTime1" disabled="disabled" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">國定假日加班時數-1類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aNationalholidays1" disabled="disabled" />
                                            </td>
                                            <!--<td align="right">
                                                <div class="font-title titlebackicon">特殊假日加班時數-1類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aSpecialholiday1" disabled="disabled" />
                                            </td>-->
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">例假日加班時數-2類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aHolidayOverTime2" disabled="disabled" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">國定假日加班時數-2類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aNationalholidays2" disabled="disabled" />
                                            </td>
                                            <!--<td align="right">
                                                <div class="font-title titlebackicon">特殊假日加班時數-2類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aSpecialholiday2" disabled="disabled" />
                                            </td>-->
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">例假日加班時數-3類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aHolidayOverTime3" disabled="disabled" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">國定假日加班時數-3類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aNationalholidays3" disabled="disabled" />
                                            </td>
                                            <!--<td align="right">
                                                <div class="font-title titlebackicon">特殊假日加班時數-3類</div>
                                            </td>
                                            <td>
                                                <input type="text" name="num" class="inputex width60" id="txt_aSpecialholiday3" disabled="disabled" />
                                            </td>-->
                                        </tr>
                                        <!--<tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">加扣別</div>
                                            </td>
                                            <td>
                                                <input type="radio" name="txt_aItme" value="01" disabled="disabled" />加<input type="radio" name="txt_aItme" value="02" disabled="disabled" />扣
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">備註</div>
                                            </td>
                                            <td colspan="3">
                                                <input type="text" class="inputex width80" id="txt_aRemark" disabled="disabled" />
                                            </td>
                                        </tr>-->

                                    </table>
                                </div>
                            </div>
                            <!--tabs-2-1- end-->
                            <div id="tabs-2-2">
                                <div class="tabfixwidth">
                                    <div class="stripeMe fixTable" style="max-height: 175px;">
                                        <table width="95%" border="0" cellspacing="0" cellpadding="0" id="tbl_leave"></table>
                                    </div>
                                </div>
                            </div>
                            <!--tabs-2-3 end-->
                            <div id="tabs-2-3">
                                <div class="tabfixwidth">
                                    <div class="stripeMe fixTable" style="max-height: 175px;">
                                        <table width="95%" border="0" cellspacing="0" cellpadding="0" id="tbl_historyhours"></table>
                                    </div>
                                </div>
                                <div class="tabfixwidth gentable">
                                </div>
                            </div>
                            <!--tabs-2-3 end-->
                        </div>
                        <!-- tabs-2 end -->
                    </div>
                    <!-- statabs -->
                    <!-- 詳細資料end -->
                </div>
                <!-- fixwidth -->
            </div>
            <!-- fixwidth -->
        </div>
        <!-- WrapperMain -->
        <!------------------------------------------------------------------------------------------------->

        <div id="fancybox_go" style="display: none;width:300px;height:120px;">
            <div id="div_fbox_out">
                <div style="color: #8b3c31;font-size:18px;">出勤管理 / 時數管理 / 時數計算</div><br />
                <div>
                    <span style="color:red;">計薪週期：</span>
                    <select id="sel_daterange">
                    
                    </select>
                </div>
                <br />
                <div class="right" style="text-align:right;width:298px;">
                    <input class="keybtn" id="subbtn" type="button" value="確認" />
                </div>
            </div>
            
            <div id="loadblock" style="display: none; text-align: center;">
                <img src="../images/loading.gif" />處理中，請稍待
            </div>
        </div>
</asp:Content>

