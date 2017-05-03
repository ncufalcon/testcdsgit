<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Allowance.aspx.cs" Inherits="webpage_page_Allowance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


            <div class="WrapperMain">
 
            <div class="fixwidth">
                <div class="twocol underlineT1 margin10T">
                    <div class="left font-light">首頁 / 薪資管理 / <span class="font-black font-bold">津貼管理</span></div>
                </div>

            </div>


            <div class="fixwidth" style="margin-top:10px;">
                <!-- 詳細資料start -->
                <div class="statabs margin10T">
                    <ul>
                        <li><a href="#tabs-1">匯入</a></li>
                        <li><a href="#tabs-2" onclick="JsEven.Inin()">津貼管理</a></li>
                    </ul>
                    <div id="tabs-1">

                 <div class="twocol margin15T">
                   <table style="width:100%">
                       <tr>
                           <td>
                               <a href="../FileTemplate/津貼匯入範本.xlsx" style=" text-decoration:none; color:blue">津貼匯入範本</a>
                                <span id="div_File"><input type="file" name="file_Atta" id="file_Atta" /></span>
                                <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.UploadFile();">匯入暫存</a>
                           </td>
                           <td style="text-align:right">
                               <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.Determine()" >確認匯入</a>
                           </td>
                       </tr>
                   </table>

                        
                    
                </div>
