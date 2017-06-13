<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-WorkHours.aspx.cs" Inherits="webpage_page_WorkHours" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.js?v=2.1.5") %>"></script>
    <link href="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.css?v=2.1.5") %>" rel="stylesheet" type="text/css" />
    <style>
        .stripeMe th {
            border-top:0px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("div[name='div_hours']").show();
            $("span[name='span_hours_search']").hide();
            //套用datetimepicker
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#search_hours_dates,#search_hours_datee,#txt_aAttendanceDate").datetimepicker({
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            load_hoursdata();

            //人事異動 工號欄位 change事件
            $(document).on("change", "#txt_perno", function () {
                load_thispeopledata($(this).val());
            });

            //匯入按鈕
            $("#btn_import").click(function () {
                $.fancybox({
                    href: "WorkHoursImport.aspx",
                    type: "iframe",
                    width: "430",
                    height: "280",
                    closeClick: false,
                    openEffect: 'elastic',
                    closeEffect: 'elastic',
                    helpers: {
                        overlay: false
                    },
                });
            });

            //外面查詢按鈕
            $("#btn_search").click(function () {
                $("div[name='div_hours']").hide();
                $("span[name='span_hours_search']").show();
            });
            //裡面的查詢按鈕
            $("#btn_hours_inner_search").click(function () {
                $("div[name='div_hours']").show();
                $("span[name='span_hours_search']").hide();
                load_hoursdata();
            });
            
            //時數資料 tr 點擊事件
            $(document).on("click", "#tbl_hours_list tbody tr td:not(:nth-child(1))", function () {
                $("#txt_type").text("修改");
                load_hoursdata_byguid($(this).closest('tr').attr("trguid"));//修改才會有
                load_leave($(this).closest('tr').attr("trperguid"), $(this).closest('tr').attr("trdate"));
            });

            //新增按鈕
            $("#btn_add").click(function () {
                $("#hidden_aguid").val("");
                $("#hidden_perguid").val("");
                $("#txt_perno").val("");
                $("#txt_pername").text("");
                $("#txt_type").text("新增");
                $("#txt_aAttendanceDate").val("");
                $("#txt_aRemark").val("");
                $("input[name='txt_aItme']").removeAttr("checked");
                $("#txt_dept").empty();
                var input_num = $("input[name='num']");
                for (var i = 0; i < input_num.length; i++) {
                    input_num[i].value = "";
                }
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
                                load_hoursdata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            });
        });

        //匯入 回傳
        function setReflash() {
            //call_paychangedata();
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
                        str_html += "<tr><td nowrap='nowrap'>查無資料</td></tr>";
                    } else if (response == "error") {
                        alert("系統錯誤");
                    }
                    else {
                        str_html += '<thead>';
                        str_html += '<tr>';
                        str_html += '<th width="60" nowrap="nowrap">操作</th>';
                        str_html += '<th nowrap="nowrap" width="60">員工編號</th>';
                        str_html += '<th nowrap="nowrap" width="150">姓名</th>';
                        str_html += '<th nowrap="nowrap" width="40">加扣別</th>';
                        str_html += '<th nowrap="nowrap" width="80">日期</th>';
                        str_html += '<th nowrap="nowrap" width="55">出勤天數</th>';
                        str_html += '<th nowrap="nowrap" width="55">出勤時數</th>';
                        str_html += '<th nowrap="nowrap">備註</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr trguid="' + response[i].aGuid + '" trleave="' + response[i].aLeave + '" trdate="' + response[i].aAttendanceDate + '" trperguid="' + response[i].aperGuid + '">';
                            str_html += '<td align="center" nowrap="nowrap" class="font-normal"><a name="a_del" aguid="' + response[i].aGuid + '" href="javascript:void(0);">刪除</a></td>';
                            str_html += '<td align="center" nowrap="nowrap">'+response[i].perNo+'</td>';
                            str_html += '<td align="center" nowrap="nowrap">'+response[i].perName+'</td>';
                            if(response[i].aItme=="01"){
                                str_html += '<td align="center" nowrap="nowrap">加項</td>';
                            }
                            if(response[i].aItme=="02"){
                                str_html += '<td align="center" nowrap="nowrap">扣項</td>';
                            }
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].aAttendanceDate + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].aDays + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">'+response[i].aTimes+'</td>';
                            str_html += '<td align="center" nowrap="nowrap">'+response[i].aRemark+'</td>';
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
                    if(response=="error"){
                    
                    } else if (response == "nodata") {

                    } else {
                        $("#hidden_aguid").val(response[0].aGuid);
                        $("#hidden_perguid").val(response[0].aperGuid);
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
                        $("#txt_aRemark").val(response[0].aRemark);
                        $("input[name='txt_aItme'][value='" + response[0].aItme + "']").prop("checked", true);
                        load_person("per", response[0].aperGuid);
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
                    mod_aAttendanceDate: $("#txt_aAttendanceDate").val(),
                    mod_aDays: $("#txt_aDays").val(),
                    mod_aTimes: $("#txt_aTimes").val(),
                    mod_aLeave: $("#txt_aLeave").val(),
                    mod_aGeneralOverTime1: $("#txt_aGeneralOverTime1").val(),
                    mod_aGeneralOverTime2: $("#txt_aGeneralOverTime2").val(),
                    mod_aGeneralOverTime3: $("#txt_aGeneralOverTime3").val(),
                    mod_aOffDayOverTime1: $("#txt_aOffDayOverTime1").val(),
                    mod_aOffDayOverTime2: $("#txt_aOffDayOverTime2").val(),
                    mod_aOffDayOverTime3: $("#txt_aOffDayOverTime3").val(),
                    mod_aHolidayOverTimes: $("#txt_aHolidayOverTimes").val(),
                    mod_aHolidayOverTime1: $("#txt_aHolidayOverTime1").val(),
                    mod_aHolidayOverTime2: $("#txt_aHolidayOverTime2").val(),
                    mod_aHolidayOverTime3: $("#txt_aHolidayOverTime3").val(),
                    mod_aNationalholidays: $("#txt_aNationalholidays").val(),
                    mod_aNationalholidays1: $("#txt_aNationalholidays1").val(),
                    mod_aNationalholidays2: $("#txt_aNationalholidays2").val(),
                    mod_aNationalholidays3: $("#txt_aNationalholidays3").val(),
                    mod_aSpecialholiday: $("#txt_aSpecialholiday").val(),
                    mod_aSpecialholiday1: $("#txt_aSpecialholiday1").val(),
                    mod_aSpecialholiday2: $("#txt_aSpecialholiday2").val(),
                    mod_aSpecialholiday3: $("#txt_aSpecialholiday3").val(),
                    mod_aRemark: $("#txt_aRemark").val(),
                    mod_aItme: $("input[name='txt_aItme']:checked").val(),
                    mod_type: $("#txt_type").text()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response != "error") {
                        if ($("#txt_type").text() == "新增") {
                            alert("新增成功");
                        } else {
                            alert("修改成功");
                        }
                        load_hoursdata();
                    } else {
                        if ($("#txt_type").text() == "新增") {
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
        //檢查輸入欄位
        function chk_data() {
            var chk_perguid = $("#hidden_perguid").val();
            var chk_pername = $("#txt_pername").text();
            var chk_adate = $("#txt_aAttendanceDate").val();
            var chk_item = $("input[name='txt_aItme']:checked").val();
            if (chk_perguid == "" || chk_pername == "" || chk_pername=="無資料") {
                alert("請挑選一個正確的人員");
                return false;
            }
            if (chk_adate=="") {
                alert("請選擇日期");
                return false;
            }
            if (chk_item != "01" && chk_item!="02") {
                alert("請選擇加/扣項");
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
                    leave_date:str_date
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
                    $("#txt_perno").val(pno);
                    $("#txt_pername").text(pname);
                    $("#hidden_perguid").val(gv);
                    load_person("dept",gv);
                    break;
            }
        }
        //撈人員資料
        function load_person(stype,gv) {
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
                        if (stype=="dept") {
                            $("#txt_dept").empty();
                            $("#txt_dept").append("無資料");
                        }
                    } else if (response == "error") {
                        alert("error");
                    } else {
                        if (stype == "per") {
                            $("#txt_perno").val(response[0].perNo);
                            $("#txt_pername").text(response[0].perName);
                        }
                        $("#txt_dept").empty();
                        $("#txt_dept").append(response[0].cbName);
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
                        $("#txt_pername").text("無資料");
                        $("#hidden_perguid").val("");
                        $("#txt_dept").empty();
                    } else if (response == "error") {
                        alert("error");
                    } else {
                        $("#txt_pername").text(response[0].perName);
                        $("#hidden_perguid").val(response[0].perGuid);
                        load_person("per", response[0].perGuid);
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
            for (var i = 0; i < input_num.length;i++){
                if (input_num[i].value != "") {
                    if (!isNaN(input_num[i].value)) {
                        continue;
                    } else {
                        alert("請檢查數字欄位是否輸入其他字元!");
                        return false;
                    }
                }
            }
            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="text" id="hidden_perguid" style="display:none;" />
    <input type="text" id="hidden_aguid" style="display:none;" />
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10T">
                <div class="left font-light">首頁 / 人事資料管理 / <span class="font-black font-bold">時數管理</span></div>
            </div>
            <div class="twocol margin15T">
                <span name="span_hours_search" class="right">
                    日期起：<input type="text" id="search_hours_dates" />
                    日期迄：<input type="text" id="search_hours_datee" />
                    關鍵字：<input id="search_hours_keyword" size="10" />&nbsp;&nbsp;
                    <a href="Javascript:void(0)" class="keybtn" id="btn_hours_inner_search">查詢</a>
                </span>
                <div class="right" name="div_hours">
                    <a href="javascript:void(0);" class="keybtn" id="btn_add">新增</a>
                    <a href="javascript:void(0);" class="keybtn" id="btn_search">查詢</a>
                    <a href="javascript:void(0);" class="keybtn" id="btn_import">匯入工作時數</a>
                </div>
            </div>
        </div>
        <br />
        <br />
        <div class="fixwidth"  name="div_hours">
            <div class="stripeMe fixTable" style="height: 175px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_hours_list"></table>
            </div>
            <!-- overwidthblock -->

        </div>
        <!-- fixwidth -->
        <div class="fixwidth" name="div_hours">
            <!-- 詳細資料start -->
            <div class="statabs margin10T">
                <ul>
                    <li><a href="#tabs-1">時數計算</a></li>
                    <li><a href="#tabs-2">請假紀錄</a></li>
                </ul>
                <div id="tabs-1">
                    <div class="twocol margin15TB">
                        <div class="font-title">維護狀態:<span id="txt_type">新增</span></div>
                        
                        <div class="right">
                            <a href="javascript:void(0);" class="keybtn" id="btn_hours">儲存</a>
                        </div>
                    </div>
                    <div class="tabfixwidth gentable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td class="width17" align="right">
                                    <div class="font-title titlebackicon font-red">員工代號</div>
                                </td>
                                <td class="width13">
                                    <input type="text" class="inputex width50" id="txt_perno" /><img src="../images/btn-search.gif" style="cursor: pointer;" onclick="openfancybox(this)" id="Pbox" />
                                    <span id="txt_pername"></span>
                                </td>
                                <td class="width17" align="right">
                                    <div class="font-title titlebackicon font-red">日期</div>
                                </td>
                                <td class="width13">
                                    <input type="text" size="10" id="txt_aAttendanceDate" />
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
                                    <input type="text" name="num" class="inputex width60" id="txt_aDays" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">出勤時數</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aTimes" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">休假天數</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aLeave" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <div class="font-title titlebackicon ">平常加班時數-1類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aGeneralOverTime1" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">休息加班時數-1類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aOffDayOverTime1" />
                                </td>
                            </tr>

                            <tr>
                                <td align="right">
                                    <div class="font-title titlebackicon">平常加班時數-2類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aGeneralOverTime2" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">休息加班時數-2類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aOffDayOverTime2" />
                                </td>
                            </tr>

                            <tr>
                                <td align="right">
                                    <div class="font-title titlebackicon">平常加班時數-3類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aGeneralOverTime3" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">休息加班時數-3類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aOffDayOverTime3" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <div class="font-title titlebackicon">例假日加班時數(正常)</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aHolidayOverTimes" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">國定假日加班時數(正常)</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aNationalholidays" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">特殊假日加班時數(正常)</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aSpecialholiday" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <div class="font-title titlebackicon">例假日加班時數-1類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aHolidayOverTime1" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">國定假日加班時數-1類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aNationalholidays1" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">特殊假日加班時數-1類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aSpecialholiday1" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <div class="font-title titlebackicon">例假日加班時數-2類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aHolidayOverTime2" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">國定假日加班時數-2類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aNationalholidays2" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">特殊假日加班時數-2類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aSpecialholiday2" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <div class="font-title titlebackicon">例假日加班時數-3類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aHolidayOverTime3" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">國定假日加班時數-3類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aNationalholidays3" />
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">特殊假日加班時數-3類</div>
                                </td>
                                <td>
                                    <input type="text" name="num" class="inputex width60" id="txt_aSpecialholiday3" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <div class="font-title titlebackicon">加扣別</div>
                                </td>
                                <td>
                                    <input type="radio" name="txt_aItme" value="01" />加<input type="radio" name="txt_aItme" value="02" />扣
                                </td>
                                <td align="right">
                                    <div class="font-title titlebackicon">備註</div>
                                </td>
                                <td colspan="3">
                                    <input type="text" class="inputex width100" id="txt_aRemark" />
                                </td>
                            </tr>
                            
                        </table>
                    </div>
                </div>
                <!-- tabs-1 -->
                <div id="tabs-2">

                    <div class=" tabfixwidth">
                        <div class="stripeMe fixTable" style="height: 175px;">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_leave">
                                
                            </table>
                        </div>
                        <!-- overwidthblock -->
                    </div>
                    <!-- fixwidth -->
                </div>
                <!-- tabs-2 -->
            </div>
            <!-- statabs -->
            <!-- 詳細資料end -->
        </div>
        <!-- fixwidth -->
    </div>
    <!-- WrapperMain -->
</asp:Content>

