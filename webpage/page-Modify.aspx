﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Modify.aspx.cs" Inherits="webpage_page_Modify" %>

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
            //人事異動 工號欄位 change事件
            $(document).on("change", "#txt_person_empno", function () {
                //alert($(this).val());
                load_thispeopledata($(this).val(),"person");
            });
            $(".li_clk").click(function () {
                switch ($(this).attr("id")) {
                    case "li_1":
                        call_changedata();//撈異動項目下拉選單選項
                        call_personchangedata();//撈人事異動資料
                        break;
                    case "li_2":
                        call_paychangedata();//撈薪資異動資料
                        break;
                }
            });
            //預設查詢區塊隱藏
            $("#span_person_search").hide();
            $("#span_pay_search").hide();
            //套用datetimepicker
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#txt_person_change_date,#search_person_date,#txt_pay_change_date,#search_pay_date").datetimepicker({
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            //人事異動 一開始預設確認日是今天 確認者是操作者
            var today_ymd = get_datenow();
            var now_user = "<%=Session["MemberInfo_Name"] %>";;//目前還沒有登入這塊 先寫死
            $("#txt_person_chkdate,#txt_pay_chkdate").val(today_ymd);
            $("#txt_person_chkpeople,#txt_pay_chkpeople").val(now_user);

            call_changedata();//撈異動項目下拉選單選項
            call_personchangedata();//撈人事異動資料

            //************************************************人事異動 STAR*********************************************//
            //人事異動 外面的查詢按鈕
            $("#btn_person_search").click(function () {
                $("#btn_person_search").hide();
                $("div[name=div_person_data]").hide();
                $("#span_person_search").show();
            });
            //人事異動 裡面的查詢按鈕
            $("#btn_person_inner_search").click(function () {
                $("#btn_person_search").show();
                $("div[name=div_person_data]").show();
                $("#span_person_search").hide();
                call_personchangedata();
                $("#search_person_date").val("");
                $("#search_person_keyword").val("");
                $("#search_person_status").val("");
            });
            //人事異動 新增按鈕
            $("#btn_person_add").click(function () {
                $("#txt_person_empno").val("");
                $("#txt_person_change_date").val("");
                $("#txt_person_change_pro").val("")
                $("#td_person_before").empty();
                $("#td_person_after").empty();
                $("#txt_person_chkdate").val(today_ymd);
                $("#txt_person_chkpeople").val(now_user);
                $("#txt_person_cname").text("");
                $("#txt_person_ps").val("");
                $("input[name='txt_person_status']").removeAttr("checked");
                $("#hidden_person_status").val("");
            });
            //人事異動 儲存按鈕
            $("#btn_person_submit").click(function () {
                mod_persondata();
            });
            //人事異動 異動項目下拉選單chaange
            $("#txt_person_change_pro").change(function () {
                //$("#txt_person_cname").text("無資料");
                //$("#txt_hidden_person_guid").val("");
                if ($("#txt_person_cname").text() != "無資料" && $("#txt_hidden_person_guid").val() != "" && $("#txt_person_empno").val() != "") {
                    var str_sel_html = "";
                    var change_type = $(this).val();//01部門調動 02職務異動 03留職停薪 04離職
                    if (change_type == "01") {
                        $("#td_person_before,#td_person_after").empty();
                        //塞下拉選單 撈分店代碼檔
                        $("#td_person_before").append("<select id='select_before' disabled></select>");
                        $("#td_person_after").append("<select id='select_after'></select>");
                        call_storedata();
                        load_thispeopledata($("#txt_person_empno").val());
                    }
                    if (change_type == "02") {
                        $("#td_person_before,#td_person_after").empty();
                        //塞下拉選單 撈職務代碼檔
                        $("#td_person_before").append("<select id='select_before' disabled></select>");
                        $("#td_person_after").append("<select id='select_after'></select>");
                        call_prodata();
                        load_thispeopledata($("#txt_person_empno").val());
                    }
                    if (change_type == "03" || change_type == "04" || change_type == "05") {
                        if (change_type == "04") {
                            $("#td_person_before,#td_person_after").empty();
                            $("#td_person_after").append("<input type='text' id='select_after' class='inputex width60' maxlength='50' />");
                            load_thispeopledata($("#txt_person_empno").val());
                            $("#select_after").datetimepicker({
                                format: 'Y/m/d',//'Y-m-d H:i:s'
                                timepicker: false,    //false關閉時間選項 
                                defaultDate: false
                            });
                        } else {
                            $("#td_person_before,#td_person_after").empty();
                            $("#td_person_before").append("<input type='text' id='select_before' class='inputex width60' maxlength='50' />");
                            $("#td_person_after").append("<input type='text' id='select_after' class='inputex width60' maxlength='50' />");
                        }


                    }
                } else {
                    alert("請先輸入或挑選一位正確的人員");
                }

            });
            //人事異動 tr 點擊事件
            $(document).on("click", "#div_person_list tbody tr td:not(:nth-child(1))", function () {
                $("#td_person_before,#td_person_after").empty();
                $("#txt_person_empno").val("");
                $("#txt_hidden_person_guid").val("");
                $("#txt_person_cname").text("");
                $("#txt_person_change_date").val("");
                $("#txt_person_change_pro").val("");
                $("#select_before").val("");
                $("#select_after").val("");
                $("#txt_person_chkdate").val(today_ymd);
                $("#txt_person_chkpeople").val(now_user);
                $("#input[name='txt_person_status']:checked").val();
                $("#txt_person_ps").val("");
                $("#span_person_Status").text("修改");
                $("#hidden_pcguid").val($(this).closest('tr').attr("trguid"));//修改才會有
                call_personchangedata_byguid();
            });
            //撈人事異動的異動項目
            function call_changedata() {
                $("#txt_person_change_pro").empty();
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/pageModify.ashx",
                    data: {
                        func: "load_person_changedata"
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        var str_html = "<option value=''>----請選擇----</option>";
                        if (response != "nodata") {
                            for (var i = 0; i < response.length; i++) {
                                str_html += "<option value='" + response[i].code_value + "'>" + response[i].code_desc + "</option>";
                            }
                        }
                        $("#txt_person_change_pro").append(str_html);
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //撈分店的下拉選單項目
            function call_storedata() {
                $("#select_after_store").empty();
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/pageModify.ashx",
                    data: {
                        func: "load_storedata"
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        var str_html = "<option value=''>----請選擇----</option>";
                        if (response != "nodata") {
                            for (var i = 0; i < response.length; i++) {
                                var str_selected = "";
                                if ($("#hidden_end").val() == response[i].cbGuid) {
                                    str_selected = "selected";
                                }
                                str_html += "<option value='" + response[i].cbGuid + "' " + str_selected + ">" + response[i].cbName + "</option>";
                            }
                        }
                        $("#select_after").append(str_html);
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //撈職務的下拉選單項目
            function call_prodata() {
                $("#select_after_store").empty();
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/pageModify.ashx",
                    data: {
                        func: "load_prodata"
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        var str_html = "<option value=''>----請選擇----</option>";
                        if (response != "nodata") {
                            for (var i = 0; i < response.length; i++) {
                                var str_selected = "";
                                if ($("#hidden_end").val() == response[i].code_value) {
                                    str_selected = "selected";
                                }
                                str_html += "<option value='" + response[i].code_value + "' " + str_selected + ">" + response[i].code_desc + "</option>";
                            }
                        }
                        $("#select_after").append(str_html);
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //撈人事異動資料
            function call_personchangedata() {
                if (chk_date($("#search_person_date").val())) {
                    $("#div_person_list").empty();
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/pageModify.ashx",
                        data: {
                            func: "load_personchangedata",
                            str_person_date: $("#search_person_date").val(),
                            str_person_keyword: $("#search_person_keyword").val(),
                            str_person_status: $("#search_person_status").val()
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
                                str_html += "<th nowrap='nowrap' width='60'>操作</th>";
                                str_html += "<th nowrap='nowrap' >員工代號</th>";
                                str_html += "<th nowrap='nowrap' >員工姓名</th>";
                                str_html += "<th nowrap='nowrap' >異動日期</th>";
                                str_html += "<th nowrap='nowrap' >異動項目名稱</th>";
                                str_html += "<th nowrap='nowrap' >異動前</th>";
                                str_html += "<th nowrap='nowrap' >異動後</th>";
                                str_html += "<th nowrap='nowrap' >確認日</th>";
                                str_html += "<th nowrap='nowrap' >確認者名稱</th>";
                                str_html += "<th nowrap='nowrap' >狀態</th>";
                                str_html += "<th nowrap='nowrap' >備註</th>";
                                str_html += "</tr>";
                                str_html += "</thead>";
                                str_html += "<tbody>";
                                for (var i = 0; i < response.length; i++) {
                                    str_html += "<tr trguid='" + response[i].pcGuid + "'>";
                                    str_html += "<td align='center' class='font-normal' nowrap='nowrap'><a href='javascript:void(0);' name='del_person_a' aguid='" + response[i].pcGuid + "'>刪除</a></td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].perNo + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].perName + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].pcChangeDate + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].ChangeCName + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].begin_name + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].end_name + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].pcVenifyDate + "</td>";
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].pcVenify + "</td>";
                                    if (response[i].pcStatus == "0") {
                                        str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;color:red;'>待確認</td>";
                                    } else {
                                        str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>已確認</td>";
                                    }

                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].pcPs + "</td>";
                                    str_html += "</tr>";
                                }
                                str_html += "</tbody>";
                            } else {
                                str_html += "<td colspan='6' nowrap='nowrap' style='cursor: pointer;'>查無資料</td>";
                            }
                            $("#div_person_list").append(str_html);
                            $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                            $(".stripeMe tr:even").addClass("alt");
                            $(".fixTable").tableHeadFixer();
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }

            }
            //撈人事異動資料 by guid
            function call_personchangedata_byguid() {
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/pageModify.ashx",
                    data: {
                        func: "load_personchangedata",
                        str_search_person_guid: $("#hidden_pcguid").val()
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        if (response != "nodata") {
                            $("#txt_person_empno").val(response[0].perNo);
                            $("#txt_hidden_person_guid").val(response[0].pcPerGuid);
                            $("#txt_person_cname").text(response[0].perName);
                            $("#txt_person_change_date").val(response[0].pcChangeDate);
                            $("#txt_person_change_pro").val(response[0].pcChangeName);
                            $("#hidden_end").val("");
                            if (response[0].pcChangeName == "01") {
                                $("#hidden_end").val(response[0].pcChangeEnd);
                                $("#td_person_before").append("<select id='select_before' disabled></select>");
                                $("#td_person_after").append("<select id='select_after'></select>");
                                call_storedata();
                                load_thispeopledata(response[0].perNo,"person");
                            }
                            if (response[0].pcChangeName == "02") {
                                $("#hidden_end").val(response[0].pcChangeEnd);
                                $("#td_person_before").append("<select id='select_before' disabled></select>");
                                $("#td_person_after").append("<select id='select_after'></select>");
                                call_prodata();
                                load_thispeopledata(response[0].perNo, "person");
                            }
                            if (response[0].pcChangeName == "03" || response[0].pcChangeName == "04" || response[0].pcChangeName == "05") {
                                $("#td_person_before").append("<input type='text' id='select_before' class='inputex width60' maxlength='50' value='" + response[0].pcChangeBegin + "' disabled='disabled' />");
                                $("#td_person_after").append("<input type='text' id='select_after' class='inputex width60' value='" + response[0].pcChangeEnd + "' maxlength='50' />");
                                if (response[0].pcChangeName == "04") {
                                    $("#select_after").datetimepicker({
                                        format: 'Y/m/d',//'Y-m-d H:i:s'
                                        timepicker: false,    //false關閉時間選項 
                                        defaultDate: false
                                    });
                                }
                            }
                            //$("#select_before").val(response[0].perNo);
                            //$("#select_after").val(response[0].perNo);
                            if (response[0].pcStatus == "1") {
                                $("#txt_person_chkdate").val(response[0].pcVenifyDate);
                                $("#txt_person_chkpeople").val(response[0].pcVenify);
                            } else {
                                $("#txt_person_chkdate").val(today_ymd);
                                $("#txt_person_chkpeople").val(now_user);
                            }
                            
                            $("input[name='txt_person_status'][value='" + response[0].pcStatus + "']").prop("checked", true);
                            $("#txt_person_ps").val(response[0].pcPs);
                            $("#hidden_person_status").val(response[0].pcStatus);
                            $("#txt_person_change_pro").attr("disabled", "disabled")
                        } else {
                            alert("");
                        }

                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //人事異動 新增/修改
            function mod_persondata() {
                if ($("#span_person_Status").text() == "修改" && $("#hidden_person_status").val() == "1") {
                    alert("已確認資料不能再修改");
                } else {
                    if (chk_person_moddata()) {
                        $.ajax({
                            type: "POST",
                            async: true, //在沒有返回值之前,不會執行下一步動作
                            url: "../handler/pageModify.ashx",
                            data: {
                                func: "mode_persondata",
                                mod_empno: $("#txt_person_empno").val(),
                                mod_person_guid: $("#txt_hidden_person_guid").val(),
                                mod_change_date: $("#txt_person_change_date").val(),
                                mod_change_pro: $("#txt_person_change_pro").val(),
                                mod_before: $("#select_before").val(),
                                mod_after: $("#select_after").val(),
                                mod_chkdate: $("#txt_person_chkdate").val(),
                                mod_chkpeople: $("#txt_person_chkpeople").val(),
                                mod_status: $("input[name='txt_person_status']:checked").val(),
                                mod_ps: $("#txt_person_ps").val(),
                                mod_addormod: $("#span_person_Status").text(),
                                mod_hidden_pcguid: $("#hidden_pcguid").val()//修改才會有
                            },
                            error: function (xhr) {
                                alert("error");
                            },
                            beforeSend: function () {
                                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                            },
                            success: function (response) {
                                if (response != "error") {
                                    if ($("#span_person_Status").text() == "新增") {
                                        alert("新增成功");
                                    } else {
                                        alert("修改成功");
                                    }
                                    $("#search_person_keyword").val("");
                                    $("#search_person_date").val("");
                                    $("input[name='search_person_status']").removeAttr("checked");
                                    if ($("input[name='txt_person_status']:checked").val() == "1" && $("#txt_person_change_pro").val() == "04") {
                                        //如果選"離職"而且"已確認"
                                        if (confirm("是否要退保?")) {
                                            $.ajax({
                                                type: "POST",
                                                async: true, //在沒有返回值之前,不會執行下一步動作
                                                url: "../handler/pageModify.ashx",
                                                data: {
                                                    func: "per_back",
                                                    back_person_guid: $("#txt_hidden_person_guid").val(),
                                                    back_date: $("#txt_person_change_date").val()
                                                },
                                                error: function (xhr) {
                                                    alert("error");
                                                },
                                                beforeSend: function () {
                                                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                                                },
                                                success: function (response) {
                                                    if (response != "error") {
                                                        alert("退保成功");
                                                        call_personchangedata();
                                                    }
                                                },//success end
                                                complete: function () {
                                                    $.unblockUI();
                                                }
                                            });//ajax end
                                        }
                                    }
                                    $("#hidden_person_status").val($("input[name='txt_person_status']:checked").val());
                                    call_personchangedata();
                                }
                            },//success end
                            complete: function () {
                                $.unblockUI();
                            }
                        });//ajax end
                    }
                }
                
            }
            //人事異動 刪除
            $(document).on("click", "a[name='del_person_a']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/pageModify.ashx",
                        data: {
                            func: "del_personchangedata",
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
                                call_personchangedata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            });
            //************************************************人事異動 END*********************************************//

            //************************************************薪資異動 STAR*********************************************//
            
            $("#txt_hidden_pay_siguid").val("");
            $("#txt_hidden_pay_perguid").val("");
            $("#hidden_pay_refcode").val("");
            //薪資異動 外面的查詢按鈕
            $("#btn_pay_search").click(function () {
                $("#btn_pay_search").hide();
                $("#span_pay_right_btn").hide();
                $("#a_pay_manychk").hide();
                $("div[name=div_pay_data]").hide();
                $("#span_pay_search").show();
            });
            //薪資異動 裡面的查詢按鈕
            $("#btn_pay_inner_search").click(function () {
                $("#btn_pay_search").show();
                $("#span_pay_right_btn").show();
                $("#a_pay_manychk").show();
                $("div[name=div_pay_data]").show();
                $("#span_pay_search").hide();
                call_paychangedata();
                $("#search_pay_date").val("");
                $("#search_pay_keyword").val("");
                $("#search_pay_status").val("");
            });
            //薪資異動 新增按鈕
            $("#btn_pay_add").click(function () {
                $("#txt_pay_empno").val("");
                $("#txt_pay_change_date").val("");
                $("#txt_pay_change_pro").val("")
                $("#txt_pay_before").val("");
                $("#txt_pay_after").val("");
                $("#txt_pay_chkdate").val(today_ymd);
                $("#txt_pay_chkpeople").val(now_user);
                $("#txt_pay_siname").val("");
                $("#txt_hidden_pay_siguid").val("");
                $("#txt_hidden_pay_perguid").val("");
                $("#PCbox").removeAttr("disabled");
                $("#txt_pay_ps").val("");
                $("input[name='txt_pay_status']").removeAttr("checked");
                $("#txt_pay_before").removeAttr("disabled");
                $("#span_pay_Status").text("新增");
                $("#txt_pay_cname").text("");
                $("#hidden_pay_refcode").val("");
            });
            //薪資異動 儲存按鈕
            $("#btn_pay_submit").click(function () {
                mod_paydata();
            });
            
            //薪資異動 tr 點擊事件
            $(document).on("click", "#div_pay_list tbody tr td:not(:nth-child(1),:nth-child(2))", function () {
                $("#hidden_pay_guid").val($(this).closest('tr').attr("trguid"));//修改才會有
                $("#span_pay_Status").text("修改");
                call_paychangedata_byguid();
            });
            //刪除 薪資異動資料
            $(document).on("click", "a[name='del_pay_a']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/pageModify.ashx",
                        data: {
                            func: "del_paychangedata",
                            del_pay_guid: $(this).attr("aguid")
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
                                call_paychangedata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            });
            //薪資異動 工號欄位 change事件
            $(document).on("change", "#txt_pay_empno", function () {
                //alert($(this).val());
                load_thispeopledata($(this).val(),"pay");
            });
            //全選
            $(document).on("change", "#clickAll", function () {
                if ($("#clickAll").prop("checked")) {
                    $("input[name='pay_box[]']").each(function () {
                        $(this).prop("checked", true);
                    });
                } else {
                    $("input[name='pay_box[]']").each(function () {
                        $(this).prop("checked", false);
                    });
                }
            });
            //checkbox點選事件
            $(document).on("change", "input[name='pay_box[]']", function () {
                checkOrRemoveCheckAll();
            });
            //批次審核
            $("#a_pay_manychk").click(function () {
                var arr = [];
                var arr2 = [];
                var arr3 = [];
                var arr4 = [];
                var arr5 = [];
                $("input[name='pay_box[]']:checked").each(function () {
                    arr.push($(this).attr("guid"));
                    arr2.push($(this).attr("aftertmoney"));
                    arr3.push($(this).attr("siRef"));
                    arr4.push($(this).attr("perguid"));
                    arr5.push($(this).attr("pacguid"));
                });
                if (arr.length > 0) {
                    var aaa = arr.toString();
                    var bbb = arr2.toString();
                    var ccc = arr3.toString();
                    var ddd = arr4.toString();
                    var eee = arr5.toString();
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/pageModify.ashx",
                        data: {
                            func: "manychk_paychangedata",
                            str_payguid: aaa,
                            str_aftertmoney: bbb,
                            str_siRef: ccc,
                            str_perguid: ddd,
                            str_pacguid: eee
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response != "error") {
                                alert("批次審核成功，共" + response + "筆資料");
                                call_paychangedata();
                            } else {
                                alert("操作失敗");
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                } else {
                    alert("請勾選至少一個項目");
                }
                
                
            });
            //薪資異動 批次匯入按鈕
            $("#btn_pay_import").click(function () {
                $.fancybox({
                    href: "PACImport.aspx",
                    type: "iframe",
                    width: "430",
                    height: "480",
                    closeClick: false,
                    openEffect: 'elastic',
                    closeEffect: 'elastic'
                });
            });
            //************************************************薪資異動 END*********************************************//
            
        });
        //撈薪資異動資料
        function call_paychangedata() {
            if (chk_date($("#search_pay_date").val())) {
                $("#div_pay_list").empty();
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/pageModify.ashx",
                    data: {
                        func: "load_paychangedata",
                        str_pay_date: $("#search_pay_date").val(),
                        str_pay_keyword: $("#search_pay_keyword").val(),
                        str_pay_status: $("#search_pay_status").val()
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
                            str_html += "<th nowrap='nowrap' width='45'><input type='checkbox' id='clickAll' /></th>";
                            str_html += "<th nowrap='nowrap' width='60'>操作</th>";
                            str_html += "<th nowrap='nowrap' >員工代號</th>";
                            str_html += "<th nowrap='nowrap' >員工姓名</th>";
                            str_html += "<th nowrap='nowrap' >異動日期</th>";
                            str_html += "<th nowrap='nowrap' >異動前金額</th>";
                            str_html += "<th nowrap='nowrap' >異動後金額</th>";
                            str_html += "<th nowrap='nowrap' >確認日</th>";
                            str_html += "<th nowrap='nowrap' >確認者名稱</th>";
                            str_html += "<th nowrap='nowrap' >狀態</th>";
                            str_html += "<th nowrap='nowrap' >備註</th>";
                            str_html += "</tr>";
                            str_html += "</thead>";
                            str_html += "<tbody>";
                            for (var i = 0; i < response.length; i++) {
                                str_html += "<tr trguid='" + response[i].pacGuid + "'>";
                                if (response[i].pacStatus == "0") {
                                    str_html += "<td align='center' class='font-normal' nowrap='nowrap'><input type='checkbox' name='pay_box[]' guid='" + response[i].pacGuid + "' aftertmoney='" + response[i].pacChangeEnd + "' siRef='" + response[i].siRef + "' perguid='" + response[i].pacPerGuid + "' pacguid='" + response[i].pacGuid + "' /></td>";
                                } else {
                                    str_html += "<td align='center' class='font-normal' nowrap='nowrap'></td>";
                                }

                                str_html += "<td align='center' class='font-normal' nowrap='nowrap'><a href='javascript:void(0);' name='del_pay_a' aguid='" + response[i].pacGuid + "'>刪除</a></td>";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].perNo + "</td>";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].perName + "</td>";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].pacChangeDate + "</td>";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].pacChangeBegin + "</td>";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].pacChangeEnd + "</td>";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].pacVenifyDate + "</td>";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].pacVenify + "</td>";
                                if (response[i].pacStatus == "0") {
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;color:red;'>待確認</td>";
                                } else {
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>已確認</td>";
                                }

                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].pacPs + "</td>";
                                str_html += "</tr>";
                            }
                            str_html += "</tbody>";
                        } else {
                            str_html += "<td colspan='6' nowrap='nowrap' style='cursor: pointer;'>查無資料</td>";
                        }
                        $("#div_pay_list").append(str_html);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                        $(".fixTable").tableHeadFixer();
                        $("#search_pay_date").val("");
                        $("#search_pay_keyword").val("");
                        $("#search_pay_status").val("");
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
        }
        //薪資異動 新增/修改
        function mod_paydata() {
            if ($("#span_pay_Status").text() == "修改" && $("#hidden_pay_status").val() == "1") {
                alert("已確認資料不能再修改");
            } else {
                if (chk_pay_moddata()) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/pageModify.ashx",
                        data: {
                            func: "mode_paydata",
                            mod_perguid: $("#txt_hidden_pay_perguid").val(),
                            mod_changedate: $("#txt_pay_change_date").val(),
                            mod_siguid: $("#txt_hidden_pay_siguid").val(),
                            mod_before: $("#txt_pay_before").val(),
                            mod_after: $("#txt_pay_after").val(),
                            mod_chkdate: $("#txt_pay_chkdate").val(),
                            mod_chkpeople: $("#txt_pay_chkpeople").val(),
                            mod_pay_ps: $("#txt_pay_ps").val(),
                            mod_pay_type: $("#span_pay_Status").text(),
                            mod_pay_status: $("input[name='txt_pay_status']:checked").val(),
                            mod_hidden_pacguid: $("#hidden_pay_guid").val(),//修改才會有
                            mod_hidden_refcode: $("#hidden_pay_refcode").val()//01底薪02職能加給
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response != "error") {
                                if ($("#span_pay_Status").text() == "新增") {
                                    alert("新增成功");
                                }
                                if ($("#span_pay_Status").text() == "修改") {
                                    alert("修改成功");
                                }
                                call_paychangedata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            }

        }
        //撈薪資異動資料 by guid
        function call_paychangedata_byguid() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/pageModify.ashx",
                data: {
                    func: "load_paychangedata",
                    str_search_person_guid: $("#hidden_pay_guid").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response != "nodata") {
                        $("#txt_pay_empno").val(response[0].perNo);
                        $("#txt_pay_change_date").val(response[0].pacChangeDate);
                        $("#PCbox").attr("disabled", "disabled");
                        $("#txt_pay_siname").val(response[0].siItemName);
                        $("#txt_hidden_pay_siguid").val(response[0].pacChange);
                        $("#txt_pay_before").attr("disabled", "disabled");
                        $("#txt_pay_before").val(response[0].pacChangeBegin);
                        $("#txt_pay_after").val(response[0].pacChangeEnd);
                        $("#txt_hidden_pay_perguid").val(response[0].pacPerGuid);
                        $("#txt_pay_cname").text(response[0].perName);
                        $("#txt_pay_ps").val(response[0].pacPs);
                        $("#hidden_pay_status").val(response[0].pacStatus);
                        $("input[name='txt_pay_status'][value='" + response[0].pacStatus + "']").prop("checked", true);
                        $("#hidden_pay_guid").val(response[0].pacGuid);
                        if (response[0].pacStatus == "1") {
                            $("#txt_pay_chkdate").val(response[0].pacVenifyDate);
                            $("#txt_pay_chkpeople").val(response[0].pacVenify);
                        } else {
                            $("#txt_pay_chkdate").val(today_ymd);
                            $("#txt_pay_chkpeople").val(now_user);
                        }
                        $("#hidden_pay_refcode").val(response[0].siRef);
                    } else {

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
                    var str_html = "";
                    if (response != "nodata") {
                        switch (txttype) {
                            case "person":
                                if ($("#txt_person_change_pro").val() == "01") {
                                    $("#select_before").empty();
                                    $("#select_before").append("<option value='" + response[0].perDep + "'>" + response[0].cbName + "</option>");
                                }
                                else if ($("#txt_person_change_pro").val() == "02") {
                                    $("#select_before").empty();
                                    $("#select_before").append("<option value='" + response[0].perPosition + "'>" + response[0].PositionName + "</option>");
                                }
                                else if ($("#txt_person_change_pro").val() == "04") {
                                    $("#td_person_before").empty();
                                    $("#td_person_before").append("<input type='text' id='select_before' class='inputex width60' maxlength='50' value='" + response[0].perFirstDate + "' disabled='disabled' />");
                                }
                                else {
                                    $("#txt_person_empno").val(response[0].perNo);
                                    $("#txt_person_cname").text(response[0].perName);
                                    $("#txt_hidden_person_guid").val(response[0].perGuid);
                                }
                                break;
                            case "pay":
                                $("#txt_pay_empno").val(response[0].perNo);
                                $("#txt_pay_cname").text(response[0].perName);
                                $("#txt_hidden_person_guid").val(response[0].perGuid);
                                if ($("#hidden_pay_refcode").val() == "01") {
                                    $("#txt_pay_before").val(response[0].perBasicSalary);
                                }
                                else if ($("#hidden_pay_refcode").val() == "02") {
                                    $("#txt_pay_before").val(response[0].perAllowance);
                                } else {
                                    $("#txt_pay_before").val("");
                                }

                                break;
                        }

                    } else {
                        switch (txttype) {
                            case "person":
                                $("#txt_person_cname").text("無資料");
                                $("#txt_hidden_pay_perguid").val("");
                                break;
                            case "pay":
                                $("#txt_pay_cname").text("無資料");
                                $("#txt_hidden_person_guid").val("");
                                break;
                        }

                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //判斷所有checkbox數量是否跟選取數量一樣 控制全選勾或不勾
        function checkOrRemoveCheckAll() {
            if ($('input[name="pay_box[]"]:checked').length == $('input[name="pay_box[]"]').length) {
                $('#clickAll').prop("checked", "checked");
            }
            else {
                $('#clickAll').removeAttr("checked");
            }
        }
        //取得現在日期
        function get_datenow() {
            var d = new Date();
            var month = d.getMonth() + 1;
            var day = d.getDate();
            var output = d.getFullYear() + '/' +
                (month < 10 ? '0' : '') + month + '/' +
                (day < 10 ? '0' : '') + day;
            return output;
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
        //檢查人事異動 新增/修改 欄位
        function chk_person_moddata() {
            var chk_empno = $("#txt_person_empno").val();
            var chk_cname = $("#txt_person_cname").text();
            var chk_person_guid = $("#txt_hidden_person_guid").val();
            var chk_change_date = $("#txt_person_change_date").val();
            var chk_change_pro = $("#txt_person_change_pro").val();
            var chk_before = $("#select_before").val();
            var chk_after = $("#select_after").val();
            var chk_chkdate = $("#txt_person_chkdate").val();
            var chk_chkpeople = $("#txt_person_chkpeople").val();
            var chk_status = $("input[name='txt_person_status']:checked").val();
            if (chk_empno == "" || chk_cname == "" || chk_person_guid == "" || chk_cname == "無資料") {
                alert("請輸入或挑選一個正確人員");
                return false;
            }
            if (chk_change_date == "") {
                alert("請輸入或挑選一個正確日期");
                return false;
            }
            if (chk_change_pro == "") {
                alert("請挑選一個異動項目");
                return false;
            }
            if (chk_change_pro != "" && (chk_change_pro == "01" || chk_change_pro == "02") && chk_after == "") {
                alert("請挑選一個異動後資料");
                return false;
            }
            if (chk_chkdate == "" || chk_chkpeople == "") {
                alert("請重新登入");
                return false;
            }
            if (chk_status == undefined) {
                alert("請選擇狀態");
                return false;
            }
            return true;
        }
        //檢查薪資異動 新增/修改欄位
        function chk_pay_moddata() {
            var chk_perguid = $("#txt_hidden_pay_perguid").val();
            var chk_cdate = $("#txt_pay_change_date").val();
            var chk_hidden_siguid = $("#txt_hidden_pay_siguid").val();
            var chk_before = $("#txt_pay_before").val();
            var chk_after = $("#txt_pay_after").val();
            var chk_chkdate = $("#txt_pay_chkdate").val();
            var chk_chkpeople = $("#txt_pay_chkpeople").val();
            var chk_status = $("input[name='txt_pay_status']:checked").val();
            if (chk_perguid == "") {
                alert("請挑選一個正確的人員");
                return false;
            }
            if (chk_cdate == "" || (chk_cdate != "" && !chk_date(chk_cdate))) {
                alert("請挑選一個正確的異動日期");
                return false;
            }
            if (chk_hidden_siguid == "") {
                alert("請挑選一個異動項目");
            }
            if (chk_hidden_siguid != "" && chk_perguid == "") {
                alert("請先挑選一個正確的人員");
            }
            if (chk_before == "" || (chk_before != "" && isNaN(chk_before))) {
                alert("請輸入正確的異動前金額");
                return false;
            }
            if (chk_after == "" || (chk_after != "" && isNaN(chk_after))) {
                alert("請輸入正確的異動後金額");
                return false;
            }
            if (chk_chkpeople == "") {
                alert("請重新登入本系統");
                return false;
            }
            if (chk_status == "") {
                alert("請選擇狀態");
                return false;
            }
            return true;
        }
        //點放大鏡 查詢視窗
        function openfancybox(item) {
            switch ($(item).attr("id")) {
                case "Pbox"://人事異動 人員挑選
                    link = "SearchWindow.aspx?v=Personnel";
                    fbox(link);
                    break;
                case "PPbox"://薪資異動 人員挑選
                    link = "SearchWindow.aspx?v=Personnel2";
                    fbox(link);
                    break;
                case "PCbox"://薪資異動 項目挑選
                    if ($("#txt_hidden_pay_perguid").val() != "") {
                        link = "SearchWindow.aspx?v=SiItem&pgv=" + $("#txt_hidden_pay_perguid").val() + "";
                        fbox(link);
                    } else {
                        alert("請先挑選一個正確的人員");
                    }
                    
                    break;
            }
            
        }
        function fbox(link){
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
        function setReturnValue(v, gv, pno, pname,refcode) {
            switch (v) {
                case "Personnel":
                    $("#txt_person_empno").val(pno);
                    $("#txt_person_cname").text(pname);
                    $("#txt_hidden_person_guid").val(gv);
                    break;
                case "Personnel2":
                    $("#txt_pay_empno").val(pno);
                    $("#txt_pay_cname").text(pname);
                    $("#txt_hidden_pay_perguid").val(gv);
                    break;
                case "SiItem":
                    $("#txt_pay_siname").val(pname);//項目名稱
                    $("#txt_hidden_pay_siguid").val(gv);//項目GUID
                    $("#hidden_pay_refcode").val(refcode);//01底薪02職能加給
                    load_thispeopledata($("#txt_pay_empno").val(), "pay");
                    break;
            }

        }
        //批次匯入 回傳
        function setReflash() {
            call_paychangedata();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="hidden" id="idtmp" name="idtmp" class="inputex" />
    <input type="hidden" id="pfid" name="pfid" class="inputex" />
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10T">
                <div class="left font-light">首頁 / 人事資料管理 / <span class="font-black font-bold">異動管理</span></div>
            </div>
        </div>

        <div class="fixwidth" id="div_Edit">
            <!-- 詳細資料start -->
            <div class="statabs margin10T">
                <ul>
                    <li><a class="li_clk" id="li_1" href="#tabs-1">人事異動</a></li>
                    <li><a class="li_clk" id="li_2" href="#tabs-2">薪資異動</a></li>
                </ul>
                <div id="tabs-1">
                    <div class="twocol margin15TB" id="div_people_btn">
                        <div class="right">
                            <span id="span_person_search">
                                關鍵字：<input type="text" id="search_person_keyword" />
                                異動日期：<input type="text" id="search_person_date" maxlength="10" />
                                狀態：<select id="search_person_status"><option value="">--請選擇--</option>
                                    <option value="0">待確認</option>
                                    <option value="1">已確認</option>
                                </select>
                                <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_person_inner_search">查詢</a>
                            </span>
                            <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_person_search">查詢</a>
                            <a href="Javascript:void(0)" class="keybtn" id="btn_person_add">新增</a>
                        </div>
                    </div>
                    <div class="tabfixwidth" name="div_person_data">
                        <div class="stripeMe fixTable" style="max-height: 175px;">
                            <table id="div_person_list" width="100%" border="0" cellspacing="0" cellpadding="0"></table>
                        </div>
                        <!-- overwidthblock -->
                    </div>
                    <!-- fixwidth END-->
                    <div class="twocol margin15TB" name="div_person_data">
                        <div class="right">
                            <a href="Javascript:void(0)" id="btn_person_submit" class="keybtn fancybox">儲存</a>
                        </div>
                    </div>
                    <div class="tbsfixwidth" style="margin-top: 20px;" name="div_person_data">
                        <div class="statabs margin10T">
                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="div_person">
                                    <tr>
                                        <td align="right" colspan="5">
                                            <div class="font-title titlebackicon">維護狀態</div>
                                        </td>
                                        <td>
                                            <span id="span_person_Status">新增</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">員工代號</div>
                                        </td>
                                        <td class="width25">
                                            <input type="text" class="inputex width60" id="txt_person_empno" value="" />
                                            <img id="Pbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor: pointer;" />
                                            <span id="txt_person_cname"></span>
                                            <span id="txt_hidden_person_guid" style="display: none;"></span>
                                        </td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">異動日期</div>
                                        </td>
                                        <td class="width20">
                                            <input type="text" class="inputex width95" id="txt_person_change_date" maxlength="10" value="" />
                                        </td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">異動項目</div>
                                        </td>
                                        <td class="width20">
                                            <select id="txt_person_change_pro">
                                                <!--撈codetable group='10'-->
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon">異動前</div>
                                        </td>
                                        <td class="width25" id="td_person_before"></td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">異動後</div>
                                        </td>
                                        <td class="width20" id="td_person_after"></td>
                                        <td class="width10"></td>
                                        <td class="width20"></td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <div class="font-title titlebackicon">備註</div>
                                        </td>
                                        <td>
                                            <input type="text" class="inputex" maxlength="200" id="txt_person_ps" />
                                        </td>
                                        <td align="right">
                                            <div class="font-title titlebackicon">確認日</div>
                                        </td>
                                        <td>
                                            <input type="text" class="inputex" maxlength="200" id="txt_person_chkdate" disabled="disabled" />
                                        </td>
                                        <td align="right">
                                            <div class="font-title titlebackicon">確認者</div>
                                        </td>
                                        <td>
                                            <input type="text" class="inputex" maxlength="200" id="txt_person_chkpeople" disabled="disabled" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <div class="font-title titlebackicon">狀態</div>
                                        </td>
                                        <td>
                                            <input type="radio" name="txt_person_status" value="0" />待確認
                                            <input type="radio" name="txt_person_status" value="1" />已確認
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <input type="text" style="display: none;" id="hidden_pcguid" />
                    <input type="text" style="display: none;" id="hidden_end" />
                    <input type="text" style="display: none;" id="hidden_person_status" />
                </div>
                <!-- tabs-1 -->

                <div id="tabs-2">
                    <div class="twocol margin15T" id="div_pay_btn">
                        <div class="left">
                            <a href="javascript:void(0);" class="keybtn fancybox" id="a_pay_manychk">批次審核</a>
                        </div>
                        <div class="right">
                            <span id="span_pay_search">關鍵字：<input id="search_pay_keyword" />&nbsp;&nbsp;
                                異動日期：<input id="search_pay_date" maxlength="10" />
                                狀態：<select id="search_pay_status"><option value="">--請選擇--</option>
                                    <option value="0">待確認</option>
                                    <option value="1">已確認</option>
                                </select>
                                <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_pay_inner_search">查詢</a>
                            </span>
                            <span id="span_pay_right_btn">
                                <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_pay_search">查詢</a>
                                <a href="Javascript:void(0)" class="keybtn" id="btn_pay_add">新增</a>
                                <a href="Javascript:void(0)" class="keybtn" id="btn_pay_import">批次匯入</a>
                            </span>
                            
                        </div>
                    </div>
                    <br />
                    <div class="tabfixwidth" style="overflow: auto;" name="div_pay_data">
                        <div class="stripeMe fixTable" style="max-height: 175px;">
                            <table id="div_pay_list" width="100%" border="0" cellspacing="0" cellpadding="0"></table>
                        </div>
                        <!-- overwidthblock -->
                    </div>
                    <!-- fixwidth END-->
                    <br />
                    <div class="twocol margin15T" name="div_pay_data">
                        <div class="right">
                            <a href="Javascript:void(0)" id="btn_pay_submit" class="keybtn fancybox">儲存</a>
                        </div>
                    </div>
                    <div class="tbsfixwidth" style="margin-top: 20px;" name="div_pay_data">
                        <div class="statabs margin10T">
                            <div class="tbsfixwidth gentable font-normal">
                                <table width="99%" border="0" cellspacing="0" cellpadding="0" id="div_pay">
                                    <tbody>
                                        <tr>
                                            <td align="right" colspan="5">
                                                <div class="font-title titlebackicon">維護狀態</div>
                                            </td>
                                            <td>
                                                <span id="span_pay_Status">新增</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="width13" align="right">
                                                <div class="font-title titlebackicon" style="color: Red">員工代號</div>
                                            </td>
                                            <td class="width15">
                                                <input type="text" class="inputex width50" id="txt_pay_empno" value="" />
                                                <img id="PPbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor: pointer;" />
                                                <span id="txt_pay_cname"></span>
                                                <span style="display: none;"><input type="text" id="txt_hidden_pay_perguid" style="display:none;" /></span>
                                            </td>
                                            <td class="width13" align="right">
                                                <div class="font-title titlebackicon " style="color: Red">異動日期</div>
                                            </td>
                                            <td class="width15">
                                                <input type="text" class="inputex width80" id="txt_pay_change_date" maxlength="10" value="" />
                                            </td>
                                            <td class="width13" align="right">
                                                <div class="font-title titlebackicon" style="color: Red">異動項目</div>
                                            </td>
                                            <td class="width15">
                                                <input type="text" class="inputex width50" id="txt_pay_siname" value="" readonly />
                                                <img id="PCbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor: pointer;" />
                                                (薪資項目設定)
                                                <input type="text" id="txt_hidden_pay_siguid" style="display: none;" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon" style="color: Red">異動前金額</div>
                                            </td>
                                            <td id="td_pay_before">
                                                <input type='text' id='txt_pay_before' class='inputex width80' maxlength='10' />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon" style="color: Red">異動後金額</div>
                                            </td>
                                            <td id="td_pay_after">
                                                <input type='text' id='txt_pay_after' class='inputex width80' maxlength='10' />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">備註</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width80" maxlength="200" id="txt_pay_ps" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="border-bottom-width: 0px;">
                                                <div class="font-title titlebackicon font-red" style="border-bottom-width: 0px;">確認日</div>
                                            </td>
                                            <td style="border-bottom-width: 0px;">
                                                <input type="text" class="inputex width80" maxlength="200" id="txt_pay_chkdate" disabled="disabled" />
                                            </td>
                                            <td align="right" style="border-bottom-width: 0px;">
                                                <div class="font-title titlebackicon font-red">確認者</div>
                                            </td>
                                            <td style="border-bottom-width: 0px;">
                                                <input type="text" class="inputex width80" maxlength="200" id="txt_pay_chkpeople" disabled="disabled" />
                                            </td>
                                            <td align="right" style="border-bottom-width: 0px;">
                                                <div class="font-title titlebackicon font-red">狀態</div>
                                            </td>
                                            <td style="border-bottom-width: 0px;">
                                                <input type="radio" name="txt_pay_status" value="0" />待確認
                                                <input type="radio" name="txt_pay_status" value="1" />已確認
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="text" style="display: none;" id="hidden_pay_guid" />
                <input type="text" style="display: none;" id="hidden_pay_status" />
                <input type="text" style="display: none;" id="hidden_pay_refcode" />
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
    <br />
</asp:Content>