<%--                        <asp:FileUpload ID="file_upload" runat="server" />
                        <asp:LinkButton ID="lbtn_Import" runat="server" OnClick="btnb_Click" CssClass="keybtn">匯入</asp:LinkButton>--%>



                        <div id="div_Import" class="stripeMe fixTable" style="margin-top:15px"></div>



                    </div><!-- tabs-1 -->
                    <div id="tabs-2">

                        <div class="tabfixwidth gentable font-normal" id="div_Search" style="display:none">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">員工編號</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_PerNo" autofocus="autofocus" class="inputex width60"  />
                                        <%--<img id="img_" src="../images/btn-search.gif"  onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>--%>
                                    </td>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">姓名</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_PerName"  class="inputex width60" />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">津貼代號</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_AllowanceCode" class="inputex width60"  />
                                        <%--<img src="../images/btn-search.gif" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>--%>
                                    </td>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">金額</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_Cost"  class="inputex width60" />
                                    </td>
                                </tr>

                                
                                <tr>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">日期起迄</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_Date_s" class="inputex width40"  />~
                                        <input type="text" id="txt_Date_e" class="inputex width40"  />
                                    </td>
                                </tr>

                            </table>
                            <div class="twocol margin15T">
                                <div class="right">
                                    <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.List();">查詢</a>
                                </div>
                            </div>
                        </div>




                        <div id="div_Data" >
                        <div class="twocol margin15T">
                            <div class="right">
                                <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.reSearch();">查詢</a>
                                <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.Ins();">新增</a>
                            </div>
                        </div>
                        <div class="tabfixwidth" style="margin-top:20px;"">
                            <div id="div_MList" class="stripeMe fixTable" style="min-height:175px;max-height:175px">
 
                            </div><!-- overwidthblock -->
                        </div><!-- fixwidth -->
                        <div class="tabfixwidth" style="margin-top:20px;">
                            <div class="twocol margin15TB">
                                <div class="right">
                                    <a href="Javascript:void(0)" onclick="JsEven.Edit();" class="keybtn">儲存</a>
                                </div>
                            </div>
                        </div>
                        <div class="tabfixwidth" style="margin-top:20px;">
                            <!-- 詳細資料start -->
                            <div class="statabs margin10T">
                                <div class="gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tb_Edit">
                                        <tr>
                                            <td><span class="font-title titlebackicon">維護狀態</span><span id="sp_Status">新增</span></td>
                                        </tr>
                                        <tr>
                                            <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">員工代號</div></td>
                                            <td class="width17">
                                                <input type="text" id="txt_PerNo_m" class="inputex width50" />
                                                <img id="img_Person" src="../images/btn-search.gif" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                                                <span id="sp_PerName_m" class="showStr"></span>
                                                <input id="hid_PerGuid_m" type="hidden" />
                                            </td>
                                            <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">津貼代號</div></td>
                                            <td class="width15">
                                                <input type="text" id="txt_AllowanceCode_m" class="inputex width50"  />
                                                <img id="img_Code" src="../images/btn-search.gif" onclick="JsEven.openfancybox(this)" style="cursor:pointer" />
                                                <span id="sp_CodeName_m"></span>
                                                <input id="hid_CodeGuid_m" type="hidden" />
                                            </td>
                                            <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">日期</div></td>
                                            <td class="width15"><input type="text" class="inputex width50" id="txt_Date_m" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">單價</div></td>
                                            <td><input type="text" class="inputex width50" id="txt_Pric_m" onblur="JsEven.countCost()" /></td>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">數量</div></td>
                                            <td><input type="text" class="inputex width50" id="txt_Quantity_m" onblur="JsEven.countCost()" /></td>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">金額</div></td>
                                            <td><input type="text" class="inputex width50" id="txt_Cost_m" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon">備註</div></td>
                                            <td colspan="3"><input type="text" class="inputex width99" id="txt_Ps_m" /></td>
                                        </tr>

                                    </table>
                                </div>
                            </div><!-- statabs -->
                        </div><!-- fixwidth -->
                        </div>

                    </div><!-- tabs-2 -->

                </div><!-- statabs -->
                <!-- 詳細資料end -->
            </div><!-- fixwidth --> 











        </div><!-- WrapperMain -->

        <input id="hid_Guid" type="hidden" />
    <input id="hid_EditType" type="hidden" />

    <script type="text/javascript">


        JsEven = {

            Page1Id: {
                file_Atta: 'file_Atta',
                div_File: 'div_File',
                div_Import: 'div_Import'
            },

            Page2Id: {
                div_Search: 'div_Search',
                txt_PerNo: 'txt_PerNo',
                txt_PerName: 'txt_PerName',
                txt_AllowanceCode: 'txt_AllowanceCode',
                txt_Cost: 'txt_Cost',
                txt_Date_s: 'txt_Date_s',
                txt_Date_e: 'txt_Date_e',
                div_MList: 'div_MList',
                hid_Guid: 'hid_Guid',
                txt_PerNo_m: 'txt_PerNo_m',
                txt_AllowanceCode_m: 'txt_AllowanceCode_m',
                txt_Pric_m: 'txt_Pric_m',
                txt_Quantity_m: 'txt_Quantity_m',
                txt_Cost_m: 'txt_Cost_m',
                txt_Date_m: 'txt_Date_m',
                txt_Ps_m: 'txt_Ps_m',
                div_Data: 'div_Data',
                sp_Status: 'sp_Status',
                sp_PerName_m: 'sp_PerName_m',
                hid_PerGuid_m: 'hid_PerGuid_m',
                sp_CodeName_m: 'sp_CodeName_m',
                hid_CodeGuid_m: 'hid_CodeGuid_m',
                tb_Edit: 'tb_Edit',
                hid_EditType: 'hid_EditType'
            },


            Inin: function () {
                this.List();
            },

            List: function () {
                // typ ='Y' 第一次進入畫面 top200
                var PerNo = $('#' + this.Page2Id.txt_PerNo).val();
                var PerName = $('#' + this.Page2Id.txt_PerName).val();
                var Code = $('#' + this.Page2Id.txt_AllowanceCode).val()
                var Cost = $('#' + this.Page2Id.txt_Cost).val();
                var DateS = $('#' + this.Page2Id.txt_Date_s).val();
                var DateE = $('#' + this.Page2Id.txt_Date_e).val();
                var typ = "";


                if (PerNo == "" && PerName == "" && Code == "" && Cost == "" && DateS == "" && DateE == "") {
                    typ = "Y";
                }


                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var opt = {
                    url: '../handler/Allowance/ashx_AllList.ashx',
                    v: 'PerNo=' + PerNo +
                       '&PerName=' + PerName +
                       '&Code=' + Code +
                       '&Cost=' + Cost +
                       '&DateS=' + DateS + '&DateE=' + DateE + '&typ=' + typ,
                    type: 'xml',
                    success: function (xmldoc) {

                        var msg = CommonEven.XmlNodeGetValue(xmldoc, "dList");
                        switch (msg) {
                            case "DangerWord":
                                CommonEven.goErrorPage();
                                break;
                            case "error":
                                alert('資料發生錯誤，請聯絡管理者');
                                break;
                            default:
                                var div = document.getElementById(JsEven.Page2Id.div_MList);
                                var dList = xmldoc.getElementsByTagName('dList');
                                var dView = xmldoc.getElementsByTagName('dView');

                                if (dView.length != 0) {
                                    CmFmCommon.Xsl(xmldoc, '../xslt/Allowance/xsl_AllList.xsl', div);
                                    LicEven.tblClass();

                                } else { div.innerHTML = '目前無任何資料'; }

                                document.getElementById(JsEven.Page2Id.div_Search).style.display = "none";
                                document.getElementById(JsEven.Page2Id.div_Data).style.display = "block";
                                //tableHeadFixer();
                                //$.fn.tableHeadFixer($('.table'));
                                break;
                        }
                        $.unblockUI();
                    }
                }
                CmFmCommon.ajax(opt);
            },

            view: function (a) {
                var guid = a.getAttribute('guid');
                $.ajax({
                    type: "POST",
                    url: '../handler/Allowance/ashx_AllView.ashx',
                    data: 'guid=' + guid,
                    dataType: 'xml',  //xml, json, script, text, html
                    success: function (xmldoc) {
                        var CView = xmldoc.getElementsByTagName('dView');
                        if (CView.length == 1) {
                            var e = CView[0];
                            $('#' + JsEven.Page2Id.txt_PerNo_m).val(CommonEven.XmlNodeGetValue(e, "perNo"));
                            $('#' + JsEven.Page2Id.sp_PerName_m).html(CommonEven.XmlNodeGetValue(e, "perName"));
                            $('#' + JsEven.Page2Id.hid_PerGuid_m).val(CommonEven.XmlNodeGetValue(e, "paPerGuid"));
                            $('#' + JsEven.Page2Id.hid_Guid).val(CommonEven.XmlNodeGetValue(e, "paGuid"));

                            $('#' + JsEven.Page2Id.txt_AllowanceCode_m).val(CommonEven.XmlNodeGetValue(e, "siItemCode"));
                            $('#' + JsEven.Page2Id.sp_CodeName_m).html(CommonEven.XmlNodeGetValue(e, "siItemName"));
                            $('#' + JsEven.Page2Id.hid_CodeGuid_m).val(CommonEven.XmlNodeGetValue(e, "paAllowanceCode"));

                            $('#' + JsEven.Page2Id.txt_Pric_m).val(CommonEven.XmlNodeGetValue(e, "paPrice"));
                            $('#' + JsEven.Page2Id.txt_Quantity_m).val(CommonEven.XmlNodeGetValue(e, "paQuantity"));
                            $('#' + JsEven.Page2Id.txt_Ps_m).val(CommonEven.XmlNodeGetValue(e, "paPs"));
                            $('#' + JsEven.Page2Id.txt_Cost_m).val(CommonEven.XmlNodeGetValue(e, "paCost"));
                            $('#' + JsEven.Page2Id.txt_Date_m).val(CommonEven.XmlNodeGetValue(e, "paDate"));
                            $('#' + JsEven.Page2Id.sp_Status).html("修改");
                            $('#' + JsEven.Page2Id.hid_EditType).val("Up");
                        }
                        else {
                            alert('資料發生錯誤')
                        }
                    },
                    error: function (xhr, statusText) {
                        //alert(xhr.status);
                        alert('資料發生錯誤');
                    }
                });
            },


            Del: function (a) {
                if (confirm('刪除後無法回復，您確定要刪除嗎?')) {
                    var guid = a.getAttribute('Guid');
                    $.ajax({
                        type: "POST",
                        url: '../handler/Allowance/ashx_AllEdit.ashx',
                        data: 'guid=' + guid + '&typ=Del',
                        dataType: 'text',  //xml, json, script, text, html
                        success: function (msg) {
                            switch (msg) {
                                case "ok":
                                    alert('刪除成功');
                                    JsEven.Ins();
                                    JsEven.List('Y');
                                    break;
                                case "e":
                                    alert('程式發生錯誤，請聯絡相關管理人員');
                                    break;
                                case "t":
                                    alert('登入逾時');
                                    CommonEven.goLogin();
                                    break;
                                case "d":
                                    CommandEven.goErrorPage();
                                    break;
                            }
                        },
                        error: function (xhr, statusText) {
                            //alert(xhr.status);
                            alert('資料發生錯誤');
                        }
                    });
                }
            },


            Edit: function () {

                var guid = $('#' + this.Page2Id.hid_Guid).val();
                var typ = $('#' + this.Page2Id.hid_EditType).val();
                var PerGuid = $('#' + this.Page2Id.hid_PerGuid_m).val();
                var AllCode = $('#' + this.Page2Id.hid_CodeGuid_m).val();
                var Price = $('#' + this.Page2Id.txt_Pric_m).val();
                var Quantity = $('#' + this.Page2Id.txt_Quantity_m).val();
                var Cost = $('#' + this.Page2Id.txt_Cost_m).val();
                var Ps = $('#' + this.Page2Id.txt_Ps_m).val();
                var Date = $('#' + this.Page2Id.txt_Date_m).val();

                if (PerGuid == "") { alert('請選擇員工'); return false; }
                if (AllCode == "") { alert('請選擇津貼項目'); return false; }
                if (Price == "") { alert('請輸入單價'); return false; }
                CheckFormat.CheckInt(this.Page2Id.txt_Pric_m);
                if (Quantity == "") { alert('請輸入數量'); return false; }
                CheckFormat.CheckInt(this.Page2Id.txt_Quantity_m);
                if (Cost == "") { alert('請輸入金額'); return false; }
                CheckFormat.CheckInt(this.Page2Id.txt_Cost_m);
                if (Date == "") { alert('請選擇日期'); return false; }
                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                $.ajax({
                    type: "POST",
                    url: '../handler/Allowance/ashx_AllEdit.ashx',
                    data: 'guid=' + guid +
                          '&typ=' + typ +
                          '&PerGuid=' + PerGuid +
                          '&AllCode=' + AllCode +
                          '&Price=' + Price +
                          '&Quantity=' + Quantity +
                          '&Cost=' + Cost +
                          '&Ps=' + Ps +
                          '&Date=' + Date,
                    dataType: 'text',  //xml, json, script, text, html
                    success: function (msg) {
                        switch (msg) {
                            case "ok":
                                alert('儲存成功');
                                JsEven.Ins();
                                JsEven.List('Y');
                                break;
                            case "e":
                                alert('程式發生錯誤，請聯絡相關管理人員');
                                break;
                            case "t":
                                alert('登入逾時');
                                CommonEven.goLogin();
                                break;
                            case "d":
                                CommandEven.goErrorPage();
                                break;
                        }
                        $.unblockUI();
                    },
                    error: function (xhr, statusText) {
                        //alert(xhr.status);
                        $.unblockUI();
                        alert('資料發生錯誤');

                    }
                });



            },

            Ins: function () {
                LicEven.ClearInput(this.Page2Id.tb_Edit);
                $('#' + this.Page2Id.sp_Status).val("新增");
                $('#' + this.Page2Id.hid_EditType).val("Ins");
            },


            countCost: function () {
                var p = $('#' + JsEven.Page2Id.txt_Pric_m).val();
                var q = $('#' + JsEven.Page2Id.txt_Quantity_m).val();

                p = (p != "") ? p : 0;
                q = (q != "") ? q : 0;
                $('#' + JsEven.Page2Id.txt_Cost_m).val(p * q);

            },


            //點放大鏡 查詢視窗
            openfancybox: function (item) {
                switch ($(item).attr("id")) {
                    case "img_Code":
                        link = "SearchWindow.aspx?v=Allowance";
                        break;
                    case "img_Person":
                        link = "SearchWindow.aspx?v=Personnel";
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
            },

            reSearch: function () {
                document.getElementById(JsEven.Page2Id.div_Search).style.display = "block";
                document.getElementById(JsEven.Page2Id.div_Data).style.display = "none";
            },


            UploadFile: function () {
                var fileUp = document.getElementById(this.Page1Id.file_Atta);
                var ExtensionName = fileUp.value.toLowerCase().split('.')[1];


                if (fileUp.value == "") {
                    alert("請選擇檔案!!");
                    return false;
                }
                else {
                    if ($.inArray(ExtensionName, ['xls', 'xlsx']) == -1) {
                        alert("請上傳Excel檔");
                        return false;
                    }
                }

                var iframe = document.createElement('iframe');
                iframe.setAttribute('id', 'fileIFRAME');
                iframe.setAttribute('name', iframe.id);
                iframe.style.display = 'none';



                var form = document.createElement('form');
                document.body.appendChild(form);
                form.style.display = 'none';
                form.setAttribute('id', 'file_FORM');
                form.setAttribute('name', form.id);

                form.target = iframe.id;
                form.method = "post";
                form.enctype = "multipart/form-data";
                form.encoding = "multipart/form-data";
                form.action = "../handler/Allowance/ashx_ImportExcel.ashx";

                form.appendChild(fileUp);
                form.appendChild(iframe);


                if (iframe.contentWindow)
                    iframe.contentWindow.name = iframe.id;  //加進去以後才可以

                form.submit();
            },

            feedbackFun: function (msg) {
                switch (msg) {
                    case "t":
                        alert('登入逾時');
                        CommonEven.goLogin();
                        break;
                    case "e":
                        alert('匯入失敗');
                        break;
                    default:
                        alert('匯入成功');
                        var opt = {
                            url: '../handler/Allowance/ashx_AllTempList.ashx',
                            v: '',
                            type: 'xml',
                            success: function (xmldoc) {
                                var div = document.getElementById(JsEven.Page1Id.div_Import);
                                var dList = xmldoc.getElementsByTagName('dList');
                                var dView = xmldoc.getElementsByTagName('dView');

                                if (dView.length != 0) {
                                    CmFmCommon.Xsl(xmldoc, '../xslt/Allowance/xsl_AllImport.xsl', div);
                                    LicEven.tblClass();

                                } else { div.innerHTML = '目前無任何資料'; }
                            }
                        }
                        CmFmCommon.ajax(opt);
                        break;
                }
                var div = document.getElementById(this.Page1Id.div_File);
                div.innerHTML = "<input type='file' name='file_Atta' id='file_Atta' />";
            },

            DelTemp: function (a) {
                if (confirm('刪除後無法回復，您確定要刪除?')) {
                    var guid = a.getAttribute('guid');
                    $.ajax({
                        type: "POST",
                        url: '../handler/Allowance/ashx_AllTempDel.ashx',
                        data: 'guid=' + guid,
                        dataType: 'text',  //xml, json, script, text, html
                        success: function (msg) {
                            switch (msg) {
                                case "ok":
                                    var div = document.getElementById(JsEven.Page1Id.div_Import);
                                    var tr = div.getElementsByTagName('tr');
                                    for (var i = 0; i < tr.length; i++) {
                                        var t = tr[i];
                                        if (guid == t.getAttribute('guid'))
                                            t.parentNode.removeChild(t);
                                    }
                                    alert('刪除成功');
                                    break;
                                case "e":
                                    alert('程式發生錯誤，請聯絡相關管理人員');
                                    break;
                                case "t":
                                    alert('登入逾時');
                                    CommonEven.goLogin();
                                    break;
                            }
                            $.unblockUI();
                        },
                        error: function (xhr, statusText) {
                            //alert(xhr.status);
                            $.unblockUI();
                            alert('程式發生錯誤，請聯絡相關管理人員');

                        }
                    });
                }

            },

            Determine: function () {         
                $.ajax({
                    type: "POST",
                    url: '../handler/Allowance/ashx_Determine.ashx',
                    data: '',
                    dataType: 'text',  //xml, json, script, text, html
                    success: function (msg) {
                        switch (msg) {
                            case "ok":
                                var div = document.getElementById(JsEven.Page1Id.div_Import);
                                div.innerHTML = "";
                                alert('匯入成功');
                                break;
                            case "e":
                                alert('程式發生錯誤，請聯絡相關管理人員');
                                break;
                            case "t":
                                alert('登入逾時');
                                CommonEven.goLogin();
                                break;
                        }
                        $.unblockUI();
                    },
                    error: function (xhr, statusText) {
                        //alert(xhr.status);
                        $.unblockUI();
                        alert('程式發生錯誤，請聯絡相關管理人員');

                    }
                });
            

        }
            

        }


        function setReturnValue(v, gv, no, name) {
            switch (v) {
                case "Personnel":
                    $("#" + JsEven.Page2Id.txt_PerNo_m).val(no);
                    $("#" + JsEven.Page2Id.sp_PerName_m).html(name);
                    $("#" + JsEven.Page2Id.hid_PerGuid_m).val(gv);
                    break;
                case "Allowance":
                    $("#" + JsEven.Page2Id.txt_AllowanceCode_m).val(no);
                    $("#" + JsEven.Page2Id.sp_CodeName_m).html(name);
                    $("#" + JsEven.Page2Id.hid_CodeGuid_m).val(gv);
                    break;
            }
        }

        document.body.onload = function () {
            //JsEven.Inin();
            $("#" + JsEven.Page2Id.hid_EditType).val("Ins");
            $("#" + JsEven.Page2Id.txt_Date_m + ",#" + JsEven.Page2Id.txt_Date_s + ",#" + JsEven.Page2Id.txt_Date_e).datepicker({
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
        }
    </script>


               
</asp:Content>


