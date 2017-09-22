<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Competence.aspx.cs" Inherits="webpage_page_Competence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="WrapperMain">
 
            <div class="fixwidth"> 
                <div class="twocol underlineT1 margin10T">
                    <div class="left font-light">首頁 / 系統設定 /  管理者資料管理 /<span class="font-black font-bold">角色管理</span></div>
                </div>

                <div class="fixwidth" id="div_Search">
                <br /><br />
                <table>
                    <tr>
                        <th><div class="font-title titlebackicon">角色名稱</div></th>
                        <td><select id="ddlist_MemberCom"></select></td>                        
                        <td><a href="Javascript:void(0)" onclick="JsEven.List()" class="keybtn">查詢</a></td>
                    </tr>
                </table>

            </div>

                <div class="twocol margin15T" id="div_DataList">
                    <div class="right">
                        <a href="Javascript:void(0)" onclick="JsEven.Ins()" class="keybtn">新增</a>
                        <a href="Javascript:void(0)" onclick="JsEven.Search()" class="keybtn fancybox">查詢人員</a>
                    </div>
                </div>
            </div>
            <br /><br />
            <div class="fixwidth">

                <div class="stripeMe fixTable" style="max-height:175px; " id="div_List"></div>                 
                
                </div><!-- overwidthblock -->

            </div><!-- fixwidth -->
            <div class="fixwidth" style="margin-top:20px;">
                <div class="twocol margin15TB">
                    <div class="right">
                        <a href="Javascript:void(0)" onclick="JsEven.Save()" class="keybtn">儲存</a>
                    </div>
                </div>
            </div>
                <div class="fixwidth" style="margin-top:20px;"><!-- 詳細資料start -->                    
                    <div class="statabs margin10T">
                        <div class="gentable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb_Data">
                                
                                <tr>
                                    <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">角色名稱</div></td>
                                    <td class="width13"><input type="text" class="inputex width95" id="txt_cmName"/></td>
                                    <td class="width10" align="right"><div class="font-title titlebackicon" >備註</div></td>
                                    <td class="width13"><input type="text" class="inputex width95" id="txt_cmDesc"/></td>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">維護狀態</div></td>
                                    <td class="width13">
                                        <span id="span_Status">新增</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">權限</div></td>
                                    <td id="td_com">
                                        <%--<input type="checkbox" /><span class="font-title ">基本資料管理</span><br />
                                        <input type="checkbox" /><span class="font-title ">保險管理</span><br />
                                        <input type="checkbox" /><span class="font-title ">異動管理</span><br />
                                        <input type="checkbox" /><span class="font-title ">時數管理</span><br />
                                        <input type="checkbox" /><span class="font-title ">津貼管理</span><br />
                                        <input type="checkbox" /><span class="font-title ">時數管理</span><br />
                                        <input type="checkbox" /><span class="font-title ">薪資管理</span><br />                                          
                                        <input type="checkbox" /><span class="font-title ">出勤管理</span><br />
                                        <input type="checkbox" /><span class="font-title ">報表輸出管理</span><br />
                                        <input type="checkbox" /><span class="font-title ">統計查詢</span><br />
                                        <input type="checkbox" /><span class="font-title ">公司資料設定</span><br />
                                        <input type="checkbox" /><span class="font-title ">管理者資料管理</span><br />
                                        <input type="checkbox" /><span class="font-title ">分店管理</span><br />
                                        <input type="checkbox" /><span class="font-title ">行事曆管理設定</span><br />
                                        <input type="checkbox" /><span class="font-title ">薪資管理設定</span><br />
                                        <input type="checkbox" /><span class="font-title ">保險管理設定</span><br /> --%>                           
                                    </td>
                                </tr> 

                            </table>
                        </div>
                    </div><!-- statabs -->    
                </div><!-- fixwidth -->



    <input id="hid_id" type="hidden" />
    <input id="hid_EditType" type="hidden" />
    <script type="text/javascript">

        JsEven = {
            id: {
                hid_id: 'hid_id',
                hid_EditType: 'hid_EditType',
                div_List: 'div_List', //div_List
                tbl_List: 'tbl_List', //tbl_List
                div_Edit: 'div_Edit',//編輯區塊
                div_DataList: 'div_DataList', //List區塊
                div_Search: 'div_Search', //查詢區塊
                span_Status: 'span_Status', //狀態
                tb_Data: 'tb_Data', //主資料tb

                ddlist_MemberCom: 'ddlist_MemberCom', //查詢 角色名稱

                txt_cmName: 'txt_cmName', //角色名稱
                txt_cmDesc: 'txt_cmDesc', //備註
                //權限
                td_com: 'td_com'
            },

         
            ComOpion: function () {
                $.ajax({
                    type: "POST",
                    url: '../handler/ashx_CodeTable.ashx',
                    data: 'Class=' + 'MemberGroup',
                    dataType: 'json',  //xml, json, script, text, html
                    success: function (Json) {
                        var td = document.getElementById(JsEven.id.td_com);
                        var html = "";
                        for (i = 0; i < Json.length; i++) {
                            html += "<input type='checkbox' class='font-title titlebackicon' code='" + Json[i].Value + "' /><span>" + Json[i].Text + "</span><br />";
                        }
                        td.innerHTML = html;
                    },
                    error: function (xhr, statusText) {
                        alert('資料發生錯誤');
                    }
                });
            },

            Ins: function () {
                //window.location.href = "page-company.aspx?type=I";
                $('#' + JsEven.id.hid_EditType).val('Ins');
                //document.getElementById('div_Edit').style.display = '';
                document.getElementById('div_DataList').style.display = '';
                document.getElementById('div_Search').style.display = 'none';
                LicEven.ClearInput('tb_Data');
                this.clearTd();
                $('#' + JsEven.id.span_Status).html('新增');


            },

            Search: function () {
                $('#' + JsEven.id.hid_EditType).val('Search');
                document.getElementById('div_Search').style.display = '';
                document.getElementById('div_DataList').style.display = 'none';
                //LicEven.ClearInput('tb_Data');
                $('#' + JsEven.id.span_comStatus).html('新增');
                //帶入 角色名稱
                LicEven.SelType("MemberCom", function (Json) {
                    LicEven.addOp(JsEven.id.ddlist_MemberCom, Json);
                });
            },

            List: function () {

                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var ddlist_MemberCom = $('#' + this.id.ddlist_MemberCom).val();
                if (ddlist_MemberCom == null) {
                    ddlist_MemberCom = '';
                }
                var hid_EditType = $('#' + this.id.hid_EditType).val();
                var opt = {
                    url: '../handler/ashx_Competence_List.ashx',
                    v: 'cmClass=' + ddlist_MemberCom,
                    type: 'xml',
                    success: function (xmldoc) {

                        var msg = CommonEven.XmlNodeGetValue(xmldoc, "dList");
                        switch (msg) {
                            case "error":
                                alert('資料發生錯誤，請聯絡管理人員');
                                break;
                            default:
                                var div = document.getElementById(JsEven.id.div_List);
                                var dList = xmldoc.getElementsByTagName('dList');
                                var dView = xmldoc.getElementsByTagName('dView');
                                if (dView.length == 0) {
                                    div.innerText = "您所查詢條件無任何資料";
                                }
                                else {
                                    CmFmCommon.Xsl(xmldoc, '../xslt/xsl_Competence_List.xsl', div);
                                    //GenSort(JsEven.id.tbl_List);
                                    LicEven.tblClass();
                                    document.getElementById('div_DataList').style.display = '';
                                    document.getElementById('div_Search').style.display = 'none';
                                }
                                $(".fixTable").tableHeadFixer();
                                break;

                        }
                        $.unblockUI();
                    }
                }
                CmFmCommon.ajax(opt);
            },

            //儲存
            Save: function () {

                var GUID = $('#' + this.id.hid_id).val();
                var EditType = $('#' + this.id.hid_EditType).val();
                var txt_cmName = $('#' + this.id.txt_cmName).val();
                var txt_cmDesc = $('#' + this.id.txt_cmDesc).val();
               
                var td = document.getElementById(this.id.td_com);
                var chk = td.getElementsByTagName("input");
                var comVal = "";
                for (var i = 0; i < chk.length; i++)
                {
                    var c= chk[i];
                    if(c.getAttribute('type')=="checkbox")
                    {
                        if (c.checked == true)
                            comVal += c.getAttribute('code') + ",";
                    }

                }
                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                if (txt_cmName != '' && comVal !='') {
                    var opt = {
                        url: '../handler/ashx_Competence_SaveData.ashx',
                        v: 'cmClass=' + GUID +
                           '&EditType=' + EditType +
                           '&cmName=' + txt_cmName +
                           '&cmDesc=' + txt_cmDesc+
                           '&comVal=' + comVal,
                        type: 'text',
                        success: function (msg) {
                            switch (msg) {
                                case "t":
                                    alert("請重新登入");
                                    CommonEven.goLogin();
                                    break;
                                case "sign":
                                    alert("請勿輸入特殊符號");
                                    CommonEven.goErrorPage();
                                    break;
                                case "e":
                                    alert("程式發生錯誤，儲存失敗");
                                    break;
                                case "repeat":
                                    alert("帳號已存在");
                                    break;
                                default:
                                    alert("儲存成功");
                                    //$('#' + JsEven.id.hid_id).val(msg);
                                    //$('#' + JsEven.id.hid_EditType).val('Ins');
                                    //JsEven.init($('#' + JsEven.id.hid_Page).val());
                                    JsEven.List();
                                    break;
                            }
                            $.unblockUI();
                        }
                    }
                    CmFmCommon.ajax(opt);

                } else {
                    alert('紅字欄位為必填，不得空白！');
                    $.unblockUI();

                }
            },

            Edit: function (id) {
                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var opt = {
                    url: '../handler/ashx_Competence_Edit.ashx',
                    v: 'cmClass=' + id,
                    type: 'xml',
                    success: function (xmldoc) {

                        var View = xmldoc.getElementsByTagName('dView');
                        if (View.length == 1) {
                            var e = View[0];

                            $('#' + JsEven.id.txt_cmName).val(CommonEven.XmlNodeGetValue(e, "cmName"));
                            $('#' + JsEven.id.txt_cmDesc).val(CommonEven.XmlNodeGetValue(e, "cmDesc"));                           
                            $('#' + JsEven.id.span_Status).html('修改');
                            JsEven.clearTd();
                            var cmVal = CommonEven.XmlNodeGetValue(e, "cmCompetence");
                            cmVal = cmVal.split(',');
                            var td = document.getElementById(JsEven.id.td_com);
                            var chk = td.getElementsByTagName('input');
                            for(var i=0;i<cmVal.length;i++)
                            {
                                var cV = cmVal[i];
                                for (var j = 0; j < chk.length;j++)
                                {
                                    if (chk[j].getAttribute('code') == cV)
                                        chk[j].checked = true;
                                }
                            }
                        }
                        $.unblockUI();
                        CommonEven.setValue(JsEven.id.hid_EditType, "Up");
                        CommonEven.setValue(JsEven.id.hid_id, id);

                    }
                }
                CmFmCommon.ajax(opt);

            },


            View: function (a) {
                var guid = a.getAttribute('guid');
                //$('#' + JsEven.id.hid_EditType).val('Up');
                //$('#' + JsEven.id.hid_id).val(guid);
                JsEven.Edit(guid);
                //alert(guid);

            },
            Del: function (a) {
                //if (confirm("刪除後無法復原，您確定要刪除??")) {
                var EditType = $('#' + this.id.hid_EditType).val();
                var id = a.getAttribute('guid');
                var opt = {
                    url: '../handler/ashx_Competence_SaveData.ashx',
                    v: 'cmClass=' + id +
                       '&EditType=' + 'Del',
                    type: 'text',
                    success: function (msg) {
                        switch (msg) {
                            case "t":
                                alert("請重新登入");
                                CommonEven.goLogin();
                                break;
                            case "sign":
                                alert("請勿輸入特殊符號");
                                CommonEven.goErrorPage();
                                break;
                            case "e":
                                alert("程式發生錯誤，儲存失敗");
                                break;
                            default:
                                alert("刪除成功");
                                //$('#' + JsEven.id.hid_id).val(msg);
                                //$('#' + JsEven.id.hid_EditType).val('Ins');
                                //JsEven.init($('#' + JsEven.id.hid_Page).val());
                                JsEven.List();
                                break;
                        }
                    }
                }
                CmFmCommon.ajax(opt);
            },

            clearTd: function () {
                var td = document.getElementById(JsEven.id.td_com);
                var chk = td.getElementsByTagName('input');
                for (var i = 0; i < chk.length; i++) {
                    var c = chk[i];
                    if (c.getAttribute('type') == "checkbox")
                        c.checked = false;
                }
            }

        }


        document.body.onload = function () {
            JsEven.ComOpion();
            JsEven.List();
            $('#' + JsEven.id.hid_EditType).val('Ins');

            document.getElementById('div_DataList').style.display = '';
            document.getElementById('div_Search').style.display = 'none';
        };
    </script>
</asp:Content>

