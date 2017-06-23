<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-hourlyadmin.aspx.cs" Inherits="webpage_page_hourlyadmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .stripeMe th {
            border-top:0px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var special_str = "";
            //tab click事件
            $(".li_clk").click(function () {
                switch ($(this).attr("id")) {
                    case "li_1":
                        load_hourdata();//撈時薪設定資料
                        break;
                    case "li_2":
                        $("#txt_hidden_sf_now").val("");
                        load_paysetdata();//撈薪資計算公式設定資料
                        //撈薪資計算公式 課稅所得公式維護 資料
                        break;
                    case "li_3":
                        $("#hidden_si_itemguid").val("");
                        load_sidata();//撈薪資項目設定資料
                        load_group16();
                        break;
                    case "li_4":
                        load_odata();//撈加班費資料
                        break;
                    case "li_5":
                        load_phdata();//撈給薪假資料
                        break;
                    case "li_1-1":
                        $("#txt_hidden_sf_now").val("");
                        $("#txt_pay_valset_taxpercent").val("");
                        load_paysetdata();//撈薪資計算公式 參數設定 資料
                        break;
                    case "li_1-2":
                        //load_paysetdata();//撈薪資計算公式 課稅所得公式維護 資料(要先撈參數設定的基本工資資料)
                        $("#txt_hidden_sf_now").val("");
                        $("#txt_pay_valset_taxpercent").val("");
                        load_TaxationItem();//撈薪資計算公式 課稅所得公式維護 項目資料
                        break;
                }
            });
            load_hourdata();//撈時薪設定資料
            //****************************************時薪設定****************************************//
            //時薪設定 儲存按鈕
            $("#btn_hour").click(function () {
                mod_hourdata();
            });
            //撈時薪設定資料
            function load_hourdata() {
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
                    data: {
                        func: "load_hourdata"
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        if (response != "nodata") {
                            $("#txt_hour_salary").val(response[0].bsSalary);
                            $("#txt_hour_other").val(response[0].bsOther);
                            $("#txt_hidden_hour_guid").val(response[0].bsGuid);
                        } else {
                            $("#txt_hour_salary").val("");
                            $("#txt_hour_other").val("");
                            $("#txt_hidden_hour_guid").val("");
                        }
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //時薪設定修改資料
            function mod_hourdata() {
                if (chk_NUM($("#txt_hour_salary").val()) && chk_NUM($("#txt_hour_other").val())) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-hourlyadmin.ashx",
                        data: {
                            func: "mod_hourdata",
                            mod_hour_salary: $("#txt_hour_salary").val(),
                            mod_hour_other: $("#txt_hour_other").val(),
                            mod_hour_guid: $("#txt_hidden_hour_guid").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response != "error") {
                                alert("修改成功");
                            } else {

                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            }
            //****************************************時薪設定 END****************************************//
            //****************************************薪資計算公式設定****************************************//
            //$("#txt_hidden_sf_now").val("1");
            $("#txt_hidden_sf_guid1").val("");
            $("#txt_hidden_sf_guid2").val("");
            //時薪設定-參數設定 tr 點擊事件
            $(document).on("click", "#tbl_sf tbody tr", function () {
                var this_id = $(this).attr("id");
                if (this_id == "1") {
                    $("#txt_pay_valset_taxpercent").val($("#txt_hidden_sf_str1").val());
                    $("#txt_hidden_sf_now").val("1");
                    $("#td_name").empty();
                    $("#td_name").append("基本工資");
                }
                if(this_id=="2"){
                    $("#txt_pay_valset_taxpercent").val($("#txt_hidden_sf_str2").val());
                    $("#txt_hidden_sf_now").val("2");
                    $("#td_name").empty();
                    $("#td_name").append("代扣福利金%數");
                }
                //call_personchangedata_byguid();
            });
            //薪資計算公式設定-參數設定 儲存按鈕
            $("#btn_payset").click(function () {
                mod_paysetdata();
            });
            //var row_count = 0;
            //時薪設定-課稅所得 tr 點擊事件
            //$(document).on("click", "#tbl_ti tbody tr", function () {
            //    var this_id = $(this).attr("trguid");
            //    $("#txt_hidden_ti_guid").val(this_id);
            //    load_TaxationDetailbyGuid();
            //});

            ////時薪設定-課稅所得 下面輸入 新增 點擊事件
            //$(document).on("click", "a[name='a_add_tf']", function () {
            //    row_count = row_count + 1;
            //    var add_html = "";
            //    add_html += '<tr>';
            //    add_html += '<td>';
            //    add_html += '<input type="radio" name="radio_tf_class' + (row_count) + '" checked="checked" />參數選擇<input type="radio" name="radio_tf_class' + (row_count) + '" />自行輸入';
            //    add_html += '</td>';
            //    add_html += '<td>';
            //    add_html += '<select>';
            //    add_html += '<option>應稅項目加總</option>';
            //    add_html += '<option>出勤天數</option>';
            //    add_html += '</select>';
            //    add_html += '</td>';
            //    add_html += '<td>';
            //    add_html += '<select>';
            //    add_html += '<option>+</option>';
            //    add_html += '<option>-</option>';
            //    add_html += '<option>X</option>';
            //    add_html += '<option>/</option>';
            //    add_html += '</select>';
            //    add_html += '</td>';
            //    add_html += '<td align="center" nowrap="nowrap" class="font-normal">';
            //    add_html += '<a href="javascript:void(0);" name="a_add_tf">新增</a>&nbsp;&nbsp;<a href="javascript:void(0);" name="a_del_tf">刪除</a>';
            //    add_html += '</td>';
            //    add_html += '</tr>';
            //    $(this).parent().parent().after(add_html);
            //});
            ////時薪設定-課稅所得 下面輸入 刪除 點擊事件
            //$(document).on("click", "a[name='a_del_tf']", function () {
            //    $(this).parent().parent().remove();
            //});
            //radio
            //$(document).on("click", "#tbl_tf input[type='radio']", function () {
            //    $(this).parent().parent().children("td").eq(1).empty();
            //    if ($(this).val() == "自行輸入") {
            //        $(this).parent().parent().children("td").eq(1).append("<input type='text' />");
            //    }
            //    if ($(this).val() == "參數選擇") {
            //        $(this).parent().parent().children("td").eq(1).append("<select></select>");
            //    }
            //});
            ////撈薪資計算公式 參數設定資料
            function load_paysetdata() {
                $("#tbl_sf").empty();
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
                    data: {
                        func: "load_paysetdata"
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        var str_html = "";
                        var str_1 = "";
                        var str_2 = "";
                        if (response != "nodata") {
                            str_1 = response[0].sfBasicSalary;
                            str_2 = response[0].sfWelfare;
                        } else {
                            str_1 = "";
                            str_2 = "";
                        }
                        str_html += '<thead>';
                        str_html += '<tr>';
                        str_html += '<th nowrap="nowrap">項目</th>';
                        str_html += '<th nowrap="nowrap">設定值</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        str_html += '<tr id="1">';
                        str_html += '<td nowrap="nowrap">基本工資</td>';
                        str_html += '<td nowrap="nowrap">' + str_1 + '</td>';
                        str_html += '</tr>';
                        str_html += '<tr id="2">';
                        str_html += '<td nowrap="nowrap">代扣福利金%數</td>';
                        str_html += '<td nowrap="nowrap">' + str_2 + '</td>';
                        str_html += '</tr>';
                        str_html += '</tbody>';
                        $("#tbl_sf").append(str_html);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                        $(".fixTable").tableHeadFixer();
                        $("#txt_hidden_sf_str1").val(str_1);
                        $("#txt_hidden_sf_str2").val(str_2);
                        $("span[name='span_ps_payset_pay']").text(str_1);
                        $("span[name='span_ps_payset_boonpercent']").text(str_2);
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //薪資計算公式設定 參數設定 修改資料
            function mod_paysetdata() {
                if ($("#txt_hidden_sf_now").val() == "") {
                    alert("請先選擇一個修改項目");
                    return;
                }
                if (chk_NUM($("#txt_pay_valset_taxpercent").val())) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-hourlyadmin.ashx",
                        data: {
                            func: "mod_paysetdata",
                            mod_payset_value: $("#txt_pay_valset_taxpercent").val(),
                            mod_payset_type: $("#txt_hidden_sf_now").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response != "error") {
                                alert("修改成功");
                                load_paysetdata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
                
            }
            //撈 薪資計算公式設定-課稅所得 項目資料sy_TaxationItem
            function load_TaxationItem() {
                $("#tbl_ti").empty();
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
                    data: {
                        func: "load_tidata"
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
                            str_html += '<thead>';
                            str_html += '<tr>';
                            str_html += '<th nowrap="nowrap">項目</th>';
                            str_html += '<th nowrap="nowrap">公式</th>';
                            str_html += '</tr>';
                            str_html += '</thead>';
                            str_html += '<tbody>';
                            for(var i=0; i<response.length; i++){
                                str_html += '<tr>';
                                //20170525決定拿掉目前為XXXXX的字樣
                                //str_html += '<td nowrap="nowrap" style="width: 40%">' + response[i].tiItem + '(目前為' + response[i].sfBasicSalary + ')</td>';
                                str_html += '<td nowrap="nowrap" style="width: 40%">' + response[i].tiItem + '</td>';
                                str_html += '<td nowrap="nowrap"><input type="text" class="inputex width80" value="' + response[i].tiFormula + '" id="str' + (i + 1) + '" maxlength="100" /></td>';
                                str_html += '</tr>';
                            }
                            str_html += '</tbody>';
                            $("#txt_hidden_ti_guid1").val(response[0].tiGuid);
                            $("#txt_hidden_ti_guid2").val(response[1].tiGuid);
                        }
                        $("#tbl_ti").append(str_html);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                        $("#span_str1").empty().append(response[0].tiFormula);
                        $("#span_str2").empty().append(response[1].tiFormula);
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //課稅所得公式維護 儲存按鈕 btn_ti
            $("#btn_ti").click(function () {
                mod_tidata();
            });
            function mod_tidata() {
                if (chk_specialstr($("#str1").val()) && chk_specialstr($("#str2").val())) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-hourlyadmin.ashx",
                        data: {
                            func: "mod_tidata",
                            mod_ti_guid1: $("#txt_hidden_ti_guid1").val(),
                            mod_ti_guid2: $("#txt_hidden_ti_guid2").val(),
                            mod_ti_str1: $("#str1").val(),
                            mod_ti_str2: $("#str2").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response != "error") {
                                alert("修改成功");
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            }

            ////撈 薪資計算公式設定-課稅所得 公式資料 BY GUID
            //function load_TaxationDetailbyGuid() {
            //    $("#tbl_tf").empty();
            //    $.ajax({
            //        type: "POST",
            //        async: true, //在沒有返回值之前,不會執行下一步動作
            //        url: "../handler/page-hourlyadmin.ashx",
            //        data: {
            //            func: "load_tidata",
            //            str_ti_guid: $("#txt_hidden_ti_guid").val()
            //        },
            //        error: function (xhr) {
            //            alert("error");
            //        },
            //        beforeSend: function () {
            //            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
            //        },
            //        success: function (response) {
            //            var str_html = "";
            //            if (response != "nodata") {
            //                if (response[0].tfTiGuid != "" && response[0].tfTiGuid != null) {
            //                } else {
            //                    row_count = 3;
            //                    str_html += '<tr>';
            //                    str_html += '<th>類別</th>';
            //                    str_html += '<th>項目</th>';
            //                    str_html += '<th>計算</th>';
            //                    str_html += '<th>操作</th>';
            //                    str_html += '</tr>';
            //                    str_html += '<tr>';
            //                    str_html += '<td>';
            //                    str_html += '<input type="radio" name="radio_tf_class1" checked="checked" value="參數選擇" />參數選擇<input type="radio" name="radio_tf_class1" value="自行輸入" />自行輸入';
            //                    str_html += '</td>';
            //                    str_html += '<td>';
            //                    str_html += '<select>';
            //                    str_html += '<option>應稅項目加總</option>';
            //                    str_html += '<option>出勤天數</option>';
            //                    str_html += '</select>';
            //                    str_html += '</td>';
            //                    str_html += '<td>';
            //                    str_html += '<select>';
            //                    str_html += '<option>+</option>';
            //                    str_html += '<option>-</option>';
            //                    str_html += '<option>X</option>';
            //                    str_html += '<option>/</option>';
            //                    str_html += '</select>';
            //                    str_html += '</td>';
            //                    str_html += '<td align="center" nowrap="nowrap" class="font-normal">';
            //                    str_html += '<a href="javascript:void(0);" name="a_add_tf">新增</a>&nbsp;&nbsp;<a href="javascript:void(0);" name="a_del_tf">刪除</a>';
            //                    str_html += '</td>';
            //                    str_html += '</tr>';
            //                    str_html += '<tr>';
            //                    str_html += '<td>';
            //                    str_html += '<input type="radio" name="radio_tf_class2" checked="checked" value="參數選擇" />參數選擇<input type="radio" name="radio_tf_class2" value="自行輸入" />自行輸入';
            //                    str_html += '</td>';
            //                    str_html += '<td>';
            //                    str_html += '<select>';
            //                    str_html += '<option>應稅項目加總</option>';
            //                    str_html += '<option>出勤天數</option>';
            //                    str_html += '</select>';
            //                    str_html += '</td>';
            //                    str_html += '<td>';
            //                    str_html += '<select>';
            //                    str_html += '<option>+</option>';
            //                    str_html += '<option>-</option>';
            //                    str_html += '<option>X</option>';
            //                    str_html += '<option>/</option>';
            //                    str_html += '</select>';
            //                    str_html += '</td>';
            //                    str_html += '<td align="center" nowrap="nowrap" class="font-normal">';
            //                    str_html += '<a href="javascript:void(0);" name="a_add_tf">新增</a>&nbsp;&nbsp;<a href="javascript:void(0);" name="a_del_tf">刪除</a>';
            //                    str_html += '</td>';
            //                    str_html += '</tr>';
            //                    str_html += '<tr>';
            //                    str_html += '<td>';
            //                    str_html += '<input type="radio" name="radio_tf_class3" checked="checked" value="參數選擇" />參數選擇<input type="radio" name="radio_tf_class3" value="自行輸入" />自行輸入';
            //                    str_html += '</td>';
            //                    str_html += '<td>';
            //                    str_html += '<select>';
            //                    str_html += '<option>應稅項目加總</option>';
            //                    str_html += '<option>出勤天數</option>';
            //                    str_html += '</select>';
            //                    str_html += '</td>';
            //                    str_html += '<td>';
            //                    str_html += '<select>';
            //                    str_html += '<option>+</option>';
            //                    str_html += '<option>-</option>';
            //                    str_html += '<option>X</option>';
            //                    str_html += '<option>/</option>';
            //                    str_html += '</select>';
            //                    str_html += '</td>';
            //                    str_html += '<td align="center" nowrap="nowrap" class="font-normal">';
            //                    str_html += '<a href="javascript:void(0);" name="a_add_tf">新增</a>&nbsp;&nbsp;<a href="javascript:void(0);" name="a_del_tf">刪除</a>';
            //                    str_html += '</td>';
            //                    str_html += '</tr>';
            //                }
            //            }
            //            $("#tbl_tf").append(str_html);
            //            $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
            //            $(".stripeMe tr:even").addClass("alt");
            //            $("#span_tf_desc").empty();
            //            $("#span_tf_desc").append(response[0].tiItem + '(目前為' + response[0].sfBasicSalary + ')');
            //        },//success end
            //        complete: function () {
            //            $.unblockUI();
            //        }
            //    });//ajax end
            //}
            ////****************************************薪資計算公式設定 END****************************************//

            //****************************************薪資項目設定****************************************//
            $("#span_si_search").hide();
            $("#hidden_si_itemguid").val("");
            //薪資項目設定 外面查詢按鈕
            $("#btn_si_search").click(function () {
                $("#span_si_search").show();
                $("div[name='div_si'],a[name='div_si']").hide();
            });
            //薪資項目設定 裡面查詢按鈕
            $("#btn_si_inner_search").click(function () {
                $("#span_si_search").hide();
                $("div[name='div_si'],a[name='div_si']").show();
                $("#hidden_si_itemguid").val("");
                load_sidata();
                $("#search_si_keyword").val("");
            });
            //薪資項目設定 儲存按鈕
            $("#btn_si_item").click(function () {
                mod_sidata();
            });
            //薪資項目設定 新增按鈕
            $("#btn_si_add").click(function () {
                $("#span_Status").text("新增");
                $("#txt_si_itemcode").val("");
                $("#txt_si_itemname").val("");
                $("input[name='txt_si_Insurance']:checked").val();
                $("input[name='txt_si_itemadd']:checked").val();
                $("input[name='txt_si_itembenefit']:checked").val();
                $("input[name='txt_si_itemsup']:checked").val();
                $("input[name='txt_si_itemtax']:checked").val();
                $("input[name='txt_si_siBuckle']:checked").val();
                $("#txt_si_itemref").val("");
                $("#hidden_si_itemguid").val("");
                datanodisabled();
            });
            //薪資項目設定 刪除
            $(document).on("click", "a[name='a_del_si']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-hourlyadmin.ashx",
                        data: {
                            func: "del_sidata",
                            del_si_itemguid: $(this).attr("aguid")
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
                                load_sidata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            });
            //薪資項目設定 tr 點擊事件
            $(document).on("click", "#tbl_si_item tbody tr td:not(:nth-child(1))", function () {
                $("#txt_si_itemcode").val("");
                $("#txt_si_itemname").val("");
                $("input[name='txt_si_Insurance']").removeAttr("checked");
                $("input[name='txt_si_itemadd']").removeAttr("checked");
                $("input[name='txt_si_itembenefit']").removeAttr("checked");
                $("input[name='txt_si_itemsup']").removeAttr("checked");
                $("input[name='txt_si_itemtax']").removeAttr("checked");
                $("input[name='txt_si_siBuckle']").removeAttr("checked");
                $("#txt_si_itemref").val("");
                $("#span_Status").text("修改");
                $("#hidden_si_itemguid").val($(this).closest('tr').attr("trguid"))//修改才會有
                load_sidata_byguid();
            });
            //撈薪資項目設定資料
            function load_sidata() {
                $("#tbl_si_item").empty();
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
                    data: {
                        func: "load_sidata",
                        str_keyword: $("#search_si_keyword").val()//,
                        //str_guid: $("#hidden_si_itemguid").val()
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
                            str_html += "<th class='width10' nowrap='nowrap'>操作</th>";
                            str_html += "<th class='width10' nowrap='nowrap'>項目代碼</th>";
                            str_html += "<th class='width10' nowrap='nowrap'>項目名稱</th>";
                            str_html += "<th class='width10' nowrap='nowrap'>加/扣項</th>";
                            str_html += "<th class='width10' nowrap='nowrap'>計算補充保費</th>";
                            str_html += "<th class='width10' nowrap='nowrap'>計投保薪資<br />(納入平均月薪)</th>";
                            str_html += "<th class='width10' nowrap='nowrap'>計算職工福利金</th>";
                            str_html += "<th class='width10' nowrap='nowrap'>所得稅</th>";
                            str_html += "</tr>";
                            str_html += "</thead>";
                            str_html += "<tbody>";
                            for (var i = 0; i < response.length; i++) {
                                var add_name = "";
                                var tax_name = "";
                                var str_disalbed = "";
                                var str_display = "";
                                //如果是底薪或職能加給 使用者就不能刪除或修改 20170609新增這功能
                                if (response[i].siRef == "01" || response[i].siRef == "02") {
                                    str_disalbed = " disabled=disabled ";
                                    str_display =" style='display:none;' "
                                }
                                str_html += "<tr trguid='" + response[i].siGuid + "'>";
                                str_html += "<td align='center' nowrap='nowrap' class='font-normal'><a href='javascript:void(0);' name='a_del_si' aguid='" + response[i].siGuid + "'  " + str_disalbed + str_display + " >刪除</a></td>";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].siItemCode + "</td>";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + response[i].siItemName + "</td>";
                                if (response[i].siAdd == "01")
                                    add_name = "加項";
                                else
                                    add_name = "減項";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + add_name + "</td>";
                                if (response[i].siSupplementaryPremium == "Y") {
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>是</td>";
                                } else {
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>否</td>";
                                }
                                if (response[i].siInsurance == "Y") {
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>是</td>";
                                } else {
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>否</td>";
                                }
                                if (response[i].siBenefit == "Y") {
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>是</td>";
                                } else {
                                    str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>否</td>";
                                }
                                if (response[i].siIncomeTax == "01")
                                    tax_name = "應稅";
                                else if (response[i].siIncomeTax == "02")
                                    tax_name = "免稅";
                                else
                                    tax_name = "與稅無關";
                                str_html += "<td align='center' nowrap='nowrap' style='cursor: pointer;'>" + tax_name + "</td>";
                                str_html += "</tr>";
                            }
                            str_html += "</tbody>";
                            
                        } else {
                            str_html += "<tr><td>查無資料<td></tr>";
                        }
                        $("#tbl_si_item").append(str_html);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                        $(".fixTable").tableHeadFixer();
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //薪資項目設定資料 新增/修改
            function mod_sidata() {
                if ($("#hidden_si_itemguid").val() == "" && $("#span_Status").text()=="修改") {
                    alert("請先選擇一個修改項目");
                    return;
                }
                if ($("#txt_si_itemcode").val() == "") {
                    alert("請輸入項目代號");
                    return;
                }
                if($("#txt_si_itemname").val() == ""){
                    alert("請輸入項目名稱");
                    return;
                }
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
                    data: {
                        func: "mod_sidata",
                        mod_si_code: $("#txt_si_itemcode").val(),
                        mod_si_name: $("#txt_si_itemname").val(),
                        mod_si_Insurance: $("input[name='txt_si_Insurance']:checked").val(),
                        mod_si_itemadd: $("input[name='txt_si_itemadd']:checked").val(),
                        mod_si_itembenefit: $("input[name='txt_si_itembenefit']:checked").val(),
                        mod_si_itemsup: $("input[name='txt_si_itemsup']:checked").val(),
                        mod_si_itemtax: $("input[name='txt_si_itemtax']:checked").val(),
                        mod_si_siBuckle: $("input[name='txt_si_siBuckle']:checked").val(),
                        mod_si_itemref: $("#txt_si_itemref").val(),
                        mod_si_itemrefcom: $("#txt_si_itemrefcom").val(),
                        mod_si_itemguid: $("#hidden_si_itemguid").val(),
                        mod_si_type: $("#span_Status").text()
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        if (response != "error") {
                            if (response == "notonly") {
                                alert("項目代號重複，請重新輸入");
                            } else if (response == "si_refcom_notonly_add") {
                                alert("已經指定過對應欄位(在勞健保比對使用)的項目，請勿重複指定");
                            } else if (response == "si_refcom_notonly_mod") {
                                alert("已經指定過對應欄位(在勞健保比對使用)的項目，請勿重複指定");
                            } else if (response == "siref_notonly_add") {
                                alert("已經指定過對應欄位(在薪資異動使用)的項目，請勿重複指定");
                            } else if (response == "siref_notonly_mod") {
                                alert("已經指定過對應欄位(在薪資異動使用)的項目，請勿重複指定");
                            } else {
                                if ($("#span_Status").text() == "新增") {
                                    alert("新增成功");
                                } else {
                                    alert("修改成功");
                                }
                                $("#search_si_keyword").val("");
                                load_sidata();
                            }
                        }
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //撈薪資項目設定 BY GUID
            function load_sidata_byguid(){
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
                    data: {
                        func: "load_sidata",
                        str_guid: $("#hidden_si_itemguid").val()
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        var str_html = "";
                        var str_disalbed = "";
                        if (response != "nodata") {
                            $("#txt_si_itemcode").val(response[0].siItemCode);
                            $("#txt_si_itemname").val(response[0].siItemName);
                            $("#txt_si_itemref").val(response[0].siRef);
                            $("#txt_si_itemrefcom").val(response[0].siRefcom);
                            $("input[name='txt_si_Insurance'][value='" + response[0].siInsurance + "']").prop("checked", true);
                            $("input[name='txt_si_itemadd'][value='" + response[0].siAdd + "']").prop("checked", true);
                            $("input[name='txt_si_itembenefit'][value='" + response[0].siBenefit + "']").prop("checked", true);
                            $("input[name='txt_si_itemsup'][value='" + response[0].siSupplementaryPremium + "']").prop("checked", true);
                            $("input[name='txt_si_itemtax'][value='" + response[0].siIncomeTax + "']").prop("checked", true);
                            $("input[name='txt_si_siBuckle'][value='" + response[0].siBuckle + "']").prop("checked", true);
                            //如果是底薪或職能加給 使用者就不能刪除或修改 20170609新增這功能
                            if (response[0].siRef == "01" || response[0].siRef == "02") {
                                datadisabled();
                            } else {
                                datanodisabled();
                            }
                            
                        } else {

                        }
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //****************************************薪資項目設定 END****************************************//
            //****************************************給薪假設定****************************************//
            $("#span_ph_search").hide();
            $("#hidden_ph_guid").val("");
            //薪資項目設定 外面查詢按鈕
            $("#btn_ph_search").click(function () {
                $("#span_ph_search").show();
                $("div[name='div_ph'],a[name='div_ph']").hide();
            });
            //薪資項目設定 裡面查詢按鈕
            $("#btn_ph_inner_search").click(function () {
                $("#span_ph_search").hide();
                $("div[name='div_ph'],a[name='div_ph']").show();
                $("#hidden_ph_guid").val("");
                load_phdata();
                $("#search_ph_keyword").val("");
                $("#hidden_ph_guid").val("");
                $("#txt_ph_name").val("");
                $("#txt_ph_ps").val("");
                $("#mod_ph_days").val("");
            });
            //給薪假設定 修改按鈕
            $("#btn_ph").click(function () {
                mod_phdata();
            });
            //撈給薪假資料
            function load_phdata() {
                $("#tbl_ph").empty();
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
                    data: {
                        func: "load_phdata",
                        str_keyword: $("#search_ph_keyword").val()
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
                            str_html += "<th class='width10' nowrap='nowrap'>給新假名稱</th>";
                            str_html += "<th class='width10' nowrap='nowrap'>計算基準</th>";
                            str_html += "<th class='width10' nowrap='nowrap'>備註</th>";
                            str_html += "</tr>";
                            str_html += "</thead>";
                            str_html += "<tbody>";
                            for (var i = 0; i < response.length; i++) {
                                str_html += "<tr trguid='" + response[i].phGuid + "'>";
                                //str_html += "<td align='center' nowrap='nowrap' class='font-normal'><a href='javascript:void(0);' name='a_del_si' aguid='" + response[i].phGuid + "'>刪除</a></td>";
                                str_html += "<td align='left' nowrap='nowrap' style='cursor: pointer;'>" + response[i].phName + "</td>";
                                if (response[i].phBasic=="01") {
                                    str_html += "<td align='left' nowrap='nowrap' style='cursor: pointer;'>全薪</td>";
                                }
                                else if (response[i].phBasic == "02") {
                                    str_html += "<td align='left' nowrap='nowrap' style='cursor: pointer;'>半薪</td>";
                                }
                                else if (response[i].phBasic == "03") {
                                    str_html += "<td align='left' nowrap='nowrap' style='cursor: pointer;'>無薪</td>";
                                } else {
                                    str_html += "<td align='left' nowrap='nowrap' style='cursor: pointer;'></td>";
                                }
                                str_html += "<td align='left' nowrap='nowrap' style='cursor: pointer;'>" + response[i].phPs + "</td>";
                                str_html += "</tr>";
                            }
                            str_html += "</tbody>";

                        } else {
                            str_html += "<tr><td>查無資料<td></tr>";
                        }
                        $("#tbl_ph").append(str_html);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                        $(".fixTable").tableHeadFixer();
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //撈給薪假資料 by GUID
            function load_phdata_byguid() {
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
                    data: {
                        func: "load_phdata",
                        str_ph_guid: $("#hidden_ph_guid").val()
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
                            $("#txt_ph_name").val(response[0].phName);
                            $("#txt_ph_ps").val(response[0].phPs);
                            $("#txt_ph_days").val(response[0].phDays);
                            $("input[name='txt_ph_basic'][value='" + response[0].phBasic + "']").prop("checked", true);
                        } else {
                            
                        }
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //給薪假設定 tr 點擊事件
            $(document).on("click", "#tbl_ph tbody tr", function () {
                $("#search_ph_keyword").val("");
                $("#hidden_ph_guid").val("");
                $("#txt_ph_name").val("");
                $("#txt_ph_ps").val("");
                $("input[name='txt_ph_basic']").removeAttr("checked");
                $("#txt_si_itemref").val("");
                $("#hidden_ph_guid").val($(this).closest('tr').attr("trguid"))//修改才會有
                $("#mod_ph_days").val("");
                load_phdata_byguid();
            });
            //給薪假設定 修改
            function mod_phdata() {
                if ($("#hidden_ph_guid").val() == "") {
                    alert("請先選擇一個修改項目");
                } else if ($("#txt_ph_name").val() == "") {
                    alert("請輸入給薪假名稱");
                } else if ($("input[name='txt_ph_basic']:checked").val() == undefined) {
                    alert("請選擇計算基準");
                } else if ($("#txt_ph_days").val()=="") {
                    alert("請輸入給假天數");
                } else if ($("#txt_ph_days").val() != "" && isNaN($("#txt_ph_days").val())) {
                    alert("請給假天數只能輸入數字");
                }
                else {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-hourlyadmin.ashx",
                        data: {
                            func: "mod_phdata",
                            mod_ph_guid: $("#hidden_ph_guid").val(),
                            mod_ph_name: $("#txt_ph_name").val(),
                            mod_ph_ps: $("#txt_ph_ps").val(),
                            mod_ph_basic: $("input[name='txt_ph_basic']:checked").val(),
                            mod_ph_days: $("#txt_ph_days").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response != "error") {
                                if (response == "notonly") {
                                    alert("給薪假名稱重複");
                                } else {
                                    alert("修改成功");
                                    $("#search_ph_keyword").val("");
                                    load_phdata();
                                }
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            }
            //****************************************給薪假設定 END****************************************//
            //****************************************加班費設定****************************************//
            //加班費儲存按鈕
            $("#btn_o").click(function () {
                mod_odata();
            });
            //撈加班費資料
            function load_odata(){
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
                    data: {
                        func: "load_odata"
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
                            $("#hidden_txt_o_oGuid").val(response[0].oGuid);
                            $("#txt_o_oMale").val(response[0].oMale);
                            $("#txt_o_oFemale").val(response[0].oFemale);
                            $("#txt_o_oFixed").val(response[0].oFixed);
                            $("#txt_o_oOverTime1").val(response[0].oOverTime1);
                            $("#txt_o_oOverTime2Start").val(response[0].oOverTime2Start);
                            $("#txt_o_oOverTime2End").val(response[0].oOverTime2End);
                            $("#txt_o_oOverTime3").val(response[0].oOverTime3);
                            $("#txt_o_oOverTimePay1").val(response[0].oOverTimePay1);
                            $("#txt_o_oOverTimePay2").val(response[0].oOverTimePay2);
                            $("#txt_o_oOverTimePay3").val(response[0].oOverTimePay3);
                            $("#txt_o_oOffDay1").val(response[0].oOffDay1);
                            $("#txt_o_oOffDay2Start").val(response[0].oOffDay2Start);
                            $("#txt_o_oOffDay2End").val(response[0].oOffDay2End);
                            $("#txt_o_oOffDay3Start").val(response[0].oOffDay3Start);
                            $("#txt_o_oOffDay3End").val(response[0].oOffDay3End);
                            $("#txt_o_oOffDayPay1").val(response[0].oOffDayPay1);
                            $("#txt_o_oOffDayPay2").val(response[0].oOffDayPay2);
                            $("#txt_o_oOffDayPay3").val(response[0].oOffDayPay3);
                            $("#txt_o_oPublickHoliday1").val(response[0].oPublickHoliday1);
                            $("#txt_o_oPublickHoliday2Start").val(response[0].oPublickHoliday2Start);
                            $("#txt_o_oPublickHoliday2End").val(response[0].oPublickHoliday2End);
                            $("#txt_o_oPublickHoliday3Start").val(response[0].oPublickHoliday3Start);
                            $("#txt_o_oPublickHoliday3End").val(response[0].oPublickHoliday3End);
                            $("#txt_o_oPublickHoliday4").val(response[0].oPublickHoliday4);
                            $("#txt_o_oPublickHolidayPay1").val(response[0].oPublickHolidayPay1);
                            $("#txt_o_oPublickHolidayPay2").val(response[0].oPublickHolidayPay2);
                            $("#txt_o_oPublickHolidayPay3").val(response[0].oPublickHolidayPay3);
                            $("#txt_o_oPublickHolidayPay4").val(response[0].oPublickHolidayPay4);
                            $("#txt_o_oNationalHolidays1").val(response[0].oNationalHolidays1);
                            $("#txt_o_oNationalHolidays2Start").val(response[0].oNationalHolidays2Start);
                            $("#txt_o_oNationalHolidays2End").val(response[0].oNationalHolidays2End);
                            $("#txt_o_oNationalHolidays3Start").val(response[0].oNationalHolidays3Start);
                            $("#txt_o_oNationalHolidays3End").val(response[0].oNationalHolidays3End);
                            $("#txt_o_oNationalHolidays4").val(response[0].oNationalHolidays4);
                            $("#txt_o_oNationalHolidaysPay1").val(response[0].oNationalHolidaysPay1);
                            $("#txt_o_oNationalHolidaysPay2").val(response[0].oNationalHolidaysPay2);
                            $("#txt_o_oNationalHolidaysPay3").val(response[0].oNationalHolidaysPay3);
                            $("#txt_o_oNationalHolidaysPay4").val(response[0].oNationalHolidaysPay4);
                            $("#txt_o_oSpecialHolidays1").val(response[0].oSpecialHolidays1);
                            $("#txt_o_oSpecialHolidays2Start").val(response[0].oSpecialHolidays2Start);
                            $("#txt_o_oSpecialHolidays2End").val(response[0].oSpecialHolidays2End);
                            $("#txt_o_oSpecialHolidays3Start").val(response[0].oSpecialHolidays3Start);
                            $("#txt_o_oSpecialHolidays3End").val(response[0].oSpecialHolidays3End);
                            $("#txt_o_oSpecialHolidays4").val(response[0].oSpecialHolidays4);
                            $("#txt_o_oSpecialHolidaysPay1").val(response[0].oSpecialHolidaysPay1);
                            $("#txt_o_oSpecialHolidaysPay2").val(response[0].oSpecialHolidaysPay2);
                            $("#txt_o_oSpecialHolidaysPay3").val(response[0].oSpecialHolidaysPay3);
                            $("#txt_o_oSpecialHolidaysPay4").val(response[0].oSpecialHolidaysPay4);
                        } else {
                            $("#hidden_txt_o_oGuid").val("");
                            $("#txt_o_oMale").val("0");
                            $("#txt_o_oFemale").val("0");
                            $("#txt_o_oFixed").val("0");
                            $("#txt_o_oOverTime1").val("0");
                            $("#txt_o_oOverTime2Start").val("0");
                            $("#txt_o_oOverTime2End").val("0");
                            $("#txt_o_oOverTime3").val("0");
                            $("#txt_o_oOverTimePay1").val("0");
                            $("#txt_o_oOverTimePay2").val("0");
                            $("#txt_o_oOverTimePay3").val("0");
                            $("#txt_o_oOffDay1").val("0");
                            $("#txt_o_oOffDay2Start").val("0");
                            $("#txt_o_oOffDay2End").val("0");
                            $("#txt_o_oOffDay3Start").val("0");
                            $("#txt_o_oOffDay3End").val("0");
                            $("#txt_o_oOffDayPay1").val("0");
                            $("#txt_o_oOffDayPay2").val("0");
                            $("#txt_o_oOffDayPay3").val("0");
                            $("#txt_o_oPublickHoliday1").val("0");
                            $("#txt_o_oPublickHoliday2Start").val("0");
                            $("#txt_o_oPublickHoliday2End").val("0");
                            $("#txt_o_oPublickHoliday3Start").val("0");
                            $("#txt_o_oPublickHoliday3End").val("0");
                            $("#txt_o_oPublickHoliday4").val("0");
                            $("#txt_o_oPublickHolidayPay1").val("0");
                            $("#txt_o_oPublickHolidayPay2").val("0");
                            $("#txt_o_oPublickHolidayPay3").val("0");
                            $("#txt_o_oPublickHolidayPay4").val("0");
                            $("#txt_o_oNationalHolidays1").val("0");
                            $("#txt_o_oNationalHolidays2Start").val("0");
                            $("#txt_o_oNationalHolidays2End").val("0");
                            $("#txt_o_oNationalHolidays3Start").val("0");
                            $("#txt_o_oNationalHolidays3End").val("0");
                            $("#txt_o_oNationalHolidays4").val("0");
                            $("#txt_o_oNationalHolidaysPay1").val("0");
                            $("#txt_o_oNationalHolidaysPay2").val("0");
                            $("#txt_o_oNationalHolidaysPay3").val("0");
                            $("#txt_o_oNationalHolidaysPay4").val("0");
                            $("#txt_o_oSpecialHolidays1").val("0");
                            $("#txt_o_oSpecialHolidays2Start").val("0");
                            $("#txt_o_oSpecialHolidays2End").val("0");
                            $("#txt_o_oSpecialHolidays3Start").val("0");
                            $("#txt_o_oSpecialHolidays3End").val("0");
                            $("#txt_o_oSpecialHolidays4").val("0");
                            $("#txt_o_oSpecialHolidaysPay1").val("0");
                            $("#txt_o_oSpecialHolidaysPay2").val("0");
                            $("#txt_o_oSpecialHolidaysPay3").val("0");
                            $("#txt_o_oSpecialHolidaysPay4").val("0");
                        }
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //加班費資料修改
            function mod_odata() {
                if (chk_o_num()) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-hourlyadmin.ashx",
                        data: {
                            func: "mod_odata",
                            mod_oGuid: $("#hidden_txt_o_oGuid").val(),
                            mod_oMale: $("#txt_o_oMale").val(),
                            mod_oFemale: $("#txt_o_oFemale").val(),
                            mod_oFixed: $("#txt_o_oFixed").val(),
                            mod_oOverTime1: $("#txt_o_oOverTime1").val(),
                            mod_oOverTime2Start: $("#txt_o_oOverTime2Start").val(),
                            mod_oOverTime2End: $("#txt_o_oOverTime2End").val(),
                            mod_oOverTime3: $("#txt_o_oOverTime3").val(),
                            mod_oOverTimePay1: $("#txt_o_oOverTimePay1").val(),
                            mod_oOverTimePay2: $("#txt_o_oOverTimePay2").val(),
                            mod_oOverTimePay3: $("#txt_o_oOverTimePay3").val(),
                            mod_oOffDay1: $("#txt_o_oOffDay1").val(),
                            mod_oOffDay2Start: $("#txt_o_oOffDay2Start").val(),
                            mod_oOffDay2End: $("#txt_o_oOffDay2End").val(),
                            mod_oOffDay3Start: $("#txt_o_oOffDay3Start").val(),
                            mod_oOffDay3End: $("#txt_o_oOffDay3End").val(),
                            mod_oOffDayPay1: $("#txt_o_oOffDayPay1").val(),
                            mod_oOffDayPay2: $("#txt_o_oOffDayPay2").val(),
                            mod_oOffDayPay3: $("#txt_o_oOffDayPay3").val(),
                            mod_oPublickHoliday1: $("#txt_o_oPublickHoliday1").val(),
                            mod_oPublickHoliday2Start: $("#txt_o_oPublickHoliday2Start").val(),
                            mod_oPublickHoliday2End: $("#txt_o_oPublickHoliday2End").val(),
                            mod_oPublickHoliday3Start: $("#txt_o_oPublickHoliday3Start").val(),
                            mod_oPublickHoliday3End: $("#txt_o_oPublickHoliday3End").val(),
                            mod_oPublickHoliday4: $("#txt_o_oPublickHoliday4").val(),
                            mod_oPublickHolidayPay1: $("#txt_o_oPublickHolidayPay1").val(),
                            mod_oPublickHolidayPay2: $("#txt_o_oPublickHolidayPay2").val(),
                            mod_oPublickHolidayPay3: $("#txt_o_oPublickHolidayPay3").val(),
                            mod_oPublickHolidayPay4: $("#txt_o_oPublickHolidayPay4").val(),
                            mod_oNationalHolidays1: $("#txt_o_oNationalHolidays1").val(),
                            mod_oNationalHolidays2Start: $("#txt_o_oNationalHolidays2Start").val(),
                            mod_oNationalHolidays2End: $("#txt_o_oNationalHolidays2End").val(),
                            mod_oNationalHolidays3Start: $("#txt_o_oNationalHolidays3Start").val(),
                            mod_oNationalHolidays3End: $("#txt_o_oNationalHolidays3End").val(),
                            mod_oNationalHolidays4: $("#txt_o_oNationalHolidays4").val(),
                            mod_oNationalHolidaysPay1: $("#txt_o_oNationalHolidaysPay1").val(),
                            mod_oNationalHolidaysPay2: $("#txt_o_oNationalHolidaysPay2").val(),
                            mod_oNationalHolidaysPay3: $("#txt_o_oNationalHolidaysPay3").val(),
                            mod_oNationalHolidaysPay4: $("#txt_o_oNationalHolidaysPay4").val(),
                            mod_oSpecialHolidays1: $("#txt_o_oSpecialHolidays1").val(),
                            mod_oSpecialHolidays2Start: $("#txt_o_oSpecialHolidays2Start").val(),
                            mod_oSpecialHolidays2End: $("#txt_o_oSpecialHolidays2End").val(),
                            mod_oSpecialHolidays3Start: $("#txt_o_oSpecialHolidays3Start").val(),
                            mod_oSpecialHolidays3End: $("#txt_o_oSpecialHolidays3End").val(),
                            mod_oSpecialHolidays4: $("#txt_o_oSpecialHolidays4").val(),
                            mod_oSpecialHolidaysPay1: $("#txt_o_oSpecialHolidaysPay1").val(),
                            mod_oSpecialHolidaysPay2: $("#txt_o_oSpecialHolidaysPay2").val(),
                            mod_oSpecialHolidaysPay3: $("#txt_o_oSpecialHolidaysPay3").val(),
                            mod_oSpecialHolidaysPay4: $("#txt_o_oSpecialHolidaysPay4").val()
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response != "error") {
                                alert("修改成功");
                                load_odata();
                            } else {
                                alert("修改失敗");
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            }
            //****************************************加班費設定 END****************************************//
            //檢查加班費欄位否為數字
            function chk_o_num(){
                var chk_oMale = $("#txt_o_oMale").val();
                var chk_oFemale = $("#txt_o_oFemale").val();
                var chk_oFixed = $("#txt_o_oFixed").val();
                var chk_oOverTime1 = $("#txt_o_oOverTime1").val();
                var chk_oOverTime2Start = $("#txt_o_oOverTime2Start").val();
                var chk_oOverTime2End = $("#txt_o_oOverTime2End").val();
                var chk_oOverTime3 = $("#txt_o_oOverTime3").val();
                var chk_oOverTimePay1 = $("#txt_o_oOverTimePay1").val();
                var chk_oOverTimePay2 = $("#txt_o_oOverTimePay2").val();
                var chk_oOverTimePay3 = $("#txt_o_oOverTimePay3").val();
                var chk_oOffDay1 = $("#txt_o_oOffDay1").val();
                var chk_oOffDay2Start = $("#txt_o_oOffDay2Start").val();
                var chk_oOffDay2End = $("#txt_o_oOffDay2End").val();
                var chk_oOffDay3Start = $("#txt_o_oOffDay3Start").val();
                var chk_oOffDay3End = $("#txt_o_oOffDay3End").val();
                var chk_oOffDayPay1 = $("#txt_o_oOffDayPay1").val();
                var chk_oOffDayPay2 = $("#txt_o_oOffDayPay2").val();
                var chk_oOffDayPay3 = $("#txt_o_oOffDayPay3").val();
                var chk_oPublickHoliday1 = $("#txt_o_oPublickHoliday1").val();
                var chk_oPublickHoliday2Start = $("#txt_o_oPublickHoliday2Start").val();
                var chk_oPublickHoliday2End = $("#txt_o_oPublickHoliday2End").val();
                var chk_oPublickHoliday3Start = $("#txt_o_oPublickHoliday3Start").val();
                var chk_oPublickHoliday3End = $("#txt_o_oPublickHoliday3End").val();
                var chk_oPublickHoliday4 = $("#txt_o_oPublickHoliday4").val();
                var chk_oPublickHolidayPay1 = $("#txt_o_oPublickHolidayPay1").val();
                var chk_oPublickHolidayPay2 = $("#txt_o_oPublickHolidayPay2").val();
                var chk_oPublickHolidayPay3 = $("#txt_o_oPublickHolidayPay3").val();
                var chk_oPublickHolidayPay4 = $("#txt_o_oPublickHolidayPay4").val();
                var chk_oNationalHolidays1 = $("#txt_o_oNationalHolidays1").val();
                var chk_oNationalHolidays2Start = $("#txt_o_oNationalHolidays2Start").val();
                var chk_oNationalHolidays2End = $("#txt_o_oNationalHolidays2End").val();
                var chk_oNationalHolidays3Start = $("#txt_o_oNationalHolidays3Start").val();
                var chk_oNationalHolidays3End = $("#txt_o_oNationalHolidays3End").val();
                var chk_oNationalHolidays4 = $("#txt_o_oNationalHolidays4").val();
                var chk_oNationalHolidaysPay1 = $("#txt_o_oNationalHolidaysPay1").val();
                var chk_oNationalHolidaysPay2 = $("#txt_o_oNationalHolidaysPay2").val();
                var chk_oNationalHolidaysPay3 = $("#txt_o_oNationalHolidaysPay3").val();
                var chk_oNationalHolidaysPay4 = $("#txt_o_oNationalHolidaysPay4").val();
                var chk_oSpecialHolidays1 = $("#txt_o_oSpecialHolidays1").val();
                var chk_oSpecialHolidays2Start = $("#txt_o_oSpecialHolidays2Start").val();
                var chk_oSpecialHolidays2End = $("#txt_o_oSpecialHolidays2End").val();
                var chk_oSpecialHolidays3Start = $("#txt_o_oSpecialHolidays3Start").val();
                var chk_oSpecialHolidays3End = $("#txt_o_oSpecialHolidays3End").val();
                var chk_oSpecialHolidays4 = $("#txt_o_oSpecialHolidays4").val();
                var chk_oSpecialHolidaysPay1 = $("#txt_o_oSpecialHolidaysPay1").val();
                var chk_oSpecialHolidaysPay2 = $("#txt_o_oSpecialHolidaysPay2").val();
                var chk_oSpecialHolidaysPay3 = $("#txt_o_oSpecialHolidaysPay3").val();
                var chk_oSpecialHolidaysPay4 = $("#txt_o_oSpecialHolidaysPay4").val();
                
                if (isNaN(chk_oMale) || isNaN(chk_oFemale) || isNaN(chk_oFixed) || isNaN(chk_oOverTime1) || isNaN(chk_oOverTime2Start) || isNaN(chk_oOverTime2End) || isNaN(chk_oOverTime3) || isNaN(chk_oOverTimePay1) || isNaN(chk_oOverTimePay2) || isNaN(chk_oOverTimePay3))
                {
                    alert("請勿輸入數字以外的東西");
                    return false;
                }
                else if (isNaN(chk_oOffDay1) || isNaN(chk_oOffDay2Start) || isNaN(chk_oOffDay2End) || isNaN(chk_oOffDay3Start) || isNaN(chk_oOffDay3End) || isNaN(chk_oOffDayPay1) || isNaN(chk_oOffDayPay2) || isNaN(chk_oOffDayPay3) ) {
                    alert("請勿輸入數字以外的東西");
                    return false;
                }
                else if (isNaN(chk_oPublickHoliday1) || isNaN(chk_oPublickHoliday2Start) || isNaN(chk_oPublickHoliday2End) || isNaN(chk_oPublickHoliday3Start) || isNaN(chk_oPublickHoliday3End) || isNaN(chk_oPublickHoliday4)) {
                    alert("請勿輸入數字以外的東西");
                    return false;
                }
                else if (isNaN(chk_oPublickHolidayPay1) || isNaN(chk_oPublickHolidayPay2) || isNaN(chk_oPublickHolidayPay3) || isNaN(chk_oPublickHolidayPay4)) {
                    alert("請勿輸入數字以外的東西");
                    return false;
                }
                else if (isNaN(chk_oNationalHolidays1) || isNaN(chk_oNationalHolidays2Start) || isNaN(chk_oNationalHolidays2End) || isNaN(chk_oNationalHolidays3Start) || isNaN(chk_oNationalHolidays3End) || isNaN(chk_oNationalHolidays4)) {
                    alert("請勿輸入數字以外的東西");
                    return false;
                }
                else if (isNaN(chk_oNationalHolidaysPay1) || isNaN(chk_oNationalHolidaysPay2) || isNaN(chk_oNationalHolidaysPay3) || isNaN(chk_oNationalHolidaysPay4)) {
                    alert("請勿輸入數字以外的東西");
                    return false;
                }
                //else if (isNaN(chk_oSpecialHolidays1) || isNaN(chk_oSpecialHolidays2Start) || isNaN(chk_oSpecialHolidays2End) || isNaN(chk_oSpecialHolidays3Start) || isNaN(chk_oSpecialHolidays3End) || isNaN(chk_oSpecialHolidays4)) {
                //    alert("請勿輸入數字以外的東西");
                //    return false;
                //}
                //else if (isNaN(chk_oSpecialHolidaysPay1) || isNaN(chk_oSpecialHolidaysPay2) || isNaN(chk_oSpecialHolidaysPay3) || isNaN(chk_oSpecialHolidaysPay4)) {
                //    alert("請勿輸入數字以外的東西");
                //    return false;
                //}
                else {
                    return true;
                }
            }
            //通用檢查數字
            function chk_NUM(str) {
                if (isNaN(str)) {
                    alert("請勿輸入數字以外的東西");
                    return false;
                } else {
                    return true;
                }
            }
            //撈項目名稱
            function load_group15(){
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
                    data: {
                        func: "load_gtype15"
                    },
                    error: function (xhr) {
                        alert("error");
                    },
                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (response) {
                        if (response!="nodata") {
                            special_str = response;
                        }
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            load_group15();
            //判斷是否有將特殊項目用[]括起來
            function chk_specialstr(str){
                if (special_str != "") {
                    //str.indexOf('應稅項目加總')!=-1 若為true , 就代表str中含有 應稅項目加總 這個substring.
                    //str.indexOf('出勤天數')!=-1 若為true , 就代表str中含有 出勤天數 這個substring.
                    var str_arr = special_str.split(",");
                    for (var i = 0; i < str_arr.length; i++) {
                        if (str.indexOf(str_arr[i]) != -1) {//包含關鍵字
                            if (str.indexOf("[" + str_arr[i] + "]") == -1) {//關鍵字沒有用括號括起來
                                alert(str_arr[i] + "  必須改成[" + str_arr[i] + "]");
                                return false;
                            }
                        }
                    }
                }
                return true;
            }
            //撈對應欄(異動用)位下拉選單
            function load_group16() {
                $("#txt_si_itemref").empty();
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-hourlyadmin.ashx",
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
                        var str_htl = '<option value="">--請選擇--</option>';
                        if (response != "nodata") {
                            for (var i = 0; i < response.length;i++){
                                str_htl += '<option value="' + response[i].code_value + '">' + response[i].code_desc + '</option>';
                            }
                        }
                        $("#txt_si_itemref").append(str_htl);
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //薪資項目設定各項disabled
            function datadisabled() {
                $("#txt_si_itemcode").attr("disabled", true);
                $("#txt_si_itemname").attr("disabled", true);
                $("#txt_si_itemref").attr("disabled", true);
                $("#txt_si_itemrefcom").attr("disabled", true);
                $("input[name='txt_si_Insurance']").attr("disabled", true);
                $("input[name='txt_si_itemadd']").attr("disabled", true);
                $("input[name='txt_si_itembenefit']").attr("disabled", true);
                $("input[name='txt_si_itemsup']").attr("disabled", true);
                $("input[name='txt_si_itemtax']").attr("disabled", true);
                $("input[name='txt_si_siBuckle']").attr("disabled", true);
                $("#btn_si_item").attr("disabled", true);//連儲存按鈕都不給點
            }
            //薪資項目設定取消各項disabled
            function datanodisabled() {
                $("#txt_si_itemcode").attr("disabled", false);
                $("#txt_si_itemname").attr("disabled", false);
                $("#txt_si_itemref").attr("disabled", false);
                $("#txt_si_itemrefcom").attr("disabled", false);
                $("input[name='txt_si_Insurance']").attr("disabled", false);
                $("input[name='txt_si_itemadd']").attr("disabled", false);
                $("input[name='txt_si_itembenefit']").attr("disabled", false);
                $("input[name='txt_si_itemsup']").attr("disabled", false);
                $("input[name='txt_si_itemtax']").attr("disabled", false); 
                $("input[name='txt_si_siBuckle']").attr("disabled", false);
                $("#btn_si_item").attr("disabled", false);//連儲存按鈕都不給點
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10TB">
                <div class="left font-light">首頁 / 系統設定 /<span class="font-black font-bold">薪資管理設定</span></div>
            </div>
            <div class="fixwidth" style="margin-top: 10px;">
                <!-- 詳細資料start -->
                <div class="statabs margin10T">
                    <ul>
                        <li class="li_clk" id="li_1"><a href="#tabs-1">時薪設定</a></li>
                        <li class="li_clk" id="li_2"><a href="#tabs-2">薪資計算公式</a></li>
                        <li class="li_clk" id="li_3"><a href="#tabs-3">薪資項目設定</a></li>
                        <li class="li_clk" id="li_4"><a href="#tabs-4">加班費設定</a></li>
                        <li class="li_clk" id="li_5"><a href="#tabs-5">給薪假設定</a></li>
                    </ul>
                    <!-- tabs-1 時薪設定-->
                    <div id="tabs-1">
                        <div class="twocol margin15TB">
                            <div class="right">
                                <a href="#" class="keybtn" id="btn_hour">儲存</a>
                            </div>
                        </div>
                        <div class="tbsfixwidth" style="margin-top: 20px;">
                            <span class="font-size3 font-bold">底薪及職能加給預設值維護</span>
                            <div class="statabs margin10T">
                                <div class="gentable fixTable">
                                    <table border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">底薪</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" id="txt_hour_salary" /></td>

                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">職能加給</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" id="txt_hour_other" /></td>
                                        </tr>
                                        <tr style="display:none;"><td style="display:none;"><input type="text" id="txt_hidden_hour_guid" style="display:none;" /></td></tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- tabs-1 -->
                    <!-- tabs-2 薪資計算公式-->
                    <div id="tabs-2">
                        <div class="statabs margin10T">
                            <ul>
                                <li class="li_clk" id="li_1-1"><a href="#tabs-1-1">參數設定</a></li>
                                <li class="li_clk" id="li_1-2"><a href="#tabs-1-2">課稅所得公式維護</a></li>
                            </ul>
                            <div id="tabs-1-1">
                                <div class="tabfixwidth">
                                    <div class="stripeMe fixTable" style="max-height: 175px;">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_sf">
                                            
                                        </table>
                                    </div>
                                    <input style="display:none;" type="text" id="txt_hidden_pay_valset_guid" />
                                </div>
                                <div class="twocol margin15TB">
                                    <div class="right">
                                        <a href="#" class="keybtn" id="btn_payset">儲存</a>
                                    </div>
                                </div>

                                <div class="statabs margin10T">
                                    <div class="tbsfixwidth gentable font-normal">
                                        <table width="99%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <td class="width15" align="right">
                                                    <div class="font-title titlebackicon">項目</div>
                                                </td>
                                                <td class="width20" id="td_name">課稅所得%數</td>
                                                <td class="width15" align="right">
                                                    <div class="font-title titlebackicon">設定值</div>
                                                </td>
                                                <td class="width20">
                                                    <input type="text" id="txt_pay_valset_taxpercent" class="inputex width100" /></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <br />
                                        <br />
                                        <span>福利金=所有與福利金相關項目加總X<span name="span_ps_payset_boonpercent"></span>%並四捨五入至整數位</span><br />
                                        <span>課稅所得：判讀<br />
                                            應發薪資總額 >= 基本工資(目前為<span name="span_ps_payset_pay"></span>)，則<span id="span_str1"></span>即為課稅所得<br /><!--所有應稅項－(80X28)-->
                                            應發薪資總額 < 基本工資(目前為<span name="span_ps_payset_pay"></span>)，則<span id="span_str2"></span>即為課稅所得<!--所有應稅項加總－出勤天數X80-->
                                        </span>
                                        <input type="text" style="display:none;" id="txt_hidden_sf_str1" />
                                        <input type="text" style="display:none;" id="txt_hidden_sf_str2" />
                                        <input type="text" style="display:none;" id="txt_hidden_sf_now" />
                                    </div>
                                </div>
                            </div>

                            <div id="tabs-1-2">
                                <div class="tabfixwidth">
                                    <div class="stripeMe fixTable">
                                        <table width="99%" border="0" cellspacing="0" cellpadding="0" id="tbl_ti"></table>
                                    </div>
                                </div>
                                <br />
                                <br />
                                <div class="stripeMe " style="margin-top: 15px">
                                    <div class="twocol margin15TB">
                                        <div class="right">
                                            <a href="javascript:void(0);" class="keybtn" id="btn_ti">儲存</a>
                                        </div>
                                    </div>
                                    <span class="font-size3 font-black" style="color:red;">
                                        提醒：<br />
                                        項目:
                                        應稅項目加總、出勤天數需要用[]來表示，ex[應稅項目加總]or[出勤天數]
                                    </span>
                                    <%--<span class="font-size3 font-black" id="span_tf_desc">目前維護項目:應發薪資總額>=基本工資(目前為21009)</span>
                                    <table class="gentable" id="tbl_tf"></table>
                                    <div style="margin-top: 10px" class="font-title font-size3">目前公式為:應稅項加總－出勤天數X80</div>
                                    --%>
                                    <input type="text" style="display:none;" id="txt_hidden_ti_guid1" />
                                    <input type="text" style="display:none;" id="txt_hidden_ti_guid2" />
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- tabs-2 -->
                    <!-- tabs-3 薪資項目設定-->
                    <div id="tabs-3">
                        <div class="twocol margin15TB">
                            <div class="right">
                                <span id="span_si_search">
                                    關鍵字：<input id="search_si_keyword" size="10" />&nbsp;&nbsp;
                                <a href="Javascript:void(0)" class="keybtn" id="btn_si_inner_search">查詢</a>
                                </span>
                                <a href="Javascript:void(0);" class="keybtn" id="btn_si_search" name="div_si">查詢</a>
                                <a href="Javascript:void(0);" class="keybtn fancybox" id="btn_si_add" name="div_si">新增</a>
                            </div>
                        </div>
                        <div class="tabfixwidth" name="div_si">
                            <div class="stripeMe fixTable" style="max-height: 175px;">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_si_item">
                                </table>
                            </div>
                        </div>
                        <div class="twocol margin15TB" name="div_si">
                            <div class="right">
                                <a href="#" class="keybtn" id="btn_si_item" >儲存</a>
                            </div>
                        </div>
                        <div class="tbsfixwidth" style="margin-top: 20px;" name="div_si">
                            <div class="statabs margin10T">
                                <div class="gentable fixTable">
                                    <table width="99%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="width10" colspan="3" align="right">
                                            <div class="font-title titlebackicon">維護狀態</div>
                                            </td>
                                            <td class="width20" style="text-align:left;">
                                                <span id="span_Status">新增</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="width25" align="right">
                                                <div class="font-title titlebackicon">項目代號</div>
                                            </td>
                                            <td class="width25">
                                                <input type="text" class="inputex width100" id="txt_si_itemcode" maxlength="4" /></td>
                                            <td class="width25" align="right">
                                                <div class="font-title titlebackicon">項目名稱</div>
                                            </td>
                                            <td class="width25">
                                                <input type="text" class="inputex width100" id="txt_si_itemname" maxlength="20" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">計投保薪資(納入平均月薪計算)</div>
                                            </td>
                                            <td>
                                                <input type="radio" name="txt_si_Insurance" checked="checked" value="Y" />是&nbsp;&nbsp;<input type="radio" name="txt_si_Insurance" value="N" />否</td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">加/扣項</div>
                                            </td>
                                            <td>
                                                <input type="radio" checked="checked" name="txt_si_itemadd" value="01" />加項&nbsp;&nbsp;<input type="radio" name="txt_si_itemadd" value="02" />扣項</td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">計算職工福利金</div>
                                            </td>
                                            <td>
                                                <input type="radio" name="txt_si_itembenefit" checked="checked" value="Y" />是&nbsp;&nbsp;<input type="radio" name="txt_si_itembenefit" value="N" />否</td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">對應欄位(在薪資異動使用)</div>
                                            </td>
                                            <td>
                                                <select id="txt_si_itemref">
                                                    <%--<option value="">--請選擇--</option>
                                                    <option value="01">底薪</option>
                                                    <option value="02">職能加給</option>--%>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">計算補充保費</div>
                                            </td>
                                            <td>
                                                <input type="radio" name="txt_si_itemsup" checked="checked" value="Y" />是&nbsp;&nbsp;<input type="radio" name="txt_si_itemsup" value="N" />否
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">對應欄位(在勞健保比對使用)</div>
                                            </td>
                                            <td>
                                                <select id="txt_si_itemrefcom">
                                                    <option value="">--請選擇--</option>
                                                    <option value="01">勞保加項</option>
                                                    <option value="02">勞保減項</option>
                                                    <option value="03">健保加項</option>
                                                    <option value="04">健保減項</option>
                                                    <option value="05">勞退自提加項</option>
                                                    <option value="06">勞退自提減項</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">所得稅</div>
                                            </td>
                                            <td>
                                                <input type="radio" checked="checked" name="txt_si_itemtax" value="01" />應稅&nbsp;&nbsp;
                                                <input type="radio" name="txt_si_itemtax" value="02" />免稅&nbsp;&nbsp;
                                                <input type="radio" name="txt_si_itemtax" value="03" />與稅無關
                                            </td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon">是否法扣</div>
                                        </td>
                                        <td class="width20">
                                            <input type="radio" name="txt_si_siBuckle" value="Y" />是
                                            <input type="radio" name="txt_si_siBuckle" value="N" />否
                                        </td>
                                        </tr>
                                        <tr style="display:none;">
                                            <td style="display:none;"><input style="display:none;" id="hidden_si_itemguid" /></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>

                    </div>
                    <!--tabs-3-->
                    <!-- tabs-4 加班費設定-->
                    <div id="tabs-4">
                        <div class="twocol margin15TB">
                            <div class="right">
                                <a href="javascript:void(0);" class="keybtn" id="btn_o">儲存</a>
                            </div>
                        </div>

                        <span class="font-size2 font-bold">每月允許不扣稅之平常加班時數</span>
                        <div class="div-line" style="width: 450px">
                            <table class="table-margin">
                                <tr>
                                    <td colspan="2">&nbsp;&nbsp;男性為<input type="text" class="width10" value="" id="txt_o_oMale" />小時</td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;&nbsp;女性為<input type="text" class="width10" value="" id="txt_o_oFemale" />小時</td>
                                </tr>
                            </table>
                        </div>

                        <!--20170609決定拿掉-->
                        <!--<div class="div-line" style="margin-top: 20px; width: 450px">
                            <table class="table-margin">
                                <tr>
                                    <td colspan="2">加班費如採固定金額時，每小時加班費為<input type="text" class="width10" value="" id="txt_o_oFixed" />元</td>
                                </tr>
                            </table>
                        </div>-->

                        <div style="margin-top: 20px;" class="font-size2 font-bold">加班費如係按底薪換算，每小時加班費係以每小時底薪乘以何比率</div>
                        <div class="div-line" style="width: 450px">
                            <table class="table-margin">
                                <tr>
                                    <td width="150px">
                                        <input type="text" value="" class="width10" id="txt_o_oOverTime1" maxlength="2" />小時以內</td>
                                    <td>加班比率-1類<input type="text" value="" class="width25" id="txt_o_oOverTimePay1" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" value="" class="width10" id="txt_o_oOverTime2Start" maxlength="2" />至<input type="text" class="width10" value="" id="txt_o_oOverTime2End" maxlength="2" />小時</td>
                                    <td>加班比率-2類<input type="text" class="width25" value="" id="txt_o_oOverTimePay2" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" value="" class="width10" id="txt_o_oOverTime3" maxlength="2" />小時以上</td>
                                    <td>加班比率-3類<input type="text" value="" class="width25" id="txt_o_oOverTimePay3" maxlength="6" />%</td>
                                </tr>
                            </table>
                        </div>

                        <div style="margin-top: 20px;" class="font-size2 font-bold">休息日加班費</div>
                        <div class="div-line" style="width: 450px">
                            <table class="table-margin">
                                <tr>
                                    <td width="150px">
                                        <input type="text" value="" class="width10" id="txt_o_oOffDay1" maxlength="2" />小時以內</td>
                                    <td>加給倍率<input type="text" value="" class="width25" id="txt_o_oOffDayPay1" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" value="" class="width10" id="txt_o_oOffDay2Start" maxlength="2" />至<input type="text" class="width10" value="" id="txt_o_oOffDay2End" maxlength="2" />小時</td>
                                    <td>加給倍率<input type="text" class="width25" value="" id="txt_o_oOffDayPay2" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" value="" class="width10" id="txt_o_oOffDay3Start" maxlength="2" /><!---->至<input type="text" value="0" class="width10" id="txt_o_oOffDay3End" maxlength="2" style="display:none;" /></td>
                                    <td>加給倍率<input type="text" value="0" class="width25" id="txt_o_oOffDayPay3" maxlength="6" />%</td>
                                </tr>
                            </table>
                        </div>

                        <div style="margin-top: 20px;" class="font-size2 font-bold">例假日加班費</div>
                        <div class="div-line" style="width: 450px">
                            <table class="table-margin">
                                <tr>
                                    <td width="150px">
                                        <input type="text" value="" class="width10" id="txt_o_oNationalHolidays1" maxlength="2" />小時以內</td>
                                    <td>加給倍率<input type="text" value="" class="width25" id="txt_o_oNationalHolidaysPay1" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" value="" class="width10" id="txt_o_oNationalHolidays2Start" maxlength="2" />至<input type="text" class="width10" value="" id="txt_o_oNationalHolidays2End" maxlength="2" />小時</td>
                                    <td>加給倍率<input type="text" class="width25" value="" id="txt_o_oNationalHolidaysPay2" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" value="" class="width10" id="txt_o_oNationalHolidays3Start" maxlength="2" />至<input type="text" value="" class="width10" id="txt_o_oNationalHolidays3End" maxlength="2" /></td>
                                    <td>加給倍率<input type="text" value="" class="width25" id="txt_o_oNationalHolidaysPay3" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td width="150px">
                                        <input type="text" value="" class="width10" id="txt_o_oNationalHolidays4" maxlength="2" />小時以上</td>
                                    <td>加給倍率<input type="text" value="" class="width25" id="txt_o_oNationalHolidaysPay4" maxlength="6" />%</td>
                                </tr>
                            </table>
                        </div>

                        <div style="margin-top: 20px;" class="font-size2 font-bold">國定假日加班費</div>
                        <div class="div-line" style="width: 450px">
                            <table class="table-margin">
                                <tr>
                                    <td width="150px">
                                        <input type="text" value="" class="width10" id="txt_o_oPublickHoliday1" maxlength="2" />小時以內</td>
                                    <td>加給倍率<input type="text" value="" class="width25" id="txt_o_oPublickHolidayPay1" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" value="" class="width10" id="txt_o_oPublickHoliday2Start" maxlength="2" />至<input type="text" class="width10" value="" id="txt_o_oPublickHoliday2End" maxlength="2" />小時</td>
                                    <td>加給倍率<input type="text" class="width25" value="" id="txt_o_oPublickHolidayPay2" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" value="" class="width10" id="txt_o_oPublickHoliday3Start" maxlength="2" />至<input type="text" value="" class="width10" id="txt_o_oPublickHoliday3End" maxlength="2" /></td>
                                    <td>加給倍率<input type="text" value="" class="width25" id="txt_o_oPublickHolidayPay3" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td width="150px">
                                        <input type="text" value="" class="width10" id="txt_o_oPublickHoliday4" maxlength="2" />小時以上</td>
                                    <td>加給倍率<input type="text" value="" class="width25" id="txt_o_oPublickHolidayPay4" maxlength="6" />%</td>
                                </tr>
                            </table>
                        </div>

                        <!--<div style="margin-top: 20px;" class="font-size2 font-bold">特殊假日加班費</div>
                        <div class="div-line" style="width: 450px">
                            <table class="table-margin">
                                <tr>
                                    <td width="150px">
                                        <input type="text" value="" class="width10" id="txt_o_oSpecialHolidays1" maxlength="2" />小時以內</td>
                                    <td>加給倍率<input type="text" value="" class="width25" id="txt_o_oSpecialHolidaysPay1" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" value="" class="width10" id="txt_o_oSpecialHolidays2Start" maxlength="2" />至<input type="text" class="width10" value="" id="txt_o_oSpecialHolidays2End" maxlength="2" />小時</td>
                                    <td>加給倍率<input type="text" class="width25" value="" id="txt_o_oSpecialHolidaysPay2" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="text" value="" class="width10" id="txt_o_oSpecialHolidays3Start" maxlength="2" />至<input type="text" value="" class="width10" id="txt_o_oSpecialHolidays3End" maxlength="2" /></td>
                                    <td>加給倍率<input type="text" value="" class="width25" id="txt_o_oSpecialHolidaysPay3" maxlength="6" />%</td>
                                </tr>
                                <tr>
                                    <td width="150px">
                                        <input type="text" value="" class="width10" id="txt_o_oSpecialHolidays4" maxlength="2" />小時以上</td>
                                    <td>加給倍率<input type="text" value="" class="width25" id="txt_o_oSpecialHolidaysPay4" maxlength="6" />%</td>
                                </tr>
                            </table>
                        </div>-->

                        <!--<div class="div-line" style="margin-top: 20px; width: 450px">
                            <table class="table-margin">
                                <tr>
                                    <td colspan="2">例假日加班比率-假日<input type="text" value="200" class="width10" id="txt_o_oNationalHolidays" />%(每小時以(底薪+職能加給)X倍數計算)</td>
                                </tr>
                                <tr>
                                    <td colspan="2">國定假日加班加班比率-假日<input type="text" value="200" class="width10" id="txt_o_oPublickHoliday" />%(每小時以底薪X倍數計算)</td>
                                </tr>
                            </table>
                        </div>-->
                        <input type="text" value="9" style="display:none;" id="hidden_txt_o_oGuid" />
                    </div>
                    <!-- tabs-4 -->
                    <!-- tabs-5 給薪假設定-->
                    <div id="tabs-5">
                        <div class="twocol margin15TB">
                            <div class="right">
                                <span id="span_ph_search">
                                    關鍵字：<input id="search_ph_keyword" size="10" />&nbsp;&nbsp;
                                <a href="Javascript:void(0)" class="keybtn" id="btn_ph_inner_search">查詢</a>
                                </span>
                                <a href="Javascript:void(0);" class="keybtn" id="btn_ph_search" name="div_ph">查詢</a>
                                <%--<a href="Javascript:void(0);" class="keybtn fancybox" id="btn_si_add" name="div_ph">新增</a>--%>
                            </div>
                        </div>
                        <div class="tabfixwidth" name="div_ph">
                            <div class="stripeMe fixTable" style="max-height: 175px;">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tbl_ph"></table>
                            </div>
                        </div>
                        <div class="twocol margin15TB" name="div_ph">
                            <div class="right">
                                <a href="#" class="keybtn" id="btn_ph">儲存</a>
                            </div>
                        </div>
                        <div class="tbsfixwidth" style="margin-top: 20px;" name="div_ph">
                            <div class="statabs margin10T">
                                <div class="gentable fixTable">
                                    <table width="99%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">給薪假名稱</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" id="txt_ph_name" /></td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">計算基準</div>
                                            </td>
                                            <td>
                                                <input type="radio" name="txt_ph_basic" checked="checked" value="01" />全薪&nbsp;&nbsp;
                                                <input type="radio" name="txt_ph_basic" value="02" />半薪&nbsp;&nbsp;
                                                <input type="radio" name="txt_ph_basic" value="03" />無薪&nbsp;&nbsp;</td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">給假天數</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width45" id="txt_ph_days" maxlength="5" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">備註</div>
                                            </td>
                                            <td colspan="5">
                                                <input type="text" class="inputex width100" id="txt_ph_ps" /></td>
                                        </tr>
                                    </table>
                                    <input type="text" id="hidden_ph_guid" style="display:none;" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- tabs-5 -->
                </div>
                <!-- statabs -->
                <!-- 詳細資料end -->
            </div>
            <!-- fixwidth -->
        </div>
        <!-- fixwidth -->
    </div>
    <!-- WrapperMain -->
</asp:Content>

