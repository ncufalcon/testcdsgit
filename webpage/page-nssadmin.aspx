<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-nssadmin.aspx.cs" Inherits="webpage_page_nssadmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .stripeMe th {
            border-top:0px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            //*****************保險基本設定 保險基本設定 START***************//
            call_ibdata();
            //頁籤點擊事件
            $(".li_clk").click(function () {
                switch($(this).attr("id")){
                    case "li_1":
                        call_ibdata();//保險基本設定
                        break;
                    case "li_2":
                        call_iidata();//勞健保身分
                        break;
                    case "li_3":
                        call_sldata();//補助等級設定
                        break;
                    case "li_4":
                        call_il_date();//投保級距設定 生效日期
                        call_ildata();//投保級距設定
                        break;
                    case "li_5":
                        call_ssi_data();//到職保薪設定
                        break;
                    case "li_1_1":
                        call_ibdata();//保險基本設定
                        break;
                    case "li_1_2":
                        call_gidata();//團體保險
                        break;
                    case "li_2_1":
                        call_iidata();//勞健保身分
                        break;
                    case "li_2_2":
                        call_giidata();//團保投保身分
                        break;
                }
            });
            //保險基本設定 儲存按鈕
            $("#btn_ib").click(function () {
                modify_ibdata();
            });
            //*****************保險基本設定 保險基本設定 END***************//
            //*****************保險基本設定 團體保險 START***************//
            $("#span_gi_search").hide();
            //團體保險 外面的查詢按鈕
            $("#btn_gi_search").click(function () {
                $("#span_gi_search").show();
                $("div[name='div_gi']").hide();
            });
            //團體保險 裡面的查詢按鈕
            $("#btn_gi_inner_search").click(function () {
                $("#span_gi_search").hide();
                $("div[name='div_gi']").show();
                $("#hidden_gi_guid").val("");
                call_gidata();//團體保險
            });
            //團體保險 新增按鈕
            $("#btn_gi_add").click(function () {
                $("#txt_gi_code").val("");
                $("#txt_gi_name").val("");
                $("#txt_gi_age").val("");
                $("#txt_gi_ps").val("");
                $("#span_gi_Status").text("新增");
                $("#hidden_gi_guid").val("");
            });
            //團體保險 儲存按鈕
            $("#btn_gi").click(function () {
                mod_gidata();
            });
            //團體保險 tr 點擊事件
            $(document).on("click", "#tbl_gi tbody tr td:not(:nth-child(1))", function () {
                var this_id = $(this).closest('tr').attr("trguid");
                $("#hidden_gi_guid").val(this_id);
                $("#span_gi_Status").text("修改");
                call_gidata_byguid();
            });
            //團體保險 刪除
            $(document).on("click", "a[name='a_gi_del_guid']", function () {
                var del_guid = $(this).attr("aguid");
                if(confirm("確定刪除?")){
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-nssadmin.ashx",
                        data: {
                            func: "del_gidata",
                            del_gi_guid: del_guid
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response == "error") {
                                alert("刪除失敗");
                            } else {
                                alert("刪除成功");
                                call_gidata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            });
            //*****************保險基本設定 團體保險 END***************//

            //*****************投保身分設定 勞健保身分 START***************//
            $("#span_ii_search").hide();
            //投保身分設定 勞健保身分 外面的查詢按鈕
            $("#btn_ii_search").click(function () {
                $("#span_ii_search").show();
                $("div[name='div_ii']").hide();
            });
            //投保身分設定 勞健保身分 裡面的查詢按鈕
            $("#btn_ii_inner_search").click(function () {
                $("#span_ii_search").hide();
                $("div[name='div_ii']").show();
                $("#hidden_ii_guid").val("");
                call_iidata();//勞健保身分
            });
            //投保身分設定 勞健保身分 新增按鈕
            $("#btn_ii_add").click(function () {
                $("#txt_ii_iiIdentityCode").val("");
                $("#txt_ii_iiIdentity").val("");
                $("#span_ii_Status").text("新增");
                $("input[name='txt_ii_iiInsurance1']").removeAttr("checked");
                $("input[name='txt_ii_iiInsurance2']").removeAttr("checked");
                $("input[name='txt_ii_iiInsurance3']").removeAttr("checked");
                $("input[name='txt_ii_iiInsurance4']").removeAttr("checked");
                $("input[name='txt_ii_iiInsurance5']").removeAttr("checked");
                $("#txt_ii_iiRetirement").val("");
                $("#hidden_ii_guid").val("");
            });
            //投保身分設定 勞健保身分 儲存按鈕
            $("#btn_ii").click(function () {
                mod_iidata();
            });
            //投保身分設定 勞健保身分 tr 點擊事件
            $(document).on("click", "#tbl_ii tbody tr td:not(:nth-child(1))", function () {
                var this_id = $(this).closest('tr').attr("trguid");
                $("#hidden_ii_guid").val(this_id);
                $("#span_ii_Status").text("修改");
                call_iidata_byguid();
            });
            //投保身分設定 勞健保身分 刪除
            $(document).on("click", "a[name='a_ii_del_guid']", function () {
                var del_guid = $(this).attr("aguid");
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-nssadmin.ashx",
                        data: {
                            func: "del_iidata",
                            del_ii_guid: del_guid
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response == "error") {
                                alert("刪除失敗");
                            } else {
                                alert("刪除成功");
                                call_iidata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            });
            //*****************投保身分設定 勞健保身分 END***************//

            //*****************投保身分設定 團保投保身分 START***************//
            $("#span_gii_search").hide();
            //投保身分設定 團保投保身分 外面的查詢按鈕
            $("#btn_gii_search").click(function () {
                $("#span_gii_search").show();
                $("div[name='div_gii']").hide();
            });
            //投保身分設定 團保投保身分 裡面的查詢按鈕
            $("#btn_gii_inner_search").click(function () {
                $("#span_gii_search").hide();
                $("div[name='div_gii']").show();
                $("#hidden_gii_guid").val("");
                call_giidata();//團保投保身分
            });
            //投保身分設定 團保投保身分 儲存按鈕
            $("#btn_gii").click(function () {
                mod_giidata();
            });
            //投保身分設定 團保投保身分 tr 點擊事件
            $(document).on("click", "#tbl_gii tbody tr td:not(:nth-child(1))", function () {
                var this_id = $(this).closest('tr').attr("trguid");
                $("#hidden_gii_guid").val(this_id);
                $("#span_gii_Status").text("修改");
                call_giidata_byguid();
            });
            //投保身分設定 團保投保身分 新增按鈕
            $("#btn_gii_add").click(function () {
                $("#txt_gii_giidentityCode").val("");
                $("#txt_gii_giiIdentity").val("");
                $("#txt_gii_giiItem1").val("");
                $("#txt_gii_giiItem2").val("");
                $("#txt_gii_giiItem3").val("");
                $("#span_gii_Status").text("新增");
                $("#hidden_gii_guid").val("");
            });
            //投保身分設定 團保投保身分 刪除
            $(document).on("click", "a[name='a_gii_del_guid']", function () {
                var del_guid = $(this).attr("aguid");
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-nssadmin.ashx",
                        data: {
                            func: "del_giidata",
                            del_gii_guid: del_guid
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response == "error") {
                                alert("刪除失敗");
                            } else {
                                alert("刪除成功");
                                call_giidata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            });
            //*****************投保身分設定 團保投保身分 END***************//

            //*****************補助等級設定 START***************//
            $("#span_sl_search").hide();
            //補助等級設定  外面的查詢按鈕
            $("#btn_sl_search").click(function () {
                $("#span_sl_search").show();
                $("div[name='div_sl']").hide();
            });
            //補助等級設定  裡面的查詢按鈕
            $("#btn_sl_inner_search").click(function () {
                $("#span_sl_search").hide();
                $("div[name='div_sl']").show();
                $("#hidden_sl_guid").val("");
                call_sldata();//補助等級設定
            });
            //補助等級設定  儲存按鈕
            $("#btn_sl").click(function () {
                mod_sldata();
            });
            //補助等級設定  tr 點擊事件
            $(document).on("click", "#tbl_sl tbody tr td:not(:nth-child(1))", function () {
                var this_id = $(this).closest('tr').attr("trguid");
                $("#hidden_sl_guid").val(this_id);
                $("#span_sl_Status").text("修改");
                call_sldata_byguid();
            });
            //補助等級設定  新增按鈕
            $("#btn_sl_add").click(function () {
                $("#txt_sl_slSubsidyCode").val("");
                $("#txt_sl_slSubsidyIdentity").val("");
                $("#txt_sl_slSubsidyRatio1").val("");
                $("#txt_sl_slSubsidyRatio2").val("");
                $("#txt_sl_slSubsidyRatio3").val("");
                $("#span_sl_Status").text("新增");
                $("#hidden_sl_guid").val("");
            });
            //補助等級設定  刪除
            $(document).on("click", "a[name='a_sl_del_guid']", function () {
                var del_guid = $(this).attr("aguid");
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: true, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/page-nssadmin.ashx",
                        data: {
                            func: "del_sldata",
                            del_sl_guid: del_guid
                        },
                        error: function (xhr) {
                            alert("error");
                        },
                        beforeSend: function () {
                            $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                        },
                        success: function (response) {
                            if (response == "error") {
                                alert("刪除失敗");
                            } else {
                                alert("刪除成功");
                                call_sldata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            });
            //*****************補助等級設定 END***************//

            //*****************投保級距設定 START***************//
            $("#div_date").hide();
            //生效日期 下拉選單切換
            $("#select_il_date").change(function () {
                call_ildata();
            });
            //薪資異動 批次匯入按鈕
            $("#btn_il_import").click(function () {
                $.fancybox({
                    href: "InsuranceLevelImport.aspx",
                    type: "iframe",
                    width: "300",
                    height: "200",
                    closeClick: false,
                    openEffect: 'elastic',
                    closeEffect: 'elastic'
                });
            });
            //*****************投保級距設定 ENDT***************//

            //*****************到職保薪設定  START***************//
            $("#btn_ssi").click(function () {
                if (chk_ssi_data()) {
                    mod_ssidata();
                }
            });
            //*****************到職保薪設定  END***************//
        });
        //撈保險基本設定 資料
        function call_ibdata() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_iddata"
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response!="nodata") {
                        $("#txt_ib_ibLaborProtection1").val(response[0].ibLaborProtection1);
                        $("#txt_ib_ibLaborProtection2").val(response[0].ibLaborProtection2);
                        $("#txt_ib_ibLaborProtection3").val(response[0].ibLaborProtection3);
                        $("#txt_ib_ibLaborProtection4").val(response[0].ibLaborProtection4);
                        $("#txt_ib_ibLaborProtection5").val(response[0].ibLaborProtection5);
                        $("#txt_ib_ibLaborProtection6").val(response[0].ibLaborProtection6);
                        $("#txt_ib_ibHealthcare1").val(response[0].ibHealthcare1);
                        $("#txt_ib_ibHealthcare2").val(response[0].ibHealthcare2);
                        $("#txt_ib_ibHealthcare3").val(response[0].ibHealthcare3);
                        $("#txt_ib_ibHealthcare4").val(response[0].ibHealthcare4);
                        $("#txt_ib_ibHealthcare5").val(response[0].ibHealthcare5);
                        $("#txt_ib_ibHealthcare6").val(response[0].ibHealthcare6);
                        $("#txt_ib_ibHealthcare6_down").val(response[0].ibHealthcare6_down);
                        $("#txt_ib_ibHealthcare6_up").val(response[0].ibHealthcare6_up);
                        $("input[name='txt_ib_ibLaborProtection7'][value='" + response[0].ibLaborProtection7 + "']").prop("checked", true);
                        $("input[name='txt_ib_ibHealthcare7'][value='" + response[0].ibHealthcare7 + "']").prop("checked", true);
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //保險基本設定 檢查儲存欄位
        function chk_ibdata() {
            //所有數字欄位 input
            var all_num_col = $("#tbl_ib_list input[type='text']");
            for (var i = 0; i < all_num_col.length; i++) {
                if (isNaN(all_num_col[i].value)) {
                    alert("請輸入數字");
                    return false;
                }
            }
            return true;
        }
        //保險基本設定 新增修改
        function modify_ibdata(){
            if (chk_ibdata()) {
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-nssadmin.ashx",
                    data: {
                        func: "mod_iddata",
                        mod_ibLaborProtection1: $("#txt_ib_ibLaborProtection1").val(),
                        mod_ibLaborProtection2: $("#txt_ib_ibLaborProtection2").val(),
                        mod_ibLaborProtection3: $("#txt_ib_ibLaborProtection3").val(),
                        mod_ibLaborProtection4: $("#txt_ib_ibLaborProtection4").val(),
                        mod_ibLaborProtection5: $("#txt_ib_ibLaborProtection5").val(),
                        mod_ibLaborProtection6: $("#txt_ib_ibLaborProtection6").val(),
                        mod_ibHealthcare1: $("#txt_ib_ibHealthcare1").val(),
                        mod_ibHealthcare2: $("#txt_ib_ibHealthcare2").val(),
                        mod_ibHealthcare3: $("#txt_ib_ibHealthcare3").val(),
                        mod_ibHealthcare4: $("#txt_ib_ibHealthcare4").val(),
                        mod_ibHealthcare5: $("#txt_ib_ibHealthcare5").val(),
                        mod_ibHealthcare6: $("#txt_ib_ibHealthcare6").val(),
                        mod_ibHealthcare6_down: $("#txt_ib_ibHealthcare6_down").val(),
                        mod_ibHealthcare6_up: $("#txt_ib_ibHealthcare6_up").val(),
                        mod_ibLaborProtection7: $("input[name='txt_ib_ibLaborProtection7']:checked").val(),
                        mod_ibHealthcare7: $("input[name='txt_ib_ibHealthcare7']:checked").val()
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
                            alert("修改失敗");
                        }
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            } 
        }

        //撈團體保險 資料
        function call_gidata() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_gidata",
                    str_keyword: $("#search_gi_keyword").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    $("#tbl_gi").empty();
                    var str_html="";
                    if (response != "nodata") {
                        str_html += '<thead>';
                        str_html += '<tr>';
                        str_html += '<th width="80" nowrap="nowrap">操作</th>';
                        str_html += '<th nowrap="nowrap">保險代號</th>';
                        str_html += '<th nowrap="nowrap">保險項目名稱</th>';
                        str_html += '<th nowrap="nowrap">承保年齡上限</th>';
                        str_html += '<th nowrap="nowrap">備註</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr trguid=' + response[i].giGuid + '>';
                            str_html += '<td align="center" nowrap="nowrap" class="font-normal"><a name="a_gi_del_guid" href="javascript:void(0);" aguid=' + response[i].giGuid + '>刪除</a></td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].giInsuranceCode + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].giInsuranceName + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].giAge + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].giPs + '</td>';
                            str_html += '</tr>';
                        }
                        str_html += '</tbody>';
                        
                    } else {
                        str_html += "<tr><td colspan='5'>查無資料</td></tr>";
                    }
                    $("#tbl_gi").append(str_html);
                    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                    $(".stripeMe tr:even").addClass("alt");
                    $(".fixTable").tableHeadFixer();
                    $("#search_gi_keyword").val("");
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //撈團體保險 資料 by guid
        function call_gidata_byguid() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_gidata",
                    str_guid: $("#hidden_gi_guid").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response != "nodata") {
                        $("#txt_gi_code").val(response[0].giInsuranceCode);
                        $("#txt_gi_name").val(response[0].giInsuranceName);
                        $("#txt_gi_age").val(response[0].giAge);
                        $("#txt_gi_ps").val(response[0].giPs);
                    }else {
                        $("#txt_gi_code").val("");
                        $("#txt_gi_name").val("");
                        $("#txt_gi_age").val("");
                        $("#txt_gi_ps").val("");
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //團體保險 新增/修改資料
        function mod_gidata() {
            if (chk_gidata()) {
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-nssadmin.ashx",
                    data: {
                        func: "mod_gidata",
                        mod_gi_code: $("#txt_gi_code").val(),
                        mod_gi_name: $("#txt_gi_name").val(),
                        mod_gi_age: $("#txt_gi_age").val(),
                        mod_gi_ps: $("#txt_gi_ps").val(),
                        mod_gi_Status: $("#span_gi_Status").text(),
                        mod_gi_guid: $("#hidden_gi_guid").val()
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
                                alert("保險代號重複");
                            } else {
                                if ($("#span_gi_Status").text() == "新增") {
                                    alert("新增成功");
                                } else {
                                    alert("修改成功");
                                }
                                call_gidata();
                            }
                            
                        } else {
                            if ($("#span_gi_Status").text() == "新增") {
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
        }
        //團體保險 檢查儲存欄位
        function chk_gidata() {
            //所有數字欄位 input
            var chk_gi_code = $("#txt_gi_code").val();
            var chk_gi_name = $("#txt_gi_name").val();
            var chk_gi_age = $("#txt_gi_age").val();
            if (isNaN(chk_gi_code)) {
                alert("保險代號只能輸入數字");
                return false;
            }
            //20170525 word裡面說保險項目名稱會有文字
            //if (isNaN(chk_gi_name)) {
            //    alert("保險項目名稱只能輸入數字");
            //    return false;
            //}
            if (isNaN(chk_gi_age)) {
                alert("承保年齡上限只能輸入數字");
                return false;
            }
            return true;
        }

        //撈 勞健保身分
        function call_iidata(){
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_iidata",
                    str_keyword: $("#search_ii_keyword").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    $("#tbl_ii").empty();
                    var str_html = "";
                    if (response != "nodata") {
                        str_html += '<thead>';
                        str_html += '<tr>';
                        str_html += '<th width="80" nowrap="nowrap" rowspan="2">操作</th>';
                        str_html += '<th nowrap="nowrap" rowspan="2">身分代碼</th>';
                        str_html += '<th nowrap="nowrap" rowspan="2">身分名稱</th>';
                        str_html += '<th nowrap="nowrap" colspan="5">投保項目</th>';
                        str_html += '<th nowrap="nowrap" rowspan="2">勞退雇主提撥率(%)</th>';
                        str_html += '</tr>';
                        str_html += '<tr>';
                        str_html += '<th nowrap="nowrap">普通事故</th>';
                        str_html += '<th nowrap="nowrap">就業保險</th>';
                        str_html += '<th nowrap="nowrap">職災保險</th>';
                        str_html += '<th nowrap="nowrap">墊償基金</th>';
                        str_html += '<th nowrap="nowrap">健保</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr trguid=' + response[i].iiGuid + '>';
                            str_html += '<td align="center" nowrap="nowrap" class="font-normal"><a name="a_ii_del_guid" href="javascript:void(0);" aguid=' + response[i].iiGuid + '>刪除</a></td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].iiIdentityCode + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].iiIdentity + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].iiInsurance1 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].iiInsurance2 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].iiInsurance3 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].iiInsurance4 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].iiInsurance5 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].iiRetirement + '</td>';
                            str_html += '</tr>';
                        }
                        str_html += '</tbody>';
                    } else {
                        str_html += "<tr><td colspan='9'>查無資料</td></tr>";
                    }
                    $("#tbl_ii").append(str_html);
                    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                    $(".stripeMe tr:even").addClass("alt");
                    $(".fixTable").tableHeadFixer();
                    $("#search_gi_keyword").val("");
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //撈 勞健保身分 by guid
        function call_iidata_byguid() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_iidata",
                    str_guid: $("#hidden_ii_guid").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response != "nodata") {
                        $("#txt_ii_iiIdentityCode").val(response[0].iiIdentityCode);
                        $("#txt_ii_iiIdentity").val(response[0].iiIdentity);
                        $("input[name='txt_ii_iiInsurance1'][value='" + response[0].iiInsurance1 + "']").prop("checked", true);
                        $("input[name='txt_ii_iiInsurance2'][value='" + response[0].iiInsurance2 + "']").prop("checked", true);
                        $("input[name='txt_ii_iiInsurance3'][value='" + response[0].iiInsurance3 + "']").prop("checked", true);
                        $("input[name='txt_ii_iiInsurance4'][value='" + response[0].iiInsurance4 + "']").prop("checked", true);
                        $("input[name='txt_ii_iiInsurance5'][value='" + response[0].iiInsurance5 + "']").prop("checked", true);
                        $("#txt_ii_iiRetirement").val(response[0].iiRetirement);
                    } else {
                        
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //勞健保身分 新增/修改資料
        function mod_iidata() {
            if (chk_iidata()) {
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-nssadmin.ashx",
                    data: {
                        func: "mod_iidata",
                        mod_ii_iiIdentityCode: $("#txt_ii_iiIdentityCode").val(),
                        mod_ii_iiIdentity: $("#txt_ii_iiIdentity").val(),
                        mod_ii_Status: $("#span_ii_Status").text(),
                        mod_ii_iiInsurance1: $("input[name='txt_ii_iiInsurance1']:checked").val(),
                        mod_ii_iiInsurance2: $("input[name='txt_ii_iiInsurance2']:checked").val(),
                        mod_ii_iiInsurance3: $("input[name='txt_ii_iiInsurance3']:checked").val(),
                        mod_ii_iiInsurance4: $("input[name='txt_ii_iiInsurance4']:checked").val(),
                        mod_ii_iiInsurance5: $("input[name='txt_ii_iiInsurance5']:checked").val(),
                        mod_ii_iiRetirement: $("#txt_ii_iiRetirement").val(),
                        mod_ii_guid: $("#hidden_ii_guid").val()
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
                                alert("保險代號重複");
                            } else {
                                if ($("#span_ii_Status").text() == "新增") {
                                    alert("新增成功");
                                } else {
                                    alert("修改成功");
                                }
                                call_iidata();
                            }

                        } else {
                            if ($("#span_ii_Status").text() == "新增") {
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
        }
        //勞健保身分 檢查儲存欄位
        function chk_iidata() {
            //所有數字欄位 input
            var chk_ii_iiIdentityCode = $("#txt_ii_iiIdentityCode").val();
            var chk_ii_iiIdentity = $("#txt_ii_iiIdentity").val();
            var chk_ii_1 = $("input[name='txt_ii_iiInsurance1']:checked").val();
            var chk_ii_2 = $("input[name='txt_ii_iiInsurance2']:checked").val();
            var chk_ii_3 = $("input[name='txt_ii_iiInsurance3']:checked").val();
            var chk_ii_4 = $("input[name='txt_ii_iiInsurance4']:checked").val();
            var chk_ii_5 = $("input[name='txt_ii_iiInsurance5']:checked").val();
            var chk_ii_iiRetirement = $("#txt_ii_iiRetirement").val();
            if (chk_ii_iiIdentityCode == "") {
                alert("請輸入身分代號");
                return false;
            }
            if (isNaN(chk_ii_iiIdentityCode)) {
                alert("身分代號只能輸入數字");
                return false;
            }
            if (chk_ii_iiIdentity=="") {
                alert("請輸入身分名稱");
                return false;
            }
            if (chk_ii_1 == undefined) {
                alert("請選擇普通事故選項");
                return false;
            }
            if (chk_ii_2 == undefined) {
                alert("請選擇就業保險選項");
                return false;
            }
            if (chk_ii_3 == undefined) {
                alert("請選擇職災保險選項");
                return false;
            }
            if (chk_ii_4 == undefined) {
                alert("請選擇墊償基金選項");
                return false;
            }
            if (chk_ii_5 == undefined) {
                alert("請選擇健保選項");
                return false;
            }
            if (chk_ii_iiRetirement=="") {
                alert("請輸入勞退雇主提撥率");
                return false;
            }
            if (isNaN(chk_ii_iiRetirement)) {
                alert("勞退雇主提撥率只能輸入數字");
                return false;
            }
            return true;
        }

        //撈團保投保身分 資料
        function call_giidata() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_giidata",
                    str_keyword: $("#search_gii_keyword").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    $("#tbl_gii").empty();
                    var str_html = "";
                    if (response != "nodata") {
                        str_html += '<thead>';
                        str_html += '<tr>';
                        str_html += '<th width="80" nowrap="nowrap" rowspan="2">操作</th>';
                        str_html += '<th nowrap="nowrap" rowspan="2">身分代碼</th>';
                        str_html += '<th nowrap="nowrap" rowspan="2">投保身分</th>';
                        str_html += '<th nowrap="nowrap" colspan="3">投保項目</th>';
                        str_html += '</tr>';
                        str_html += '<tr>';
                        str_html += '<th nowrap="nowrap">團保項目一</th>';
                        str_html += '<th nowrap="nowrap">團保項目二</th>';
                        str_html += '<th nowrap="nowrap">團保項目三</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr trguid=' + response[i].giiGuid + '>';
                            str_html += '<td align="center" nowrap="nowrap" class="font-normal"><a name="a_gii_del_guid" href="javascript:void(0);" aguid=' + response[i].giiGuid + '>刪除</a></td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].giidentityCode + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].giiIdentity + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].giiItem1 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].giiItem2 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].giiItem3 + '</td>';
                            str_html += '</tr>';
                        }
                        str_html += '</tbody>';

                    } else {
                        str_html += "<tr><td colspan='6'>查無資料</td></tr>";
                    }
                    $("#tbl_gii").append(str_html);
                    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                    $(".stripeMe tr:even").addClass("alt");
                    $(".fixTable").tableHeadFixer();
                    $("#search_gii_keyword").val("");
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //撈 團保投保身分 by guid
        function call_giidata_byguid() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_giidata",
                    str_guid: $("#hidden_gii_guid").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response != "nodata") {
                        $("#txt_gii_giidentityCode").val(response[0].giidentityCode);
                        $("#txt_gii_giiIdentity").val(response[0].giiIdentity);
                        $("#txt_gii_giiItem1").val(response[0].giiItem1);
                        $("#txt_gii_giiItem2").val(response[0].giiItem2);
                        $("#txt_gii_giiItem3").val(response[0].giiItem3);
                    } else {

                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //團保投保身分 新增/修改資料
        function mod_giidata() {
            if (chk_giidata()) {
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-nssadmin.ashx",
                    data: {
                        func: "mod_giidata",
                        mod_gii_giidentityCode: $("#txt_gii_giidentityCode").val(),
                        mod_gii_giiIdentity: $("#txt_gii_giiIdentity").val(),
                        mod_gii_giiItem1: $("#txt_gii_giiItem1").val(),
                        mod_gii_giiItem2: $("#txt_gii_giiItem2").val(),
                        mod_gii_giiItem3: $("#txt_gii_giiItem3").val(),
                        mod_gii_Status: $("#span_gii_Status").text(),
                        mod_gii_guid: $("#hidden_gii_guid").val()
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
                                alert("身分代碼重複");
                            } else {
                                if ($("#span_gii_Status").text() == "新增") {
                                    alert("新增成功");
                                } else {
                                    alert("修改成功");
                                }
                                call_giidata();
                            }

                        } else {
                            if ($("#span_gii_Status").text() == "新增") {
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
        }
        //團保投保身分 檢查儲存欄位
        function chk_giidata() {
            //所有數字欄位 input
            var chk_gii_giidentityCode = $("#txt_gii_giidentityCode").val();
            var chk_gii_giiIdentity = $("#txt_gii_giiIdentity").val();
            var chk_gii_giiItem1 = $("#txt_gii_giiItem1").val();
            var chk_gii_giiItem2 = $("#txt_gii_giiItem2").val();
            var chk_gii_giiItem3 = $("#txt_gii_giiItem3").val();
            if (chk_gii_giidentityCode == "") {
                alert("請輸入身分代號");
                return false;
            }
            if (isNaN(chk_gii_giidentityCode)) {
                alert("身分代號只能輸入數字");
                return false;
            }
            if (chk_gii_giiIdentity == "") {
                alert("請輸入投保身分");
                return false;
            }
            //if (chk_gii_giiItem1 == "") {
            //    alert("請輸入團保項目一");
            //    return false;
            //}
            //if (chk_gii_giiItem2 == "") {
            //    alert("請輸入團保項目二");
            //    return false;
            //}
            //if (chk_gii_giiItem3 == "") {
            //    alert("請輸入團保項目三");
            //    return false;
            //}
            return true;
        }

        //撈補助等級設定 資料
        function call_sldata() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_sldata",
                    str_keyword: $("#search_sl_keyword").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    $("#tbl_sl").empty();
                    var str_html = "";
                    if (response != "nodata") {
                        str_html += '<thead>';
                        str_html += '<tr>';
                        str_html += '<th width="80" nowrap="nowrap" rowspan="2">操作</th>';
                        str_html += '<th nowrap="nowrap" rowspan="2">補助代碼</th>';
                        str_html += '<th nowrap="nowrap" rowspan="2">補助身分說明</th>';
                        str_html += '<th nowrap="nowrap" colspan="3">補助比率</th>';
                        str_html += '</tr>';
                        str_html += '<tr>';
                        str_html += '<th nowrap="nowrap" rowspan="2">勞保(%)</th>';
                        str_html += '<th nowrap="nowrap" rowspan="2">健保(%)</th>';
                        str_html += '<th nowrap="nowrap" colspan="3">健保補助上限($)</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr trguid=' + response[i].slGuid + '>';
                            str_html += '<td align="center" nowrap="nowrap" class="font-normal"><a name="a_sl_del_guid" href="javascript:void(0);" aguid=' + response[i].slGuid + '>刪除</a></td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].slSubsidyCode + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].slSubsidyIdentity + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].slSubsidyRatio1 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].slSubsidyRatio2 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].slSubsidyRatio3 + '</td>';
                            str_html += '</tr>';
                        }
                        str_html += '</tbody>';

                    } else {
                        str_html += "<tr><td colspan='6'>查無資料</td></tr>";
                    }
                    $("#tbl_sl").append(str_html);
                    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                    $(".stripeMe tr:even").addClass("alt");
                    $(".fixTable").tableHeadFixer();
                    $("#search_sl_keyword").val("");
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //撈 補助等級設定 by guid
        function call_sldata_byguid() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_sldata",
                    str_guid: $("#hidden_sl_guid").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response != "nodata") {
                        $("#txt_sl_slSubsidyCode").val(response[0].slSubsidyCode);
                        $("#txt_sl_slSubsidyIdentity").val(response[0].slSubsidyIdentity);
                        $("#txt_sl_slSubsidyRatio1").val(response[0].slSubsidyRatio1);
                        $("#txt_sl_slSubsidyRatio2").val(response[0].slSubsidyRatio2);
                        $("#txt_sl_slSubsidyRatio3").val(response[0].slSubsidyRatio3);
                    } else {

                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //補助等級設定 新增/修改資料
        function mod_sldata() {
            if (chk_sldata()) {
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/page-nssadmin.ashx",
                    data: {
                        func: "mod_sldata",
                        mod_sl_slSubsidyCode: $("#txt_sl_slSubsidyCode").val(),
                        mod_sl_slSubsidyIdentity: $("#txt_sl_slSubsidyIdentity").val(),
                        mod_sl_slSubsidyRatio1: $("#txt_sl_slSubsidyRatio1").val(),
                        mod_sl_slSubsidyRatio2: $("#txt_sl_slSubsidyRatio2").val(),
                        mod_sl_slSubsidyRatio3: $("#txt_sl_slSubsidyRatio3").val(),
                        mod_sl_Status: $("#span_sl_Status").text(),
                        mod_sl_guid: $("#hidden_sl_guid").val()
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
                                alert("補助代號重複");
                            } else {
                                if ($("#span_sl_Status").text() == "新增") {
                                    alert("新增成功");
                                } else {
                                    alert("修改成功");
                                }
                                call_sldata();
                            }

                        } else {
                            if ($("#span_sl_Status").text() == "新增") {
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
        }
        //補助等級設定 檢查儲存欄位
        function chk_sldata() {
            var chk_sl_slSubsidyCode = $("#txt_sl_slSubsidyCode").val();
            var chk_sl_slSubsidyIdentity = $("#txt_sl_slSubsidyIdentity").val();
            var chk_sl_slSubsidyRatio1 = $("#txt_sl_slSubsidyRatio1").val();
            var chk_sl_slSubsidyRatio2 = $("#txt_sl_slSubsidyRatio2").val();
            var chk_sl_slSubsidyRatio3 = $("#txt_sl_slSubsidyRatio3").val();
            if (chk_sl_slSubsidyCode == "") {
                alert("請輸入補助代號");
                return false;
            }
            if (chk_sl_slSubsidyIdentity == "") {
                alert("請輸入補助名稱");
                return false;
            }
            if (chk_sl_slSubsidyRatio1=="") {
                alert("請輸入勞保補助比率");
                return false;
            }
            if (isNaN(chk_sl_slSubsidyRatio1)) {
                alert("勞保補助比率只能輸入數字");
                return false;
            }
            if (chk_sl_slSubsidyRatio2 == "") {
                alert("請輸入健保補助比率");
                return false;
            }
            if (isNaN(chk_sl_slSubsidyRatio2)) {
                alert("健保補助比率只能輸入數字");
                return false;
            }
            if (chk_sl_slSubsidyRatio3 == "") {
                alert("健保補助上限健保補助上限");
                return false;
            }
            if (isNaN(chk_sl_slSubsidyRatio3)) {
                alert("健保補助上限只能輸入數字");
                return false;
            }
            return true;
        }

        //撈投保級距設定 資料
        function call_ildata() {
            $.ajax({
                type: "POST",
                async: true, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_ildata",
                    str_il_date: $("#select_il_date").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    $("#tbl_il").empty();
                    var str_html = "";
                    if (response != "nodata") {
                        str_html += '<thead>';
                        str_html += '<tr>';
                        //str_html += '<th width="80" nowrap="nowrap">操作</th>';
                        //str_html += '<th nowrap="nowrap">月投保薪資</th>';
                        str_html += '<th nowrap="nowrap">勞保</th>';
                        str_html += '<th nowrap="nowrap">勞退</th>';
                        str_html += '<th nowrap="nowrap">健保</th>';
                        str_html += '<th nowrap="nowrap">生效日期</th>';
                        str_html += '</tr>';
                        str_html += '</thead>';
                        str_html += '<tbody>';
                        for (var i = 0; i < response.length; i++) {
                            str_html += '<tr trguid=' + response[i].ilGuid + '>';
                            //str_html += '<td align="center" nowrap="nowrap" class="font-normal"><a name="a_sl_del_guid" href="javascript:void(0);" aguid=' + response[i].slGuid + '>刪除</a></td>';
                            //str_html += '<td align="center" nowrap="nowrap">' + response[i].ilItem1 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ilItem2 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ilItem3 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ilItem4 + '</td>';
                            str_html += '<td align="center" nowrap="nowrap">' + response[i].ilEffectiveDate + '</td>';
                            str_html += '</tr>';
                        }
                        str_html += '</tbody>';

                    } else {
                        str_html += "<tr><td colspan='6'>查無資料</td></tr>";
                    }
                    $("#tbl_il").append(str_html);
                    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                    $(".stripeMe tr:even").addClass("alt");
                    $(".fixTable").tableHeadFixer();
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //撈投保級距設定 生效日資料
        function call_il_date() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_il_date"
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    $("#tbl_il").empty();
                    var str_html = "";
                    if (response != "nodata") {
                        $("#select_il_date").empty();
                        for (var i = 0; i < response.length; i++) {
                            if (i == 0) {
                                str_html += '<option value="' + response[i].ilEffectiveDate + '" selected>' + response[i].ilEffectiveDate + '</option>';
                            } else {
                                str_html += '<option value="' + response[i].ilEffectiveDate + '">' + response[i].ilEffectiveDate + '</option>';
                            }
                        }
                        $("#select_il_date").append(str_html);
                        $("#div_date").show();
                    } else {
                        $("#div_date").hide();
                        str_html += "<tr><td colspan='6'>查無資料</td></tr>";
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }

        //撈到職保薪設定
        function call_ssi_data() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "load_SetStartInsurance"
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    $("#tbl_ssi").empty();
                    var str_html = "";
                    if (response != "nodata") {
                        $("#txt_labor").val(response[0].ssi_labor);
                        $("#txt_ganbor").val(response[0].ssi_ganbor);
                        $("#txt_tahui").val(response[0].ssi_tahui);
                    } else {
                        $("#txt_labor").val("0");
                        $("#txt_ganbor").val("0");
                        $("#txt_tahui").val("0");
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //檢查到職保新設定輸入欄位
        function chk_ssi_data() {
            var str_txt_labor = $("#txt_labor").val();
            var str_txt_ganbor = $("#txt_ganbor").val();
            var str_txt_tahui = $("#txt_tahui").val();
            if (str_txt_labor=="") {
                alert("請輸入勞保金額");
                return false;
            }
            if (str_txt_labor == "") {
                alert("請輸入勞保金額");
                return false;
            }
            if (str_txt_tahui == "") {
                alert("請輸入勞退金額");
                return false;
            }
            if (str_txt_labor!="" && isNaN(str_txt_labor)) {
                alert("勞保只能輸入數字");
                return false;
            }
            if (str_txt_ganbor != "" && isNaN(str_txt_ganbor)) {
                alert("健保只能輸入數字");
                return false;
            }
            if (str_txt_tahui != "" && isNaN(str_txt_tahui)) {
                alert("勞退只能輸入數字");
                return false;
            }
            return true;
        }
        //新增/修改 到職保薪設定
        function mod_ssidata(){
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/page-nssadmin.ashx",
                data: {
                    func: "mod_SetStartInsurance",
                    mod_labor: $("#txt_labor").val(),
                    mod_ganbor: $("#txt_ganbor").val(),
                    mod_tahui: $("#txt_tahui").val()
                },
                error: function (xhr) {
                    alert("error");
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                success: function (response) {
                    if (response != "ok") {
                        alert(response);
                    } else {
                        alert("修改成功");
                    }
                },//success end
                complete: function () {
                    $.unblockUI();
                }
            });//ajax end
        }
        //匯入
        function setReflash(str_date) {
            call_il_date();
            $("#select_il_date").val(str_date);
            call_ildata();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10TB">
                <div class="left font-light">首頁 / 系統設定 /<span class="font-black font-bold">保險管理</span></div>
            </div>
            <div class="fixwidth" style="margin-top: 10px;">
                <!-- 詳細資料start -->
                <div class="statabs margin10T">
                    <ul>
                        <li><a class="li_clk" id="li_1" href="#tabs-1">保險基本設定</a></li>
                        <li><a class="li_clk" id="li_2" href="#tabs-2">投保身分設定</a></li>
                        <li><a class="li_clk" id="li_3" href="#tabs-3">補助等級設定</a></li>
                        <li><a class="li_clk" id="li_4" href="#tabs-4">投保級距設定</a></li>
                        <li><a class="li_clk" id="li_5" href="#tabs-5">到職保薪設定</a></li>
                    </ul>
                    <div id="tabs-1">
                        <div class="statabs margin10T">
                            <ul>
                                <li><a class="li_clk" id="li_1_1" href="#tabs-1-1">保險基本設定</a></li>
                                <li><a class="li_clk" id="li_1_2" href="#tabs-1-2">團體保險</a></li>
                            </ul>
                            <div id="tabs-1-1">
                                <div class="tbsfixwidth" style="margin-top: 20px;">
                                    <div class="statabs margin10T">
                                        <div class="twocol margin15TB">
                                            <div class="right">
                                                <a href="javascript:void(0)" class="keybtn" id="btn_ib">儲存</a>
                                            </div>
                                        </div>
                                        <div class="gentable fixTable">
                                            <table width="99%" border="0" cellspacing="0" cellpadding="0" id="tbl_ib_list">
                                                <tr>
                                                    <th colspan="2">
                                                        <div class="font-title font-size3 ">勞保</div>
                                                    </th>
                                                    <th colspan="2">
                                                        <div class="font-title font-size3 ">健保</div>
                                                    </th>
                                                </tr>

                                                <tr>
                                                    <td class="width25" align="right">
                                                        <div class="font-title titlebackicon">普通事故保險費率</div>
                                                    </td>
                                                    <td class="width25">
                                                        <input type="text" class="inputex width100" id="txt_ib_ibLaborProtection1" /></td>
                                                    <td class="width25" align="right">
                                                        <div class="font-title titlebackicon">健保費率</div>
                                                    </td>
                                                    <td class="width25">
                                                        <input type="text" class="inputex width100" id="txt_ib_ibHealthcare1" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">就業保險費率</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibLaborProtection2" /></td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">健保費被保險人負擔比率</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibHealthcare2"  /></td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">職業災害保險費率</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibLaborProtection3" /></td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">健保費投保單位負擔比率</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibHealthcare3" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">工資墊償基金提繳費率</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibLaborProtection4" /></td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">平均眷口數</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibHealthcare4" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">勞保費被保險人負擔比率</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibLaborProtection5" /></td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">地區保費</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibHealthcare5" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">勞保費投保單位負擔比率</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibLaborProtection6" /></td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">補充保險費率</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibHealthcare6" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">補充保費單次給付下限</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibHealthcare6_down" /></td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">補充保費單次給付上限</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ib_ibHealthcare6_up" /></td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">殘月扣款方式</div>
                                                    </td>
                                                    <td>
                                                        <input type="radio" name="txt_ib_ibLaborProtection7" value="1" />按天數扣款<input type="radio" name="txt_ib_ibLaborProtection7" value="2" />不予扣款</td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">殘月扣款方式</div>
                                                    </td>
                                                    <td>
                                                        <input type="radio" name="txt_ib_ibHealthcare7" value="1" />按天數扣款<input type="radio" name="txt_ib_ibHealthcare7" value="2" />不予扣款</td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--tabs-1-1 end-->
                            <div id="tabs-1-2">
                                <div class="twocol margin15TB">
                                    <span id="span_gi_search" class="right">
                                        關鍵字：<input id="search_gi_keyword" size="10" />&nbsp;&nbsp;
                                    <a href="Javascript:void(0)" class="keybtn" id="btn_gi_inner_search">查詢</a>
                                    </span>
                                    <div class="right" name="div_gi">
                                        <a href="#searchblock" class="keybtn" id="btn_gi_search">查詢</a>
                                        <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_gi_add">新增項目</a>
                                    </div>
                                </div>
                                <div class="tabfixwidth" name="div_gi">
                                    <div class="stripeMe fixTable" style="height: 175px;">
                                        <table width="99%" border="0" cellspacing="0" cellpadding="0" id="tbl_gi">
                                            
                                        </table>
                                    </div>
                                </div>
                                <div class="twocol margin15TB" name="div_gi">
                                    <div class="right">
                                        <a href="javascript:void(0);" class="keybtn" id="btn_gi">儲存</a>
                                    </div>
                                </div>
                                <div class="tbsfixwidth" style="margin-top: 20px;" name="div_gi">
                                    <div class="statabs margin10T">
                                        <div class="gentable fixTable">
                                            <table width="99%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td class="width10" align="right" colspan="5">
                                                        <div class="font-title titlebackicon">維護狀態</div>
                                                    </td>
                                                    <td class="width20">
                                                        <span id="span_gi_Status">新增</span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="width13" align="right">
                                                        <div class="font-title titlebackicon">保險代號</div>
                                                    </td>
                                                    <td class="width20">
                                                        <input type="text" class="inputex width100" id="txt_gi_code" /></td>
                                                    <td class="width13" align="right">
                                                        <div class="font-title titlebackicon">保險項目名稱</div>
                                                    </td>
                                                    <td class="width20">
                                                        <input type="text" class="inputex width100" id="txt_gi_name" /></td>
                                                    <td class="width13" align="right">
                                                        <div class="font-title titlebackicon">承保年齡上限</div>
                                                    </td>
                                                    <td class="width20">
                                                        <input type="text" class="inputex width100" id="txt_gi_age" /></td>
                                                </tr>

                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">備註</div>
                                                    </td>
                                                    <td colspan="5">
                                                        <input type="text" class="inputex width100" id="txt_gi_ps" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <input type="text" id="hidden_gi_guid" style="display:none;" />
                            </div>
                            <!--tabs-1-2 end-->
                        </div>
                    </div>
                    <!-- tabs-1 end-->
                    <div id="tabs-2">
                        <div class="statabs margin10T">
                            <ul>
                                <li><a class="li_clk" id="li_2_1" href="#tabs-2-1">勞健保身分</a></li>
                                <li><a class="li_clk" id="li_2_2" href="#tabs-2-2">團保投保身分</a></li>
                            </ul>
                            <div id="tabs-2-1">
                                <div class="twocol margin15TB">
                                    <span id="span_ii_search"  class="right">
                                        關鍵字：<input id="search_ii_keyword" size="10" />&nbsp;&nbsp;
                                    <a href="Javascript:void(0)" class="keybtn" id="btn_ii_inner_search">查詢</a>
                                    </span>
                                    <div class="right"  name="div_ii">
                                        <a href="#searchblock" class="keybtn" id="btn_ii_search">查詢</a>
                                        <a href="Javascript:void(0);" class="keybtn fancybox" id="btn_ii_add">新增</a>
                                    </div>
                                </div>
                                <div class="tabfixwidth" name="div_ii">
                                    <div class="stripeMe fixTable" style="height: 175px;">
                                        <table width="99%" border="0" cellspacing="0" cellpadding="0" id="tbl_ii">
                                            
                                        </table>
                                    </div>
                                </div>
                                <div class="twocol margin15TB" name="div_ii">
                                    <div class="right">
                                        <a href="javascript:void(0);" class="keybtn" id="btn_ii" >儲存</a>
                                    </div>
                                </div>
                                <div class="tbsfixwidth" style="margin-top: 20px;" name="div_ii">
                                    <div class="statabs margin10T">
                                        <div class="gentable font-normal">
                                            <table width="99%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">身分代號</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ii_iiIdentityCode" /></td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">身分名稱</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_ii_iiIdentity" />
                                                    </td>
                                                    <td class="width10" align="right">
                                                        <div class="font-title titlebackicon">維護狀態</div>
                                                    </td>
                                                    <td class="width20">
                                                        <span id="span_ii_Status">新增</span>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="width15" align="right">
                                                        <div class="font-title titlebackicon">普通事故</div>
                                                    </td>
                                                    <td class="width20">
                                                        <input type="radio" name="txt_ii_iiInsurance1" value="Y" />Y<input type="radio" name="txt_ii_iiInsurance1" value="N" />N</td>
                                                    <td class="width15" align="right">
                                                        <div class="font-title titlebackicon">就業保險</div>
                                                    </td>
                                                    <td class="width20">
                                                        <input type="radio" name="txt_ii_iiInsurance2" value="Y" />Y<input type="radio" name="txt_ii_iiInsurance2" value="N" />N</td>
                                                    <td class="width15" align="right">
                                                        <div class="font-title titlebackicon">職災保險</div>
                                                    </td>
                                                    <td class="width20">
                                                        <input type="radio" name="txt_ii_iiInsurance3" value="Y" />Y<input type="radio" name="txt_ii_iiInsurance3" value="N" />N</td>
                                                </tr>
                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">墊償基金</div>
                                                    </td>
                                                    <td>
                                                        <input type="radio" name="txt_ii_iiInsurance4" value="Y" />Y<input type="radio" name="txt_ii_iiInsurance4" value="N" />N</td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">健保</div>
                                                    </td>
                                                    <td>
                                                        <input type="radio" name="txt_ii_iiInsurance5" value="Y" />Y<input type="radio" name="txt_ii_iiInsurance5" value="N" />N</td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">勞退雇主提撥率</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" id="txt_ii_iiRetirement" /></td>
                                                </tr>
                                            </table>
                                        </div>

                                    </div>
                                </div>
                                <input type="text" id="hidden_ii_guid" style="display:none;" />
                            </div>
                            <div id="tabs-2-2">
                                <div class="twocol margin15TB">
                                    <span id="span_gii_search"  class="right">
                                        關鍵字：<input id="search_gii_keyword" size="10" />&nbsp;&nbsp;
                                    <a href="Javascript:void(0)" class="keybtn" id="btn_gii_inner_search">查詢</a>
                                    </span>
                                    <div class="right" name="div_gii">
                                        <a href="#searchblock" class="keybtn" id="btn_gii_search">查詢</a>
                                        <a href="Javascript:void(0);" class="keybtn fancybox" id="btn_gii_add">新增</a>
                                    </div>
                                </div>
                                <div class="tabfixwidth" name="div_gii">
                                    <div class="stripeMe fixTable" style="height: 175px;">
                                        <table width="99%" border="0" cellspacing="0" cellpadding="0" id="tbl_gii">
                                            
                                        </table>
                                    </div>
                                </div>
                                <div class="twocol margin15TB" name="div_gii">
                                    <div class="right">
                                        <a href="javascript:void(0);" class="keybtn" id="btn_gii">儲存</a>
                                    </div>
                                </div>
                                <div class="tbsfixwidth" style="margin-top: 20px;" name="div_gii">
                                    <div class="statabs margin10T">
                                        <div class="gentable font-normal">
                                            <table width="99%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">身分代號</div>
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_gii_giidentityCode" /></td>
                                                    <td align="right">
                                                        <div class="font-title titlebackicon">投保身分</div> 
                                                    </td>
                                                    <td>
                                                        <input type="text" class="inputex width100" id="txt_gii_giiIdentity" />
                                                    </td>
                                                    <td class="width10" align="right">
                                                        <div class="font-title titlebackicon">維護狀態</div>
                                                    </td>
                                                    <td class="width20">
                                                        <span id="span_gii_Status">新增</span>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="width15" align="right">
                                                        <div class="font-title titlebackicon">團保項目一</div>
                                                    </td>
                                                    <td class="width20">
                                                        <input type="text" class="inputex width100" id="txt_gii_giiItem1" /></td>
                                                    <td class="width15" align="right">
                                                        <div class="font-title titlebackicon">團保項目二</div>
                                                    </td>
                                                    <td class="width20">
                                                        <input type="text" class="inputex width100" id="txt_gii_giiItem2" /></td>
                                                    <td class="width15" align="right">
                                                        <div class="font-title titlebackicon">團保項目三</div>
                                                    </td>
                                                    <td class="width20">
                                                        <input type="text" class="inputex width100" id="txt_gii_giiItem3" /></td>
                                                </tr>
                                            </table>
                                        </div>

                                    </div>
                                </div>
                                <input type="text" id="hidden_gii_guid" style="display:none;" />
                            </div>
                        </div>
                    </div>
                    <!-- tabs-2 end-->
                    <div id="tabs-3">
                        <div class="twocol margin15TB">
                            <span id="span_sl_search"  class="right">
                                關鍵字：<input id="search_sl_keyword" size="10" />&nbsp;&nbsp;
                                <a href="Javascript:void(0)" class="keybtn" id="btn_sl_inner_search">查詢</a>
                            </span>
                            <div class="right" name="div_sl">
                                <a href="#searchblock" class="keybtn" id="btn_sl_search">查詢</a>
                                <a href="Javascript:void(0);" class="keybtn fancybox" id="btn_sl_add">新增</a>
                            </div>
                        </div>
                        <div class="tabfixwidth" name="div_sl">
                            <div class="stripeMe fixTable" style="height: 175px;">
                                <table width="99%" border="0" cellspacing="0" cellpadding="0" id="tbl_sl">
                                    
                                </table>
                            </div>
                        </div>
                        <div class="twocol margin15TB" name="div_sl">
                            <div class="right">
                                <a href="javascript:void(0);" class="keybtn" id="btn_sl">儲存</a>
                            </div>
                        </div>
                        <div class="tbsfixwidth" style="margin-top: 20px;" name="div_sl">
                            <div class="statabs margin10T">
                                <div class="gentable font-normal">
                                    <table width="99%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">補助代號</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" id="txt_sl_slSubsidyCode" /></td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">補助名稱</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" id="txt_sl_slSubsidyIdentity" />
                                            </td>
                                            <td class="width10" align="right">
                                                <div class="font-title titlebackicon">維護狀態</div>
                                            </td>
                                            <td class="width20">
                                                <span id="span_sl_Status">新增</span>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td class="width15" align="right">
                                                <div class="font-title titlebackicon">勞保補助比率</div>
                                            </td>
                                            <td class="width20">
                                                <input type="text" class="inputex width100" id="txt_sl_slSubsidyRatio1" /></td>
                                            <td class="width15" align="right">
                                                <div class="font-title titlebackicon">健保補助比率</div>
                                            </td>
                                            <td class="width20">
                                                <input type="text" class="inputex width100" id="txt_sl_slSubsidyRatio2" /></td>
                                            <td class="width15" align="right">
                                                <div class="font-title titlebackicon">健保補助上限</div>
                                            </td>
                                            <td class="width20">
                                                <input type="text" class="inputex width100" id="txt_sl_slSubsidyRatio3" /></td>
                                        </tr>
                                    </table>
                                </div>

                            </div>
                        </div>
                        <input type="text" id="hidden_sl_guid" style="display:none;" />
                    </div>
                    <!--tabs-3 end-->
                    <div id="tabs-4">
                        <div class="twocol margin15TB">
                            <div class="left">
                                <div id="div_date">
                                    生效日期：
                                    <select id="select_il_date"></select>
                                </div>
                            </div>
                            <div class="right">
                                <!--<a href="#searchblock" class="keybtn">查詢</a>-->
                                <a href="../Excel_sample/投保級距匯入範例.xlsx">匯入格式範例檔下載</a>
                                <a href="Javascript:void(0);" class="keybtn" id="btn_il_import">匯入</a>
                            </div>
                        </div>
                        <div class="tabfixwidth" name="div_il">
                            <div class="stripeMe fixTable" style="height: 400px;">
                                <table width="99%" border="0" cellspacing="0" cellpadding="0" id="tbl_il">
                                    
                                </table>
                            </div>
                        </div>
                        <!--<div class="twocol margin15TB">
                            <div class="right">
                                <a href="#" class="keybtn">儲存</a>
                            </div>
                        </div>
                        <div class="tbsfixwidth" style="margin-top: 20px;">
                            <div class="statabs margin10T">
                                <div class="gentable font-normal">
                                    <table width="99%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">月投保薪資</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" /></td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">勞保</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" /></td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">勞退</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" /></td>
                                        </tr>

                                        <tr>
                                            <td class="width15" align="right">
                                                <div class="font-title titlebackicon">健保</div>
                                            </td>
                                            <td class="width20">
                                                <input type="text" class="inputex width100" /></td>
                                            <td class="width15" align="right">
                                                <div class="font-title titlebackicon">生效日期</div>
                                            </td>
                                            <td class="width20">
                                                <input type="text" class="inputex width100" /></td>
                                        </tr>
                                    </table>
                                </div>

                            </div>
                        </div>-->

                    </div>
                    <!--tabs-4 end-->
                    <div id="tabs-5">
                        <div class="tbsfixwidth" style="margin-top: 20px;" name="div_ssi">
                            <span class="font-size3 font-bold">到職勞健保、勞退保薪預設值維護</span>
                            <div class="twocol margin15TB" name="div_ssi">
                                <div class="right">
                                    <a href="javascript:void(0);" class="keybtn" id="btn_ssi">儲存</a>
                                </div>
                            </div>
                            <div class="statabs margin10T">
                                <div class="gentable fixTable">
                                    <table border="0" cellspacing="0" cellpadding="0" style="width:100%;">
                                        <tr>
                                            <td align="right">
                                                <div class="font-title titlebackicon">勞保</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" id="txt_labor" name="txt_num" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">健保</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" id="txt_ganbor" name="txt_num" />
                                            </td>
                                            <td align="right">
                                                <div class="font-title titlebackicon">勞退</div>
                                            </td>
                                            <td>
                                                <input type="text" class="inputex width100" id="txt_tahui" name="txt_num" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- tabs-5 end-->
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

