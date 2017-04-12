<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-regionadmin.aspx.cs" Inherits="webpage_page_regionadmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="WrapperMain">
            <div class="fixwidth">

                <div class="twocol underlineT1 margin10TB">
                    <div class="left font-light">首頁 / 系統設定 /<span class="font-black font-bold">分店管理</span></div>
                </div>

                
            <div class="fixwidth" id="div_Search">
                <br /><br />
                <table>
                    <tr>
                        <th><div class="font-title titlebackicon">代碼</div></th>
                        <td><input type="text" class="inputex width95" id="txt_Search_cbValue"/></td>
                        <td style="width:10px"></td>
                        <th><div class="font-title titlebackicon">分店</div></th>
                        <td><input type="text" class="inputex width95" id="txt_Search_cbName" /></td>
                        <td style="width:10px"></td>
                        <td><a href="Javascript:void(0)" onclick="JsEven.List()" class="keybtn">查詢</a></td>
                    </tr>
                </table>

            </div>
                 <div class="fixwidth" id="div_DataList">
                <div class="twocol margin15TB">
                    <div class="right">
                        <a href="Javascript:void(0)" onclick="JsEven.Search()" class="keybtn">查詢</a>
                        <a href="Javascript:void(0)" onclick="JsEven.Ins()" class="keybtn fancybox">新增分店</a>
                    </div>
                </div>
                <br />
                <div class="fixwidth" >
                <div class="stripeMe fixTable" style="max-height:175px; " id="div_List"></div>                 
            </div><!-- fixwidth -->
            </div><!-- fixwidth -->  
            <div class="fixwidth">
                <div class="twocol margin15TB">
                    <div class="right">
                        <a href="Javascript:void(0)" onclick="JsEven.Save()" class="keybtn">儲存</a>
                    </div>
                </div>
            </div>
                <div class="fixwidth" style="margin-top:20px;">
                    <div class="statabs margin10T">
                        <div >
                            <div style="text-align:right;color:#8b3c31;padding:20px 35px 20px 0">維護狀態：<span id="span_Status">新增</span></div>
                        </div>
                        
                        
                        <div class="gentable ">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb_Data">
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">代碼</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_cbValue" /></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">分店</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_cbName" /></td>
                                    <td align="right"><div class="font-title titlebackicon" >說明</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_cbDesc" /></td>
                                </tr>
                            </table>
                        </div>
                        <br /><br />
                    </div>
                    
                </div>
                </div>

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

                txt_Search_cbValue:'txt_Search_cbValue', //查詢 代碼
                txt_Search_cbName: 'txt_Search_cbName', //查詢 店名

                txt_cbValue: 'txt_cbValue', //代碼
                txt_cbName: 'txt_cbName', //店名
                txt_cbDesc: 'txt_cbDesc' //說明

                
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
            },

            List:function() {

                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var txt_Search_cbValue = $('#' + this.id.txt_Search_cbValue).val();
                var txt_Search_cbName = $('#' + this.id.txt_Search_cbName).val();
                var hid_EditType = $('#' + this.id.hid_EditType).val();
                var opt = {
                    url: '../handler/ashx_Regionadmin_List.ashx',
                    v: 'cbValue=' + txt_Search_cbValue +
                       '&cbName=' + txt_Search_cbName,
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
                                    CmFmCommon.Xsl(xmldoc, '../xslt/xsl_Regionadmin_List.xsl', div);
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
                    url: '../handler/ashx_Regionadmin_Edit.ashx',
                    v: 'cbGuid=' + id,
                    type: 'xml',
                    success: function (xmldoc) {

                        var View = xmldoc.getElementsByTagName('dView');
                        if (View.length == 1) {
                            var e = View[0];

                            $('#' + JsEven.id.txt_cbValue).val(CommonEven.XmlNodeGetValue(e, "cbValue"));
                            $('#' + JsEven.id.txt_cbName).val(CommonEven.XmlNodeGetValue(e, "cbName"));
                            $('#' + JsEven.id.txt_cbDesc).val(CommonEven.XmlNodeGetValue(e, "cbDesc"));
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

                var txt_cbValue = $('#' + this.id.txt_cbValue).val();
                var txt_cbName = $('#' + this.id.txt_cbName).val();
                var txt_cbDesc = $('#' + this.id.txt_cbDesc).val();

                //驗證
                if (CheckFormat.CheckInt('txt_cbValue') == false) {
                    return false;
                }
                
                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                if (txt_cbValue != '' && txt_cbName != '') {
                    if (txt_cbValue.length < 10) {
                        var opt = {
                            url: '../handler/ashx_Regionadmin_SaveData.ashx',
                            v: 'cbGuid=' + GUID +
                               '&EditType=' + EditType +
                               '&cbValue=' + txt_cbValue +
                               '&cbName=' + txt_cbName +
                               '&cbDesc=' + txt_cbDesc,

                            type: 'text',
                            success: function (msg) {
                                switch (msg) {
                                    case "Timeout":
                                        alert("請重新登入");
                                        window.location.href = "index.aspx";
                                        break;
                                    case "sign":
                                        alert("請勿輸入特殊符號");
                                        break;
                                    case "error":
                                        alert("程式發生錯誤，儲存失敗");
                                        break;
                                    case "repeat":
                                        alert("代碼重複");
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
                        alert('代碼長度不得超過10碼！');
                        $.unblockUI();
                    }
                    
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
                    url: '../handler/ashx_Regionadmin_SaveData.ashx',
                    v: 'cbGuid=' + id +
                       '&EditType=' + 'Del',
                    type: 'text',
                    success: function (msg) {
                        switch (msg) {
                            //case "Timeout":
                            //    alert("請重新登入");
                            //    window.location.href = "index.aspx";
                            //    break;
                            //case "sign":
                            //    alert("請勿輸入特殊符號");
                            //    break;
                            case "error":
                                alert("刪除失敗");
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
            //JsEven.opBind();
            JsEven.List();
            $('#' + JsEven.id.hid_EditType).val('Ins');
            //document.getElementById('div_Edit').style.display = 'none';
            document.getElementById('div_DataList').style.display = '';
            document.getElementById('div_Search').style.display = 'none';
        };
    </script>
</asp:Content>

