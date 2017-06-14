<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="Insurance.aspx.cs" Inherits="webpage_Insurance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.js?v=2.1.5") %>"></script>
    <link href="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.css?v=2.1.5") %>" rel="stylesheet" type="text/css"  />
    <%--Common--%>
    <script type="text/javascript">
        $(document).ready(function () {
            getddl("11", "#pl_Change");
            getddl("12", "#pi_Change");
            getddl("13", "#pp_Change");
            getddl("14", "#pfi_Change");
            getddl("19", "#pgi_Change");

            //click tabs to load data
            var TabsAry = ["#tabs-1"];
            $(document).on("click", "a[name='aTab']", function () {
                //紀錄已選過的tab,未postback切換tab時不會刷新
                if ($.inArray($(this).attr("href"), TabsAry) < 0) {
                    TabsAry.push($(this).attr("href"));

                    switch ($(this).attr("href")) {
                        case "#tabs-2":
                            getHealList();
                            break;
                        case "#tabs-3":
                            getPensionList();
                            break;
                        case "#tabs-4":
                            getFamilyInsList();
                            break;
                        case "#tabs-5":
                            getGroupInsList();
                            break;
                    }
                }
            });

            //datepicker
            $("#pl_ChangeDate,#pi_ChangeDate,#pp_ChangeDate,#pfi_ChangeDate,#pgi_ChangeDate").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy/mm/dd',
                dayNamesMin: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
                monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
                yearRange: '-100:+0',
                onClose: function (dateText, inst) {
                    $(this).datepicker('option', 'dateFormat', 'yy/mm/dd');
                }
            });

            //勞健保比對
            $(document).on("click", "#LH_CompBtn", function () {
                $.fancybox({
                    href: "PersonImport.aspx?tp=LH_Compare",
                    type: "iframe",
                    width: "450",
                    minHeight: "50",
                    closeClick: false,
                    openEffect: 'elastic',
                    closeEffect: 'elastic',
                    afterClose: function () {
                        //getData();
                    },
                    helpers: {
                        overlay: { closeClick: false } // prevents closing when clicking OUTSIDE fancybox
                    }
                });
            });

            $(document).on("click", "#L_ExportBtn,#H_ExportBtn,#ppExportBtn,#PfiExportBtn", function () {
                var eType, eItem, cate, ckname;
                switch (this.id) {
                    case "L_ExportBtn":
                        cate = "LH";
                        ckname = "lbck"
                        eItem = $("#ddlLaborExport").val();
                        eType = $("input[name='rbLaborOut']:checked").val();
                        break;
                    case "H_ExportBtn":
                        cate = "LH";
                        ckname = "hck";
                        eItem = $("#ddlHealExport").val();
                        eType = $("input[name='HealOut']:checked").val();
                        break;
                    case "ppExportBtn":
                        cate = "Pension";
                        ckname = "ppck";
                        eItem = $("#ddlPensionExport").val();
                        break;
                    case "PfiExportBtn":
                        cate = "PFI";
                        ckname = "pfick";
                        eItem = $("#ddlPfExport").val();
                        break;
                }

                var perGuid = "";
                $("input[name='" + ckname + "']:checked").each(function () {
                    if (perGuid != "") perGuid += ",";
                    perGuid += "'" + this.value + "'";
                });

                if (perGuid == "") {
                    alert("請勾選要匯出的人員");
                    return false;
                }

                if (eItem == "") {
                    alert("請選擇匯出類別");
                    return false;
                }

                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/InsuranceExport.ashx",
                    data: {
                        category: cate,
                        type: eType,
                        item: eItem,
                        perGuid: perGuid
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },

                    beforeSend: function () {
                        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    },
                    success: function (data) {
                        var reStr = data.split(',');
                        if (reStr[0] == "error") {
                            alert(decodeURIComponent(reStr[1]));
                            $.unblockUI();
                            return false;
                        }
                        else {
                            location.href = "../DOWNLOAD.aspx?FlexCel=" + reStr[1];
                            $.unblockUI();
                        }
                    }
                });
            });
        });

        //DDL
        function getddl(gno, tagName) {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/GetDDL.ashx",
                data: {
                    Group: gno
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("GetDDL Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $(tagName).empty();
                        var ddlstr = '<option value="">--請選擇--</option>';
                        if ($(data).find("code").length > 0) {
                            $(data).find("code").each(function (i) {
                                ddlstr += '<option value="' + $(this).attr("v") + '">' + $(this).attr("desc") + '</option>';
                            });
                        }
                        $(tagName).append(ddlstr);
                    }
                }
            });
        }

        //確認欄位資料key in是否正確
        function checkData(type, v, pNo) {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/checkData.ashx",
                data: {
                    tp: type,
                    str: v,
                    pNo: pNo
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("checkData Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        if ($(data).find("data_item").length > 1)
                            alert("有兩筆資料")
                        else if ($(data).find("data_item").length > 0) {
                            switch (type) {
                                case "LB_Person":
                                    $("#pl_pName").html($("perName", data).text());
                                    $("#pl_NoGuid").val($("perGuid", data).text());
                                    $("#pl_pName").css("color", "");
                                    $("#pl_NoStatus").val("Y");
                                    $("#pl_Dep").html($("cbName", data).text());
                                    break;
                                case "LB_SL":
                                    $("#pl_SLName").html($("slSubsidyIdentity", data).text());
                                    $("#pl_SLGuid").val($("slGuid", data).text());
                                    $("#pl_SLName").css("color", "");
                                    $("#pl_SLStatus").val("Y");
                                    break;
                                case "H_Person":
                                    $("#pi_pName").html($("perName", data).text());
                                    $("#pi_NoGuid").val($("perGuid", data).text());
                                    $("#pi_pName").css("color", "");
                                    $("#pi_NoStatus").val("Y");
                                    $("#pi_Dep").html($("cbName", data).text());
                                    break;
                                case "H_SL":
                                    $("#pi_SLName").html($("slSubsidyIdentity", data).text());
                                    $("#pi_SLGuid").val($("slGuid", data).text());
                                    $("#pi_SLName").css("color", "");
                                    $("#pi_SLStatus").val("Y");
                                    break;
                                case "PP_Person":
                                    $("#pp_pName").html($("perName", data).text());
                                    $("#pp_NoGuid").val($("perGuid", data).text());
                                    $("#pp_pName").css("color", "");
                                    $("#pp_NoStatus").val("Y");
                                    $("#pp_Dep").html($("cbName", data).text());
                                    break;
                                case "PF_Person":
                                    $("#pf_pName").html($("perName", data).text());
                                    $("#pf_NoGuid").val($("perGuid", data).text());
                                    $("#pf_pName").css("color", "");
                                    $("#pf_NoStatus").val("Y");
                                    $("#pfi_Dep").html($("cbName", data).text());
                                    break;
                                case "PF_FName":
                                    if ($("pfName", data).text().trim() == "") {
                                        $("#pf_fName").html("X");
                                        $("#pf_fName").css("color", "red");
                                        $("#pf_fStatus").val("N");
                                        $("#pfi_IDNum").html("");
                                        $("#pfi_Birth").html("");
                                        $("#pfi_Title").html("");
                                    }
                                    else {
                                        $("#pf_fName").html($("pfName", data).text());
                                        $("#pf_PfGuid").val($("pfGuid", data).text());
                                        $("#pfi_IDNum").html($("pfIDNumber", data).text());
                                        $("#pfi_Birth").html($("pfBirthday", data).text());
                                        $("#pfi_Title").html($("pfTitle", data).text());
                                        $("#pf_fName").css("color", "");
                                        $("#pf_NoStatus").val("Y");
                                    }
                                    break;
                                case "PF_SL":
                                    $("#pf_SLName").html($("slSubsidyIdentity", data).text());
                                    $("#pf_SLGuid").val($("slGuid", data).text());
                                    $("#pf_SLName").css("color", "");
                                    $("#pf_SLStatus").val("Y");
                                    break;
                                case "PG_Person":
                                    $("#pg_pName").html($("perName", data).text());
                                    $("#pg_NoGuid").val($("perGuid", data).text());
                                    $("#pg_pName").css("color", "");
                                    $("#pg_NoStatus").val("Y");
                                    $("#pgi_Dep").html($("cbName", data).text());
                                    break;
                                case "PG_FName":
                                    if ($("pfName", data).text().trim() == "") {
                                        $("#pg_fName").html("X");
                                        $("#pg_fName").css("color", "red");
                                        $("#pg_fStatus").val("N");
                                        $("#pgi_IDNum").html("");
                                        $("#pgi_Birth").html("");
                                        $("#pgi_Title").html("");
                                    }
                                    else {
                                        $("#pg_fName").html($("pfName", data).text());
                                        $("#pg_PfGuid").val($("pfGuid", data).text());
                                        $("#pgi_IDNum").html($("pfIDNumber", data).text());
                                        $("#pgi_Birth").html($("pfBirthday", data).text());
                                        $("#pgi_Title").html($("pfTitle", data).text());
                                        $("#pg_fName").css("color", "");
                                        $("#pg_fStatus").val("Y");
                                    }
                                    break;
                                case "PG_IC":
                                    $("#pg_IGName").html($("giInsuranceName", data).text());
                                    $("#pg_ICGuid").val($("giGuid", data).text());
                                    $("#pg_IGName").css("color", "");
                                    $("#pg_IGStatus").val("Y");
                                    break;
                            }
                        }
                        else {
                            switch (type) {
                                case "LB_Person":
                                    $("#pl_pName").html("X");
                                    $("#pl_pName").css("color", "red");
                                    $("#pl_NoStatus").val("N");
                                    $("#pl_Dep").html("");
                                    break;
                                case "LB_SL":
                                    $("#pl_SLName").html("X");
                                    $("#pl_SLName").css("color", "red");
                                    $("#pl_SLStatus").val("N");
                                    break;
                                case "H_Person":
                                    $("#pi_pName").html("X");
                                    $("#pi_pName").css("color", "red");
                                    $("#pi_NoStatus").val("N");
                                    $("#pi_Dep").html("");
                                    break;
                                case "H_SL":
                                    $("#pi_SLName").html("X");
                                    $("#pi_SLName").css("color", "red");
                                    $("#pi_SLStatus").val("N");
                                    break;
                                case "PP_Person":
                                    $("#pp_pName").html("X");
                                    $("#pp_pName").css("color", "red");
                                    $("#pp_NoStatus").val("N");
                                    $("#pp_Dep").html("");
                                    break;
                                case "PF_Person":
                                    $("#pf_pName").html("X");
                                    $("#pf_pName").css("color", "red");
                                    $("#pf_NoStatus").val("N");
                                    $("#pfi_Dep").html("");
                                    break;
                                case "PF_FName":
                                    if ($("#pfi_No").val().trim() == "")
                                        alert("請先輸入員工代號");
                                    else {
                                        $("#pf_fName").html("X");
                                        $("#pf_fName").css("color", "red");
                                        $("#pf_fStatus").val("N");
                                        $("#pfi_IDNum").html("");
                                        $("#pfi_Birth").html("");
                                        $("#pfi_Title").html("");
                                    }
                                    break;
                                case "PF_SL":
                                    $("#pf_SLName").html("X");
                                    $("#pf_SLName").css("color", "red");
                                    $("#pf_SLStatus").val("N");
                                    break;
                                case "PG_Person":
                                    $("#pg_pName").html("X");
                                    $("#pg_pName").css("color", "red");
                                    $("#pg_NoStatus").val("N");
                                    $("#pgi_Dep").html("");
                                    break;
                                case "PG_FName":
                                    if ($("#pgi_No").val().trim() == "")
                                        alert("請先輸入員工代號");
                                    else {
                                        $("#pg_fName").html("X");
                                        $("#pg_fName").css("color", "red");
                                        $("#pg_fStatus").val("N");
                                        $("#pgi_IDNum").html("");
                                        $("#pgi_Birth").html("");
                                        $("#pgi_Title").html("");
                                    }
                                    break;
                                case "PG_IC":
                                    $("#pg_IGName").html("X");
                                    $("#pg_IGName").css("color", "red");
                                    $("#pg_IGStatus").val("N");
                                    break;
                            }
                        }
                    }
                }
            });
        }

        //查詢視窗
        function openfancybox(item) {
            switch ($(item).attr("id")) {
                case "PLBBox":
                    link = "SearchWindow.aspx?v=LInsPerson";
                    break;
                case "PHBox":
                    link = "SearchWindow.aspx?v=HInsPerson";
                    break;
                case "LaborSLBox":
                    link = "SearchWindow.aspx?v=LaborSL";
                    break;
                case "HealSLBox":
                    link = "SearchWindow.aspx?v=HealSL";
                    break;
                case "PPBox":
                    link = "SearchWindow.aspx?v=PPInsPerson";
                    break;
                case "PFBox":
                    link = "SearchWindow.aspx?v=PFInsPerson";
                    break;
                case "PFnBox":
                    link = "SearchWindow.aspx?v=PFInsFname&pgv=" + $("#pf_NoGuid").val();
                    break;
                case "Pfi_SLBox":
                    link = "SearchWindow.aspx?v=PFInsSL";
                    break;
                case "PGBox":
                    link = "SearchWindow.aspx?v=PGInsPerson";
                    break;
                case "PGFnBox":
                    link = "SearchWindow.aspx?v=PGInsFname&pgv=" + $("#pg_NoGuid").val();
                    break;
                case "PG_ICBox":
                    link = "SearchWindow.aspx?v=PG_IC";
                    break;
            }
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
        function setReturnValue(type, gv, str, str2, str3, str4) {
            switch (type) {
                case "LInsPerson":
                    $("#pl_No").val(str);
                    $("#pl_NoGuid").val(gv);
                    $("#pl_pName").html(str2);
                    $("#pl_pName").css("color", "");
                    $("#pl_NoStatus").val("Y");
                    $("#pl_Dep").html(str3);
                    break;
                case "HInsPerson":
                    $("#pi_No").val(str);
                    $("#pi_NoGuid").val(gv);
                    $("#pi_pName").html(str2);
                    $("#pi_pName").css("color", "");
                    $("#pi_NoStatus").val("Y");
                    $("#pi_Dep").html(str3);
                    break;
                case "PPInsPerson":
                    $("#pp_No").val(str);
                    $("#pp_NoGuid").val(gv);
                    $("#pp_pName").html(str2);
                    $("#pp_pName").css("color", "");
                    $("#pp_NoStatus").val("Y");
                    $("#pp_Dep").html(str3);
                    $("#pp_Dep").css("color", "");
                    break;
                case "LaborSL":
                    $("#pl_SubsidyLevel").val(str);
                    $("#pl_SLGuid").val(gv);
                    $("#pl_SLName").html(str2);
                    $("#pl_SLName").css("color", "");
                    $("#pl_SLStatus").val("Y");
                    break;
                case "HealSL":
                    $("#pi_SubsidyLevel").val(str);
                    $("#pi_SLGuid").val(gv);
                    $("#pi_SLName").html(str2);
                    $("#pi_SLName").css("color", "");
                    $("#pi_SLStatus").val("Y");
                    break;
                case "PFInsPerson":
                    $("#pfi_No").val(str);
                    $("#pf_NoGuid").val(gv);
                    $("#pf_pName").html(str2);
                    $("#pf_pName").css("color", "");
                    $("#pf_NoStatus").val("Y");
                    $("#pfi_Dep").html(str3);
                    $("#pfi_Dep").css("color", "");
                    break;
                case "PFInsSL":
                    $("#pfi_SubsidyLevel").val(str);
                    $("#pf_SLGuid").val(gv);
                    $("#pf_SLName").html(str2);
                    $("#pf_SLName").css("color", "");
                    $("#pf_SLStatus").val("Y");
                    break;
                case "PFInsFname":
                    $("#pfi_FName").val(str);
                    $("#pf_PfGuid").val(gv);
                    $("#pf_fName").html("");
                    $("#pf_fName").css("color", "");
                    $("#pf_fStatus").val("Y");
                    $("#pfi_IDNum").html(str2);
                    $("#pfi_IDNum").css("color", "");
                    $("#pfi_Birth").html(str3);
                    $("#pfi_Birth").css("color", "");
                    $("#pfi_Title").html(str4);
                    $("#pfi_Title").css("color", "");
                    break;
                case "PGInsPerson":
                    $("#pgi_No").val(str);
                    $("#pg_NoGuid").val(gv);
                    $("#pg_pName").html(str2);
                    $("#pg_pName").css("color", "");
                    $("#pg_NoStatus").val("Y");
                    $("#pgi_Dep").html(str3);
                    $("#pgi_Dep").css("color", "");
                    break;
                case "PGInsFname":
                    $("#pgi_FName").val(str);
                    $("#pg_PfGuid").val(gv);
                    $("#pg_fName").html("");
                    $("#pg_fName").css("color", "");
                    $("#pg_fStatus").val("Y");
                    $("#pgi_IDNum").html(str2);
                    $("#pgi_IDNum").css("color", "");
                    $("#pgi_Birth").html(str3);
                    $("#pgi_Birth").css("color", "");
                    $("#pgi_Title").html(str4);
                    $("#pgi_Title").css("color", "");
                    break;
                case "PG_IC":
                    $("#pgi_InsuranceCode").val(str);
                    $("#pg_ICGuid").val(gv);
                    $("#pg_IGName").html(str2);
                    $("#pg_IGName").css("color", "");
                    $("#pg_IGStatus").val("Y");
                    break;
            }
        }

        //清空欄位
        function ClearInput() {
            $(".inputex").val("");
            $(".showStr").html("");
            //radiobutton
            var optobj = $("input:radio");
            for (i = 0; i < optobj.length; i++) {
                optobj[i].checked = false;
            }
            //checkbox
            $("input:checkbox").prop("checked", false);
            //把匯出的radio加回去
            $(".ep[value='3']").prop("checked", true);
        }
     
        function feedbackFun(type, str) {
            switch (type) {
                case "LB":
                    alert("完成");
                    ClearInput();
                    $("#pl_eStatus").html("新增");
                    $("#pl_saveBtn").hide();
                    $("#pl_addBtn").show();
                    getLaborList();
                    break;
                case "H":
                    alert("完成");
                    ClearInput();
                    $("#pi_eStatus").html("新增");
                    $("#pi_saveBtn").hide();
                    $("#pi_addBtn").show();
                    getHealList();
                    break;
                case "PP":
                    alert("完成");
                    ClearInput();
                    $("#pp_eStatus").html("新增");
                    $("#pp_saveBtn").hide();
                    $("#pp_addBtn").show();
                    getPensionList();
                    break;
                case "PFI":
                    alert("完成");
                    ClearInput();
                    $("#pf_eStatus").html("新增");
                    $("#pf_saveBtn").hide();
                    $("#pf_addBtn").show();
                    getFamilyInsList();
                    break;
                case "PGI":
                    alert("完成");
                    ClearInput();
                    $("#pg_eStatus").html("新增");
                    $("#pg_saveBtn").hide();
                    $("#pg_addBtn").show();
                    getGroupInsList();
                    break;
                case "InsSalaryMod":
                    alert("完成");
                    $("#InsModifyTab").empty();
                    $(".statabs").tabs({ active: 0 });
                    break;
                case "error":
                    alert(str + " Error");
                    break;
                case "exMsg":
                    alert("Error: " + decodeURIComponent(str));
                    break;
            }
        }
    </script>
    <%--勞保--%>
    <script type="text/javascript">
        $(document).ready(function () {
            getLaborList();

            //新增勞保
            $(document).on("click", "#newLBbtn", function () {
                $("#pl_eStatus").html("新增");
                $("#pl_saveBtn").hide();
                $("#pl_addBtn").show();
                ClearInput();
            });

            //checkbox check all
            $(document).on("click", "input[name='lb_checkall']", function () {
                if ($("input[name='lb_checkall']").prop("checked")) {
                    $("input[name='lbck']").each(function () {
                        $(this).prop("checked", true);
                    });
                } else {
                    $("input[name='lbck']").each(function () {
                        $(this).prop("checked", false);
                    });
                }
            });

            //勞保 新增/修改
            $(document).on("click", "#pl_addBtn,#pl_saveBtn", function () {
                var msg = "";
                if ($("#pl_No").val().trim() == "")
                    msg += "請輸入員工代號\n";
                else if ($("#pl_NoStatus").val()=="N")
                    msg += "找不到該員工代號，請重新確認\n";
                if ($("#pl_SubsidyLevel").val().trim() == "")
                    msg += "請輸入補助等級\n";
                else if ($("#pl_SLStatus").val() == "N")
                    msg += "找不到該補助等級，請重新確認\n";
                if ($("#pl_ChangeDate").val().trim() == "")
                    msg += "請輸入異動日期\n";
                else if ($("#pl_ChangeDate").val() != "" && $("#pl_ChangeDate").val().substring(4, 5) != "/" && $("#pl_ChangeDate").val().substring(7, 8) != "/")
                    msg += "請檢查日期格式，格式範例：2017/01/01 \n";
                if ($("#pl_Change").val().trim() == "")
                    msg += "請選擇異動別\n";
                if ($("#pl_LaborPayroll").val() == "")
                    msg += "請輸入健保投保薪資\n";

                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = "";
                if (this.id == "pl_addBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="New" />');
                else
                    mode = $('<input type="hidden" name="mode" id="mode" value="Modify" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addLabor.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            //勞保刪除
            $(document).on("click", "a[name='lbdelbtn']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/editLabor.ashx",
                        data: {
                            Mode: "D",
                            id: $(this).attr("aid")
                        },
                        error: function (xhr) {
                            alert(xhr);
                        },
                        success: function (data) {
                            if (data == "error") {
                                alert("editLabor Error");
                                return false;
                            }

                            if (data != null) {
                                getLaborList();
                            }
                        }
                    });
                }
            });

            //確認員工代號&補助代號
            $(document).on("change", "#pl_No,#pl_SubsidyLevel", function () {
                if (this.id == "pl_No")
                    checkData("LB_Person", this.value);
                else
                    checkData("LB_SL", this.value);
            });

            //查詢人員
            $(document).on("click", "#LB_SearchBtn", function () {
                if ($(this).attr("sv") == "N") {
                    $("#searchDiv").show();
                    $(this).attr("sv", "Y");
                }
                else {
                    $("#searchDiv").hide();
                    $(this).attr("sv", "N");
                }
            });

            $(document).on("click", "#lb_tab tbody tr td:not(:nth-child(1),:nth-child(2))", function () {
                $("#pl_eStatus").html("編輯");
                $("#pl_saveBtn").show();
                $("#pl_addBtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editLabor.ashx",
                    data: {
                        Mode: "E",
                        id: $(this).closest('tr').attr("aid")
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },
                    success: function (data) {
                        if (data == "error") {
                            alert("editPerson Error");
                            return false;
                        }

                        if (data != null) {
                            data = $.parseXML(data);
                            ClearInput();
                            $(data).find("data_item").each(function (i) {
                                $("#idtmp").val($(this).children("plGuid").text().trim());
                                $("#pl_No").val($(this).children("perNo").text().trim());
                                $("#pl_NoGuid").val($(this).children("plPerGuid").text().trim());
                                $("#pl_pName").html("");
                                $("#pl_NoStatus").val("Y");
                                $("#pl_Dep").html($(this).children("cbName").text().trim());
                                $("#pl_SubsidyLevel").val($(this).children("slSubsidyCode").text().trim());
                                $("#pl_SLGuid").val($(this).children("plSubsidyLevel").text().trim());
                                $("#pl_SLName").html("");
                                $("#pl_SLStatus").val("Y");
                                $("#pl_ChangeDate").val($(this).children("plChangeDate").text().trim());
                                $("#pl_Change").val($(this).children("plChange").text().trim());
                                $("#pl_LaborPayroll").val($(this).children("plLaborPayroll").text().trim());
                                $("#pl_Ps").val($(this).children("plPs").text().trim());
                            });
                        }
                    }
                });
            });
        });

        //勞保列表
        function getLaborList() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/getLaborList.ashx",
                data: {
                    keyword: $("#lb_keyword").val(),
                    ddlLabor: $("#ddlLaborExport").val()
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("getLaborList Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#lb_tab").empty();
                        var tabstr = '<thead><tr>';
                        tabstr += '<th nowrap="nowrap"><input name="lb_checkall" type="checkbox" /></th>';
                        tabstr += '<th width="80" nowrap="nowrap">操作</th>';
                        tabstr += '<th nowrap="nowrap" >員工代號</th>';
                        tabstr += '<th nowrap="nowrap" >姓名</th>';
                        tabstr += '<th nowrap="nowrap" >補助等級</th>';
                        tabstr += '<th nowrap="nowrap" >勞保卡號</th>';
                        tabstr += '<th nowrap="nowrap" >異動別</th>';
                        tabstr += '<th nowrap="nowrap" >勞保投保薪資</th>';
                        tabstr += '<th nowrap="nowrap" >異動日期</th></tr></thead>';
                        tabstr += '<tbody>';
                        if ($(data).find("lb_item").length > 0) {
                            $(data).find("lb_item").each(function (i) {
                                tabstr += '<tr aid=' + $(this).children("plGuid").text() + '>';
                                tabstr += '<td align="center"><input name="lbck" type="checkbox" value="' + $(this).children("plPerGuid").text() + '" /></td>';
                                tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="lbdelbtn" aid=' + $(this).children("plGuid").text() + '>刪除</a></td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perNo").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perName").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("slSubsidyCode").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("plLaborNo").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("code_desc").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("plLaborPayroll").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("plChangeDate").text() + '</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += "<tr><td colspan='9'>查詢無資料</td></tr>";
                        tabstr += '</tbody>';
                        $("#lb_tab").append(tabstr);
                        $("#lb_tab tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $("#lb_tab tr:even").addClass("alt");
                        $(".fixTable").tableHeadFixer();
                    }
                }
            });
        }
    </script>
    <%--健保--%>
    <script type="text/javascript">
        $(document).ready(function () {
            //新增健保
            $(document).on("click", "#newHbtn", function () {
                $("#pi_eStatus").html("新增");
                $("#pi_saveBtn").hide();
                $("#pi_addBtn").show();
                $(".dor").hide();
                ClearInput();
            });

            //checkbox check all
            $(document).on("click", "input[name='h_checkall']", function () {
                if ($("input[name='h_checkall']").prop("checked")) {
                    $("input[name='hck']").each(function () {
                        $(this).prop("checked", true);
                    });
                } else {
                    $("input[name='hck']").each(function () {
                        $(this).prop("checked", false);
                    });
                }
            });

            //退保原因說明別
            $(".dor").hide();
            $(document).on("change", "#pi_Change", function () {
                $(".dor").hide();
                if ($(this).val() == "02") {
                    $(".dor").show();
                    getddl("20", "#pi_DropOutReason");
                }

                if ($(this).val() == "07") {
                    $(".dor").show();
                    getddl("21", "#pi_DropOutReason");
                }
            });

            //健保 新增/修改
            $(document).on("click", "#pi_addBtn,#pi_saveBtn", function () {
                var msg = "";
                if ($("#pi_No").val().trim() == "")
                    msg += "請輸入員工代號\n";
                else if ($("#pi_NoStatus").val()=="N")
                    msg += "找不到該員工代號，請重新確認\n";
                if ($("#pi_SubsidyLevel").val().trim() == "")
                    msg += "請輸入補助等級\n";
                else if ($("#pi_SLStatus").val() == "N")
                    msg += "找不到該補助等級，請重新確認\n";
                if ($("#pi_ChangeDate").val().trim() == "")
                    msg += "請輸入異動日期\n";
                else if ($("#pi_ChangeDate").val() != "" && $("#pi_ChangeDate").val().substring(4, 5) != "/" && $("#pi_ChangeDate").val().substring(7, 8) != "/")
                    msg += "請檢查日期格式，格式範例：2017/01/01 \n";
                if ($("#pi_Change").val().trim() == "")
                    msg += "請選擇異動別\n";
                if ($("#pi_LaborPayroll").val() == "")
                    msg += "請輸入勞保投保薪資\n";

                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = "";
                if (this.id == "pi_addBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="New" />');
                else
                    mode = $('<input type="hidden" name="mode" id="mode" value="Modify" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addHeal.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            //健保刪除
            $(document).on("click", "a[name='hdelbtn']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/editHeal.ashx",
                        data: {
                            Mode: "D",
                            id: $(this).attr("aid")
                        },
                        error: function (xhr) {
                            alert(xhr);
                        },
                        success: function (data) {
                            if (data == "error") {
                                alert("editHeal Error");
                                return false;
                            }

                            if (data != null) {
                                getHealList();
                            }
                        }
                    });
                }
            });

            //確認員工代號&補助代號
            $(document).on("change", "#pi_No,#pi_SubsidyLevel", function () {
                if (this.id == "pi_No")
                    checkData("H_Person", this.value);
                else
                    checkData("H_SL", this.value);
            });

            //查詢人員
            $(document).on("click", "#H_SearchBtn", function () {
                if ($(this).attr("sv") == "N") {
                    $("#h_searchDiv").show();
                    $(this).attr("sv", "Y");
                }
                else {
                    $("#h_searchDiv").hide();
                    $(this).attr("sv", "N");
                }
            });

            //健保編輯
            $(document).on("click", "#h_tab tbody tr td:not(:nth-child(1),:nth-child(2))", function () {
                $("#pi_eStatus").html("編輯");
                $("#pi_saveBtn").show();
                $("#pi_addBtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editHeal.ashx",
                    data: {
                        Mode: "E",
                        id: $(this).closest('tr').attr("aid")
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },
                    success: function (data) {
                        if (data == "error") {
                            alert("editHeal Error");
                            return false;
                        }

                        if (data != null) {
                            data = $.parseXML(data);
                            ClearInput();
                            $(data).find("data_item").each(function (i) {
                                $("#idtmp").val($(this).children("piGuid").text().trim());
                                $("#pi_No").val($(this).children("perNo").text().trim());
                                $("#pi_NoGuid").val($(this).children("piPerGuid").text().trim());
                                $("#pi_pName").html("");
                                $("#pi_NoStatus").val("Y");
                                $("#pi_Dep").html($(this).children("cbName").text().trim());
                                $("#pi_SubsidyLevel").val($(this).children("slSubsidyCode").text().trim());
                                $("#pi_SLGuid").val($(this).children("piSubsidyLevel").text().trim());
                                $("#pi_SLName").html("");
                                $("#pi_SLStatus").val("Y");
                                $("#pi_ChangeDate").val($(this).children("piChangeDate").text().trim());
                                $("#pi_Change").val($(this).children("piChange").text().trim());
                                $("#pi_InsurancePayroll").val($(this).children("piInsurancePayroll").text().trim());
                                $("#pi_Ps").val($(this).children("piPs").text().trim());
                                if ($(this).children("piChange").text().trim() != "02" && $(this).children("piChange").text().trim() != "07")
                                    $(".dor").hide();
                                else {
                                    $(".dor").show();
                                    if ($(this).children("piChange").text().trim() == "02") {
                                        $(".dor").show();
                                        getddl("20", "#pi_DropOutReason");
                                    }

                                    if ($(this).children("piChange").text().trim() == "07") {
                                        $(".dor").show();
                                        getddl("21", "#pi_DropOutReason");
                                    }
                                    $("#pi_DropOutReason").val($(this).children("piDropOutReason").text().trim());
                                }
                            });
                        }
                    }
                });
            });
        });

        //健保列表
        function getHealList() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/getHealList.ashx",
                data: {
                    keyword: $("#h_keyword").val(),
                    ddlHeal: $("#ddlHealExport").val()
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("getHealList Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#h_tab").empty();
                        var tabstr = '<thead><tr>';
                        tabstr += '<th nowrap="nowrap"><input name="h_checkall" type="checkbox" /></th>';
                        tabstr += '<th width="80" nowrap="nowrap">操作</th>';
                        tabstr += '<th nowrap="nowrap" >員工代號</th>';
                        tabstr += '<th nowrap="nowrap" >姓名</th>';
                        tabstr += '<th nowrap="nowrap" >補助等級</th>';
                        tabstr += '<th nowrap="nowrap" >卡別</th>';
                        tabstr += '<th nowrap="nowrap" >異動別</th>';
                        tabstr += '<th nowrap="nowrap" >健保投保薪資</th>';
                        tabstr += '<th nowrap="nowrap" >異動日期</th></tr></thead>';
                        tabstr += '<tbody>';
                        if ($(data).find("h_item").length > 0) {
                            $(data).find("h_item").each(function (i) {
                                tabstr += '<tr aid=' + $(this).children("piGuid").text() + '>';
                                tabstr += '<td align="center"><input name="hck" type="checkbox" value="' + $(this).children("piPerGuid").text() + '" /></td>';
                                tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="hdelbtn" aid=' + $(this).children("piGuid").text() + '>刪除</a></td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perNo").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perName").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("slSubsidyCode").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("piCardNo").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("code_desc").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("piInsurancePayroll").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("piChangeDate").text() + '</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += "<tr><td colspan='9'>查詢無資料</td></tr>";
                        tabstr += '</tbody>';
                        $("#h_tab").append(tabstr);
                        $("#h_tab tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $("#h_tab tr:even").addClass("alt");
                        $(".fixTable").tableHeadFixer();
                    }
                }
            });
        }
    </script>
    <%--勞退--%>
    <script type="text/javascript">
        $(document).ready(function () {
            //新增勞退
            $(document).on("click", "#newPPbtn", function () {
                $("#pp_eStatus").html("新增");
                $("#pp_saveBtn").hide();
                $("#pp_addBtn").show();
                ClearInput();
            });

            //checkbox check all
            $(document).on("click", "input[name='pp_checkall']", function () {
                if ($("input[name='pp_checkall']").prop("checked")) {
                    $("input[name='ppck']").each(function () {
                        $(this).prop("checked", true);
                    });
                } else {
                    $("input[name='ppck']").each(function () {
                        $(this).prop("checked", false);
                    });
                }
            });

            //勞退 新增/修改
            $(document).on("click", "#pp_addBtn,#pp_saveBtn", function () {
                var msg = "";
                if ($("#pp_No").val().trim() == "")
                    msg += "請輸入員工代號\n";
                else if ($("#pp_NoStatus").val()=="N")
                    msg += "找不到該員工代號，請重新確認\n";
                if ($("#pp_ChangeDate").val().trim() == "")
                    msg += "請輸入異動日期\n";
                else if ($("#pp_ChangeDate").val() != "" && $("#pp_ChangeDate").val().substring(4, 5) != "/" && $("#pp_ChangeDate").val().substring(7, 8) != "/")
                    msg += "請檢查日期格式，格式範例：2017/01/01 \n";
                if ($("#pp_Change").val().trim() == "")
                    msg += "請選擇異動別\n";
                if ($("#pp_LarboRatio").val() == "")
                    msg += "請輸入勞工自提比率\n";
                if ($("#pp_EmployerRatio").val() == "")
                    msg += "請輸入雇主提繳比率\n";
                if ($("#pp_PayPayroll").val() == "")
                    msg += "請輸入勞退月提繳工資\n";

                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = "";
                if (this.id == "pp_addBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="New" />');
                else
                    mode = $('<input type="hidden" name="mode" id="mode" value="Modify" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addPension.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            //勞退刪除
            $(document).on("click", "a[name='ppdelbtn']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/editPension.ashx",
                        data: {
                            Mode: "D",
                            id: $(this).attr("aid")
                        },
                        error: function (xhr) {
                            alert(xhr);
                        },
                        success: function (data) {
                            if (data == "error") {
                                alert("editPension Error");
                                return false;
                            }

                            if (data != null) {
                                getPensionList();
                            }
                        }
                    });
                }
            });

            //確認員工代號
            $(document).on("change", "#pp_No", function () {
                checkData("PP_Person", this.value);
            });

            //查詢人員
            $(document).on("click", "#PP_SearchBtn", function () {
                if ($(this).attr("sv") == "N") {
                    $("#pp_searchDiv").show();
                    $(this).attr("sv", "Y");
                }
                else {
                    $("#pp_searchDiv").hide();
                    $(this).attr("sv", "N");
                }
            });

            //勞退編輯
            $(document).on("click", "#pp_tab tbody tr td:not(:nth-child(1),:nth-child(2))", function () {
                $("#pp_eStatus").html("編輯");
                $("#pp_saveBtn").show();
                $("#pp_addBtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editPension.ashx",
                    data: {
                        Mode: "E",
                        id: $(this).closest('tr').attr("aid")
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },
                    success: function (data) {
                        if (data == "error") {
                            alert("editPension Error");
                            return false;
                        }

                        if (data != null) {
                            data = $.parseXML(data);
                            ClearInput();
                            $(data).find("data_item").each(function (i) {
                                $("#idtmp").val($(this).children("ppGuid").text().trim());
                                $("#pp_No").val($(this).children("perNo").text().trim());
                                $("#pp_NoGuid").val($(this).children("ppPerGuid").text().trim());
                                $("#pp_pName").html("");
                                $("#pp_NoStatus").val("Y");
                                $("#pp_Dep").html($(this).children("cbName").text().trim());
                                $("#pp_ChangeDate").val($(this).children("ppChangeDate").text().trim());
                                $("#pp_Change").val($(this).children("ppChange").text().trim());
                                $("#pp_LarboRatio").val($(this).children("ppLarboRatio").text().trim());
                                $("#pp_EmployerRatio").val($(this).children("ppEmployerRatio").text().trim());
                                $("#pp_PayPayroll").val($(this).children("ppPayPayroll").text().trim());
                                $("#pp_Ps").val($(this).children("ppPs").text().trim());
                            });
                        }
                    }
                });
            });
        });

        //勞退列表
        function getPensionList() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/getPensionList.ashx",
                data: {
                    keyword: $("#pp_keyword").val(),
                    ddlPension: $("#ddlPensionExport").val()
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("getPensionList Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#pp_tab").empty();
                        var tabstr = '<thead><tr>';
                        tabstr += '<th nowrap="nowrap"><input name="pp_checkall" type="checkbox" /></th>';
                        tabstr += '<th width="80" nowrap="nowrap">操作</th>';
                        tabstr += '<th nowrap="nowrap" >員工代號</th>';
                        tabstr += '<th nowrap="nowrap" >姓名</th>';
                        tabstr += '<th nowrap="nowrap" >異動別</th>';
                        tabstr += '<th nowrap="nowrap" >勞工自提比率</th>';
                        tabstr += '<th nowrap="nowrap" >雇主提繳比率</th>';
                        tabstr += '<th nowrap="nowrap" >勞退月提繳工資</th>';
                        tabstr += '<th nowrap="nowrap" >異動日期</th></tr></thead>';
                        tabstr += '<tbody>';
                        if ($(data).find("pp_item").length > 0) {
                            $(data).find("pp_item").each(function (i) {
                                tabstr += '<tr aid=' + $(this).children("ppGuid").text() + '>';
                                tabstr += '<td align="center"><input name="ppck" type="checkbox" value="' + $(this).children("ppPerGuid").text() + '" /></td>';
                                tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="ppdelbtn" aid=' + $(this).children("ppGuid").text() + '>刪除</a></td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perNo").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perName").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("code_desc").text() + '</td>';
                                if ($(this).children("ppLarboRatio").text().trim() == "")
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">0%</td>';
                                else
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("ppLarboRatio").text() + '%</td>';
                                if ($(this).children("ppEmployerRatio").text().trim() == "")
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">0%</td>';
                                else
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("ppEmployerRatio").text() + '%</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("ppPayPayroll").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("ppChangeDate").text() + '</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += "<tr><td colspan='9'>查詢無資料</td></tr>";
                        tabstr += '</tbody>';
                        $("#pp_tab").append(tabstr);
                        $("#pp_tab tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $("#pp_tab tr:even").addClass("alt");
                        $(".fixTable").tableHeadFixer();
                    }
                }
            });
        }
    </script>
    <%--眷屬健保--%>
    <script type="text/javascript">
        $(document).ready(function () {
            //新增眷屬健保
            $(document).on("click", "#newPFbtn", function () {
                $("#pf_eStatus").html("新增");
                $("#pf_saveBtn").hide();
                $("#pf_addBtn").show();
                $(".dor").hide();
                ClearInput();
            });

            //checkbox check all
            $(document).on("click", "input[name='pfi_checkall']", function () {
                if ($("input[name='pfi_checkall']").prop("checked")) {
                    $("input[name='pfick']").each(function () {
                        $(this).prop("checked", true);
                    });
                } else {
                    $("input[name='pfick']").each(function () {
                        $(this).prop("checked", false);
                    });
                }
            });


            //退保原因說明別
            $(".dor").hide();
            $(document).on("change", "#pi_Change", function () {
                $(".dor").hide();
                if ($(this).val() == "02") {
                    $(".dor").show();
                    getddl("20", "#pfi_DropOutReason");
                }

                if ($(this).val() == "03") {
                    $(".dor").show();
                    getddl("21", "#pfi_DropOutReason");
                }
            });

            //眷屬健保 新增/修改
            $(document).on("click", "#pf_addBtn,#pf_saveBtn", function () {
                var msg = "";
                if ($("#pfi_No").val().trim() == "")
                    msg += "請輸入員工代號\n";
                else if ($("#pf_NoStatus").val() == "N")
                    msg += "找不到該員工代號，請重新確認\n";
                if ($("#pfi_ChangeDate").val().trim() == "")
                    msg += "請輸入異動日期\n";
                else if ($("#pfi_ChangeDate").val() != "" && $("#pfi_ChangeDate").val().substring(4, 5) != "/" && $("#pfi_ChangeDate").val().substring(7, 8) != "/")
                    msg += "請檢查日期格式，格式範例：2017/01/01 \n";
                if ($("#pfi_Change").val().trim() == "")
                    msg += "請選擇異動別\n";
                if ($("#pfi_SubsidyLevel").val().trim() == "")
                    msg += "請輸入補助等級\n";
                else if ($("#pf_SLStatus").val() == "N")
                    msg += "找不到該補助代號，請重新確認\n";
                if ($("#pfi_FName").val().trim() == "")
                    msg += "請輸入眷屬姓名\n";
                else if ($("#pf_fStatus").val() == "N")
                    msg += "找不到該眷屬姓名，請重新確認\n";

                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = "";
                if (this.id == "pf_addBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="New" />');
                else
                    mode = $('<input type="hidden" name="mode" id="mode" value="Modify" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addFamilyIns.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            //眷屬健保 刪除
            $(document).on("click", "a[name='pfidelbtn']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/editFamilyIns.ashx",
                        data: {
                            Mode: "D",
                            id: $(this).attr("aid")
                        },
                        error: function (xhr) {
                            alert(xhr);
                        },
                        success: function (data) {
                            if (data == "error") {
                                alert("editFamilyIns Error");
                                return false;
                            }

                            if (data != null) {
                                getFamilyInsList();
                            }
                        }
                    });
                }
            });

            //確認員工代號&眷屬姓名&補助代號
            $(document).on("change", "#pfi_No,#pfi_FName,#pfi_SubsidyLevel", function () {
                switch (this.id) {
                    case "pfi_No":
                        checkData("PF_Person", this.value);
                        break;
                    case "pfi_FName":
                        checkData("PF_FName", this.value, $("#pfi_No").val());
                        break;
                    case "pfi_SubsidyLevel":
                        checkData("PF_SL", this.value);
                        break;
                }
            });

            //查詢人員
            $(document).on("click", "#PF_SearchBtn", function () {
                if ($(this).attr("sv") == "N") {
                    $("#pf_searchDiv").show();
                    $(this).attr("sv", "Y");
                }
                else {
                    $("#pf_searchDiv").hide();
                    $(this).attr("sv", "N");
                }
            });

            //眷屬健保編輯
            $(document).on("click", "#pf_tab tbody tr td:not(:nth-child(1),:nth-child(2))", function () {
                $("#pf_eStatus").html("編輯");
                $("#pf_saveBtn").show();
                $("#pf_addBtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editFamilyIns.ashx",
                    data: {
                        Mode: "E",
                        id: $(this).closest('tr').attr("aid")
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },
                    success: function (data) {
                        if (data == "error") {
                            alert("editFamilyIns Error");
                            return false;
                        }

                        if (data != null) {
                            data = $.parseXML(data);
                            ClearInput();
                            $(data).find("data_item").each(function (i) {
                                $("#idtmp").val($(this).children("pfiGuid").text().trim());
                                //基本資料
                                $("#pfi_No").val($(this).children("perNo").text().trim());
                                $("#pf_NoGuid").val($(this).children("pfiPerGuid").text().trim());
                                $("#pf_pName").html("");
                                $("#pf_NoStatus").val("Y");
                                $("#pfi_Dep").html($(this).children("cbName").text().trim());
                                $("#pfi_ChangeDate").val($(this).children("pfiChangeDate").text().trim());
                                $("#pfi_FName").val($(this).children("pfName").text().trim());
                                $("#pf_PfGuid").val($(this).children("pfiPfGuid").text().trim());
                                $("#pf_fName").html("");
                                $("#pf_fStatus").val("Y");
                                $("#pfi_IDNum").html($(this).children("pfIDNumber").text().trim());
                                $("#pfi_Birth").html($(this).children("pfBirthday").text().trim());
                                $("#pfi_Title").html($(this).children("pfTitle").text().trim());
                                $("#pfi_Change").val($(this).children("pfiChange").text().trim());
                                $("#pfi_SubsidyLevel").val($(this).children("slSubsidyCode").text().trim());
                                $("#pf_SLGuid").val($(this).children("pfiSubsidyLevel").text().trim());
                                $("#pf_SLName").html("");
                                $("#pf_SLStatus").val("Y");
                                if ($(this).children("pfiAreaPerson").text().trim() == "Y")
                                    $("input[name='pfi_AreaPerson']").prop('checked', true);
                                $("#pfi_Ps").val($(this).children("pfiPs").text().trim());
                                if ($(this).children("pfiChange").text().trim() != "02" && $(this).children("pfiChange").text().trim() != "03")
                                    $(".dor").hide();
                                else {
                                    $(".dor").show();
                                    if ($(this).children("pfiChange").text().trim() == "02") {
                                        $(".dor").show();
                                        getddl("20", "#pfi_DropOutReason");
                                    }

                                    if ($(this).children("pfiChange").text().trim() == "03") {
                                        $(".dor").show();
                                        getddl("21", "#pfi_DropOutReason");
                                    }
                                    $("#pfi_DropOutReason").val($(this).children("pfiDropOutReason").text().trim());
                                }
                            });
                        }
                    }
                });
            });
        });

        //眷屬健保列表
        function getFamilyInsList() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/getFamilyInsList.ashx",
                data: {
                    keyword: $("#pf_keyword").val(),
                    ddlPfExport: $("#ddlPfExport").val()
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("getFamilyInsList Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#pf_tab").empty();
                        var tabstr = '<thead><tr>';
                        tabstr += '<th nowrap="nowrap"><input name="pfi_checkall" type="checkbox" /></th>';
                        tabstr += '<th width="80" nowrap="nowrap">操作</th>';
                        tabstr += '<th nowrap="nowrap" >員工代號</th>';
                        tabstr += '<th nowrap="nowrap" >姓名</th>';
                        tabstr += '<th nowrap="nowrap" >異動別</th>';
                        tabstr += '<th nowrap="nowrap" >眷屬姓名</th>';
                        tabstr += '<th nowrap="nowrap" >關係稱謂</th>';
                        tabstr += '<th nowrap="nowrap" >補助等級</th>';
                        tabstr += '<th nowrap="nowrap" >異動日期</th></tr></thead>';
                        tabstr += '<tbody>';
                        if ($(data).find("pfi_item").length > 0) {
                            $(data).find("pfi_item").each(function (i) {
                                tabstr += '<tr aid=' + $(this).children("pfiGuid").text() + '>';
                                tabstr += '<td align="center"><input name="pfick" type="checkbox" value="' + $(this).children("pfiPfGuid").text() + '" /></td>';
                                tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="pfidelbtn" aid=' + $(this).children("pfiGuid").text() + '>刪除</a></td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perNo").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perName").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("code_desc").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfName").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfTitle").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("slSubsidyCode").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfiChangeDate").text() + '</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += "<tr><td colspan='9'>查詢無資料</td></tr>";
                        tabstr += '</tbody>';
                        $("#pf_tab").append(tabstr);
                        $("#pf_tab tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $("#pf_tab tr:even").addClass("alt");
                        $(".fixTable").tableHeadFixer();
                    }
                }
            });
        }
    </script>
    <%--團保--%>
    <script type="text/javascript">
        $(document).ready(function () {
            //新增團保
            $(document).on("click", "#newPGbtn", function () {
                $("#pg_eStatus").html("新增");
                $("#pg_saveBtn").hide();
                $("#pg_addBtn").show();
                ClearInput();
            });

            //checkbox check all
            $(document).on("click", "input[name='pgi_checkall']", function () {
                if ($("input[name='pgi_checkall']").prop("checked")) {
                    $("input[name='pgick']").each(function () {
                        $(this).prop("checked", true);
                    });
                } else {
                    $("input[name='pgick']").each(function () {
                        $(this).prop("checked", false);
                    });
                }
            });

            $(document).on("change", "input[name='pgi_Type']", function () {
                if ($("input[name='pgi_Type']:checked").val() == "01") {
                    $("#pgi_FName").attr("disabled", "disabled");
                    $("#PGFnBox").hide();
                }
                else {
                    $("#pgi_FName").removeAttr("disabled");
                    $("#PGFnBox").show();
                }
            });

            //團保 新增/修改
            $(document).on("click", "#pg_addBtn,#pg_saveBtn", function () {
                var msg = "";
                if ($("#pgi_No").val().trim() == "")
                    msg += "請輸入員工代號\n";
                else if ($("#pg_NoStatus").val() == "N")
                    msg += "找不到該員工代號，請重新確認\n";
                if ($("#pgi_ChangeDate").val().trim() == "")
                    msg += "請輸入異動日期\n";
                else if ($("#pgi_ChangeDate").val() != "" && $("#pgi_ChangeDate").val().substring(4, 5) != "/" && $("#pgi_ChangeDate").val().substring(7, 8) != "/")
                    msg += "請檢查日期格式，格式範例：2017/01/01 \n";
                if ($("input[name='pgi_Type']:checked").length == 0)
                    msg += "請選擇身分\n";
                if ($("#pgi_Change").val().trim() == "")
                    msg += "請選擇異動別\n";
                if ($("#pgi_InsuranceCode").val().trim() == "")
                    msg += "請輸入保險代號\n";
                else if ($("#pg_IGStatus").val() == "N")
                    msg += "找不到該保險代號，請重新確認\n";
                if ($("input[name='pgi_Type']:checked").val() == "02") {
                    if ($("#pgi_FName").val().trim() == "")
                        msg += "請輸入眷屬姓名\n";
                    else if ($("#pg_fStatus").val() == "N")
                        msg += "找不到該眷屬姓名，請重新確認\n";
                }

                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = "";
                if (this.id == "pg_addBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="New" />');
                else
                    mode = $('<input type="hidden" name="mode" id="mode" value="Modify" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addGroupIns.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            //團保 刪除
            $(document).on("click", "a[name='pgdelbtn']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/editGroupIns.ashx",
                        data: {
                            Mode: "D",
                            id: $(this).attr("aid")
                        },
                        error: function (xhr) {
                            alert(xhr);
                        },
                        success: function (data) {
                            if (data == "error") {
                                alert("editGroupIns Error");
                                return false;
                            }

                            if (data != null) {
                                getGroupInsList();
                            }
                        }
                    });
                }
            });

            //確認員工代號&眷屬姓名&保險代號
            $(document).on("change", "#pgi_No,#pgi_FName,#pgi_InsuranceCode", function () {
                switch (this.id) {
                    case "pgi_No":
                        checkData("PG_Person", this.value);
                        break;
                    case "pgi_FName":
                        checkData("PG_FName", this.value, $("#pgi_No").val());
                        break;
                    case "pgi_InsuranceCode":
                        checkData("PG_IC", this.value);
                        break;
                }
            });

            //查詢人員
            $(document).on("click", "#PG_SearchBtn", function () {
                if ($(this).attr("sv") == "N") {
                    $("#pg_searchDiv").show();
                    $(this).attr("sv", "Y");
                }
                else {
                    $("#pg_searchDiv").hide();
                    $(this).attr("sv", "N");
                }
            });

            //團保編輯
            $(document).on("click", "#pg_tab tbody tr td:not(:nth-child(1),:nth-child(2))", function () {
                $("#pg_eStatus").html("編輯");
                $("#pg_saveBtn").show();
                $("#pg_addBtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editGroupIns.ashx",
                    data: {
                        Mode: "E",
                        id: $(this).closest('tr').attr("aid")
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },
                    success: function (data) {
                        if (data == "error") {
                            alert("editGroupIns Error");
                            return false;
                        }

                        if (data != null) {
                            data = $.parseXML(data);
                            ClearInput();
                            $(data).find("data_item").each(function (i) {
                                $("#idtmp").val($(this).children("pgiGuid").text().trim());
                                $("#pgi_No").val($(this).children("perNo").text().trim());
                                $("#pg_NoGuid").val($(this).children("pgiPerGuid").text().trim());
                                $("#pg_pName").html("");
                                $("#pg_NoStatus").val("Y");
                                $("#pgi_Dep").html($(this).children("cbName").text().trim());
                                $("#pgi_ChangeDate").val($(this).children("pgiChangeDate").text().trim());
                                $("input[name='pgi_Type'][value='" + $(this).children("pgiType").text().trim() + "']").prop("checked", true);
                                $("#pgi_Change").val($(this).children("pgiChange").text().trim());
                                $("#pgi_InsuranceCode").val($(this).children("giInsuranceCode").text().trim());
                                $("#pg_ICGuid").val($(this).children("pgiInsuranceCode").text().trim());
                                $("#pg_IGName").html("");
                                $("#pg_IGStatus").val("Y");
                                $("#pgi_FName").val($(this).children("pfName").text().trim());
                                $("#pg_PfGuid").val($(this).children("pgiPfGuid").text().trim());
                                $("#pg_fName").html("");
                                $("#pg_fStatus").val("Y");
                                $("#pgi_IDNum").html($(this).children("pfIDNumber").text().trim());
                                $("#pgi_Birth").html($(this).children("pfBirthday").text().trim());
                                $("#pgi_Title").html($(this).children("pfTitle").text().trim());
                                $("#pgi_Ps").val($(this).children("pgiPs").text().trim());
                            });
                        }
                    }
                });
            });
        });

        //團保列表
        function getGroupInsList() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/getGroupInsList.ashx",
                data: {
                    keyword: $("#pg_keyword").val()
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("getGroupInsList Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#pg_tab").empty();
                        var tabstr = '<thead><tr>';
                        tabstr += '<th nowrap="nowrap"><input name="pgi_checkall" type="checkbox" /></th>';
                        tabstr += '<th width="80" nowrap="nowrap">操作</th>';
                        tabstr += '<th nowrap="nowrap" >員工代號</th>';
                        tabstr += '<th nowrap="nowrap" >姓名</th>';
                        tabstr += '<th nowrap="nowrap" >異動別</th>';
                        tabstr += '<th nowrap="nowrap" >眷屬姓名</th>';
                        tabstr += '<th nowrap="nowrap" >關係稱謂</th>';
                        tabstr += '<th nowrap="nowrap" >類別</th>';
                        tabstr += '<th nowrap="nowrap" >異動日期</th></tr></thead>';
                        tabstr += '<tbody>';
                        if ($(data).find("pgi_item").length > 0) {
                            $(data).find("pgi_item").each(function (i) {
                                tabstr += '<tr aid=' + $(this).children("pgiGuid").text() + '>';
                                tabstr += '<td align="center"><input name="pgick" type="checkbox" value="' + $(this).children("pgiGuid").text() + '" /></td>';
                                tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="pgdelbtn" aid=' + $(this).children("pgiGuid").text() + '>刪除</a></td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perNo").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perName").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("code_desc").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfName").text() + '</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfTitle").text() + '</td>';
                                if ($(this).children("pgiType").text() == "01")
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">本人</td>';
                                else
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">眷屬</td>';
                                tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pgiChangeDate").text() + '</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += "<tr><td colspan='9'>查詢無資料</td></tr>";
                        tabstr += '</tbody>';
                        $("#pg_tab").append(tabstr);
                        $("#pg_tab tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $("#pg_tab tr:even").addClass("alt");
                        $(".fixTable").tableHeadFixer();
                    }
                }
            });
        }
    </script>
    <%--保薪調整--%>
    <script type="text/javascript">
        $(document).ready(function () {
            //保薪調整
            $(document).on("click", "#InsModBtn", function () {
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/sp_payModify.ashx",
                    data: {
                        //Group: gno
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },
                    success: function (data) {
                        if (data == "error") {
                            alert("sp_payModify Error");
                            return false;
                        }

                        if (data != null) {
                            data = $.parseXML(data);
                            $("#InsModifyTab").empty();
                            var tabstr = '<thead><tr>';
                            tabstr += '<th width="80" nowrap="nowrap" rowspan="2">操作</th>';
                            tabstr += '<th nowrap="nowrap" rowspan="2">員工編號</th>';
                            tabstr += '<th nowrap="nowrap" rowspan="2">姓名</th>';
                            tabstr += '<th nowrap="nowrap" rowspan="2">平均月薪</th>';
                            tabstr += '<th nowrap="nowrap" colspan="3">調整前級距金額</th>';
                            tabstr += '<th nowrap="nowrap" colspan="3">調整後級距金額</th>';
                            tabstr += '</tr><tr>';
                            tabstr += '<th nowrap="nowrap">勞保</th>';
                            tabstr += '<th nowrap="nowrap">健保</th>';
                            tabstr += '<th nowrap="nowrap">勞退</th>';
                            tabstr += '<th nowrap="nowrap">勞保</th>';
                            tabstr += '<th nowrap="nowrap">健保</th>';
                            tabstr += '<th nowrap="nowrap">勞退</th></tr></thead>';
                            tabstr += '<tbody>';
                            if ($(data).find("data_item").length > 0) {
                                $(data).find("data_item").each(function (i) {
                                    tabstr += '<tr aid=' + $(this).children("pPerGuid").text() + '>';
                                    tabstr += '<td style="display:none">';
                                    tabstr += '<input type="hidden" name="im_gv" value="' + $(this).children("pPerGuid").text() + '" />';
                                    tabstr += '<input type="hidden" name="im_lSL" value="' + $(this).children("L_SL").text() + '" />';
                                    tabstr += '<input type="hidden" name="im_hSL" value="' + $(this).children("H_SL").text() + '" />';
                                    tabstr += '<input type="hidden" name="bf_L" value="' + $(this).children("b_labor").text() + '" />';
                                    tabstr += '<input type="hidden" name="bf_H" value="' + $(this).children("b_ganbor").text() + '" />';
                                    tabstr += '<input type="hidden" name="bf_P" value="' + $(this).children("b_tahui").text() + '" />';
                                    tabstr += '<input type="hidden" name="af_L" value="' + $(this).children("pay_i2").text() + '" />';
                                    tabstr += '<input type="hidden" name="af_H" value="' + $(this).children("pay_i3").text() + '" />';
                                    tabstr += '<input type="hidden" name="af_P" value="' + $(this).children("pay_i4").text() + '" />';
                                    tabstr += '<input type="hidden" name="labor_id" value="' + $(this).children("LaborID").text() + '" />';
                                    tabstr += '<input type="hidden" name="ganbor_id" value="' + $(this).children("GanborID").text() + '" />';
                                    tabstr += '</td>';
                                    tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="IMdelbtn" aid=' + $(this).children("pPerGuid").text() + ' ano=' + $(this).children("perNo").text() + '>刪除</a></td>';
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perNo").text() + '</td>';
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perName").text() + '</td>';
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pay_avg").text() + '</td>';
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("b_labor").text() + '</td>';
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("b_ganbor").text() + '</td>';
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("b_tahui").text() + '</td>';
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pay_i2").text() + '</td>';
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pay_i3").text() + '</td>';
                                    tabstr += '<td align="center" nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pay_i4").text() + '</td>';
                                    tabstr += '</tr>';
                                });
                            }
                            else
                                tabstr += "<tr><td colspan='10'>查詢無資料</td></tr>";
                            tabstr += '</tbody>';
                            $("#InsModifyTab").append(tabstr);
                            $("#InsModifyTab tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                            $("#InsModifyTab tr:even").addClass("alt");
                            $(".fixTable").tableHeadFixer();
                        }
                    }
                });
            });

            //保薪調整 刪除
            $(document).on("click", "a[name='IMdelbtn']", function () {
                if (confirm('確定刪除 員工編號：' + $(this).attr("ano") + "？"))
                    $(this).parent().parent().remove();
            });

            //執行保薪調整
            $(document).on("click", "#start_im", function () {
                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var form = $("form")[0];

                $("#postiframe").remove();

                form.appendChild(iframe[0]);

                form.setAttribute("action", "../handler/InsSalaryMod.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });
        });
    </script>
    <%--datepicker--%>
    <style type="text/css">
        .ui-datepicker {
            background: #D4C8B9;
            border: 1px solid #000;
            color: #000;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <input type="hidden" id="idtmp" name="idtmp" class="inputex" />
   <div class="WrapperMain">
            <div class="fixwidth">
                <div class="twocol underlineT1 margin10T">
                    <div class="left font-light">首頁 / 人事資料管理 / <span class="font-black font-bold">保險管理</span></div>
                </div>
            </div>
            <div class="fixwidth">
                <!-- 詳細資料start -->
                <div class="twocol margin15T">
                    <div class="right">
                        <a id="LH_CompBtn" href="javascript:void(0);" class="keybtn">勞健保比對</a>
                    </div>
                </div>
                <div class="statabs margin10T">
                    <ul>
                        <li><a href="#tabs-1" name="aTab">勞保</a></li>
                        <li><a href="#tabs-2" name="aTab">健保</a></li>
                        <li><a href="#tabs-3" name="aTab">勞退</a></li> 
                        <li><a href="#tabs-4" name="aTab">眷屬健保</a></li>
                        <li><a href="#tabs-5" name="aTab">團保</a></li>  
                        <li><a href="#tabs-6" name="aTab">保薪調整</a></li>  
                    </ul>
                    <div id="tabs-1">
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="newLBbtn" href="javascript:void(0);" class="keybtn">新增</a>
                                <a id="LB_SearchBtn" href="javascript:void(0);" sv="N" class="keybtn">查詢</a>
                            </div>
                            <div>
                                <a href="javascript:void(0);" id="L_ExportBtn" class="keybtn">匯出</a>
                                <input type="radio" name="rbLaborOut" value="3" checked="checked" class="ep" />三合一<input type="radio" name="rbLaborOut" value="2" class="ep" />二合一
                                <select id="ddlLaborExport" name="ddlLaborExport" onchange="getLaborList()">
                                    <option value="">--請選擇--</option>
                                    <option value="01">加保</option>
                                    <option value="02">退保</option>
                                    <option value="03">保薪調整</option>
                                </select>
                            </div>
                        </div><br />
                        <div id="searchDiv" style="display:none;">
                            <span class="font-title">關鍵字：</span><input id="lb_keyword" type="text" class="inputex" />
                            <input type="button" value="查詢" class="keybtn" onclick="getLaborList()" />
                        </div>
                        <div class="tabfixwidth margin15T">
                            <div class="stripeMe fixTable" style="max-height:175px;">
                                <table id="lb_tab" width="98%" border="0" cellspacing="0" cellpadding="0"></table>
                            </div><!-- overwidthblock -->
                        </div>
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="pl_addBtn" href="javascript:void(0);" class="keybtn">儲存</a>
                                <a id="pl_saveBtn" href="javascript:void(0);" class="keybtn" style="display:none;">儲存</a>
                            </div>
                            <div class="left font-title">
                                維護狀態:<span id="pl_eStatus">新增</span>
                            </div>
                        </div>
                        <div class="gentable font-normal margin15T">
                                <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="width10" align="right"><div class="font-title titlebackicon font-red">員工代號</div></td>
                                        <td class="width15">
                                            <input id="pl_No" name="pl_No" type="text" class="inputex width60" /><input id="pl_NoGuid" name="pl_NoGuid" type="hidden" />
                                            <img id="PLBBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                            <span id="pl_pName" class="showStr"></span>
                                            <input id="pl_NoStatus" name="pl_NoStatus" type="hidden" />
                                        </td>
                                        <td class="width13" align="right"><div class="font-title titlebackicon">部門別</div></td>
                                        <td class="width13"><span id="pl_Dep" class="showStr"></span></td>
                                        <td class="width13" align="right"><div class="font-title titlebackicon font-red">補助等級</div></td>
                                        <td class="width15">
                                            <input id="pl_SubsidyLevel" name="pl_SubsidyLevel" type="text" class="inputex width80" value="" /><input id="pl_SLGuid" name="pl_SLGuid" type="hidden" />
                                            <img id="LaborSLBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                            <span id="pl_SLName" class="showStr"></span>
                                            <input id="pl_SLStatus" name="pl_SLStatus" type="hidden" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon font-red" >異動日期</div></td>
                                        <td><input id="pl_ChangeDate" name="pl_ChangeDate" type="text" class="inputex width95" /></td>
                                        <td align="right"><div class="font-title titlebackicon font-red" >異動別</div></td>
                                        <td><select id="pl_Change" name="pl_Change" class="inputex"></select></td>
                                        <td align="right"><div class="font-title titlebackicon font-red">勞保投保薪資</div></td>
                                        <td><input id="pl_LaborPayroll" name="pl_LaborPayroll" type="text" class="inputex width95" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">備註</div></td>
                                        <td colspan="5"><input id="pl_Ps" name="pl_Ps" type="text" class="inputex width99" /></td>
                                    </tr>
                                </table>
                            </div>
                    </div><!-- tabs-1 -->
                    <div id="tabs-2">
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="newHbtn" href="javascript:void(0);" class="keybtn">新增</a>
                                <a id="H_SearchBtn" href="javascript:void(0);" sv="N" class="keybtn">查詢</a>
                            </div>
                            <div>
                                <a href="javascript:void(0);" id="H_ExportBtn" class="keybtn">匯出</a>
                                <input type="radio" name="HealOut" value="3" checked="checked" class="ep" />三合一<input type="radio" name="HealOut" value="2" class="ep" />二合一
                                <select id="ddlHealExport" name="ddlHealExport" onchange="getHealList()">
                                    <option value="">--請選擇--</option>
                                    <option value="01">加保</option>
                                    <option value="02">退保</option>
                                    <option value="03">保薪調整</option>
                                </select>
                            </div>
                        </div><br />
                        <div id="h_searchDiv" style="display:none;">
                            <span class="font-title">關鍵字：</span><input id="h_keyword" type="text" class="inputex" />
                            <input type="button" value="查詢" class="keybtn" onclick="getHealList()" />
                        </div>
                        <div class="tabfixwidth margin15T">
                            <div class="stripeMe fixTable" style="max-height:175px;">
                                <table id="h_tab" width="98%" border="0" cellspacing="0" cellpadding="0"></table>
                            </div><!-- overwidthblock -->
                        </div>
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="pi_addBtn" href="javascript:void(0);" class="keybtn">儲存</a>
                                <a id="pi_saveBtn" href="javascript:void(0);" class="keybtn" style="display:none;">儲存</a>
                            </div>
                            <div class="left font-title">
                                維護狀態:<span id="pi_eStatus">新增</span>
                            </div>
                        </div>
                        <div class="gentable font-normal margin15T">
                            <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">員工代號</div></td>
                                    <td class="width15">
                                        <input id="pi_No" name="pi_No" type="text" class="inputex width60" value="" /><input id="pi_NoGuid" name="pi_NoGuid" type="hidden" />
                                        <img id="PHBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                        <span id="pi_pName" class="showStr"></span>
                                        <input id="pi_NoStatus" name="pl_NoStatus" type="hidden" />
                                    </td>
                                    <td class="width13" align="right"><div class="font-title titlebackicon">部門別</div></td>
                                    <td class="width15"><span id="pi_Dep" class="showStr"></span></td>
                                    <td class="width13" align="right"><div class="font-title titlebackicon font-red">補助等級</div></td>
                                    <td class="width15">
                                        <input id="pi_SubsidyLevel" name="pi_SubsidyLevel" type="text" class="inputex width80" value="" /><input id="pi_SLGuid" name="pi_SLGuid" type="hidden" />
                                        <img id="HealSLBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                        <span id="pi_SLName" class="showStr"></span>
                                        <input id="pi_SLStatus" name="pl_SLStatus" type="hidden" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">異動日期</div></td>
                                    <td><input id="pi_ChangeDate" name="pi_ChangeDate" type="text" class="inputex width95" /></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">異動別</div></td>
                                    <td><select id="pi_Change" name="pi_Change" class="inputex"></select></td>
                                    <td align="right" class="dor"><div class="font-title titlebackicon">退保原因說明別</div></td>
                                    <td class="dor"><select id="pi_DropOutReason" name="pi_DropOutReason" class="inputex"></select></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">健保投保薪資</div></td>
                                    <td><input id="pi_InsurancePayroll" name="pi_InsurancePayroll" type="text" class="inputex width95" /></td>
                                    <td align="right"><div class="font-title titlebackicon">備註</div></td>
                                    <td colspan="3"><input id="pi_Ps" name="pi_Ps" type="text" class="inputex width99" /></td>
                                </tr>
                            </table>
                        </div>
                    </div><!-- tabs-2 -->
                    <div id="tabs-3">
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="newPPbtn" href="javascript:void(0);" class="keybtn">新增</a>
                                <a id="PP_SearchBtn" href="javascript:void(0);" sv="N" class="keybtn">查詢</a>
                            </div>
                            <div>
                                <a href="javascript:void(0);" id="ppExportBtn" class="keybtn fancybox">匯出</a>
                                <select id="ddlPensionExport" name="ddlPensionExport" onchange="getPensionList()">
                                    <option value="">--請選擇--</option>
                                    <option value="01">提繳</option>
                                    <option value="02">提繳工資調整</option>
                                    <option value="03">停繳</option>
                                </select>
                            </div>
                        </div><br />
                        <div id="pp_searchDiv" style="display:none;">
                            <span class="font-title">關鍵字：</span><input id="pp_keyword" type="text" class="inputex" />
                            <input type="button" value="查詢" class="keybtn" onclick="getPensionList()" />
                        </div>
                        <div class="tabfixwidth margin15T">
                            <div class="stripeMe fixTable" style="max-height:175px;">
                                <table id="pp_tab" width="98%" border="0" cellspacing="0" cellpadding="0"></table>
                            </div><!-- overwidthblock -->
                        </div>
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="pp_addBtn" href="javascript:void(0);" class="keybtn">儲存</a>
                                <a id="pp_saveBtn" href="javascript:void(0);" class="keybtn" style="display:none;">儲存</a>
                            </div>
                            <div class="left font-title">
                                維護狀態:<span id="pp_eStatus">新增</span>
                            </div>
                        </div>
                        <div class="gentable font-normal margin15T">
                            <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">員工代號</div></td>
                                    <td class="width15"><input id="pp_No" type="text" class="inputex width80" value="" /><input id="pp_NoGuid" name="pp_NoGuid" type="hidden" />
                                        <img id="PPBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                        <span id="pp_pName" class="showStr"></span>
                                        <input id="pp_NoStatus" name="pp_NoStatus" type="hidden" />
                                    </td>
                                    <td class="width13" align="right"><div class="font-title titlebackicon">部門別</div></td>
                                    <td class="width15"><span id="pp_Dep" class="showStr"></span></td>
                                    <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">異動日期</div></td>
                                    <td class="width15"><input id="pp_ChangeDate" name="pp_ChangeDate"  type="text" class="inputex width95" value="" /></td>
                                </tr>
                                <tr>                        
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">異動別</div></td>
                                    <td><select id="pp_Change" name="pp_Change" class="inputex"></select></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">勞工自提比率</div></td>
                                    <td><input id="pp_LarboRatio" name="pp_LarboRatio" type="text" class="inputex width95" value="" /></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">雇主提繳比率</div></td>
                                    <td><input id="pp_EmployerRatio" name="pp_EmployerRatio" type="text" class="inputex width95" value="" /></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">勞退月提繳工資</div></td>
                                    <td><input id="pp_PayPayroll" name="pp_PayPayroll" type="text" class="inputex width95" value="" /></td>
                                    <td align="right"><div class="font-title titlebackicon">備註</div></td>
                                    <td colspan="3"><input id="pp_Ps" name="pp_Ps" type="text" class="inputex width99" /></td>
                                </tr>

                            </table>
                        </div>
                    </div><!-- tabs-3 -->
                    <div id="tabs-4">
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="newPFbtn" href="javascript:void(0);" class="keybtn">新增</a>
                                <a id="PF_SearchBtn" href="javascript:void(0);" sv="N" class="keybtn">查詢</a>
                            </div>
                            <div>
                                <a href="javascript:void(0);" id="PfiExportBtn" class="keybtn">匯出</a>
                                <select id="ddlPfExport" name="ddlPfExport" onchange="getFamilyInsList()">
                                    <option value="">--請選擇--</option>
                                    <option value="01">加保</option>
                                </select>
                            </div>
                        </div><br />
                        <div id="pf_searchDiv" style="display:none;">
                            <span class="font-title">關鍵字：</span><input id="pf_keyword" type="text" class="inputex" />
                            <input type="button" value="查詢" class="keybtn" onclick="getFamilyInsList()" />
                        </div>
                        <div class="tabfixwidth margin15T">
                            <div class="stripeMe fixTable" style="max-height:175px;">
                                <table id="pf_tab" width="98%" border="0" cellspacing="0" cellpadding="0"></table>
                            </div><!-- overwidthblock -->
                        </div>
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="pf_addBtn" href="javascript:void(0);" class="keybtn">儲存</a>
                                <a id="pf_saveBtn" href="javascript:void(0);" class="keybtn" style="display:none;">儲存</a>
                            </div>
                            <div class="left font-title">
                                維護狀態:<span id="pf_eStatus">新增</span>
                            </div>
                        </div>
                        <div class="gentable font-normal margin15T">
                            <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">員工代號</div></td>
                                    <td class="width15">
                                        <input id="pfi_No" name="pfi_No" type="text" class="inputex width70" value="" /><input id="pf_NoGuid" name="pf_NoGuid" type="hidden" />
                                        <img id="PFBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                        <span id="pf_pName" class="showStr"></span>
                                        <input id="pf_NoStatus" name="pf_NoStatus" type="hidden" />
                                    </td>
                                    <td class="width13" align="right"><div class="font-title titlebackicon">部門別</div></td>
                                    <td class="width15"><span id="pfi_Dep" class="showStr"></span></td>
                                    <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">異動日期</div></td>
                                    <td class="width15"><input id="pfi_ChangeDate" name="pfi_ChangeDate" type="text" class="inputex width95" value="" /></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">為地區人口</div></td>
                                    <td><input name="pfi_AreaPerson" type="checkbox" value="Y" /></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">異動別</div></td>
                                    <td><select id="pfi_Change" name="pfi_Change" class="inputex"></select></td>
                                    <td align="right" class="dor"><div class="font-title titlebackicon">退保原因說明別</div></td>
                                    <td class="dor"><select id="pfi_DropOutReason" name="pfi_DropOutReason" class="inputex"></select></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon font-red">補助代號</div></td>
                                    <td>
                                        <input id="pfi_SubsidyLevel" name="pfi_SubsidyLevel" type="text" class="inputex width70" /><input id="pf_SLGuid" name="pf_SLGuid" type="hidden" />
                                        <img id="Pfi_SLBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                        <span id="pf_SLName" class="showStr"></span>
                                        <input id="pf_SLStatus" name="pf_SLStatus" type="hidden" />
                                    </td>
                                    <td align="right"><div class="font-title titlebackicon font-red" >眷屬姓名</div></td>
                                    <td>
                                        <input id="pfi_FName" name="pfi_FName" type="text" class="inputex width60" /><input id="pf_PfGuid" name="pf_PfGuid" type="hidden" />
                                        <img id="PFnBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                        <span id="pf_fName" class="showStr"></span>
                                        <input id="pf_fStatus" name="pf_NoStatus" type="hidden" />
                                    </td>
                                    <td align="right"><div class="font-title titlebackicon" >眷屬身分證號</div></td>
                                    <td><span id="pfi_IDNum" class="showStr"></span></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" >生日</div></td>
                                    <td><span id="pfi_Birth" class="showStr"></span></td>
                                    <td align="right"><div class="font-title titlebackicon">關係稱謂</div></td>
                                    <td><span id="pfi_Title" class="showStr"></span></td>
                                    <td align="right"><div class="font-title titlebackicon">備註</div></td>
                                    <td ><input id="pfi_Ps" name="pfi_Ps" type="text" class="inputex width99" /></td>
                                </tr>
                            </table>
                        </div>
                    </div><!-- tabs-4 -->
                    <div id="tabs-5">
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="newPGbtn" href="javascript:void(0);" class="keybtn">新增</a>
                                <a id="PG_SearchBtn" href="javascript:void(0);" sv="N" class="keybtn">查詢</a>
                            </div>
                        </div><br />
                        <div id="pg_searchDiv" style="display:none;">
                            <span class="font-title">關鍵字：</span><input id="pg_keyword" type="text" class="inputex" />
                            <input type="button" value="查詢" class="keybtn" onclick="getGroupInsList()" />
                        </div>
                        <div class="tabfixwidth margin15T">
                            <div class="stripeMe fixTable" style="max-height:175px;">
                                <table id="pg_tab" width="98%" border="0" cellspacing="0" cellpadding="0"></table>
                            </div><!-- overwidthblock -->
                        </div>
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="pg_addBtn" href="javascript:void(0);" class="keybtn">儲存</a>
                                <a id="pg_saveBtn" href="javascript:void(0);" class="keybtn" style="display:none;">儲存</a>
                            </div>
                            <div class="left font-title">
                                維護狀態:<span id="pg_eStatus">新增</span>
                            </div>
                        </div>
                        <div class="gentable font-normal margin15T">
                            <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">員工代號</div></td>
                                    <td class="width15">
                                        <input id="pgi_No" name="pgi_No" type="text" class="inputex width70" value="" /><input id="pg_NoGuid" name="pg_NoGuid" type="hidden" />
                                        <img id="PGBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                        <span id="pg_pName" class="showStr"></span>
                                        <input id="pg_NoStatus" name="pg_NoStatus" type="hidden" />
                                    </td>
                                    <td class="width13" align="right"><div class="font-title titlebackicon">部門別</div></td>
                                    <td class="width15"><span id="pgi_Dep" class="showStr"></span></td>
                                    <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">異動日期</div></td>
                                    <td class="width15"><input id="pgi_ChangeDate" name="pgi_ChangeDate" type="text" class="inputex width95" value="" /></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">身分</div></td>
                                    <td><input type="radio" name="pgi_Type" value="01" />本人<input type="radio" name="pgi_Type" value="02" />眷屬</td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">異動別</div></td>
                                    <td><select id="pgi_Change" name="pgi_Change" class="inputex"></select></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">保險代號</div></td>
                                    <td>
                                        <input id="pgi_InsuranceCode" name="pgi_InsuranceCode" type="text" class="inputex width50" /><input id="pg_ICGuid" name="pg_ICGuid" type="hidden" />
                                        <img id="PG_ICBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                        <span id="pg_IGName" class="showStr"></span>
                                        <input id="pg_IGStatus" name="pg_IGStatus" type="hidden" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon font-red">眷屬姓名</div></td>
                                    <td>
                                        <input id="pgi_FName" name="pgi_FName" type="text" class="inputex width60" /><input id="pg_PfGuid" name="pg_PfGuid" type="hidden" />
                                        <img id="PGFnBox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                        <span id="pg_fName" class="showStr"></span>
                                        <input id="pg_fStatus" name="pf_NoStatus" type="hidden" />
                                    </td>
                                    <td align="right"><div class="font-title titlebackicon" >眷屬身分證號</div></td>
                                    <td><span id="pgi_IDNum" class="showStr"></span></td>
                                    <td align="right"><div class="font-title titlebackicon">生日</div></td>
                                    <td><span id="pgi_Birth" class="showStr"></span></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">關係稱謂</div></td>
                                    <td><span id="pgi_Title" class="showStr"></span></td>
                                    <td align="right"><div class="font-title titlebackicon">備註</div></td>
                                    <td><input id="pgi_Ps" name="pgi_Ps" type="text" class="inputex width99" /></td>
                                </tr>
                            </table>
                        </div>
                    </div><!-- tabs-5 -->
                    <div id="tabs-6">
                        <div class="twocol margin15T">
                            <div class="right">
                                <a id="InsModBtn" href="javascript:void(0);" class="keybtn">執行保薪調整</a>
                                <a id="start_im" href="javascript:void(0);" class="keybtn">送出調整</a>
                            </div>
                        </div><br />
                        <div class="tabfixwidth margin15T">
                            <div class="stripeMe fixTable" style="max-height:400px;">
                                <table id="InsModifyTab" width="98%" border="0" cellspacing="0" cellpadding="0"></table>
                            </div><!-- overwidthblock -->
                        </div>
                    </div>
                <!-- 詳細資料end -->
            </div><!-- fixwidth -->         
        </div><!-- WrapperMain -->
    </div>
</asp:Content>

