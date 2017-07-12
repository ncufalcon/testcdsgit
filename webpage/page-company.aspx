<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-company.aspx.cs" Inherits="webpage_page_company" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="WrapperMain">

            <div class="fixwidth">
                <div class="twocol underlineT1 margin10T">
                    <div class="left font-light">首頁 / 系統設定 / <span class="font-black font-bold">公司資料設定</span></div>
                </div>          
            </div>
            <br />
            <div class="fixwidth" id="div_Search">
                <br /><br />
                <table>
                    <tr>
                        <th><div class="font-title titlebackicon">申報公司</div></th>
                        <td><input type="text" class="inputex width95" id="txt_Search_coName"/></td>
                        <td style="width:10px"></td>
                        <th><div class="font-title titlebackicon">統一編號</div></th>
                        <td><input type="text" class="inputex width95" id="txt_Search_comUniform" /></td>
                        <td style="width:10px"></td>
                        <td><a href="Javascript:void(0)" onclick="JsEven.List()" class="keybtn">查詢</a></td>
                    </tr>
                </table>

            </div>
            

            <div class="fixwidth" id="div_DataList">
            <div class="twocol margin15T" style="height:35px">
               <div class="right">
                   <a href="Javascript:void(0)" onclick="JsEven.Ins()" class="keybtn">新增</a>
                   <a href="Javascript:void(0)" onclick="JsEven.Search()" class="keybtn">查詢</a>
               </div>
           </div>
            <div class="fixwidth" >
                <div class="stripeMe fixTable" style="max-height:175px; " id="div_List"></div>                 
            </div><!-- fixwidth -->
            <div class="fixwidth" id="div_Edit">
                <!-- 詳細資料start -->
                <div class="statabs margin10T">
                    <ul>
                        <li><a href="#tabs-1">基本資料</a></li>

                    </ul>
                    <div id="tabs-1">
                        <div class="twocol margin15T">
                   
                            <div class="right">
                                <a href="Javascript:void(0)" onclick="JsEven.Save()" class="keybtn fancybox">儲存</a>
                            </div>
                        </div>
                        <div class="gentable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb_Data">
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">申報公司</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_comName" /></td>
                                     <td align="right"><div class="font-title titlebackicon"></div></td>
                                    <td></td>  
                                      <td align="right"><div class="font-title titlebackicon">維護狀態</div></td>
                                    <td><span id="span_comStatus">新增</span></td>                                  
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">公司簡稱</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_comAbbreviate" /></td>
                                    <td align="right"><div class="font-title titlebackicon">營業人名稱</div></td>
                                    <td colspan="3"><input type="text" class="inputex width99" id="txt_comBusinessEntity"/></td>
                                </tr>
                                <tr>
                                    <td class="width15" align="right"><div class="font-title titlebackicon" style="color:Red">統一編號</div></td>
                                    <td class="width20"><input type="text" class="inputex width95" id="txt_comUniform" /></td>
                                    <td class="width17" align="right"><div class="font-title titlebackicon">營利事業稅籍編號</div></td>
                                    <td class="width20"><input type="text" class="inputex width95" id="txt_comBIT" /></td>
                                    <td class="width15"align="right"><div class="font-title titlebackicon">房屋稅籍編號</div></td>
                                    <td class="width20"><input type="text" class="inputex width95" id="txt_comHouseTax"/></td>
                 

                                </tr>
                                <tr>

                                    <td align="right"><div class="font-title titlebackicon">所屬國稅局分局</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_comNTB"/></td>
                                    <td align="right"><div class="font-title titlebackicon">所屬國稅局分局代號</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_comNTBCode"/></td>
                                    <td align="right"><div class="font-title titlebackicon">勞工保險業別代號</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_comLaborProtectionCode"/></td>
                                </tr>
                                <tr>
    
                                    <td align="right" style="display:none"><div class="font-title titlebackicon" >所屬縣市別代號</div></td>
                                    <td style="display:none">
                                        <select id="ddlist_comCity">

                                        </select>
                                    </td>
                                    <td align="right"><div class="font-title titlebackicon">健保投保單位代號</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_comHealthInsuranceCode"/></td>
                                    <td align="right"></td>
                                    <td></td>
                                </tr>
                                <tr>
  
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">負責人</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_comResponsible"/></td>
                                    <td class="width15" align="right"><div class="font-title titlebackicon">所屬國稅局</div></td>
                                    <td class="width20"><input type="text" class="inputex width95" id="txt_comNTA"/></td>

                                    <td class="width15" align="right"><div class="font-title titlebackicon">勞工保險證號</div></td>
                                    <td class="width20"><input type="text" class="inputex width60" id="txt_comLaborProtection1" />-<input type="text" class="inputex width15" id="txt_comLaborProtection2"/></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">電話號碼</div></td>
                                    <td><input type="text" class="inputex width95" id="txt_comTel" /></td>
                                </tr>

                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">營業地址(一)</div></td>
                                    <td colspan="5"><input type="text" class="inputex width99" id="txt_comAddress1"/></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">營業地址(二)</div></td>
                                    <td colspan="5"><input type="text" class="inputex width99" id="txt_comAddress2" /></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">備註</div></td>
                                    <td colspan="5"><input type="text" class="inputex width99" id="txt_comPs" /></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">E-Mail</div></td>
                                    <td colspan="5"><input type="text" class="inputex width99" id="txt_comMail" /></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">薪資轉存局號</div></td>
                                    <td ><input type="text" class="inputex width99" id="txt_comOfficeNumber" /></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">薪資轉存帳號</div></td>
                                    <td ><input type="text" class="inputex width99" id="txt_comAccountNumber"/></td>
                                </tr>
                            </table>
                        </div>
                        
                    </div><!-- tabs-1 -->

                </div><!-- statabs -->
                <!-- 詳細資料end -->
                <br /><br />
            </div><!-- fixwidth -->          
            </div>
        </div><!-- WrapperMain -->
    
    <input id="hid_id" type="hidden" />
    <input id="hid_EditType" type="hidden" />

    <script type="text/javascript">

        JsEven = {
            id: {
                hid_EditType: 'hid_EditType', //EditType
                hid_id: 'hid_id', //hid_id
                div_List: 'div_List', //div_List
                tbl_List: 'tbl_List', //tbl_List
                div_Edit: 'div_Edit',//編輯區塊
                div_DataList: 'div_DataList', //List區塊
                div_Search: 'div_Search', //查詢區塊
                span_comStatus: 'span_comStatus', //狀態
                tb_Data: 'tb_Data', //主資料tb

                txt_Search_coName: 'txt_Search_coName', //查詢 公司
                txt_Search_comUniform: 'txt_Search_comUniform', //查詢 統編

                txt_comName: 'txt_comName', //公司
                txt_comAbbreviate: 'txt_comAbbreviate', //公司簡稱
                txt_comUniform: 'txt_comUniform', //統編

                txt_comNTA: 'txt_comNTA', //所屬國稅局
                txt_comLaborProtection1: 'txt_comLaborProtection1', //勞工保險證號1
                txt_comLaborProtection2: 'txt_comLaborProtection2', //勞工保險證號2

                txt_comBIT: 'txt_comBIT', //營利事業稅籍編號
                txt_comNTB: 'txt_comNTB', //所屬國稅局分局
                txt_comNTBCode: 'txt_comNTBCode', //所屬國稅局分局代號
                txt_comLaborProtectionCode: 'txt_comLaborProtectionCode', //勞工保險業別代號

                txt_comHouseTax: 'txt_comHouseTax', //房屋稅籍編號
                ddlist_comCity: 'ddlist_comCity', //所屬縣市別代號
                txt_comHealthInsuranceCode: 'txt_comHealthInsuranceCode', //健保投保單位代號

                txt_comBusinessEntity: 'txt_comBusinessEntity', //營業人名稱
                txt_comResponsible: 'txt_comResponsible', //負責人
                txt_comTel: 'txt_comTel', //電話

                txt_comAddress1: 'txt_comAddress1', //營業地址1
                txt_comAddress2: 'txt_comAddress2', //營業地址2
                txt_comPs: 'txt_comPs', //備註

                txt_comMail: 'txt_comMail', //Email
                txt_comOfficeNumber: 'txt_comOfficeNumber', //薪資轉存局號
                txt_comAccountNumber: 'txt_comAccountNumber' //薪資轉存帳號

            },

            opBind: function () {
                //城市
                LicEven.SelType("City", function (Json) {
                    LicEven.addOp(JsEven.id.ddlist_comCity, Json);
                });

            },
            Ins: function () {
                //window.location.href = "page-company.aspx?type=I";
                $('#' + JsEven.id.hid_EditType).val('Ins');
                //document.getElementById('div_Edit').style.display = '';
                document.getElementById('div_DataList').style.display = '';
                document.getElementById('div_Search').style.display = 'none';
                LicEven.ClearInput('tb_Data');
                $('#' + JsEven.id.span_comStatus).html('新增');

            },

            Search: function () {
                $('#' + JsEven.id.hid_EditType).val('Search');
                document.getElementById('div_Search').style.display = '';
                document.getElementById('div_DataList').style.display = 'none';
                LicEven.ClearInput('tb_Data');
                $('#' + JsEven.id.span_comStatus).html('新增');
            },

            List: function () {
                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var txt_Search_coName = $('#' + this.id.txt_Search_coName).val();
                var txt_Search_comUniform = $('#' + this.id.txt_Search_comUniform).val();
                var hid_EditType = $('#' + this.id.hid_EditType).val();
                var opt = {
                    url: '../handler/ashx_Company_List.ashx',
                    v: 'comName=' + txt_Search_coName +
                       '&comUniform=' + txt_Search_comUniform,
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
                                    CmFmCommon.Xsl(xmldoc, '../xslt/xsl_Company_List.xsl', div);
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
                    url: '../handler/ashx_Company_Edit.ashx',
                    v: 'comGuid=' + id,
                    type: 'xml',
                    success: function (xmldoc) {

                        var View = xmldoc.getElementsByTagName('dView');
                        if (View.length == 1) {
                            var e = View[0];

                            $('#' + JsEven.id.txt_comName).val(CommonEven.XmlNodeGetValue(e, "comName"));
                            $('#' + JsEven.id.txt_comAbbreviate).val(CommonEven.XmlNodeGetValue(e, "comAbbreviate"));
                            $('#' + JsEven.id.txt_comUniform).val(CommonEven.XmlNodeGetValue(e, "comUniform"));

                            $('#' + JsEven.id.txt_comNTA).val(CommonEven.XmlNodeGetValue(e, "comNTA"));
                            $('#' + JsEven.id.txt_comLaborProtection1).val(CommonEven.XmlNodeGetValue(e, "comLaborProtection1"));
                            $('#' + JsEven.id.txt_comLaborProtection2).val(CommonEven.XmlNodeGetValue(e, "comLaborProtection2"));

                            $('#' + JsEven.id.txt_comBIT).val(CommonEven.XmlNodeGetValue(e, "comBIT"));
                            $('#' + JsEven.id.txt_comNTB).val(CommonEven.XmlNodeGetValue(e, "comNTB"));
                            $('#' + JsEven.id.txt_comNTBCode).val(CommonEven.XmlNodeGetValue(e, "comNTBCode"));
                            $('#' + JsEven.id.txt_comLaborProtectionCode).val(CommonEven.XmlNodeGetValue(e, "comLaborProtectionCode"));

                            $('#' + JsEven.id.txt_comHouseTax).val(CommonEven.XmlNodeGetValue(e, "comHouseTax"));
                            $('#' + JsEven.id.ddlist_comCity).val(CommonEven.XmlNodeGetValue(e, "comCity"));
                            $('#' + JsEven.id.txt_comHealthInsuranceCode).val(CommonEven.XmlNodeGetValue(e, "comHealthInsuranceCode"));

                            $('#' + JsEven.id.txt_comBusinessEntity).val(CommonEven.XmlNodeGetValue(e, "comBusinessEntity"));
                            $('#' + JsEven.id.txt_comResponsible).val(CommonEven.XmlNodeGetValue(e, "comResponsible"));
                            $('#' + JsEven.id.txt_comTel).val(CommonEven.XmlNodeGetValue(e, "comTel"));

                            $('#' + JsEven.id.txt_comAddress1).val(CommonEven.XmlNodeGetValue(e, "comAddress1"));
                            $('#' + JsEven.id.txt_comAddress2).val(CommonEven.XmlNodeGetValue(e, "comAddress2"));
                            $('#' + JsEven.id.txt_comPs).val(CommonEven.XmlNodeGetValue(e, "comPs"));

                            $('#' + JsEven.id.txt_comMail).val(CommonEven.XmlNodeGetValue(e, "comMail"));
                            $('#' + JsEven.id.txt_comOfficeNumber).val(CommonEven.XmlNodeGetValue(e, "comOfficeNumber"));
                            $('#' + JsEven.id.txt_comAccountNumber).val(CommonEven.XmlNodeGetValue(e, "comAccountNumber"));
                            $('#' + JsEven.id.span_comStatus).html('修改');
                        }
                        $.unblockUI();
                        CommonEven.setValue(JsEven.id.hid_EditType, "Up");
                        CommonEven.setValue(JsEven.id.hid_id, id);
                        //document.getElementById('div_Edit').style.display = '';
                        //document.getElementById('div_DataList').style.display = 'none';
                    }
                }
                CmFmCommon.ajax(opt);

            },
            //儲存
            Save: function () {
               
                var GUID = $('#' + this.id.hid_id).val();

                var EditType = $('#' + this.id.hid_EditType).val();

                var txt_comName = $('#' + this.id.txt_comName).val();
                var txt_comAbbreviate = $('#' + this.id.txt_comAbbreviate).val();
                var txt_comUniform = $('#' + this.id.txt_comUniform).val();

                var txt_comNTA = $('#' + this.id.txt_comNTA).val();
                var txt_comLaborProtection1 = $('#' + this.id.txt_comLaborProtection1).val();
                var txt_comLaborProtection2 = $('#' + this.id.txt_comLaborProtection2).val();

                var txt_comBIT = $('#' + this.id.txt_comBIT).val();
                var txt_comNTB = $('#' + this.id.txt_comNTB).val();
                var txt_comNTBCode = $('#' + this.id.txt_comNTBCode).val();
                var txt_comLaborProtectionCode = $('#' + this.id.txt_comLaborProtectionCode).val();

                var txt_comHouseTax = $('#' + this.id.txt_comHouseTax).val();
                var ddlist_comCity = $('#' + this.id.ddlist_comCity).val();
                var txt_comHealthInsuranceCode = $('#' + this.id.txt_comHealthInsuranceCode).val();

                var txt_comBusinessEntity = $('#' + this.id.txt_comBusinessEntity).val();
                var txt_comResponsible = $('#' + this.id.txt_comResponsible).val();
                var txt_comTel = $('#' + this.id.txt_comTel).val();

                var txt_comAddress1 = $('#' + this.id.txt_comAddress1).val();
                var txt_comAddress2 = $('#' + this.id.txt_comAddress2).val();
                var txt_comPs = $('#' + this.id.txt_comPs).val();

                var txt_comMail = $('#' + this.id.txt_comMail).val();
                var txt_comOfficeNumber = $('#' + this.id.txt_comOfficeNumber).val();
                var txt_comAccountNumber = $('#' + this.id.txt_comAccountNumber).val();

                //驗證
                if (CheckFormat.CheckIdennum('txt_comUniform') == false) {
                    return false;
                }

                if (CheckFormat.CheckEmail('txt_comMail') == false) { 
                    return false;
                }

                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                if (txt_comName != '' && txt_comAbbreviate != '' && txt_comUniform != '') {
                    var opt = {
                        url: '../handler/ashx_Company_SaveData.ashx',
                        v: 'comGuid=' + GUID +
                           '&EditType=' + EditType +
                           '&comName=' + txt_comName +
                           '&comAbbreviate=' + txt_comAbbreviate +
                           '&comUniform=' + txt_comUniform +

                           '&comNTA=' + txt_comNTA +
                           '&comLaborProtection1=' + txt_comLaborProtection1 +
                           '&comLaborProtection2=' + txt_comLaborProtection2 +

                           '&comBIT=' + txt_comBIT +
                           '&comNTB=' + txt_comNTB +
                           '&comNTBCode=' + txt_comNTBCode +
                           '&comLaborProtectionCode=' + txt_comLaborProtectionCode +

                           '&comHouseTax=' + txt_comHouseTax +
                           '&comCity=' + ddlist_comCity +
                           '&comHealthInsuranceCode=' + txt_comHealthInsuranceCode +

                           '&comBusinessEntity=' + txt_comBusinessEntity +
                           '&comResponsible=' + txt_comResponsible +
                           '&comTel=' + txt_comTel +

                           '&comAddress1=' + txt_comAddress1 +
                           '&comAddress2=' + txt_comAddress2 +
                           '&comPs=' + txt_comPs +

                           '&comMail=' + txt_comMail +
                           '&comOfficeNumber=' + txt_comOfficeNumber +
                           '&comAccountNumber=' + txt_comAccountNumber,

                        type: 'text',
                        success: function (msg) {
                            switch (msg) {
                                case "Timeout":
                                    alert("請重新登入");
                                    window.location.href = "login.aspx";
                                    break;
                                case "sign":
                                    alert("請勿輸入特殊符號");
                                    break;
                                case "error":
                                    alert("程式發生錯誤，儲存失敗");
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
                        url: '../handler/ashx_Company_SaveData.ashx',
                        v: 'comGuid=' + id +
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
        //}

        document.body.onload = function () {
            JsEven.opBind();
            JsEven.List();
            $('#' + JsEven.id.hid_EditType).val('Ins');
            //document.getElementById('div_Edit').style.display = 'none';
            document.getElementById('div_DataList').style.display = '';
            document.getElementById('div_Search').style.display = 'none';
        };
    </script>
</asp:Content>

