<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="PersonnelInfo.aspx.cs" Inherits="webpage_PersonnelInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.js?v=2.1.5") %>"></script>
    <link href="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.css?v=2.1.5") %>" rel="stylesheet" type="text/css"  />
    <%--Common--%>
    <script type="text/javascript">
        $(document).ready(function () {
            getddl("02", "#pPosition");
            getddl("17", "#pf_Title");
            getddl("18", "#pp_Identity");

            $(document).on("keyup", "#pIDNumber,#pf_IDNumber", function () {
                this.value = this.value.toUpperCase();
            });

            $(document).on("click", "#ImportBtn", function () {
                $.fancybox({
                    href: "PersonImport.aspx?tp=Person",
                    type: "iframe",
                    width: "450",
                    minHeight: "150",
                    closeClick: false,
                    openEffect: 'elastic',
                    closeEffect: 'elastic',
                    afterClose: function () {
                        getData();
                    },
                    helpers: {
                        overlay: { closeClick: false } // prevents closing when clicking OUTSIDE fancybox
                    }
                });
            });

            //datepicker
            $("#pBirthday,#pFirstDate,#pLastDate,#pExaminationDate,#pExaminationLastDate,#pContractDeadline,#pResidentPermitDate,#pf_Birthday,#pb_Issued").datepicker({
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
                        var ddlstr = '<option value="">請選擇</option>';
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
        function checkData(type,v) {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/checkData.ashx",
                data: {
                    tp: type,
                    str: v
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
                                case "Company":
                                    $("#CompStr").html($("comAbbreviate", data).text());
                                    $("#pComGuid").val($("comGuid", data).text());
                                    $("#CompStr").css("color", "");
                                    $("#Compstatus").val("Y");
                                    break;
                                case "Dep":
                                    $("#DepStr").html($("cbName", data).text());
                                    $("#pDep").val($("cbGuid", data).text());
                                    $("#DepStr").css("color", "");
                                    $("#Depstatus").val("Y");
                                    break;
                                case "PA":
                                    $("#PaStr").html($("siItemName", data).text());
                                    $("#pa_CodeGuid").val($("siGuid", data).text());
                                    $("#PaStr").css("color", "");
                                    $("#PAstatus").val("Y");
                                    break;
                                case "PF":
                                    $("#PfStr").html($("slSubsidyIdentity", data).text());
                                    $("#pf_CodeGuid").val($("slGuid", data).text());
                                    $("#PfStr").css("color", "");
                                    $("#PFstatus").val("Y");
                                    break;
                                case "PLv":
                                    $("#PLvStr").html($("iiIdentity", data).text());
                                    $("#plv_CodeGuid").val($("iiGuid", data).text());
                                    $("#PLvStr").css("color", "");
                                    $("#PLVstatus").val("Y");
                                    break;
                                case "LB":
                                    $("#LaborStr").html($("slSubsidyIdentity", data).text());
                                    $("#Labor_CodeGuid").val($("slGuid", data).text());
                                    $("#LaborStr").css("color", "");
                                    $("#Laborstatus").val("Y");
                                    break;
                                case "Heal":
                                    $("#HealthStr").html($("slSubsidyIdentity", data).text());
                                    $("#Health_CodeGuid").val($("slGuid", data).text());
                                    $("#HealthStr").css("color", "");
                                    $("#Healthstatus").val("Y");
                                    break;
                            }
                        }
                        else {
                            switch (type) {
                                case "Company":
                                    $("#CompStr").html("X");
                                    $("#CompStr").css("color", "red");
                                    $("#Compstatus").val("N");
                                    break;
                                case "Dep":
                                    $("#DepStr").html("X");
                                    $("#DepStr").css("color", "red");
                                    $("#Depstatus").val("N");
                                    break;
                                case "PA":
                                    $("#PaStr").html("X");
                                    $("#PaStr").css("color", "red");
                                    $("#PAstatus").val("N");
                                    break;
                                case "PF":
                                    $("#PfStr").html("X");
                                    $("#PfStr").css("color", "red");
                                    $("#PFstatus").val("N");
                                    break;
                                case "PLv":
                                    $("#PLvStr").html("X");
                                    $("#PLvStr").css("color", "red");
                                    $("#PLVstatus").val("N");
                                    break;
                                case "LB":
                                    $("#LaborStr").html("X");
                                    $("#LaborStr").css("color", "red");
                                    $("#Laborstatus").val("N");
                                    break;
                                case "Heal":
                                    $("#HealthStr").html("X");
                                    $("#HealthStr").css("color", "red");
                                    $("#Healthstatus").val("N");
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
                case "Cbox":
                    link = "SearchWindow.aspx?v=Comp";
                    break;
                case "Dbox":
                    link = "SearchWindow.aspx?v=Dep";
                    break;
                case "PFbox":
                    link = "SearchWindow.aspx?v=Family";
                    break;
                case "PAbox":
                    link = "SearchWindow.aspx?v=Allowance";
                    break;
                case "PLvbox":
                    link = "SearchWindow.aspx?v=PLv";
                    break;
                case "Laborbox":
                    link = "SearchWindow.aspx?v=LB";
                    break;
                case "Healthbox":
                    link = "SearchWindow.aspx?v=Heal";
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
        function setReturnValue(type, gv, str, str2) {
            switch (type) {
                case "Comp":
                    $("#pCompName").val(str);
                    $("#pComGuid").val(gv);
                    $("#CompStr").html(str2);
                    $("#CompStr").css("color", "");
                    $("#Compstatus").val("Y");
                    break;
                case "Dep":
                    $("#pDepName").val(str);
                    $("#pDep").val(gv);
                    $("#DepStr").html(str2);
                    $("#DepStr").css("color", "");
                    $("#Depstatus").val("Y");
                    break;
                case "Family":
                    $("#pf_Code").val(str);
                    $("#pf_CodeGuid").val(gv);
                    $("#PfStr").html(str2);
                    $("#PfStr").css("color", "");
                    $("#PFstatus").val("Y");
                    break;
                case "Allowance":
                    $("#pa_AllowanceCode").val(str);
                    $("#pa_CodeGuid").val(gv);
                    $("#PaStr").html(str2);
                    $("#PaStr").css("color", "");
                    $("#PAstatus").val("Y");
                    break;
                case "PLv":
                    $("#pInsuranceDes").val(str);
                    $("#plv_CodeGuid").val(gv);
                    $("#PLvStr").html(str2);
                    $("#PLvStr").css("color", "");
                    $("#PLVstatus").val("Y");
                    break;
                case "LB":
                    $("#pLaborID").val(str);
                    $("#Labor_CodeGuid").val(gv);
                    $("#LaborStr").html(str2);
                    $("#LaborStr").css("color", "");
                    $("#Laborstatus").val("Y");
                    break;
                case "Heal":
                    $("#pInsuranceID").val(str);
                    $("#Health_CodeGuid").val(gv);
                    $("#HealthStr").html(str2);
                    $("#HealthStr").css("color", "");
                    $("#Healthstatus").val("Y");
                    break;
            }
        }

        //清空欄位
        function ClearInput() {
            $(".inputex").val("");
            $(".noSpan").html("無");
            $(".showStr").html("");
            //radiobutton
            var optobj = $("input:radio");
            for (i = 0; i < optobj.length; i++) {
                optobj[i].checked = false;
            }
            getPerFamilyList();
            getPerBuckleList();
            getPerAllowanceList();
        }

        function feedbackFun(msg,ern) {
            switch (msg) {
                default:
                    alert("完成");
                    ClearInput();
                    getData();
                    $("#editstatus").html("新增");
                    $("#Psavebtn").hide();
                    $("#Paddbtn").show();
                    break;
                case "error":
                    alert(ern + " Error");
                    break;
                case "repeatNo":
                    alert("此員工編號已存在");
                    break;
                case "repeatID":
                    alert("此身分證字號已存在");
                    break;
                case "PF":
                    alert("完成");
                    getPerFamilyList();
                    PFNewClick();
                    $("#PfStr").html("");
                    break;
                case "PB":
                    alert("完成");
                    getPerBuckleList();
                    PbNewClick();
                    break;
                case "PA":
                    alert("完成");
                    getPerAllowanceList();
                    PaNewClick();
                    $("#PaStr").html("");
                    break;
            }
        }
    </script>
    <%--基本資料--%>
    <script type="text/javascript">
        $(document).ready(function () {
            getData();

            $("#PersonTab").tabs();

            //人員新增/修改
            $(document).on("click", "#Paddbtn,#Psavebtn", function () {
                var msg = "";
                if ($("#pNo").val().trim() == "")
                    msg += "請輸入員工編號\n";
                if ($("#pName").val().trim() == "")
                    msg += "請輸入員工姓名\n";
                if ($("#pComGuid").val().trim() == "")
                    msg += "請輸入工司別\n";
                else if ($("#Compstatus").val()=="N")
                    msg += "找不到該工司別，請重新確認\n";
                if ($("#pDep").val().trim() == "")
                    msg += "請輸入部門\n";
                else if ($("#Depstatus").val() == "N")
                    msg += "找不到該部門，請重新確認\n";
                if ($("input[name='pSex']:checked").length == 0)
                    msg += "請選擇性別\n";
                if ($("#pPosition").val() == "")
                    msg += "請選擇職務\n";
                if ($("#pIDNumber").val().trim() == "")
                    msg += "請輸入身份證字號\n";
                if ($("input[name='pContract']:checked").length == 0)
                    msg += "請輸入合約別\n";
                if ($("#pFirstDate").val().trim() == "")
                    msg += "請輸入到職日期\n";
                //驗證日期
                var stmp = false;
                if ($("#pBirthday").val() != "" && $("#pBirthday").val().substring(4, 5) != "/" && $("#pBirthday").val().substring(7, 8) != "/")
                    stmp = true;
                if ($("#pFirstDate").val() != "" && $("#pFirstDate").val().substring(4, 5) != "/" && $("#pFirstDate").val().substring(7, 8) != "/")
                    stmp = true;
                if ($("#pLastDate").val() != "" && $("#pLastDate").val().substring(4, 5) != "/" && $("#pLastDate").val().substring(7, 8) != "/")
                    stmp = true;
                if ($("#pExaminationDate").val() != "" && $("#pExaminationDate").val().substring(4, 5) != "/" && $("#pExaminationDate").val().substring(7, 8) != "/")
                    stmp = true;
                if ($("#pExaminationLastDate").val() != "" && $("#pExaminationLastDate").val().substring(4, 5) != "/" && $("#pExaminationLastDate").val().substring(7, 8) != "/")
                    stmp = true;
                if ($("#pContractDeadline").val() != "" && $("#pContractDeadline").val().substring(4, 5) != "/" && $("#pContractDeadline").val().substring(7, 8) != "/")
                    stmp = true;
                if ($("#pResidentPermitDate").val() != "" && $("#pResidentPermitDate").val().substring(4, 5) != "/" && $("#pResidentPermitDate").val().substring(7, 8) != "/")
                    stmp = true;
                if (stmp)
                    msg += "請檢查日期格式，格式範例：2017/01/01 \n";

                if ($("#pEmail").val().trim() != "") {
                    var pattern = new RegExp(/^[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i);
                    if (!pattern.test($("#pEmail").val()))
                        msg += "請輸入正確Email";
                }
                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = "";
                if (this.id == "Paddbtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="New" />');
                else
                    mode = $('<input type="hidden" name="mode" id="mode" value="Modify" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addPerson.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            //人員刪除
            $(document).on("click", "a[name='pdelbtn']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/editPerson.ashx",
                        data: {
                            Mode: "D",
                            id: $(this).attr("aid")
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
                                getData();
                            }
                        }
                    });
                }
            });

            //編輯
            $(document).on("click", "#perlist tbody tr td:not(:first-child)", function () {
                $("#editstatus").html("編輯");
                $("#Psavebtn").show();
                $("#Paddbtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editPerson.ashx",
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
                            $(data).find("info_item").each(function (i) {
                                $("#idtmp").val($(this).children("perGuid").text().trim());
                                //基本資料
                                $("#pNo").val($(this).children("perNo").text().trim());
                                $("#pName").val($(this).children("perName").text().trim());
                                $("#pComGuid").val($(this).children("perComGuid").text().trim());
                                $("#pCompName").val($(this).children("comAbbreviate").text().trim());
                                $("#CompStr").html("");
                                $("#Compstatus").val("Y");
                                $("#pDep").val($(this).children("perDep").text().trim());
                                $("#pDepName").val($(this).children("cbValue").text().trim());
                                $("#DepStr").html("");
                                $("#Depstatus").val("Y");
                                $("input[name='pSex'][value='" + $(this).children("perSex").text().trim() + "']").prop("checked", true);
                                $("input[name='perMarriage'][value='" + $(this).children("perMarriage").text().trim() + "']").prop("checked", true);
                                $("#pPosition").val($(this).children("perPosition").text().trim());
                                $("#pBirthday").val($(this).children("perBirthday").text().trim());
                                $("#pIDNumber").val($(this).children("perIDNumber").text().trim());
                                $("input[name='pContract'][value='" + $(this).children("perContract").text().trim() + "']").prop("checked", true);
                                $("#pFirstDate").val($(this).children("perFirstDate").text().trim());
                                $("#pLastDate").val($(this).children("perLastDate").text().trim());
                                $("#pExaminationDate").val($(this).children("perExaminationDate").text().trim());
                                $("#pExaminationLastDate").val($(this).children("perExaminationLastDate").text().trim());
                                $("#pContractDeadline").val($(this).children("perContractDeadline").text().trim());
                                $("#pResidentPermitDate").val($(this).children("perResidentPermitDate").text().trim());
                                $("#pTel").val($(this).children("perTel").text().trim());
                                $("#pPhone").val($(this).children("perPhone").text().trim());
                                $("#pEmail").val($(this).children("perEmail").text().trim());
                                $("#pPostalCode").val($(this).children("perPostalCode").text().trim());
                                $("#pAddr").val($(this).children("perAddr").text().trim());
                                $("#pResPostalCode").val($(this).children("perResPostalCode").text().trim());
                                $("#pResidentAddr").val($(this).children("perResidentAddr").text().trim());
                                $("#pContactPerson").val($(this).children("perContactPerson").text().trim());
                                $("#pContactTel").val($(this).children("perContactTel").text().trim());
                                $("#pRel").val($(this).children("perRel").text().trim());
                                $("#pPs").val($(this).children("perPs").text().trim());
                                $("#pYears").val($(this).children("perYears").text().trim());
                                $("#pAnnualLeave").val($(this).children("perAnnualLeave").text().trim());
                                //保險
                                $("#pHIClass").val($(this).children("perHIClass").text().trim());
                                $("#pInsuranceDes").val($(this).children("iiIdentityCode").text().trim());
                                $("#plv_CodeGuid").val($(this).children("iiGuid").text().trim());
                                $("#PLvStr").html("");
                                $("#PLVstatus").val("Y");
                                $("input[name='pGroupInsurance'][value='" + $(this).children("perGroupInsurance").text().trim() + "']").prop("checked", true);
                                $("#pLaborID").val($(this).children("LCode").text().trim());
                                $("#Labor_CodeGuid").val($(this).children("Lgv").text().trim());
                                $("#LaborStr").html("");
                                $("#Laborstatus").val("Y");
                                $("#pInsuranceID").val($(this).children("HCode").text().trim());
                                $("#Health_CodeGuid").val($(this).children("Hgv").text().trim());
                                $("#HealthStr").html("");
                                $("#Healthstatus").val("Y");
                                $("#pp_Identity").val($(this).children("perPensionIdentity").text().trim());
                                //計薪
                                $("#pSalaryClass").val($(this).children("perSalaryClass").text().trim());
                                $("#pTaxable").val($(this).children("perTaxable").text().trim());
                                $("#pBasicSalary").val($(this).children("perBasicSalary").text().trim());
                                $("#pAllowance").val($(this).children("perAllowance").text().trim());
                                $("#pSyAccountName").val($(this).children("perSyAccountName").text().trim());
                                $("#pSyNumber").val($(this).children("perSyNumber").text().trim());
                                $("#pSyAccount").val($(this).children("perSyAccount").text().trim());
                                //法院執行命令
                                $("#pReferenceNumber").val($(this).children("perReferenceNumber").text().trim());
                                $("#pDetentionRatio").val($(this).children("perDetentionRatio").text().trim());
                                $("#pMonthPayroll").val($(this).children("perMonthPayroll").text().trim());
                                $("#pYearEndBonuses").val($(this).children("perYearEndBonuses").text().trim());

                            });
                        }
                    }
                });
                $(".noSpan").html($(this).closest('tr').children().get(1).innerText);
                getPerFamilyList();
                getPerBuckleList();
                getPerAllowanceList();
            });

            //設定合約/試用期滿日
            $(document).on("change", "#pFirstDate,input[name='pContract']", function () {
                if ($("input[name='pContract']:checked").length > 0 && $("#pFirstDate").val() != "") {
                    if ($("#pFirstDate").val().substring(4, 5) == "/" && $("#pFirstDate").val().substring(7, 8) == "/") {
                        var sday = new Date($("#pFirstDate").val());
                        if ($("input[name='pContract']:checked").val() == "01")
                            sday = new Date(sday.getFullYear(), sday.getMonth() + 1, sday.getDate());
                        else
                            sday = new Date(sday.getFullYear(), sday.getMonth() + 3, sday.getDate());
                        $("#pContractDeadline").val($.datepicker.formatDate('yy/mm/dd', new Date(sday)));
                    }
                }
            });

            //確認公司&部門
            $(document).on("change", "#pCompName,#pDepName", function () {
                if (this.id == "pCompName") type = "Company"
                else type = "Dep"
                checkData(type, $("#" + this.id).val());
            });

            //新增人員
            $(document).on("click", "#newPerBtn", function () {
                $("#editstatus").html("新增");
                $("#Psavebtn").hide();
                $("#Paddbtn").show();
                ClearInput();
                $("#PersonTab").tabs("option", "active", 0); //切換至第一個Tab
            });

            //查詢人員
            $(document).on("click", "#searchPerBtn", function () {
                if ($(this).attr("sv") == "N") {
                    $("#searchDiv").show();
                    $(this).attr("sv", "Y");
                }
                else {
                    $("#searchDiv").hide();
                    $(this).attr("sv", "N");
                }
            });


            //表頭排序
            $(document).on("click", "a[name='sortbtn']", function () {
                $("#sortName").val($(this).attr("atp"));
                if ($("#sortMethod").val() == "desc")
                    $("#sortMethod").val("asc");
                else
                    $("#sortMethod").val("desc");
                getData();
            });
        });
        
        //人員列表
        function getData() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/getPersonList.ashx",
                data: {
                    keyword: $("#keyword").val(),
                    sortMethod: $("#sortMethod").val(),
                    sortName: $("#sortName").val()
                },
                beforeSend: function () {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    $.unblockUI();
                    if (data == "error") {
                        alert("getPersonList Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#perlist").empty();
                        var tabstr = '<thead><tr>';
                        tabstr += '<th nowrap="nowrap">操作</th>';
                        tabstr += '<th nowrap="nowrap"><a href="javascript:void(0);" name="sortbtn" atp="perNo">編號</a></th>';
                        tabstr += '<th nowrap="nowrap"><a href="javascript:void(0);" name="sortbtn" atp="perName">姓名</a></th>';
                        tabstr += '<th nowrap="nowrap"><a href="javascript:void(0);" name="sortbtn" atp="cbName">所屬分店</a></th>';
                        tabstr += '<th nowrap="nowrap"><a href="javascript:void(0);" name="sortbtn" atp="perSex">性別</a></th>';
                        tabstr += '<th nowrap="nowrap"><a href="javascript:void(0);" name="sortbtn" atp="iiIdentityCode">補助等級</a></th>';
                        tabstr += '<th nowrap="nowrap"><a href="javascript:void(0);" name="sortbtn" atp="iiIdentity">投保身分</a></th>';
                        tabstr += '<th nowrap="nowrap"><a href="javascript:void(0);" name="sortbtn" atp="perFirstDate">到職日</a></th>';
                        tabstr += '</tr></thead><tbody>';
                        if ($(data).find("info_item").length > 0) {
                            $(data).find("info_item").each(function (i) {
                                tabstr += '<tr aid=' + $(this).children("perGuid").text() + '>';
                                tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="pdelbtn" aid=' + $(this).children("perGuid").text() + '>刪除</a></td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perNo").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perName").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("cbName").text() + '</td>';
                                if ($(this).children("perSex").text()=="M")
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">男</td>';
                                else
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">女</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("iiIdentityCode").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("iiIdentity").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perFirstDate").text() + '</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += "<tr><td colspan='8'>查詢無資料</td></tr>";
                        tabstr += '</tbody>';
                        $("#perlist").append(tabstr);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                    }
                }
            });
        }
    </script>
    <%--保險關聯--%>
    <script type="text/javascript">
        $(document).ready(function () {
            getddl("06", "#pHIClass");

            //保險儲存
            $(document).on("click", "#savInsurBtn", function () {
                var msg = "";
                if ($("#idtmp").val().trim() == "")
                    msg += "請選擇要修改的員工編號\n";
                else {
                    if ($("#pHIClass").val().trim() == "")
                        msg += "請選擇二代健保身分類別\n";
                    if ($("#pInsuranceDes").val().trim() == "")
                        msg += "請輸入投保身分\n";
                    else if ($("#PLVstatus").val() == "N")
                        msg += "找不到該投保身分，請重新確認\n";
                    if ($("input[name='pGroupInsurance']:checked").length == 0)
                        msg += "請選擇團保保險\n";
                    if ($("#pLaborID").val().trim() == "")
                        msg += "請輸入勞保補助身分\n";
                    else if ($("#Laborstatus").val() == "N")
                        msg += "找不到該勞保補助身分，請重新確認\n";
                    if ($("#pInsuranceID").val().trim() == "")
                        msg += "請輸入健保補助身分\n";
                    else if ($("#Healthstatus").val() == "N")
                        msg += "找不到該健保補助身分，請重新確認\n";
                }
                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = $('<input type="hidden" name="mode" id="mode" value="Insurance" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addPerson.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            $(document).on("change", "#pInsuranceDes,#pLaborID,#pInsuranceID", function () {
                switch (this.id) {
                    case "pInsuranceDes":
                        checkData("PLv", this.value);
                        break;
                    case "pLaborID":
                        checkData("LB", this.value);
                        break;
                    case "pInsuranceID":
                        checkData("Heal", this.value);
                        break;
                }
            });
        });
    </script>
    <%--計薪資料--%>
    <script type="text/javascript">
        $(document).ready(function () {
            getddl("08", "#pSalaryClass");
            getddl("09", "#pTaxable");
            
            $(document).on("keyup", ".num", function () {
                if (/[^0-9\-]/g.test(this.value)) {
                    this.value = this.value.replace(/[^0-9\-]/g, '');
                }
            });

            //計薪儲存
            $(document).on("click", "#savSalaryBtn", function () {
                var msg = "";
                if ($("#idtmp").val().trim() == "")
                    msg += "請選擇要修改的員工編號\n";
                else {
                    if ($("#pSalaryClass").val().trim() == "")
                        msg += "請選擇計薪別\n";
                    if ($("#pTaxable").val().trim() == "")
                        msg += "請選擇課稅方式\n";
                    if ($("#pBasicSalary").val().trim() == "")
                        msg += "請輸入底薪\n";
                    if ($("#pAllowance").val().trim() == "")
                        msg += "請輸入職能加給\n";
                    if ($("#pSyAccountName").val().trim() == "")
                        msg += "請輸入薪資轉入帳戶名\n";
                    if ($("#pSyNumber").val().trim() == "")
                        msg += "請輸入薪資轉入行(局)號\n";
                    if ($("#pSyAccount").val().trim() == "")
                        msg += "請輸入薪資轉入帳號\n";
                }
                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = $('<input type="hidden" name="mode" id="mode" value="Salary" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addPerson.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });
        });
    </script>
    <%--眷屬資料--%>
    <script type="text/javascript">
        $(document).ready(function () {
            getPerFamilyList();
            //眷屬資料新增/修改
            $(document).on("click", "#pf_addBtn,#pf_saveBtn", function () {
                var msg = "";
                if ($("#idtmp").val().trim() == "")
                    msg += "請選擇要修改的員工編號\n";
                else {
                    if ($("#pf_Name").val().trim() == "")
                        msg += "請輸入眷屬姓名\n";
                    if ($("input[name='pf_HealthInsurance']:checked").length == 0)
                        msg += "請選擇健保加保\n";
                    if ($("input[name='pf_GroupInsurance']:checked").length == 0)
                        msg += "請選擇團險加保\n";
                    if ($("#pf_IDNumber").val().trim() == "")
                        msg += "請輸入眷屬身分證字號\n";
                    if ($("#pf_Code").val().trim() == "")
                        msg += "請輸入補助代號\n";
                    else if ($("#PFstatus").val() == "N")
                        msg += "找不到該補助代號，請重新確認\n";
                    if ($("#pf_Title").val().trim() == "")
                        msg += "請選擇稱謂\n";
                    if ($("#pf_Birthday").val().trim() == "")
                        msg += "請輸入生日\n";
                    else if ($("#pf_Birthday").val() != "" && $("#pf_Birthday").val().substring(4, 5) != "/" && $("#pf_Birthday").val().substring(7, 8) != "/")
                        msg += "請檢查日期格式，格式範例：2017/01/01 \n";
                }
                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = "";
                if (this.id == "pf_addBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="New" />');
                if (this.id == "pf_saveBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="Modify" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addPersonFamily.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            //眷屬刪除
            $(document).on("click", "a[name='pfdelbtn']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/editPersonFamily.ashx",
                        data: {
                            Mode: "D",
                            id: $(this).attr("aid")
                        },
                        error: function (xhr) {
                            alert(xhr);
                        },
                        success: function (data) {
                            if (data == "error") {
                                alert("editPersonFamily Error");
                                return false;
                            }

                            if (data != null) {
                                getPerFamilyList();
                            }
                        }
                    });
                }
            });

            //眷屬編輯
            $(document).on("click", "#pfTab tbody tr td:not(:first-child)", function () {
                $("#pf_editstatus").html("編輯");
                $("#pf_saveBtn").show();
                $("#pf_addBtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editPersonFamily.ashx",
                    data: {
                        Mode: "E",
                        id: $(this).closest('tr').attr("aid")
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },
                    success: function (data) {
                        if (data == "error") {
                            alert("editPersonFamily Error");
                            return false;
                        }

                        if (data != null) {
                            data = $.parseXML(data);
                            //清除資料
                            $(".pftxt").val("");
                            var optobj = $(".pfrao");
                            for (i = 0; i < optobj.length; i++) {
                                optobj[i].checked = false;
                            }
                            $(data).find("info_item").each(function (i) {
                                $("#pfid").val($(this).children("pfGuid").text().trim());
                                //基本資料
                                $("#pf_Name").val($(this).children("pfName").text().trim());
                                $("input[name='pf_HealthInsurance'][value='" + $(this).children("pfHealthInsurance").text().trim() + "']").prop("checked", true);
                                $("input[name='pf_GroupInsurance'][value='" + $(this).children("pfGroupInsurance").text().trim() + "']").prop("checked", true);
                                $("#pf_IDNumber").val($(this).children("pfIDNumber").text().trim());
                                $("#pf_Code").val($(this).children("slSubsidyCode").text().trim());
                                $("#pf_CodeGuid").val($(this).children("slSubsidyCode").text().trim());
                                $("#PfStr").html("");
                                $("#PFstatus").val("Y");
                                $("#pf_Title").val($(this).children("pfTitle").text().trim());
                                $("#pf_Birthday").val($(this).children("pfBirthday").text().trim());
                            });
                        }
                    }
                });
            });

            $(document).on("change", "#pf_Code", function () {
                checkData("PF", this.value);
            });
        });

        function PFNewClick() {
            $("#pf_editstatus").html("新增");
            $("#pf_saveBtn").hide();
            $("#pf_addBtn").show();
            $(".pftxt").val("");
            var optobj = $(".pfrao");
            for (i = 0; i < optobj.length; i++) {
                optobj[i].checked = false;
            }
        }

        //人員列表
        function getPerFamilyList() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/getPersonFamilyList.ashx",
                data: {
                    id: $("#idtmp").val()
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("getPersonFamilyList Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#pfTab").empty();
                        var tabstr = '<tr>';
                        tabstr += '<th width="60" nowrap="nowrap" rowspan="2">操作</th>';
                        tabstr += '<th nowrap="nowrap" rowspan="2">眷屬姓名</th>';
                        tabstr += '<th nowrap="nowrap" rowspan="2">眷屬稱謂</th>';
                        tabstr += '<th nowrap="nowrap" rowspan="2">眷屬生日</th>';
                        tabstr += '<th nowrap="nowrap" rowspan="2">眷屬身分證字號</th>';
                        tabstr += '<th nowrap="nowrap" colspan="2">健保</th>';
                        tabstr += '<th nowrap="nowrap" rowspan="2">團險加保</th>';
                        tabstr += '</tr><tr>';
                        tabstr += '<th nowrap="nowrap">加保</th>';
                        tabstr += '<th nowrap="nowrap">補助代號</th></tr>';
                        if ($(data).find("pf_item").length > 0) {
                            $(data).find("pf_item").each(function (i) {
                                tabstr += '<tr aid=' + $(this).children("pfGuid").text() + '>';
                                tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="pfdelbtn" aid=' + $(this).children("pfGuid").text() + '>刪除</a></td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfName").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("code_desc").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfBirthday").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfIDNumber").text() + '</td>';
                                if ($(this).children("pfHealthInsurance").text() == "Y")
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">是</td>';
                                else
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">否</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("slSubsidyCode").text() + '</td>';
                                if ($(this).children("pfGroupInsurance").text() == "Y")
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">是</td>';
                                else
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">否</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += "<tr><td colspan='8'>查詢無資料</td></tr>";
                        $("#pfTab").append(tabstr);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                    }
                }
            });
        }
    </script>
    <%--法院執行命令--%>
    <script type="text/javascript">
        $(document).ready(function () {
            getPerBuckleList();

            //法院執行命令儲存
            $(document).on("click", "#perBuckleSavBtn", function () {
                var msg = "";
                if ($("#idtmp").val().trim() == "")
                    msg += "請選擇要修改的員工編號\n";
                else {
                    if ($("#pReferenceNumber").val().trim() == "")
                        msg += "請輸入執行明令發文字號\n";
                    if ($("#pDetentionRatio").val().trim() == "")
                        msg += "請輸入執行扣押薪資比例\n";
                    if ($("#pMonthPayroll").val().trim() == "")
                        msg += "請輸入每月應領薪津\n";
                    if ($("#pYearEndBonuses").val().trim() == "")
                        msg += "請輸入年終獎金\n";
            }
                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = $('<input type="hidden" name="mode" id="mode" value="Buckle" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addPerson.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            //法院強制扣繳來源新增/修改
            $(document).on("click", "#pb_addBtn,#pb_saveBtn", function () {
                var msg = "";
                if ($("#idtmp").val().trim() == "")
                    msg += "請選擇要修改的員工編號\n";
                else {
                    if ($("#pb_Creditor").val().trim() == "")
                        msg += "請輸入債權人\n";
                    if ($("#pb_CreditorCost").val().trim() == "")
                        msg += "請輸入債權金額\n";
                    if ($("#pb_Issued").val().trim() == "")
                        msg += "請輸入執行命令發文日期\n";
                    else if ($("#pb_Issued").val() != "" && $("#pb_Issued").val().substring(4, 5) != "/" && $("#pb_Issued").val().substring(7, 8) != "/")
                        msg += "請檢查日期格式，格式範例：2017/01/01 \n";
                    if ($("#pb_IntoNumber").val().trim() == "")
                        msg += "請輸入解款行代號\n";
                    if ($("#pb_IntoAccount").val().trim() == "")
                        msg += "請輸入收款人帳號\n";
                    if ($("#pb_IntoName").val().trim() == "")
                        msg += "請輸入戶名\n";
                    if ($("input[name='pb_Payment']:checked").length == 0)
                        msg += "請選擇繳款方式\n";
                    if ($("#pb_Contractor").val().trim() == "")
                        msg += "請輸入債權人承辦人\n";
                    if ($("#pb_Tel").val().trim() == "")
                        msg += "請輸入聯絡電話\n";
                    if ($("#pb_Fee").val().trim() == "")
                        msg += "請輸入匯款手續費/掛號郵資\n";
            }
                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = "";
                if (this.id == "pb_addBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="New" />');
                if (this.id == "pb_saveBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="Modify" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addPersonBuckle.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            //法院強制扣繳來源刪除
            $(document).on("click", "a[name='pbdelbtn']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/editPersonBuckle.ashx",
                        data: {
                            Mode: "D",
                            id: $(this).attr("aid")
                        },
                        error: function (xhr) {
                            alert(xhr);
                        },
                        success: function (data) {
                            if (data == "error") {
                                alert("editPersonBuckle Error");
                                return false;
                            }

                            if (data != null) {
                                getPerBuckleList();
                            }
                        }
                    });
                }
            });

            //法院強制扣繳來源編輯
            $(document).on("click", "#pbTab tbody tr td:not(:first-child)", function () {
                $("#pb_editstatus").html("編輯");
                $("#pb_saveBtn").show();
                $("#pb_addBtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editPersonBuckle.ashx",
                    data: {
                        Mode: "E",
                        id: $(this).closest('tr').attr("aid")
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },
                    success: function (data) {
                        if (data == "error") {
                            alert("editPersonBuckle Error");
                            return false;
                        }

                        if (data != null) {
                            data = $.parseXML(data);
                            //清除資料
                            $(".pbtxt").val("");
                            var optobj = $(".pbrao");
                            for (i = 0; i < optobj.length; i++) {
                                optobj[i].checked = false;
                            }
                            $(data).find("info_item").each(function (i) {
                                $("#pbid").val($(this).children("pbGuid").text().trim());
                                $("#pb_Creditor").val($(this).children("pbCreditor").text().trim());
                                $("#pb_CreditorCost").val($(this).children("pbCreditorCost").text().trim());
                                $("#pb_Issued").val($(this).children("pbIssued").text().trim());
                                $("#pb_IntoNumber").val($(this).children("pbIntoNumber").text().trim());
                                $("#pb_IntoAccount").val($(this).children("pbIntoAccount").text().trim());
                                $("#pb_IntoName").val($(this).children("pbIntoName").text().trim());
                                $("input[name='pb_Payment'][value='" + $(this).children("pbPayment").text().trim() + "']").prop("checked", true);
                                $("#pb_Contractor").val($(this).children("pbContractor").text().trim());
                                $("#pb_Tel").val($(this).children("pbTel").text().trim());
                                $("#pb_Fee").val($(this).children("pbFee").text().trim());
                            });
                        }
                    }
                });
            });
        });

        function PbNewClick() {
            $("#pb_editstatus").html("新增");
            $("#pb_saveBtn").hide();
            $("#pb_addBtn").show();
            $(".pbtxt").val("");
            var optobj = $(".pbrao");
            for (i = 0; i < optobj.length; i++) {
                optobj[i].checked = false;
            }
        }

        //扣繳來源列表
        function getPerBuckleList() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/getPersonBuckleList.ashx",
                data: {
                    id: $("#idtmp").val()
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("getPersonBuckleList Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#pbTab").empty();
                        var tabstr = '<tr>';
                        tabstr += '<th width="60" nowrap="nowrap">操作</th>';
                        tabstr += '<th nowrap="nowrap">債權人</th>';
                        tabstr += '<th nowrap="nowrap">債權金額</th>';
                        tabstr += '<th nowrap="nowrap">移轉比例</th>';
                        tabstr += '<th nowrap="nowrap">執行命令<br />發文日期</th>';
                        tabstr += '<th nowrap="nowrap">繳款方式</th>';
                        tabstr += '<th nowrap="nowrap">戶名</th>';
                        tabstr += '<th nowrap="nowrap">解款行代號</th>';
                        tabstr += '<th nowrap="nowrap">收款人帳號</th>';
                        tabstr += '<th nowrap="nowrap">匯款手續費/<br />掛號郵資</th>';
                        tabstr += '</tr>';
                        if ($(data).find("pb_item").length > 0) {
                            $(data).find("pb_item").each(function (i) {
                                tabstr += '<tr aid=' + $(this).children("pbGuid").text() + '>';
                                tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="pbdelbtn" aid=' + $(this).children("pbGuid").text() + '>刪除</a></td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pbCreditor").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pbCreditorCost").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;"></td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pbIssued").text() + '</td>';
                                if ($(this).children("pbPayment").text() == "01")
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">支票</td>';
                                else
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">匯款</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pbIntoName").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pbIntoNumber").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pbIntoAccount").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pbFee").text() + '</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += "<tr><td colspan='10'>查詢無資料</td></tr>";
                        $("#pbTab").append(tabstr);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                    }
                }
            });
        }
    </script>
    <%--個人津貼--%>
    <script type="text/javascript">
        $(document).ready(function () {
            getPerAllowanceList();
            //津貼新增/修改
            $(document).on("click", "#pa_addBtn,#pa_saveBtn", function () {
                var msg = "";
                if ($("#idtmp").val().trim() == "")
                    msg += "請選擇要修改的員工編號\n";
                else {
                    if ($("#pa_AllowanceCode").val().trim() == "")
                        msg += "請輸入津貼代號\n";
                    else if ($("#PAstatus").val() == "N")
                        msg += "找不到該津貼代號，請重新確認\n";
                    if ($("#pa_Cost").val().trim() == "")
                        msg += "請輸入金額\n";
                }
                if (msg != "") {
                    alert(msg);
                    return false;
                }

                var iframe = $('<iframe name="postiframe" id="postiframe" style="display: none" />');
                var mode = "";
                if (this.id == "pa_addBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="New" />');
                if (this.id == "pa_saveBtn")
                    mode = $('<input type="hidden" name="mode" id="mode" value="Modify" />');
                var form = $("form")[0];

                $("#postiframe").remove();
                $("input[name='mode']").remove();

                form.appendChild(iframe[0]);
                form.appendChild(mode[0]);

                form.setAttribute("action", "../handler/addPersonAllowance.ashx");
                form.setAttribute("method", "post");
                form.setAttribute("enctype", "multipart/form-data");
                form.setAttribute("encoding", "multipart/form-data");
                form.setAttribute("target", "postiframe");
                form.submit();
            });

            //津貼刪除
            $(document).on("click", "a[name='padelbtn']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "../handler/editPersonAllowance.ashx",
                        data: {
                            Mode: "D",
                            id: $(this).attr("aid")
                        },
                        error: function (xhr) {
                            alert(xhr);
                        },
                        success: function (data) {
                            if (data == "error") {
                                alert("editPersonAllowance Error");
                                return false;
                            }

                            if (data != null) {
                                getPerAllowanceList();
                            }
                        }
                    });
                }
            });

            //津貼編輯
            $(document).on("click", "#paTab tbody tr td:not(:first-child)", function () {
                $("#pa_editstatus").html("編輯");
                $("#pa_saveBtn").show();
                $("#pa_addBtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editPersonAllowance.ashx",
                    data: {
                        Mode: "E",
                        id: $(this).closest('tr').attr("aid")
                    },
                    error: function (xhr) {
                        alert(xhr);
                    },
                    success: function (data) {
                        if (data == "error") {
                            alert("editPersonAllowance Error");
                            return false;
                        }

                        if (data != null) {
                            data = $.parseXML(data);
                            //清除資料
                            $(".patxt").val("");
                            $(data).find("info_item").each(function (i) {
                                $("#paid").val($(this).children("paGuid").text().trim());
                                $("#pa_AllowanceCode").val($(this).children("paAllowanceCode").text().trim());
                                $("#pa_Cost").val($(this).children("paCost").text().trim());
                            });
                        }
                    }
                });
            });

            $(document).on("change", "#pa_AllowanceCode", function () {
                checkData("PA", this.value);
            });
        });

        function PaNewClick() {
            $("#pa_editstatus").html("新增");
            $("#pa_saveBtn").hide();
            $("#pa_addBtn").show();
            $(".patxt").val("");
        }

        //津貼列表
        function getPerAllowanceList() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/getPersonAllowanceList.ashx",
                data: {
                    id: $("#idtmp").val()
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("getPersonAllowanceList Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#paTab").empty();
                        var tabstr = '<tr>';
                        tabstr += '<th width="60" nowrap="nowrap" >操作</th>';
                        tabstr += '<th nowrap="nowrap" >津貼扣款代號</th>';
                        tabstr += '<th nowrap="nowrap" >津貼扣款名稱</th>';
                        tabstr += '<th nowrap="nowrap" >加扣別</th>';
                        tabstr += '<th nowrap="nowrap" >金額</th></tr>';
                        if ($(data).find("pa_item").length > 0) {
                            $(data).find("pa_item").each(function (i) {
                                tabstr += '<tr aid=' + $(this).children("paGuid").text() + '>';
                                tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="padelbtn" aid=' + $(this).children("paGuid").text() + '>刪除</a></td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("siItemCode").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("siItemName").text() + '</td>';
                                if ($(this).children("siAdd").text()=="01")
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">加項</td>';
                                else
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">扣項</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("paCost").text() + '</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += "<tr><td colspan='5'>查詢無資料</td></tr>";
                        $("#paTab").append(tabstr);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                    }
                }
            });
        }
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
    <input type="hidden" id="pfid" name="pfid" class="inputex" />
    <input type="hidden" id="pbid" name="pbid" class="inputex" />
    <input type="hidden" id="paid" name="paid" class="inputex" />
    <input type="hidden" id="sortMethod" name="sortMethod" value="desc" />
    <input type="hidden" id="sortName" name="sortName" />
    <div class="WrapperMain">
                <div class="fixwidth">
                    <div class="twocol underlineT1 margin10T">
                        <div class="left font-light">首頁 / 人事資料管理 / <span class="font-black font-bold">基本資料管理</span></div>
                    </div>
                    <div class="twocol margin15T">
                        <div class="left">資料管理:<a id="ImportBtn" href="javascript:void(0);" class="keybtn">匯入資料</a></div>
                        <div class="right">
                            <a href="javascript:void(0);" id="newPerBtn" class="keybtn">新增人員</a>
                            <a href="javascript:void(0);" id="searchPerBtn" sv="N" class="keybtn">查詢人員</a>
                        </div>
                    </div>
                </div>
                <br /><br />
                <div id="searchDiv" class="fixwidth" style="display:none;">
                    <span class="font-title">關鍵字：</span><input id="keyword" type="text" class="inputex" />
                    <input type="button" value="查詢" class="keybtn" onclick="getData()" />
                </div><br />
                <div class="fixwidth">
                    <div class="stripeMe fixTable" style="height:175px;">
                        <table id="perlist" width="100%" border="0" cellspacing="0" cellpadding="0"></table>
                    </div><!-- overwidthblock -->
                </div><!-- fixwidth -->
                <div class="fixwidth" style="margin-top:10px;">
                    <!-- 詳細資料start -->
                    <div id="PersonTab" class="margin10T">
                        <ul>
                            <li><a href="#tabs-1">基本資料</a></li>
                            <li><a href="#tabs-2">保險關聯</a></li>
                            <li><a href="#tabs-3">計薪資料</a></li>
                            <li><a href="#tabs-4">眷屬資料</a></li>
                            <li><a href="#tabs-5">法院執行命令</a></li>
                            <li><a href="#tabs-6">個人津貼</a></li>
                        </ul>
                        <div id="tabs-1">
                            <div class="twocol margin15TB">
                                <div class="right">
                                    <a id="Paddbtn" href="javascript:void(0);" class="keybtn">儲存</a>
                                    <a id="Psavebtn" href="javascript:void(0);" class="keybtn" style="display:none;">儲存</a>
                                </div>
                                <div class="left font-title">
                                    維護狀態:<span id="editstatus">新增</span>
                                </div>
                            </div>
                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">員工編號</div></td>
                                        <td class="width15"><input type="text" id="pNo" name="pNo" class="inputex width100" /></td>
                                        <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">員工姓名</div></td>
                                        <td class="width15"><input type="text" id="pName" name="pName" class="inputex width100" /></td>
                                        <td style="width:8%" align="right"><div class="font-title titlebackicon" style="color:Red">公司別</div></td>
                                        <td class="width15">
                                            <input type="text" id="pCompName" name="pCompName" class="inputex width60" /><input type="hidden" id="pComGuid" name="pComGuid" />
                                            <img id="Cbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                            <span id="CompStr" class="showStr"></span>
                                            <input id="Compstatus" type="hidden" />
                                        </td>
                                        <td style="width:8%" align="right"><div class="font-title titlebackicon" style="color:Red">部門</div></td>
                                        <td class="width15">
                                            <input type="text" id="pDepName" name="pDepName" class="inputex width60" /><input type="hidden" id="pDep" name="pDepGuid" />
                                            <img id="Dbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                            <span id="DepStr" class="showStr"></span>
                                            <input id="Depstatus" type="hidden" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon" style="color:Red">性別</div></td>
                                        <td><input type="radio" name="pSex" value="M" />男<input type="radio" name="pSex" value="F" />女</td>
                                        <td align="right"><div class="font-title titlebackicon" >婚姻狀況</div></td>
                                        <td><input type="radio" name="perMarriage" value="01" />已婚<input type="radio" name="perMarriage" value="02" />未婚</td>
                                        <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">職務</div></td>
                                        <td class="width15">
                                            <select id="pPosition" name="pPosition" class="inputex width95"></select>
                                        </td>
                                    </tr>           
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">出生日期</div></td>
                                        <td><input type="text" id="pBirthday" name="pBirthday" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon" style="color:Red">身分證<br />居留證編號</div></td>
                                        <td><input type="text" id="pIDNumber" name="pIDNumber" class="inputex width100" maxlength="10" /></td>
                                        <td align="right"><div class="font-title titlebackicon" style="color:Red">合約別</div></td>
                                        <td><input type="radio" name="pContract" value="01" />正式<input type="radio" name="pContract" value="02" />季節</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon" style="color:Red">到職日期</div></td>
                                        <td><input type="text" id="pFirstDate" name="pFirstDate" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">離職日期</div></td>
                                        <td><input type="text" id="pLastDate" name="pLastDate" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">體檢日期</div></td>
                                        <td ><input type="text" id="pExaminationDate" name="pExaminationDate" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">體檢到期日</div></td>
                                        <td ><input type="text" id="pExaminationLastDate" name="pExaminationLastDate" class="inputex width100" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">合約/試用期滿日</div></td>
                                        <td><input type="text" id="pContractDeadline" name="pContractDeadline" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">居留證到期日</div></td>
                                        <td><input type="text" id="pResidentPermitDate" name="pResidentPermitDate" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">年資</div></td>
                                        <td ><input type="text" id="pYears" name="pYears" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">特休天數</div></td>
                                        <td ><input type="text" id="pAnnualLeave" name="pAnnualLeave" class="inputex width100" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">電話</div></td>
                                        <td><input type="text" id="pTel" name="pTel" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">手機號碼</div></td>
                                        <td><input type="text" id="pPhone" name="pPhone" class="inputex width100" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">Email</div></td>
                                        <td colspan="3"><input type="text" id="pEmail" name="pEmail" class="inputex width100" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">通訊地址</div></td>
                                        <td colspan="7">
                                            <input type="text" id="pPostalCode" name="pPostalCode" class="inputex width10" />(郵遞區號)-<input type="text" id="pAddr" name="pAddr" class="inputex width75" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">戶籍地址</div></td>
                                        <td colspan="7">
                                            <input type="text" id="pResPostalCode" name="pResPostalCode" class="inputex width10" />(郵遞區號)-<input type="text" id="pResidentAddr" name="pResidentAddr" class="inputex width75" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">緊急聯絡人</div></td>
                                        <td><input type="text" id="pContactPerson" name="pContactPerson" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">緊急聯電話</div></td>
                                        <td><input type="text" id="pContactTel" name="pContactTel" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">關係</div></td>
                                        <td><input type="text" id="pRel" name="pRel" class="inputex width100" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">備註</div></td>
                                        <td colspan="7"><input type="text" id="pPs" name="pPs" class="inputex width99" /></td>
                                    </tr>
                                </table>
                            </div>
                        </div><!-- tabs-1 -->
                        <div id="tabs-2">
                            <div class="twocol margin15TB">
                                <div class="right">
                                    <a id="savInsurBtn" href="javascript:void(0);" class="keybtn">儲存</a>
                                </div>
                                <div class="left font-title">
                                    修改編號:<span class="noSpan"">無</span>
                                </div>
                            </div>
                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="width15" align="right"><div class="font-title titlebackicon font-red">二代健保身分類別</div></td>
                                        <td class="width35">
                                            <select id="pHIClass" name="pHIClass" class="inputex width95"></select>                                      
                                        </td>
                                        <td class="width15" align="right"><div class="font-title titlebackicon font-red">投保身分</div></td>
                                        <td>
                                            <input id="pInsuranceDes" name="pInsuranceDes" type="text" class="inputex width50" /><input type="hidden" id="plv_CodeGuid" name="plv_CodeGuid" />
                                            <img id="PLvbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                            <span id="PLvStr" class="showStr"></span>
                                            <input id="PLVstatus" type="hidden" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon font-red">團保保險</div></td>
                                        <td><input type="radio" name="pGroupInsurance" value="Y" />參加<input type="radio" name="pGroupInsurance" value="N" />不參加</td>
                                        <td align="right" class="auto-style3"><div class="font-title titlebackicon font-red">勞保補助身分</div></td>
                                        <td>
                                            <input id="pLaborID" name="pLaborID" type="text" class="inputex width50" /><input type="hidden" id="Labor_CodeGuid" name="Labor_CodeGuid" />
                                            <img id="Laborbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                            <span id="LaborStr" class="showStr"></span>
                                            <input id="Laborstatus" type="hidden" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon font-red">健保補助身分</div></td>
                                        <td>
                                            <input id="pInsuranceID" name="pInsuranceID" type="text" class="inputex width50" /><input type="hidden" id="Health_CodeGuid" name="Health_CodeGuid" />
                                            <img id="Healthbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                            <span id="HealthStr" class="showStr"></span>
                                            <input id="Healthstatus" type="hidden" />
                                        </td>
                                        <td align="right"><div class="font-title titlebackicon">提繳身分別</div></td>
                                        <td><select id="pp_Identity" name="pp_Identity" class="inputex width80"></select></td>
                                    </tr>
                                </table>
                            </div>
                        </div><!-- tabs-2 -->
                        <div id="tabs-3">
                            <div class="twocol margin15TB">
                                <div class="right">
                                    <a id="savSalaryBtn" href="javascript:void(0);" class="keybtn">儲存</a>
                                </div>
                                <div class="left font-title">
                                    修改編號:<span class="noSpan"">無</span>
                                </div>
                            </div>
                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="width15" align="right"><div class="font-title titlebackicon font-red">計薪別</div></td>
                                        <td class="width35"><select id="pSalaryClass" name="pSalaryClass" class="inputex width95"></select></td>
                                        <td align="right"><div class="font-title titlebackicon font-red">課稅方式</div></td>
                                        <td><select id="pTaxable" name="pTaxable" class="inputex width95"></select></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon font-red">底薪</div></td>
                                        <td><input id="pBasicSalary" name="pBasicSalary" type="text" class="inputex width95 num" /></td>
                                        <td align="right"><div class="font-title titlebackicon font-red">職能加給</div></td>
                                        <td><input id="pAllowance" name="pAllowance" type="text" class="inputex width95 num" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon font-red">薪資轉入帳戶名</div></td>
                                        <td><input id="pSyAccountName" name="pSyAccountName" type="text" class="inputex width95" /></td>
                                        <td align="right">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon font-red">薪資轉入行(局)號</div></td>
                                        <td><input id="pSyNumber" name="pSyNumber" type="text" class="inputex width95 num" /></td>
                                        <td align="right"><div class="font-title titlebackicon font-red">薪資轉入帳號</div></td>
                                        <td><input id="pSyAccount" name="pSyAccount" type="text" class="inputex width95 num" /></td>
                                    </tr>
                                </table>
                            </div>
                        </div><!-- tabs-3 -->
                        <div id="tabs-4">
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="javascript:void(0);" onclick="PFNewClick()" class="keybtn">新增眷屬</a>
                                </div>
                                 <div class="left font-title">
                                    修改編號:<span class="noSpan">無</span>
                                </div>
                            </div>
                            <div class="stripeMe font-normal">
                                <table id="pfTab" width="100%" cellspacing="0" cellpadding="0"></table>
                            </div><br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="javascript:void(0);" id="pf_addBtn" class="keybtn">儲存</a>
                                    <a href="javascript:void(0);" id="pf_saveBtn" style="display:none;" class="keybtn">儲存</a>
                                </div>
                                 <div class="left font-title">
                                    維護狀態:<span id="pf_editstatus">新增</span>
                                </div>
                            </div>
                            <div class="gentable">
                                <div class="gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">眷屬姓名</div></td>
                                            <td class="width15"><input id="pf_Name" name="pf_Name" type="text" class="inputex width100 pftxt" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">健保加保</div></td>
                                            <td class="width15"><input type="radio" value="Y" name="pf_HealthInsurance" class="pfrao" />是<input type="radio" value="N" name="pf_HealthInsurance" class="pfrao" />否</td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">團險加保</div></td>
                                            <td class="width15"><input type="radio" value="Y" name="pf_GroupInsurance" class="pfrao" />是<input type="radio" value="N" name="pf_GroupInsurance" class="pfrao" />否</td>
                                        </tr>    
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">眷屬身分證字號</div></td>
                                            <td><input id="pf_IDNumber" name="pf_IDNumber" type="text" class="inputex width100 pftxt" maxlength="10" /></td>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">補助代號</div></td>
                                            <td>
                                                <input id="pf_Code" name="pf_Code" type="text" class="inputex width50 pftxt" /><input type="hidden" id="pf_CodeGuid" name="pf_CodeGuid" />
                                                <img id="PFbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                                <span id="PfStr" class="showStr"></span>
                                                <input id="PFstatus" type="hidden" />
                                            </td>
                                        </tr>  
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">稱謂</div></td>
                                            <td><select id="pf_Title" name="pf_Title" class="inputex width95"></select></td>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">生日</div></td>
                                            <td><input id="pf_Birthday" name="pf_Birthday" type="text" class="inputex width100 pftxt" /></td>
                                        </tr>                                     
                                    </table>
                                </div>
                            </div>
                        </div><!-- tabs-4 -->
                        <div id="tabs-5">
                             <div class="twocol margin10B">
                                <div class="right">
                                    <a href="javascript:void(0);" id="perBuckleSavBtn" class="keybtn">儲存</a>
                                </div>
                                 <div class="left font-title">
                                    修改編號:<span class="noSpan">無</span>
                                </div>
                            </div>
                           <div class="gentable font-normal">
                               <table>
                                   <tr>
                                       <td class="width13" align="right"><div class="font-title titlebackicon font-red">執行明令發文字號</div></td>
                                       <td class="width15"><input id="pReferenceNumber" name="pReferenceNumber" type="text" class="inputex width100" /></td>
                                       <td class="width13" align="right"><div class="font-title titlebackicon font-red">執行扣押薪資比例</div></td>
                                       <td class="width15"><input id="pDetentionRatio" name="pDetentionRatio" type="text" class="inputex width100" /></td>
                                   </tr>
                                   <tr>
                                       <td class="width13" align="right"><div class="font-title titlebackicon font-red"">每月應領薪津</div></td>
                                       <td class="width15"><input id="pMonthPayroll" name="pMonthPayroll" type="text" class="inputex width100" /></td>
                                       <td class="width13" align="right"><div class="font-title titlebackicon font-red"">年終獎金</div></td>
                                       <td class="width15"><input id="pYearEndBonuses" name="pYearEndBonuses" type="text" class="inputex width100" /></td>
                                   </tr>
                               </table>
                           </div><br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="javascript:void(0);" onclick="PbNewClick()" class="keybtn">新增法院強制扣繳來源</a>
                                    <a href="javascript:void(0);" class="keybtn">重新計算分配比例</a>
                                </div>
                            </div>
                            <div class="stripeMe font-normal">
                                <table id="pbTab" width="100%" border="0" cellspacing="0" cellpadding="0"></table>
                            </div>
                            <br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="javascript:void(0);" id="pb_addBtn" class="keybtn">儲存</a>
                                    <a href="javascript:void(0);" id="pb_saveBtn" style="display:none;" class="keybtn">儲存</a>
                                </div>
                                 <div class="left font-title">
                                    維護狀態:<span id="pb_editstatus">新增</span>
                                </div>
                            </div>
                            <div class="gentable">
                                <div class="gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="width15" align="right"><div class="font-title titlebackicon font-red" >債權人</div></td>
                                            <td class="width15"><input id="pb_Creditor" name="pb_Creditor" type="text" class="inputex width100 pbtxt" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon font-red" >債權金額</div></td>
                                            <td class="width15"><input id="pb_CreditorCost" name="pb_CreditorCost" type="text" class="inputex width100 pbtxt" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon font-red" >執行命令發文日期</div></td>
                                            <td class="width15"><input id="pb_Issued" name="pb_Issued" type="text" class="inputex width100 pbtxt" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon font-red">解款行代號</div></td>
                                            <td><input id="pb_IntoNumber" name="pb_IntoNumber" type="text" class="inputex width100 pbtxt" /></td>
                                            <td align="right"><div class="font-title titlebackicon font-red">收款人帳號</div></td>
                                            <td><input id="pb_IntoAccount" name="pb_IntoAccount" type="text" class="inputex width100 pbtxt" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon font-red">戶名</div></td>
                                            <td colspan="3"><input id="pb_IntoName" name="pb_IntoName" type="text" class="inputex width100 pbtxt" /></td>
                                            <td align="right"><div class="font-title titlebackicon font-red">繳款方式</div></td>
                                            <td><input type="radio" name="pb_Payment" value="01" class="pbrao" />支票<input type="radio" name="pb_Payment" value="02" class="pbrao" />匯款</td>
                                        </tr>
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon font-red">債權人承辦人</div></td>
                                            <td><input type="text" id="pb_Contractor" name="pb_Contractor" class="inputex width100 pbtxt" /></td>
                                            <td align="right"><div class="font-title titlebackicon font-red">聯絡電話</div></td>
                                            <td><input type="text" id="pb_Tel" name="pb_Tel" class="inputex width100 pbtxt num" /></td>
                                            <td align="right"><div class="font-title titlebackicon font-red">匯款手續費<br />掛號郵資</div></td>
                                            <td><input id="pb_Fee" name="pb_Fee" type="text" class="inputex width100 pbtxt" /></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div><!-- tabs-5 -->
                        <div id="tabs-6">
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="javascript:void(0);" onclick="PaNewClick()" class="keybtn fancybox">新增</a>
                                </div>
                                 <div class="left font-title">
                                    修改編號:<span class="noSpan">無</span>
                                </div>
                            </div>
                            <div class="stripeMe font-normal">
                                <table id="paTab" width="100%" cellspacing="0" cellpadding="0"></table>
                            </div><br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="javascript:void(0);" id="pa_addBtn" class="keybtn">儲存</a>
                                    <a href="javascript:void(0);" id="pa_saveBtn" style="display:none;" class="keybtn">儲存</a>
                                </div>
                                 <div class="left font-title">
                                    維護狀態:<span id="pa_editstatus">新增</span>
                                </div>
                            </div>
                            <div class="gentable">
                                <div class="gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="width13" align="right"><div class="font-title titlebackicon font-red">津貼代號</div></td>
                                            <td class="width15">
                                                <input id="pa_AllowanceCode" name="pa_AllowanceCode" type="text" class="inputex width50 patxt" /><input type="hidden" id="pa_CodeGuid" name="pa_CodeGuid" />
                                                <img id="PAbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                                <span id="PaStr" class="showStr"></span>
                                                <input type="hidden" id="PAstatus" />
                                            </td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon font-red">金額</div></td>
                                            <td class="width15"><input id="pa_Cost" name="pa_Cost" type="text" class="inputex width100 patxt" /></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div><!-- tabs-4 -->
                    </div><!-- statabs -->
                    <!-- 詳細資料end -->
                </div><!-- fixwidth -->
            </div>
    <br />
</asp:Content>