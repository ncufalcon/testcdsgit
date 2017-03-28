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
            $("#txt_person_change_date").datetimepicker({
                format: 'Y/m/d',//'Y-m-d H:i:s'
                timepicker: false,    //false關閉時間選項 
                defaultDate: false
            });
            //人事異動 一開始預設確認日是今天 確認者是操作者
            var today_ymd = get_datenow();
            var now_user = "王胖爺";//目前還沒有登入這塊 先寫死
            $("#txt_person_chkdate").val(today_ymd);
            $("#txt_person_chkpeople").val(now_user);

            call_changedata();
            call_personchangedata();

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
                call_changedata();
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
            });

            //人事異動 異動項目下拉選單chaange
            $("#txt_person_change_pro").change(function () {
                var str_sel_html = "";
                var change_type = $(this).val();//01部門調動 02職務異動 03留職停薪 04離職
                if (change_type == "01") {
                    $("#td_person_before,#td_person_after").empty();
                    //塞下拉選單 撈分店代碼檔
                    $("#td_person_before").append("<select id='select_before_store'></select>");
                    $("#td_person_after").append("<select id='select_after_store'></select>");
                    call_storedata();
                }
                if (change_type == "02") {
                    $("#td_person_before,#td_person_after").empty();
                    //塞下拉選單 撈職務代碼檔
                    str_sel_html += "<select><option value=''>撈職務代碼檔</option></select>";
                    $("#td_person_before,#td_person_after").append(str_sel_html);
                }
                if (change_type == "03") {
                    $("#td_person_before,#td_person_after").empty();
                    //塞下拉選單 撈職務代碼檔
                    $("#td_person_before").append("<input type='text' id='txt_person_before' class='inputex width60' maxlength='50' />");
                    $("#td_person_after").append("<input type='text' id='txt_person_before' class='inputex width60' maxlength='50' />");
                }
                if (change_type == "04") {
                    $("#td_person_before,#td_person_after").empty();
                    //塞下拉選單 撈職務代碼檔
                    $("#td_person_before").append("<input type='text' id='txt_person_before' class='inputex width60' maxlength='50' />");
                    $("#td_person_after").append("<input type='text' id='txt_person_before' class='inputex width60' maxlength='50' />");
                }
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
                                str_html += "<option value='" + response[i].cbGuid + "'>" + response[i].cbName + "</option>";
                            }
                        }
                        $("#select_after_store").append(str_html);
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
                                狀態：<select id="search_person_status"><option value="">--請選擇--</option><option value="N">待確認</option><option value="Y">已確認</option></select>
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
                <input type="text" style="display:none;" id="hidden_person_guid" />
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

