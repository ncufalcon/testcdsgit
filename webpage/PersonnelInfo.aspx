<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="PersonnelInfo.aspx.cs" Inherits="webpage_PersonnelInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.js?v=2.1.5") %>"></script>
    <link href="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.css?v=2.1.5") %>" rel="stylesheet" type="text/css"  />
    <%--Common--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).on("keyup", "#pIDNumber,#pf_IDNumber", function () {
                this.value = this.value.toUpperCase();
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

        //清空欄位
        function ClearInput() {
            $(".inputex").val("");
            $(".noSpan").html("無");
            //radiobutton
            var optobj = $("input:radio");
            for (i = 0; i < optobj.length; i++) {
                optobj[i].checked = false;
            }
            //img
            $(".imgtag").hide();
            getPerFamilyList();
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
                    break;
            }
        }
    </script>
    <%--基本資料--%>
    <script type="text/javascript">
        $(document).ready(function () {
            getddl("02", "#pPosition");
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
            $(document).on("click", "#perlist tr", function () {
                $("#editstatus").html("編輯");
                $("#Psavebtn").show();
                $("#Paddbtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editPerson.ashx",
                    data: {
                        Mode: "E",
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
                            data = $.parseXML(data);
                            ClearInput();
                            $(data).find("info_item").each(function (i) {
                                $("#idtmp").val($(this).children("perGuid").text().trim());
                                //基本資料
                                $("#pNo").val($(this).children("perNo").text().trim());
                                $("#pName").val($(this).children("perName").text().trim());
                                $("#pComGuid").val($(this).children("perComGuid").text().trim());
                                $("#pCompName").val($(this).children("perCompName").text().trim());
                                $("#pDep").val($(this).children("perDep").text().trim());
                                $("#pDepName").val($(this).children("perDepName").text().trim());
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
                                //保險
                                $("#pHIClass").val($(this).children("perHIClass").text().trim());
                                $("#pInsuranceDes").val($(this).children("perInsuranceDes").text().trim());
                                $("input[name='pGroupInsurance'][value='" + $(this).children("perGroupInsurance").text().trim() + "']").prop("checked", true);
                                $("#pLaborID").val($(this).children("perLaborID").text().trim());
                                $("#pInsuranceID").val($(this).children("perInsuranceID").text().trim());
                                //計薪
                                $("#pSalaryClass").val($(this).children("perSalaryClass").text().trim());
                                $("#pTaxable").val($(this).children("perTaxable").text().trim());
                                $("#pBasicSalary").val($(this).children("perBasicSalary").text().trim());
                                $("#pAllowance").val($(this).children("perAllowance").text().trim());
                                $("#pSyAccountName").val($(this).children("perSyAccountName").text().trim());
                                $("#pSyNumber").val($(this).children("perSyNumber").text().trim());
                                $("#pSyAccount").val($(this).children("perSyAccount").text().trim());
                            });
                        }
                    }
                });
                $(".noSpan").html($(this).children().get(1).innerText);
                getPerFamilyList();
            });

            //datepicker
            $("#pBirthday,#pFirstDate,#pLastDate,#pExaminationDate,#pExaminationLastDate,#pContractDeadline,#pResidentPermitDate,#pf_Birthday").datepicker({
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
                if (this.id == "pCompName") type = "C"
                else type = "D"
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/checkData.ashx",
                    data: {
                        tp: type,
                        str: $("#" + this.id + "").val()
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
                                alert("兩項")
                           else if ($(data).find("data_item").length > 0) {
                               if (type == "C") {
                                   $("#cyesimg").show();
                                   $("#cnoimg").hide();
                                   $("#Compstatus").val("Y");
                               }
                               else {
                                   $("#dyesimg").show();
                                   $("#dnoimg").hide();
                                   $("#Depstatus").val("Y");
                               }
                           }
                           else {
                               if (type == "C") {
                                   $("#cyesimg").hide();
                                   $("#cnoimg").show();
                                   $("#Compstatus").val("N");
                               }
                               else {
                                   $("#dyesimg").hide();
                                   $("#dnoimg").show();
                                   $("#Depstatus").val("N");
                               }
                           }
                        }
                    }
                });
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
        });
        
        //人員列表
        function getData() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/getPersonList.ashx",
                data: {
                    keyword: $("#keyword").val()
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("getPersonList Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#perlist").empty();
                        var tabstr = '<thead>';
                        tabstr += '<tr><th nowrap="nowrap">操作</th>';
                        tabstr += '<th nowrap="nowrap">編號</th>';
                        tabstr += '<th nowrap="nowrap">姓名</th>';
                        tabstr += '<th nowrap="nowrap">所屬分店</th>';
                        tabstr += '<th nowrap="nowrap">性別</th>';
                        tabstr += '<th nowrap="nowrap">補助等級</th>';
                        tabstr += '<th nowrap="nowrap">投保身分</th>';
                        tabstr += '<th nowrap="nowrap">到職日</th></tr></thead>';
                        tabstr += '<tbody>';
                        if ($(data).find("info_item").length > 0) {
                            $(data).find("info_item").each(function (i) {
                                tabstr += '<tr aid=' + $(this).children("perGuid").text() + '>';
                                tabstr += '<td align="center" nowrap="nowrap" class="font-normal"><a href="javascript:void(0);" name="pdelbtn" aid=' + $(this).children("perGuid").text() + '>刪除</a></td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perNo").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perName").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("perDepName").text() + '</td>';
                                if ($(this).children("perSex").text()=="M")
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">男</td>';
                                else
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">女</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;"></td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;"></td>';
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

        //查詢視窗
        function openfancybox(item) {
            if ($(item).attr("id") == "Cbox")
                link = "SearchWindow.aspx?v=C";
            else
                link = "SearchWindow.aspx?v=D";

            $.fancybox({
                href: link,
                type:"iframe",
                minHeight: "400",
                closeClick: false,
                openEffect: 'elastic',
                closeEffect: 'elastic'
            });
        }

        //fancybox回傳
        function setReturnValue(type, gv,str) {
            if (type == "C") {
                $("#pCompName").val(str);
                $("#pComGuid").val(gv);
                $("#Compstatus").val("Y");
                $("#cyesimg").show();
                $("#cnoimg").hide();
            }
            else {
                $("#pDepName").val(str);
                $("#pDep").val(gv);
                $("#Depstatus").val("Y");
                $("#dyesimg").show();
                $("#dnoimg").hide();
            }
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
                    if ($("input[name='pGroupInsurance']:checked").length == 0)
                        msg += "請選擇團保保險\n";
                    if ($("#pLaborID").val().trim() == "")
                        msg += "請輸入勞保補助身分\n";
                    if ($("#pInsuranceID").val().trim() == "")
                        msg += "請輸入健保補助身分\n";
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

            //保險儲存
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
                    if ($("#pf_Title").val().trim() == "")
                        msg += "請輸入稱謂\n";
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
            $(document).on("click", "#pfTab tr", function () {
                $("#pf_editstatus").html("編輯");
                $("#pf_saveBtn").show();
                $("#pf_addBtn").hide();
                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/editPersonFamily.ashx",
                    data: {
                        Mode: "E",
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
                                $("#pf_Code").val($(this).children("pfCode").text().trim());
                                $("#pf_Title").val($(this).children("pfTitle").text().trim());
                                $("#pf_Birthday").val($(this).children("pfBirthday").text().trim());
                            });
                        }
                    }
                });
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
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfTitle").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfBirthday").text() + '</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfIDNumber").text() + '</td>';
                                if ($(this).children("pfHealthInsurance").text() == "Y")
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">是</td>';
                                else
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">否</td>';
                                tabstr += '<td nowrap="nowrap" style="cursor: pointer;">' + $(this).children("pfCode").text() + '</td>';
                                if ($(this).children("pfGroupInsurance").text() == "Y")
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">是</td>';
                                else
                                    tabstr += '<td nowrap="nowrap" style="cursor: pointer;">否</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += "<tr><td colspan='8'>查詢無資料</td></tr>";
                        tabstr += '</tbody>';
                        $("#pfTab").append(tabstr);
                        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
                        $(".stripeMe tr:even").addClass("alt");
                    }
                }
            });
        }
    </script>
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
    <div class="WrapperMain">
                <div class="fixwidth">
                    <div class="twocol underlineT1 margin10T">
                        <div class="left font-light">首頁 / 人事資料管理 / <span class="font-black font-bold">基本資料管理</span></div>
                    </div>
                    <div class="twocol margin15T">
                        <div class="left">資料管理:<a href="#" class="keybtn fancybox">匯入WorkDay資料</a></div>
                        <div class="right">
                            <a href="javascript:void(0);" id="newPerBtn" class="keybtn">新增人員</a>
                            <a href="javascript:void(0);" id="searchPerBtn" sv="N" class="keybtn">查詢人員</a>
                        </div>
                    </div>
                </div>
                <br /><br />
                <div class="fixwidth">
                    <div id="searchDiv" style="display:none;">
                        <span class="font-title">關鍵字：</span><input id="keyword" type="text" class="inputex" />
                        <input type="button" value="查詢" class="keybtn" onclick="getData()" />
                    </div><br />
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
                                            <input type="text" id="pCompName" name="pCompName" class="inputex width50" /><input type="hidden" id="pComGuid" name="pComGuid" />
                                            <img id="Cbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                            <img id="cyesimg" class="imgtag" src="<%= ResolveUrl("~/images/yes.png") %>" width="19" height="19" style="display:none;" />
                                            <img id="cnoimg" class="imgtag" src="<%= ResolveUrl("~/images/no.png") %>" width="19" height="19" style="display:none;" />
                                            <input id="Compstatus" type="hidden" />
                                        </td>
                                        <td style="width:8%" align="right"><div class="font-title titlebackicon" style="color:Red">部門</div></td>
                                        <td class="width15">
                                            <input type="text" id="pDepName" name="pDepName" class="inputex width50" /><input type="hidden" id="pDep" name="pDep" />
                                            <img id="Dbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                            <img id="dyesimg" class="imgtag" src="<%= ResolveUrl("~/images/yes.png") %>" width="19" height="19" style="display:none;" />
                                            <img id="dnoimg" class="imgtag" src="<%= ResolveUrl("~/images/no.png") %>" width="19" height="19" style="display:none;" />
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
                                        <td><input id="pInsuranceDes" name="pInsuranceDes" type="text" class="inputex width50" /><img src="<%= ResolveUrl("~/images/btn-search.gif") %>" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon font-red">團保保險</div></td>
                                        <td><input type="radio" name="pGroupInsurance" value="Y" />參加<input type="radio" name="pGroupInsurance" value="N" />不參加</td>
                                        <td align="right" class="auto-style3"><div class="font-title titlebackicon font-red">勞保補助身分</div></td>
                                        <td><input id="pLaborID" name="pLaborID" type="text" class="inputex width50" /><img src="<%= ResolveUrl("~/images/btn-search.gif") %>" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon font-red">健保補助身分</div></td>
                                        <td><input id="pInsuranceID" name="pInsuranceID" type="text" class="inputex width50" /><img src="<%= ResolveUrl("~/images/btn-search.gif") %>" /></td>
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
                                    <a href="javascript:void(0);" onclick="PFNewClick()" class="keybtn fancybox">新增眷屬</a>
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
                                            <td><input id="pf_Code" name="pf_Code" type="text" class="inputex width50 pftxt" /><img src="<%= ResolveUrl("~/images/btn-search.gif") %>" /></td>
                                        </tr>  
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">稱謂</div></td>
                                            <td><input id="pf_Title" name="pf_Title" type="text" class="inputex width100 pftxt" /></td>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">生日</div></td>
                                            <td><input id="pf_Birthday" name="pf_Birthday" type="text" class="inputex width100 pftxt" /></td>
                                        </tr>                                     
                                    </table>
                                </div>
                            </div>
                        </div><!-- tabs-4 -->
                        <div id="tabs-5">
                           <div class="gentable font-normal">
                               <table>
                                   <tr>
                                       <td class="width13" align="right"><div class="font-title titlebackicon font-red">執行明令發文字號</div></td>
                                       <td class="width15"><input type="text" class="inputex width100" /></td>
                                       <td class="width13" align="right"><div class="font-title titlebackicon font-red">執行扣押薪資比例</div></td>
                                       <td class="width15"><input type="text" class="inputex width100" /></td>
                                   </tr>
                                   <tr>
                                       <td class="width13" align="right"><div class="font-title titlebackicon font-red"">每月應領薪津</div></td>
                                       <td class="width15"><input type="text" class="inputex width100" /></td>
                                       <td class="width13" align="right"><div class="font-title titlebackicon font-red"">年終獎金</div></td>
                                       <td class="width15"><input type="text" class="inputex width100" /></td>
                                   </tr>
                               </table>
                           </div><br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="#" class="keybtn">新增法院強制扣繳來源</a><a href="#" class="keybtn">重新計算分配比例</a>
                                </div>
                            </div>
                        
                            <div class="stripeMe font-normal">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <th width="60" nowrap="nowrap">操作</th>
                                        <th nowrap="nowrap">債權人序號</th>
                                        <th nowrap="nowrap">債權人</th>
                                        <th nowrap="nowrap">債權金額</th>
                                        <th nowrap="nowrap">移轉比例</th>
                                        <th nowrap="nowrap">執行命令<br />發文日期</th>
                                        <th nowrap="nowrap">繳款方式</th>
                                        <th nowrap="nowrap">法扣轉入<br />戶名</th>
                                        <th nowrap="nowrap">法扣行轉入<br />局號</th>
                                        <th nowrap="nowrap">法扣轉入<br />帳號</th>
                                        <th nowrap="nowrap">匯款手續費/<br />掛號郵資</th>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#" class="fancybox">刪除</a>&nbsp;&nbsp;</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">台新銀行</td>
                                        <td nowrap="nowrap">100000</td>
                                        <td nowrap="nowrap">20%</td>
                                        <td nowrap="nowrap">20170101</td>
                                        <td nowrap="nowrap">匯款</td>
                                        <td nowrap="nowrap">台新銀</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">78909</td>
                                        <td nowrap="nowrap">10</td>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#" class="fancybox">刪除</a>&nbsp;&nbsp;</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">花旗</td>
                                        <td nowrap="nowrap">100000</td>
                                        <td nowrap="nowrap">20%</td>
                                        <td nowrap="nowrap">20170101</td>
                                        <td nowrap="nowrap">匯款</td>
                                        <td nowrap="nowrap">台新銀</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">78909</td>
                                        <td nowrap="nowrap">10</td>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#" class="fancybox">刪除</a>&nbsp;&nbsp;</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">國泰</td>
                                        <td nowrap="nowrap">100000</td>
                                        <td nowrap="nowrap">20%</td>
                                        <td nowrap="nowrap">20170101</td>
                                        <td nowrap="nowrap">匯款</td>
                                        <td nowrap="nowrap">台新銀</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">78909</td>
                                        <td nowrap="nowrap">10</td>
                                    </tr>
                                </table>
                            </div>
                            <!--<div class="twocol margin5TB">
                                <div class="right">
                                    <div class="font-title ">
                                        總金額
                                        <span>22000</span>
                                    </div>
                                </div>

                            </div>--><br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="#" class="keybtn">儲存</a>
                                </div>
                            </div>
                            <div class="gentable">
                                <div class="gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="width15" align="right"><div class="font-title titlebackicon font-red" >債權人</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon font-red" >債權金額</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon font-red" >執行命令發文日期</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>

                                        </tr>
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon font-red">解款行代號</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                            <td align="right"><div class="font-title titlebackicon font-red">收款人帳號</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon font-red">戶名</div></td>
                                            <td colspan="3"><input type="text" class="inputex width100" /></td>
                                            <td align="right"><div class="font-title titlebackicon font-red">繳款方式</div></td>
                                            <td><input type="radio" />支票<input type="radio" />匯款</td>
                                        </tr>
                                        <tr>

                                            <td align="right"><div class="font-title titlebackicon font-red">債權人承辦人</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                            <td align="right"><div class="font-title titlebackicon font-red">聯絡電話</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                            <td align="right"><div class="font-title titlebackicon font-red">匯款手續費<br />掛號郵資</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div><!-- tabs-5 -->
                        <div id="tabs-6">

                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="#" class="keybtn fancybox">新增</a>
                                </div>
                            </div>
                            <div class="stripeMe font-normal">
                                <table width="100%" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <th width="60" nowrap="nowrap" >操作</th>
                                        <th nowrap="nowrap" >津貼扣款代號</th>
                                        <th nowrap="nowrap" >津貼扣款名稱</th>
                                        <th nowrap="nowrap" >加扣別</th>
                                        <th nowrap="nowrap" >金額</th>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#">刪除</a></td>
                                        <td nowrap="nowrap">0001</td>
                                        <td nowrap="nowrap">捐款</td>
                                        <td nowrap="nowrap">扣</td>
                                        <td nowrap="nowrap">1500</td>

                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#">刪除</a></td>
                                        <td nowrap="nowrap">0002</td>
                                        <td nowrap="nowrap">其它津貼</td>
                                        <td nowrap="nowrap">加</td>
                                        <td nowrap="nowrap">1000</td>    
                                    </tr>

                                </table>
                            </div><br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="#" class="keybtn">儲存</a>
                                </div>
                            </div>
                            <div class="gentable">
                                <div class="gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="width13" align="right"><div class="font-title titlebackicon font-red">津貼代號</div></td>
                                            <td class="width15"><input type="text" class="inputex width50" /><img src="<%= ResolveUrl("~/images/btn-search.gif") %>" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon font-red">金額</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>
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

