<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Modify.aspx.cs" Inherits="webpage_page_Modify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.js?v=2.1.5") %>"></script>
    <link href="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.css?v=2.1.5") %>" rel="stylesheet" type="text/css"  />
    <script type="text/javascript">
        $(function () {
            $(document).on("change", "#txt_person_empno", function () { 
                //alert($(this).val());
                load_thispeopledata($(this).val());
            });

            //預設查詢區塊隱藏
            $("#span_person_search").hide();
            //套用datetimepicker
            $.datetimepicker.setLocale('zh-TW');//設定為中文
            $("#txt_person_change_date,#search_person_date").datetimepicker({
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            //人事異動 一開始預設確認日是今天 確認者是操作者
            var today_ymd = get_datenow();
            var now_user = "王胖爺";//目前還沒有登入這塊 先寫死
            $("#txt_person_chkdate").val(today_ymd);
            $("#txt_person_chkpeople").val(now_user);

            call_changedata();//撈異動項目下拉選單選項
            call_personchangedata();//撈人事異動資料

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
            });
            //人事異動 儲存按鈕
            $("#btn_person_submit").click(function () {
                mod_persondata();
            });;
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
            //$(document).on("click", "#div_person_list tbody tr td:not(:nth-child(1),:nth-child(2))", function () {
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
                $("#hidden_pcguid").val($(this).closest('tr').attr("trguid"))//修改才會有
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
                                str_html += "<th nowrap='nowrap'>操作</th>";
                                str_html += "<th nowrap='nowrap'>員工代號</th>";
                                str_html += "<th nowrap='nowrap'>員工姓名</th>";
                                str_html += "<th nowrap='nowrap'>異動日期</th>";
                                str_html += "<th nowrap='nowrap'>異動項目名稱</th>";
                                str_html += "<th nowrap='nowrap'>異動前</th>";
                                str_html += "<th nowrap='nowrap'>異動後</th>";
                                str_html += "<th nowrap='nowrap'>確認日</th>";
                                str_html += "<th nowrap='nowrap'>確認者名稱</th>";
                                str_html += "<th nowrap='nowrap'>狀態</th>";
                                str_html += "<th nowrap='nowrap'>備註</th>";
                                str_html += "</tr>";
                                str_html += "</thead>";
                                str_html += "<tbody>";
                                for (var i = 0; i < response.length; i++) {
                                    str_html += "<tr trguid='" + response[i].pcGuid + "'>";
                                    str_html += "<td align='center' nowrap='nowrap' class='font-normal'><a href='javascript:void(0);' name='del_person_a' aguid='" + response[i].pcGuid + "'>刪除</a></td>";
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
                                load_thispeopledata(response[0].perNo);
                            }
                            if (response[0].pcChangeName == "02") {
                                $("#hidden_end").val(response[0].pcChangeEnd);
                                $("#td_person_before").append("<select id='select_before' disabled></select>");
                                $("#td_person_after").append("<select id='select_after'></select>");
                                call_prodata();
                                load_thispeopledata(response[0].perNo);
                            }
                            if (response[0].pcChangeName == "03" || response[0].pcChangeName == "04" || response[0].pcChangeName == "05") {
                                $("#td_person_before").append("<input type='text' id='select_before' class='inputex width60' maxlength='50' />");
                                $("#td_person_after").append("<input type='text' id='select_after' class='inputex width60' maxlength='50' />");
                                $("#select_before").val(response[0].pcChangeBegin);
                                $("#select_after").val(response[0].pcChangeEnd);
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
                            $("#txt_person_chkdate").val(response[0].pcVenifyDate);
                            $("#txt_person_chkpeople").val(response[0].pcVenify);
                            $("input[name='txt_person_status'][value='" + response[0].pcStatus + "']").prop("checked", true);
                            $("#txt_person_ps").val(response[0].pcPs);
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
            function mod_persondata(){
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
                                if ($("#span_person_Status").text()=="新增") {
                                    alert("新增成功");
                                }else{
                                    alert("修改成功");
                                }
                                $("#search_person_keyword").val("");
                                $("#search_person_date").val("");
                                $("input[name='search_person_status']").removeAttr("checked");
                                call_personchangedata();
                            }
                        },//success end
                        complete: function () {
                            $.unblockUI();
                        }
                    });//ajax end
                }
            }
            //dovument);
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
                            if(response!="error"){
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
            //取的該員工號碼的資料
            function load_thispeopledata(thisno){
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../handler/pageModify.ashx",
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
                        var str_html = "";
                        if (response != "nodata") {
                            if ($("#txt_person_change_pro").val()=="01") {
                                $("#select_before").empty();
                                $("#select_before").append("<option value='" + response[0].perDep + "'>" + response[0].cbName + "</option>");
                            }
                            else if ($("#txt_person_change_pro").val() == "02") {
                                $("#select_before").empty();
                                $("#select_before").append("<option value='" + response[0].perPosition + "'>" + response[0].PositionName + "</option>");
                            }
                            else if ($("#txt_person_change_pro").val() == "04") {
                                $("#td_person_before").empty();
                                $("#td_person_before").append("<input type='text' id='select_before' class='inputex width60' maxlength='50' value='" + response[0].perFirstDate + "' readonly />");
                            }
                            else {
                                $("#txt_person_empno").val(response[0].perNo);
                                $("#txt_person_cname").text(response[0].perName);
                                $("#txt_hidden_person_guid").val(response[0].perGuid);
                            }
                        } else {
                            $("#txt_person_cname").text("無資料");
                            $("#txt_hidden_person_guid").val("");
                        }
                    },//success end
                    complete: function () {
                        $.unblockUI();
                    }
                });//ajax end
            }
            //檢查人事異動 新增/修改 欄位
            function chk_person_moddata(){
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
                if (chk_empno == "" || chk_cname == "" || chk_person_guid == "" || chk_cname=="無資料") {
                    alert("請輸入或挑選一個正確人員");
                    return false;
                }
                if (chk_change_date=="") {
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
                if (chk_chkdate == "" || chk_chkpeople=="") {
                    alert("請重新登入");
                    return false;
                }
                if (chk_status == undefined) {
                    alert("請選擇狀態");
                    return false;
                }
                return true;
            }
        });
        //點放大鏡 查詢視窗
        function openfancybox(item) {
            link = "SearchWindow.aspx?v=Personnel";
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
        function setReturnValue(gv, pno, pname) {
            $("#txt_person_empno").val(pno);
            $("#txt_person_cname").text(pname);
            $("#txt_hidden_person_guid").val(gv);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
                    <li><a href="#tabs-1">人事異動</a></li>
                    <li><a href="#tabs-2">薪資異動</a></li>
                </ul>
                <div id="tabs-1">
                    <div class="twocol margin15T" id="div_people_btn">
                        <!--<div class="left">
                            <a href="#" class="keybtn fancybox">匯出</a>
                            <select id="ddl_person" >
                                <option value="continue">續保</option>
                                <option value="comeback">復職</option>
                            </select>
                        </div>-->
                        <div class="right">
                            <span id="span_person_search">
                                關鍵字：<input id="search_person_keyword" />&nbsp;&nbsp;
                                異動日期：<input id="search_person_date" maxlength="10" />
                                狀態：<select id="search_person_status"><option value="">--請選擇--</option><option value="0">待確認</option><option value="1">已確認</option></select>
                                <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_person_inner_search">查詢</a>
                            </span>
                            <a href="Javascript:void(0)" class="keybtn fancybox" id="btn_person_search">查詢</a>
                            <a href="Javascript:void(0)" class="keybtn" id="btn_person_add">新增</a>
                        </div>
                    </div>
                    <br />
                    <div class="tabfixwidth" style="overflow: auto;" name="div_person_data">
                        <div class="stripeMe fixTable" style="max-height: 175px;">
                            <table id="div_person_list" width="100%" border="0" cellspacing="0" cellpadding="0"></table>
                        </div>
                        <!-- overwidthblock -->
                    </div>
                    <!-- fixwidth END-->
                    <br />
                    <div class="twocol margin15T" name="div_person_data">
                        <div class="right">
                            <a href="Javascript:void(0)" id="btn_person_submit" class="keybtn fancybox">儲存</a>
                        </div>
                    </div>
                    <div class="tbsfixwidth" style="margin-top: 20px;" name="div_person_data">
                        <div class="statabs margin10T">
                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="div_person">
                                    <tr>
                                        <td align="right" colspan="6">
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
                                            <img id="Pbox" onclick="openfancybox(this)" src="<%= ResolveUrl("~/images/btn-search.gif") %>" style="cursor:pointer;" />
                                            <span id="txt_person_cname"></span>
                                            <span id="txt_hidden_person_guid" style="display:none;"></span>
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
                                        <td class="width25" id="td_person_before">
                                            
                                        </td>
                                        <td class="width10" align="right">
                                            <div class="font-title titlebackicon" style="color: Red">異動後</div>
                                        </td>
                                        <td class="width20" id="td_person_after">
                                            
                                        </td>
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
                                            <input type="text" class="inputex" maxlength="200" id="txt_person_chkdate" readonly />
                                        </td>
                                        <td align="right">
                                            <div class="font-title titlebackicon">確認者</div>
                                        </td>
                                        <td>
                                            <input type="text" class="inputex" maxlength="200" id="txt_person_chkpeople" readonly />
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

                </div>
                <input type="text" style="display:none;" id="hidden_pcguid" />
                <input type="text" style="display:none;" id="hidden_end" />
                <!-- tabs-1 -->

                <div id="tabs-2">
                    
                </div>
                <input type="text" style="display:none;" id="hidden_sr_guid" />
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

