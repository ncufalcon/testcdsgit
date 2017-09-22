<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-admin.aspx.cs" Inherits="webpage_page_admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="WrapperMain">
 
            <div class="fixwidth">
                <div class="twocol underlineT1 margin10T">
                    <div class="left font-light">首頁 / 系統設定 /  管理者資料管理 /<span class="font-black font-bold">管理者資料</span></div>
                </div>
                <div class="fixwidth" id="div_Search">
                <br /><br /> 
                <table>
                    <tr>
                        <th><div class="font-title titlebackicon">姓名</div></th>
                        <td><input type="text" class="inputex width95" id="txt_Search_mbName"/></td>
                        <td style="width:10px"></td>
                        <th><div class="font-title titlebackicon">工號</div></th>
                        <td><input type="text" class="inputex width95" id="txt_Search_mbJobNumber" /></td>
                        <td style="width:10px"></td>
                        <th><div class="font-title titlebackicon">角色</div></th>
                        <td><select id="ddlist_Search_mbCom"></select></td>
                        <td><a href="Javascript:void(0)" onclick="JsEven.List()" class="keybtn">查詢</a></td>
                    </tr>
                </table>

            </div>
                <div class="fixwidth" id="div_DataList">
                <div class="twocol margin15T">
                    <div class="right">
                        <a href="Javascript:void(0)" onclick="JsEven.Ins()" class="keybtn">新增</a>
                        <a href="Javascript:void(0)" onclick="JsEven.Search()" class="keybtn fancybox">查詢人員</a>
                    </div>
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
                                    <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">姓名</div></td>
                                    <td class="width20"><input type="text" class="inputex width95" id="txt_mbName" value="" /></td>
                                    <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">工號</div></td>
                                    <td class="width20"><input type="text" class="inputex width95" id="txt_mbJobNumber" value="" /></td>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">維護狀態</div></td>
                                    <td class="width20">
                                        <span id="span_Status">新增</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">帳號</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_mbId" value="" /></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">密碼</div></td>
                                    <td><input type="password" autocomplete="off" maxlength="20" class="inputex width95" id="txt_mbPassword" value="" /></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">角色</div></td>
                                    <td><select id="ddlist_Member">
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">備註</div></td>
                                    <td colspan="5"><input type="text" class="inputex width99" id="txt_mbPs"/></td>
                                </tr>

                            </table>
                        </div>
                    </div><!-- statabs -->    
                </div><!-- fixwidth -->


        </div><!-- WrapperMain -->
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

                txt_Search_mbName:'txt_Search_mbName', //查詢 姓名
                txt_Search_mbJobNumber: 'txt_Search_mbJobNumber', //查詢 工號
                ddlist_Search_mbCom: 'ddlist_Search_mbCom', //查詢 角色

                txt_mbName: 'txt_mbName', //姓名
                txt_mbJobNumber: 'txt_mbJobNumber', //工號
                txt_mbId: 'txt_mbId', //帳號
                txt_mbPassword: 'txt_mbPassword', //密碼
                ddlist_Member: 'ddlist_Member', //角色
                txt_mbPs: 'txt_mbPs' //備註
            },
            opBind: function () {
                //角色
                LicEven.SelType("Member", function (Json) {
                    LicEven.addOp(JsEven.id.ddlist_Member, Json);
                });
                
            },

            Ins: function () {
                //window.location.href = "page-company.aspx?type=I";
                $('#' + JsEven.id.hid_EditType).val('Ins');
                //document.getElementById('div_Edit').style.display = '';
                document.getElementById('div_DataList').style.display = '';
                document.getElementById('div_Search').style.display = 'none';
                LicEven.ClearInput('tb_Data');
                $('#' + JsEven.id.span_Status).html('新增');

            },

            Search: function () {
                $('#' + JsEven.id.hid_EditType).val('Search');
                document.getElementById('div_Search').style.display = '';
                document.getElementById('div_DataList').style.display = 'none';
                LicEven.ClearInput('tb_Data');
                $('#' + JsEven.id.span_comStatus).html('新增');
                //查詢 角色
                LicEven.SelType("Member", function (Json) {
                    LicEven.addOp(JsEven.id.ddlist_Search_mbCom, Json);
                });
            },

            List: function () {

                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var txt_Search_mbName = $('#' + this.id.txt_Search_mbName).val();
                var txt_Search_mbJobNumber = $('#' + this.id.txt_Search_mbJobNumber).val();
                var ddlist_Search_mbCom = $('#' + this.id.ddlist_Search_mbCom).val();
                if (ddlist_Search_mbCom == null) {
                    ddlist_Search_mbCom = '';
                }
                var hid_EditType = $('#' + this.id.hid_EditType).val();
                var opt = {
                    url: '../handler/ashx_Admin_List.ashx',
                    v: 'mbName=' + txt_Search_mbName +
                       '&mbJobNumber=' + txt_Search_mbJobNumber +
                       '&mbCom=' + ddlist_Search_mbCom,
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
                                    CmFmCommon.Xsl(xmldoc, '../xslt/xsl_Admin_List.xsl', div);
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

            Edit: function (id) {
                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var opt = {
                    url: '../handler/ashx_Admin_Edit.ashx',
                    v: 'mbGuid=' + id,
                    type: 'xml',
                    success: function (xmldoc) {

                        var View = xmldoc.getElementsByTagName('dView');
                        if (View.length == 1) {
                            var e = View[0];
                            
                            $('#' + JsEven.id.txt_mbName).val(CommonEven.XmlNodeGetValue(e, "mbName"));
                            $('#' + JsEven.id.txt_mbJobNumber).val(CommonEven.XmlNodeGetValue(e, "mbJobNumber"));
                            $('#' + JsEven.id.txt_mbId).val(CommonEven.XmlNodeGetValue(e, "mbId"));

                            $('#' + JsEven.id.txt_mbPassword).val(CommonEven.XmlNodeGetValue(e, "mbPassword"));
                            $('#' + JsEven.id.ddlist_Member).val(CommonEven.XmlNodeGetValue(e, "mbCom"));
                            $('#' + JsEven.id.txt_mbPs).val(CommonEven.XmlNodeGetValue(e, "mbPs"));

                            $('#' + JsEven.id.span_Status).html('修改');
                        }
                        $.unblockUI();
                        CommonEven.setValue(JsEven.id.hid_EditType, "Up");
                        CommonEven.setValue(JsEven.id.hid_id, id);

                    }
                }
                CmFmCommon.ajax(opt);

            },

            //儲存
            Save: function () {

                var GUID = $('#' + this.id.hid_id).val();

                var EditType = $('#' + this.id.hid_EditType).val();

                var txt_mbName = $('#' + this.id.txt_mbName).val();
                var txt_mbJobNumber = $('#' + this.id.txt_mbJobNumber).val();
                var txt_mbId = $('#' + this.id.txt_mbId).val();
                var txt_mbPassword = $('#' + this.id.txt_mbPassword).val();
                var ddlist_Member = $('#' + this.id.ddlist_Member).val();
                var txt_mbPs = $('#' + this.id.txt_mbPs).val();

                //驗證
                if (CheckFormat.CheckIntAndE('txt_mbJobNumber') == false) {
                    return false;
                }
                if (CheckFormat.CheckIntAndE('txt_mbPassword') == false) {
                    return false;
                }
                if (CheckFormat.CheckIntAndE('txt_mbId') == false) {
                    return false;
                }

                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                if (txt_mbName != '' && txt_mbJobNumber != '' && txt_mbId != '' && txt_mbPassword != '' && ddlist_Member != '' && ddlist_Member != null) {
                        var opt = {
                            url: '../handler/ashx_Admin_SaveData.ashx',
                            v: 'mbGuid=' + GUID +
                               '&EditType=' + EditType +
                               '&mbName=' + txt_mbName +
                               '&mbJobNumber=' + txt_mbJobNumber +
                               '&mbId=' + txt_mbId +
                               '&mbPassword=' + txt_mbPassword +
                               '&mbCom=' + ddlist_Member +
                               '&mbPs=' + txt_mbPs,

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
                    url: '../handler/ashx_Admin_SaveData.ashx',
                    v: 'mbGuid=' + id +
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
            }
        }

        document.body.onload = function () {
            JsEven.opBind();
            JsEven.List();
            $('#' + JsEven.id.hid_EditType).val('Ins');

            document.getElementById('div_DataList').style.display = '';
            document.getElementById('div_Search').style.display = 'none';
        };
    </script>
</asp:Content>

