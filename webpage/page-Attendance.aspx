<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Attendance.aspx.cs" Inherits="webpage_page_Attendance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.blockUI.js") %>"></script>
    <style>
        .stripeMe th {
            border-top:0px;
        }
        .xdsoft_time_box xdsoft_scroller_box {
            height:10px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#sel_dates,#sel_datee").datetimepicker({
                lang: 'zh-TW',
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            //datetimepicker套用
            $("#txt_dates,#txt_datee").datetimepicker({
                lang: 'zh-TW',
                format: 'Y/m/d',//'Y-m-d H:i:s'
                //allowTimes: ['12:00:00 PM', '00:00:00 AM'],//請假不需要其他的時間點 只需要這兩個
                timepicker: false,    //false關閉時間選項 
                defaultDate: false,
                ignoreReadonly: true,
                onSelectDate: function () {
                    if ($("input[name='radio_dates']:checked").val() != undefined && $("input[name='radio_datee']:checked").val() != undefined) {
                        dateDiff();
                    }
                }
            });
            $('.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box').css({ 'height': 'auto' });
            //$("#txt_dates,#txt_datee .").remove(xdsoft_time);
            load_payrange();
            load_PayHoliday();
            //請假記錄匯入 按鈕
            $("#btn_import").click(function () {
                load_payrange();
                $.fancybox({
                    href: "#txtBlock",
                    //type: "iframe",
                    //width: "300",
                    //height: "200",
                    closeClick: false,
                    openEffect: 'elastic',
                    closeEffect: 'elastic'
                });
            });
            //匯入fancybox 確認按鈕
            $("#subbtn").click(function () {
                var start_d = $("#import_payrange option:selected").val();
                var end_d = $("#import_payrange option:selected").attr("value2");
                var sr_guid = $("#import_payrange option:selected").attr("guid");
                if (start_d == "" && end_d == undefined) {
                    alert("請選擇一個計薪週期");
                    return;
                }
                $.fancybox.close();
                //if (confirm("系統將刪除本系統" + start_d + "~" + end_d + "已匯入的請假紀錄，並重新匯入請假紀錄，是否繼續?")) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-Attendance.ashx",
                        data: {
                            func: "copy_and_del_data",
                            copy_dates: start_d,
                            copy_datee: end_d,
                            copy_srguid: sr_guid
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response == "ok") {
                                alert("請假資料匯入成功");
                                $.fancybox.close();
                            } else if (response == "timeout") {
                                alert("請重新登入");
                                location.href = "Page-Login.aspx";
                            }
                            else {
                                alert("請假資料匯入失敗");
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                //}
                
            });
            //查詢按鈕
            $("#btn_sel").click(function () {
                if (chk_sel()) {
                    load_data();
                }
            });
            //工號欄位 change事件
            $(document).on("change", "#txt_person_empno", function () {
                //alert($(this).val());
                load_thispeopledata($(this).val(), "person");
            });
            //日期起迄 keyup事件
            $("#txt_dates,#txt_datee").blur(function () {
                if ($("#txt_dates").val() != "" && $("#txt_dates").val() != "" && $("input[name='radio_dates']:checked").val() != undefined && $("input[name='radio_datee']:checked").val() != undefined) {
                    dateDiff();
                }
            });
            $("input[name='radio_dates'],input[name='radio_datee']").change(function () {
                if ($("#txt_dates").val() != "" && $("#txt_dates").val() != "" && $("input[name='radio_dates']:checked").val() != undefined && $("input[name='radio_datee']:checked").val() != undefined) {
                    dateDiff();
                }
            });
            //假別2天數 輸入
            $("#txt_leave_type2_date").keyup(function () {
                if ($("#txt_leave_type2_date").val() != "" && chk_num($("#txt_leave_type2_date").val()) && parseFloat($("#txt_date").val()).toFixed(1) > 0) {
                    var m_dates = parseFloat($("#txt_date").val()).toFixed(1) - parseFloat($("#txt_leave_type2_date").val()).toFixed(1);
                    $("#txt_leave_type_date").text(m_dates);
                    if (m_dates < 0) {
                        $("#txt_leave_type_date").css('border', '3px solid red');
                    } else {
                        $("#txt_leave_type_date").css('border', '');
                    }
                } else {
                    $("#txt_leave_type2_date").val("");
                    $("#txt_leave_type_date").text($("#txt_date").val());
                }
            });
            //儲存按鈕
            $("#btn_submit").click(function () {
                if (chk_data() && dateDiff()) {
                    mod_data();
                }
            });
            //刪除
            $(document).on("click", "a[name='a_del']", function () {
                $("#hidden_guid").val($(this).attr("aguid"));
                if(confirm("確定刪除?")){
                    del_data();
                }
            });
            //新增
            $("#btn_add").click(function () {
                $("#txt_type").text("新增");
                $("#hidden_guid").val("");
                $("#hidden_id").val("");
                $("#txt_person_empno").val("");
                $("#txt_hidden_person_guid").val("");
                $("#txt_dept").val("");
                $("#txt_hidden_deptno").val("");
                $("#txt_dates").val("");
                $("#txt_datee").val("");
                $("#txt_date").val("");
                $("#txt_leave_type").val("");
                $("#txt_leave_type2").val("");
                $("#txt_ps").val("");
                $("#txt_leave_type2_date").val("");
                $("#txt_person_cname").text("");
                $("#txt_leave_type_date").text("");
                $("#txt_leave_type_date").css('border', '');
                $("#txt_person_empno").removeAttr("disabled");
                $("#Pbox").removeAttr("disabled");
                $("input[name='radio_dates']").removeAttr("checked");
                $("input[name='radio_datee']").removeAttr("checked");
            });
            //tr 點擊事件
            $(document).on("click", "#tbl_list tbody tr td:not(:nth-child(1))", function () {
                $("#hidden_guid").val($(this).closest('tr').attr("trguid"));//修改才會有
                $("#hidden_id").val($(this).closest('tr').attr("trid"));//修改才會有
                $("#txt_type").text("修改");
                load_databyguid();
            });
        });
        //撈計薪週期 下拉選單資料
        function load_payrange() {
            $("#import_payrange").empty();
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-Attendance.ashx",
                data: {
                    func: "load_payrange"
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
                    } else if (response == "timeout") {
                        alert("請重新登入");
                        location.href = "Page-Login.aspx";
                    }
                    else {
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<option value="' + response[i].sr_BeginDate_c + '" value2="' + response[i].sr_Enddate_c + '" guid="' + response[i].sr_Guid + '" >' + response[i].sr_BeginDate + '-' + response[i].sr_Enddate + '</option>';
                        }
                        str_html += '</tbody>';
                    }
                    $("#import_payrange").append(str_html);
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //檢查查詢欄位
        function chk_sel(){
            var chk_sel_dates = $("#sel_dates").val();
            var chk_sel_datee = $("#sel_datee").val();
            if (chk_sel_dates == "" && chk_sel_datee == "") {
                alert("至少選擇一個日期起或日期迄");
                return false;
            }
            return true;
        }
        //撈假單資料
        function load_data(){
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-Attendance.ashx",
                data: {
                    func: "load_data",
                    str_dates: $("#sel_dates").val(),
                    str_datee: $("#sel_datee").val(),
                    str_type: $("#sel_type").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    $("#tbl_list").empty();
                    var str_html = "";
                    if (response == "timeout") {
                        alert("請重新登入");
                        location.href = "Page-Login.aspx";
                    }
                    else if (response != "nodata") {
                        str_html += '<thead>';
                        str_html += '<tr>';
                        str_html += '<th nowrap="nowrap">操作</th>';
                        //str_html += '<th nowrap="nowrap">假單編號</th>';
                        str_html += '<th nowrap="nowrap">員工代號</th>';
                        str_html += '<th nowrap="nowrap">員工姓名</th>';
                        str_html += '<th nowrap="nowrap">日期起</th>';
                        str_html += '<th nowrap="nowrap">日期迄</th>';
                        str_html += '<th nowrap="nowrap">天數</th>';
                        str_html += '<th nowrap="nowrap">假別</th>';
                        str_html += '<th nowrap="nowrap"">事由</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr trguid=' + response[i].leaGuid + ' trid=' + response[i].leaID + '>';
                            if (response[i].leaImportStatus != "Y") {
                                str_html += '<td align="center" nowrap="nowrap" class="font-normal"><a name="a_del" href="javascript:void(0);" aguid=' + response[i].leaGuid + '>刪除</a></td>';
                            } else {
                                str_html += '<td align="center" nowrap="nowrap" class="font-normal"></td>';
                            }
                            
                            //str_html += '<td align="center" nowrap="nowrap">' + response[i].ilItem1 + '</td>';
                            
                            //str_html += '<td align="center" nowrap="nowrap">' + response[i].ilItem4 + '</td>';
                            //str_html += '<td align="center" nowrap="nowrap">' + response[i].ilItem3 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].leaAppilcantId + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].perName + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].leaStratFrom + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].leaEndAt + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].leaDuration + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].leaLeaveType + '</td>';
                            str_html += '<td align="left" nowrap="nowrap">' + response[i].leaRemark + '</td>';
                            str_html += '</tr>';
                        }
                        str_html += '</tbody>';

                    } else {
                        str_html += "<tr><td colspan='6'>查無資料</td></tr>";
                    }
                    $("#tbl_list").append(str_html);
                    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                    $(".stripeMe tr:even").addClass("alt");
                    $(".fixTable").tableHeadFixer();
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //撈假單資料 by guid
        function load_databyguid() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-Attendance.ashx",
                data: {
                    func: "load_data",
                    str_guid: $("#hidden_guid").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response == "timeout") {
                        alert("請重新登入");
                        location.href = "Page-Login.aspx";
                    }
                    else if (response != "nodata") {
                        $("#txt_person_empno").val(response[0].leaAppilcantId);
                        $("#txt_person_cname").text(response[0].perName);
                        $("#txt_dates").val(response[0].leaStratFrom.substr(0, 10));
                        $("#txt_datee").val(response[0].leaEndAt.substr(0, 10));
                        $("#txt_date").val(response[0].leaDuration);
                        $("#txt_leave_type").val(response[0].leaLeaveTypeId);
                        if (response[0].leaLeaveType2 == "0") {
                            $("#txt_leave_type2").val("");
                            $("#txt_leave_type2_date").val("");
                            $("#txt_leave_type_date").text(response[0].leaDuration);
                        } else {
                            $("#txt_leave_type2").val(response[0].leaLeaveType2);
                            $("#txt_leave_type2_date").val(response[0].leaDuration2);
                            $("#txt_leave_type_date").text(parseFloat(response[0].leaDuration) - parseFloat(response[0].leaDuration2));
                        }
                        $("#txt_ps").val(response[0].leaRemark);
                        $("#txt_dept").val("");
                        $("#txt_hidden_deptno").val("");
                        $("#txt_person_empno").attr("disabled", "disabled");
                        $("#Pbox").attr("disabled", "disabled");
                        if (response[0].leaStratFrom.substr(-8) == "12:00:00")
                            $("input[name='radio_dates'][value='0']").prop("checked", true);
                        else
                            $("input[name='radio_dates'][value='1']").prop("checked", true);
                        if (response[0].leaEndAt.substr(-8) == "12:00:00")
                            $("input[name='radio_datee'][value='0']").prop("checked", true);
                        else
                            $("input[name='radio_datee'][value='1']").prop("checked", true);
                        load_thispeopledata(response[0].leaAppilcantId, "person");

                    } else {
                        alert("查無資料");
                        $("#txt_person_empno").val("");
                        $("#txt_hidden_person_guid").val("");
                        $("#txt_dept").val("");
                        $("#txt_hidden_deptno").val("");
                        $("#txt_dates").val("");
                        $("#txt_datee").val("");
                        $("#txt_date").val("");
                        $("#txt_leave_type").val("");
                        $("#txt_leave_type2").val("");
                        $("#txt_ps").val("");
                        $("#txt_leave_type2_date").val("");
                        $("#txt_person_cname").text("");
                        $("#txt_leave_type_date").text("");
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //取的該員工號碼的資料
        function load_thispeopledata(thisno, txttype) {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/pageModify.ashx",
                data: {
                    func: "load_thispeopledata",
                    str_thisno: thisno,
                    str_thistype: txttype
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response != "nodata") {
                        switch (txttype) {
                            case "person":
                                $("#txt_person_empno").val(response[0].perNo);
                                $("#txt_person_cname").text(response[0].perName);
                                $("#txt_hidden_person_guid").val(response[0].perGuid);
                                $("#txt_dept").val(response[0].cbName);
                                $("#txt_hidden_deptno").val(response[0].perDep);
                                break;
                        }

                    } else {
                        switch (txttype) {
                            case "person":
                                $("#txt_person_cname").text("無資料");
                                $("#txt_hidden_pay_perguid").val("");
                                $("#txt_dept").val("無資料");
                                $("#txt_hidden_deptno").val("");
                                break;
                        }
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
                    $("#txt_person_empno").val(pno);
                    $("#txt_person_cname").text(pname);
                    $("#txt_hidden_person_guid").val(gv);
                    load_thispeopledata(pno, "person");
                    break;
            }

        }
        //新增/修改假單資料
        function mod_data() {
            if ($("input[name='radio_dates']:checked").val() == "0") {
                dtStar = $("#txt_dates").val() + " 12:00:00";
            } else {
                dtStar = $("#txt_dates").val() + " 00:00:00";
            }
            if ($("input[name='radio_datee']:checked").val() == "0") {
                dtEnd = $("#txt_datee").val() + " 12:00:00";
            } else {
                dtEnd = $("#txt_datee").val() + " 00:00:00";
            }
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-Attendance.ashx",
                data: {
                    func: "mod_data",
                    mod_dates: dtStar,
                    mod_datee: dtEnd,
                    mod_date: $("#txt_date").val(),
                    mod_empno: $("#txt_person_empno").val(),
                    mod_leave_type: $("#txt_leave_type").val(),
                    mod_leave_type2: $("#txt_leave_type2").val(),
                    mod_leave_type_date: $("#txt_leave_type_date").text(),
                    mod_leave_type2_date: $("#txt_leave_type2_date").val(),
                    mod_ps: $("#txt_ps").val(),
                    mod_type: $("#txt_type").text(),
                    mod_id: $("#hidden_id").val(),
                    mod_guid: $("#hidden_guid").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response == "ok") {
                        alert($("#txt_type").text() + "成功");
                        if ($("#sel_dates").val() != "" ||  $("#sel_datee").val() != "") {
                            load_data();
                        }
                        
                    } else if (response == "timeout") {
                        alert("請重新登入");
                        location.href = "Page-Login.aspx";
                    } else {
                        alert($("#txt_type").text() + "失敗");
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //檢查新增/修改欄位
        function chk_data(){
            var chk_perempno = $("#txt_person_empno").val();//員編
            var chk_pername = $("#txt_person_cname").text();//姓名
            var chk_perdept = $("#txt_dept").val();//部門
            var chk_dates = $("#txt_dates").val();//日期起
            var chk_datee = $("#txt_datee").val();//日期迄
            var chk_date = $("#txt_date").val();//總天數
            var chk_leave_type = $("#txt_leave_type").val();//假別一
            var chk_leave_type2 = $("#txt_leave_type2").val();//假別二
            var chk_leave_type_date = $("#txt_leave_type_date").text();//假別一天數
            var chk_leave_type_date2 = $("#txt_leave_type2_date").val();//假別二天數
            var chk_ps = $("#txt_ps").val();//事由
            if (chk_perempno == "" || chk_pername == "" || chk_pername == "無資料" || chk_perdept == "" || chk_perdept == "無資料") {
                alert("請挑選一個正確的人員");
                return false;
            }
            if (chk_dates == "" || chk_datee == "") {
                alert("請選擇日期起迄");
                return false;
            }
            if ($("input[name='radio_dates']:checked").val() == undefined) {
                alert("請選擇日期起為全天或半天");
                return false;
            }
            if ($("input[name='radio_datee']:checked").val() == undefined) {
                alert("請選擇日期迄為全天或半天");
                return false;
            }
            if(chk_date == "" || chk_date == "0"){
                alert("請選擇正確的日期起迄");
                return false;
            }
            chk_dates = chk_dates + $("input[name='radio_dates']:checked").val();
            chk_datee = chk_datee + $("input[name='radio_datee']:checked").val();
            if (chk_leave_type=="") {
                alert("請選擇假別");
                return false;
            }
            if (chk_leave_type == "") {
                alert("請選擇假別");
                return false;
            }
            //總天數!=假別一天數  表示有假別二
            if ((parseFloat(chk_date).toFixed(1)) != (parseFloat(chk_leave_type_date).toFixed(1))) {
                if (chk_leave_type2 == "") {
                    alert("請選擇假別2");
                    return false;
                }
            }
            if (chk_leave_type_date2 != "" && chk_leave_type_date2 != "0" && chk_leave_type_date2 != "0.0" && chk_leave_type2 == "" && chk_num(chk_leave_type_date2) == true) {
                alert("請選擇假別2");
                return false;
            }
            if (chk_leave_type2 != "" && chk_leave_type_date2!="" && isNaN(chk_leave_type_date2) && chk_leave_type_date2 != "0" && chk_leave_type_date2 != "0.0") {
                alert("請輸入正確的假別2天數");
                return false;
            } else {
                var chk_leave_type_date = parseFloat(chk_leave_type_date).toFixed(1);
                var chk_leave_type_date2 = parseFloat(chk_leave_type_date2).toFixed(1);
                if (chk_leave_type_date < 0) {
                    alert("假別1天數為負數請檢查假別2天數");
                    return false;
                }
                if (chk_leave_type_date.toString().substr(-2) != ".0" && chk_leave_type_date.toString().substr(-2) != ".5") {
                    alert("請檢查假別2天數不為半天或整天");
                    return false;
                }
                if (chk_leave_type_date2 < 0) {
                    alert("假別2為負數請檢查假別2天數");
                    return false;
                }
                if (chk_leave_type_date == 0) {
                    alert("假別1為0天請檢查假別2天數");
                    return false;
                }
            }
            if ((parseFloat($("#txt_date").val()).toFixed(1))<0) {
                alert("請檢查假別天數");
                return false;
            }
            if (chk_ps=="") {
                alert("請輸入事由");
                return false;
            }
            return true;
        }
        //刪除資料
        function del_data(){
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-Attendance.ashx",
                data: {
                    func: "del_data",
                    del_guid: $("#hidden_guid").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response == "ok") {
                        alert("刪除成功");
                        load_data();
                    } else if (response == "timeout") {
                        alert("請重新登入");
                        location.href = "Page-Login.aspx";
                    } else {
                        alert("刪除失敗");
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //撈假別名稱
        function load_PayHoliday() {
            $("#txt_leave_type").empty();
            $("#txt_leave_type2").empty();
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-hourlyadmin.ashx",
                data: {
                    func: "load_phdata",
                    str_keyword: ""
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response == "timeout") {
                        alert("請重新登入");
                        location.href = "Page-Login.aspx";
                    } else {
                        var str_html = "<option value=''>-----請選擇-----</option>";
                        if (response != "nodata") {

                            for (var i = 0; i < response.length; i++) {
                                str_html += "<option value='" + response[i].phCode + "'>" + response[i].phName + "</option>";
                            }
                            str_html += "</tbody>";
                        }
                        $("#txt_leave_type").append(str_html);
                        $("#txt_leave_type2").append(str_html);
                    }
                    
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //計算時間
        function dateDiff() {
            if ($("input[name='radio_dates']:checked").val() == undefined) {
                alert("請選擇日期起為全天或半天");
                return false;
            }
            if ($("input[name='radio_datee']:checked").val() == undefined) {
                alert("請選擇日期迄為全天或半天");
                return false;
            }
            var dtStar;
            var dtEnd;
            if ($("input[name='radio_dates']:checked").val() == "0") {
                dtStar = $("#txt_dates").val() + " 12:00:00";
            } else {
                dtStar = $("#txt_dates").val() + " 00:00:00";
            }
            if ($("input[name='radio_datee']:checked").val() == "0") {
                dtEnd = $("#txt_datee").val() + " 12:00:00";
            } else {
                dtEnd = $("#txt_datee").val() + " 00:00:00";
            }
            if (dtStar != "" && dtEnd != "") {
                var sDT = new Date(dtStar);
                var eDT = new Date(dtEnd);
                //錯      2017/05/02 12:00 - 2017/05/01 00:00 
                //對 半天 2017/05/02 12:00 - 2017/05/02 00:00 
                if (sDT.dateDiff("h", eDT) < 0 && sDT.dateDiff("d", eDT) != 0) {
                    alert("請選擇正確的時間區間");
                    return false;
                }
                else {
                    if (dtStar.substring(11) != "12:00:00" && dtStar.substring(11) != "00:00:00") {
                        alert("請輸入正確的時間區間");
                        return false;
                    }
                    var diff_h = sDT.dateDiff("h", eDT);
                    //如果相減=0
                    if (diff_h == 0) {
                        //表示請半天
                        if (dtStar.substring(11) == "12:00:00") {
                            $("#txt_date").val("0.5");
                            $("#txt_leave_type_date").text("0.5");
                        }
                        //表示請整天
                        if (dtStar.substring(11) == "00:00:00" && $("#txt_leave_type2_date").val()!="0.5") {
                            $("#txt_date").val("1.0");
                            $("#txt_leave_type_date").text("1.0");
                        }
                        return true;
                    } else {
                        if ((diff_h / 24).toFixed(1) < 0) {
                            //狀況 請半天的 2017/05/04 12:00:00 - 2017/05/04 00:00:00
                            $("#txt_date").val((-(diff_h / 24).toFixed(1)));
                        } else {
                            //狀況 請超過半天的(1.5、2.5、3.5....等) 2017/05/04 12:00:00 - 2017/05/05 00:00:00
                            //狀況 請超過半天的(2、3、4....等) 2017/05/04 00:00:00 - 2017/05/05 00:00:00
                            $("#txt_date").val(((diff_h / 24) + 1).toFixed(1));
                        }
                        if ($("#txt_leave_type2_date").val() != "" && chk_num($("#txt_leave_type2_date").val())) {
                            $("#txt_leave_type_date").text(parseFloat($("#txt_date").val()).toFixed(1) - parseFloat($("#txt_leave_type2_date").val()).toFixed(1));
                        } else {
                            $("#txt_leave_type_date").text($("#txt_date").val());
                        }
                        return true;

                    }
                }//判斷結束時間是否小於開始時間else end
            } else {
                return false;
            }
        }
        //檢查數字
        function chk_num(str_num) {
            if (isNaN(str_num)) {
                alert("請輸入數字");
                return false;
            }
            return true;
        }
        Date.prototype.dateDiff = function (interval, objDate) {
            var dtEnd = new Date(objDate);
            if (isNaN(dtEnd)) return undefined;
            switch (interval) {
                case "s": return parseInt((dtEnd - this) / 1000);
                case "n": return parseInt((dtEnd - this) / 60000);
                case "h": return parseInt((dtEnd - this) / 3600000);
                case "d": return parseInt((dtEnd - this) / 86400000);
                case "w": return parseInt((dtEnd - this) / (86400000 * 7));
                case "m": return (dtEnd.getMonth() + 1) + ((dtEnd.getFullYear() - this.getFullYear()) * 12) - (this.getMonth() + 1);
                case "y": return dtEnd.getFullYear() - this.getFullYear();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10T">
                <div class="left font-light">首頁 / 出勤管理 / <span class="font-black font-bold">請假資料維護</span></div>
            </div>
            <div class="twocol margin15T">
                <div class="left">
                    日期起：<input type="text" id="sel_dates" size="12" />
                    日期迄：<input type="text" id="sel_datee" size="12" />
                    資料別：
                    <select id="sel_type">
                        <option value="all">全部</option>
                        <option value="">手動新增</option>
                        <option value="Y">匯入資料</option>
                    </select>
                    <a href="javascript:void(0);" class="keybtn" id="btn_sel">查詢</a>
                </div>
                <div class="right">
                    <a href="javascript:void(0);" class="keybtn" id="btn_add">新增</a>
                    <a href="javascript:void(0);" class="keybtn" id="btn_import">請假記錄匯入</a>
                </div>
            </div>
        </div>
        <div class=" fixwidth " style="margin-top: 10px">
            <div class="stripeMe fixTable" style="height: 275px;">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_list">
                </table>
            </div>
            <!-- overwidthblock -->
        </div>
        <!-- fixwidth -->

        <div class="fixwidth">
            <div class="twocol margin15TB">
                <div class="right">
                    <a href="javascript:void(0)" class="keybtn" id="btn_submit">儲存</a>
                </div>
            </div>
        </div>
        <div class="fixwidth" style="margin-top: 20px;">
            <div class="statabs margin10T">
                <div class="gentable ">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        
                        <tr>
                            <td class="width10" align="right">
                                <div class="font-title titlebackicon" style="color: Red">員工編號</div>
                            </td>
                            <td class="width20">
                                <input type="text" class="inputex width60" id="txt_person_empno" />
                                <img id="Pbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor: pointer;" />
                                <span id="txt_person_cname"></span>
                                <input type="text" id="txt_hidden_person_guid" style="display: none;" />
                            </td>
                            <td class="width10" align="right">
                                <div class="font-title titlebackicon" style="color: Red">部門</div>
                            </td>
                            <td class="width20">
                                <input type="text" class="inputex width95" id="txt_dept" disabled="disabled" />
                                <input type="text" class="inputex width95" style="display:none;" id="txt_hidden_deptno"/>
                            </td>
                            <td class="width10" align="right">
                                <div class="font-title titlebackicon">維護狀態</div>
                                <!--<div class="font-title titlebackicon" style="color: Red">假單編號</div>-->
                            </td>
                            <td class="width15">
                                <span class="width15" align="left" id="txt_type">新增</span>
                                <!--<input type="text" class="inputex width95" id="txt_num" value="A000001" />-->
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <div class="font-title titlebackicon" style="color: Red">日期起</div>
                            </td>
                            <td>
                                <input type="text" id="txt_dates" size="10" />
                                <input type="radio" name="radio_dates" value="0" />半天
                                <input type="radio" name="radio_dates" value="1" />全天
                            </td>
                            <td align="right">
                                <div class="font-title titlebackicon" style="color: Red">日期迄</div>
                            </td>
                            <td>
                                <input type="text" id="txt_datee" size="10" />
                                <input type="radio" name="radio_datee" value="0" />半天
                                <input type="radio" name="radio_datee" value="1" />全天
                            </td>
                            <td align="right">
                                <div class="font-title titlebackicon" style="color: Red">天數</div>
                            </td>
                            <td>
                                <input type="text" id="txt_date" size="5" disabled="disabled" /></td>
                        </tr>
                        <tr>
                            <td align="right">
                                <div class="font-title titlebackicon" style="color: Red">假別</div>
                            </td>
                            <td colspan="2">
                                <select id="txt_leave_type"></select>
                                <span class="font-title titlebackicon">假別1天數</span>
                                <span id="txt_leave_type_date" ></span>
                            </td>
                            
                            <td align="right">
                                <div class="font-title titlebackicon" style="color: Red">假別2</div>
                            </td>
                            <td colspan="2">
                                <select id="txt_leave_type2"></select>
                                <span class="font-title titlebackicon">假別2天數</span>
                                <input type="text" id="txt_leave_type2_date" size="3" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="right">
                                <div class="font-title titlebackicon" style="color: Red">事由</div>
                            </td>
                            <td colspan="5">
                                <input type="text" id="txt_ps" class="inputex width100" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <input type="text" style="display:none;" id="hidden_guid" />
            <input type="text" style="display:none;" id="hidden_id" />
        </div>

        <div id="txtBlock" style="display:none;width:300px;height:120px;">
            <div style="color:#8b3c31;font-size:18px;">請假記錄匯入</div><br />
            <div>
                <span style="color:red;">計薪週期：</span>
                <select id="import_payrange">
                    
                </select>
            </div>
            <br />
            <div class="right" style="text-align:right;width:298px;">
                <input class="keybtn" id="subbtn" type="button" value="確認" />
            </div>
            <div id="loadblock" style="display: none; text-align: center;">
                <img src="../images/loading.gif" />處理中，請稍待
            </div>
        </div>
    </div>
    <!-- WrapperMain -->
</asp:Content>

