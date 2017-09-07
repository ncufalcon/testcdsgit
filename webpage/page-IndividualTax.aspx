<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-IndividualTax.aspx.cs" Inherits="webpage_page_IndividualTax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">



            <div class="WrapperMain">
 
            <div class="fixwidth">
                <div class="twocol underlineT1 margin10T">
                    <div class="left font-light">首頁 / 薪資管理 / <span class="font-black font-bold">申報所得稅</span></div>
                </div>
<%--                <div class="twocol margin15T">
                    <div class="right">
                        <a href="" class="keybtn">計算薪資</a>
                        <a href="" class="keybtn">查詢</a>
                    </div>
                </div>--%>
            </div>
            <br /><br />
            <div class="fixwidth"> 

        <div class=" gentable font-normal " id="div_Search" style="display:none; height:200px">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">員工編號</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_PerNo_S" autofocus="autofocus" class="inputex width60"  />                                       
                                    </td>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">姓名</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_PerName_S"  class="inputex width60" />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">公司名稱</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_Comp_S" class="inputex width60"  />
                                    </td>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">部門</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_Dep_S"  class="inputex width60" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">年度</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_yyyy_S" class="inputex width60"  />
                                    </td>
                                </tr>
                            </table>
                            <div class="twocol margin15T">
                                <div class="right">
                                    <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.List();">查詢</a>
                                    <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.Cancel();">取消</a>
                                </div>
                            </div>
                        </div>

        <div id="div_GenTax" class=" gentable font-normal" style="display:none; height:200px">
          <table  border="0" cellspacing="0" cellpadding="0">
              <tr>
                  <td class="width15" align="right"><div class="font-title titlebackicon">年度</div></td>
                  <td class="width35"><input type="text" id="txt_yyyy_gen" autofocus="autofocus" maxlength="4" class="inputex width60"  /><span style="color:red">#2017</span></td>
                  <td  style="text-align:right">
                      <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.genTax();">開始計算所得稅資料</a>
                      <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.Cancel();">取消</a>
                  </td>
              </tr>

          </table> 

        </div>

        <div id="div_reportTax" class=" gentable font-normal" style="display:none; height:200px">
          <table  border="0" cellspacing="0" cellpadding="0">
              <tr>
                  <td class="width15" align="right"><div class="font-title titlebackicon">年度</div></td>
                  <td class="width35"><input type="text" id="txt_yyyy_rep" autofocus="autofocus" maxlength="4" class="inputex width60"  /><span style="color:red">#2017</span></td>
                  <td  style="text-align:right">
                      <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.genTax();">依年度匯出所得稅資料</a>
                      <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.Cancel();">取消</a>
                  </td>
              </tr>

          </table> 

        </div>

        <div id="div_Data">
                    <div class="twocol margin15T">
                            <div class="right">
                                <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.reSearch();">查詢</a>
                                <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.opGenPayroll();">產生所得稅資料</a>
                                <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.opReportPayroll();">匯出所得稅資料</a>
                            </div>
                        </div>
            <div class="fixwidth" style="margin-top:20px;">
           <div id="div_MList" class="stripeMe fixTable" style="min-height:175px;max-height:175px">
           </div>
          </div>
       </div><!-- overwidthblock -->





            </div><!-- fixwidth -->
            <div class="fixwidth" style="margin-top:10px;">
                <!-- 詳細資料start -->
                <div class="statabs margin10T">
                    <ul>
                        <li><a href="#tabs-1">計薪資料一</a></li>
<%--                        <li><a href="#tabs-2">計薪資料二</a></li>
                        <li><a href="#tabs-3">計薪資料三</a></li>--%>
                    </ul>
                    <div id="tabs-1">
                            <div class="twocol margin15TB">
                                <div class="right">
                                    <a href="javascript:void(0);" class="keybtn" onclick="JsEven.Edit();">儲存</a>                                 
                                </div>
                            </div>
                        <div class="gentable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">年度</div></td>
                                    <td class="width15" id="td_yyyy"></td>
                                </tr>
                                <tr>
                                    <td class="width12" align="right"><div class="font-title titlebackicon">員工編號</div></td>
                                    <td class="width15" id="td_iitPerNo"></td>
                                    <td class="width12" align="right"><div class="font-title titlebackicon">姓名</div></td>
                                    <td class="width15" id="td_iitPerName"></td>
                                    <td class="width13" align="right"><div class="font-title titlebackicon">部門</div></td>
                                    <td class="width15" id="td_iitPerDep"></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">身分證號</div></td>
                                    <td id="td_iitPerIDNumber"></td>
                                    <td align="right"><div class="font-title titlebackicon">護照號碼</div></td>
                                    <td id="td_iitPassPort"></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">戶籍地址</div></td>
                                    <td colspan="5" id="td_iitPerResidentAddr"></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">通訊地址</div></td>
                                    <td colspan="5" id="td_iitPerAdds"></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">申報公司</div></td>
                                    <td id="td_iitComName"></td>
                                    <td align="right"><div class="font-title titlebackicon">統一編號</div></td>
                                    <td id="td_iitComUniform"></td>
                                    <td align="right"><div class="font-title titlebackicon">稽徵機關代號</div></td>
                                    <td id="td_iitInstitutionCode"></td>
                                </tr>
                                </table><br /><br />
                                <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">憑單格式</div></td>
                                        <td colspan="5" ><select id="ddls_iitFormat" ></select></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">註記</div></td>
                                        <td colspan="5"><select id="ddls_iitMark" ></select></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">憑單填發方式</div></td>
                                        <td colspan="5"><select id="ddls_iitManner" ></select></td>

                                    </tr>
                                    <tr>
                                        <td style="width:10%" align="right"><div class="font-title titlebackicon">給付總額</div></td>
                                        <td style="width:15%" ><input type="text" class="inputex width50" id="txt_iitPaySum" /></td>             
                                        <td style="width:10%" align="right"><div class="font-title titlebackicon">扣繳稅額</div></td>
                                        <td style="width:15%" ><input type="text" class="inputex width50" id="txt_iitPayTax"/></td>
                                        <td style="width:10%" align="right"><div class="font-title titlebackicon">給付淨額</div></td>
                                        <td style="width:15%" ><input type="text" class="inputex width50" id="txt_iitPayAmount"/></td>
                                   </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">所屬年月起</div></td>
                                        <td><input type="text" class="inputex width50" id="txt_iitYearStart" maxlength="7" /><span style="color:red">#2017/01</span></td>                                   
                                        <td align="right"><div class="font-title titlebackicon">所屬年月迄</div></td>
                                        <td><input type="text" class="inputex width50" id="txt_iitYearEnd" maxlength="7" /><span style="color:red">#2017/12</span></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">自提退休金加總</div></td>
                                        <td><input type="text" class="inputex width50" id="txt_iitStock" /></td>                                     
                                        <td align="right"><div class="font-title titlebackicon">證號別</div></td>
                                        <td><input type="text" class="inputex width50" id="txt_iitIdentify" /></td>                                       
                                        <td align="right"><div class="font-title titlebackicon">錯誤註記</div></td>
                                        <td><input type="text" class="inputex width50" id="txt_iitErrMark" /></td>
                                    </tr>
                                      <tr>
                                        <td align="right"><div class="font-title titlebackicon">房屋稅及編號</div></td>
                                        <td><input type="text" class="inputex width50" id="txt_iitHouseTax" /></td>                                     
                                        <td align="right"><div class="font-title titlebackicon">執行業別代號</div></td>
                                        <td><input type="text" class="inputex width50" id="txt_iitIndustryCode" /></td>                                       
                                    </tr>  

                                </table>
                        </div><br /><br />

                    </div><!-- tabs-1 -->

                </div><!-- statabs -->
                <!-- 詳細資料end -->
            </div><!-- fixwidth -->


        </div><!-- WrapperMain -->




    <input id="hid_iitGuid" type="hidden" />
    
    <script type="text/javascript">
        JsEven = {

            Id: {
                div_Search: 'div_Search',
                txt_PerNo_S: 'txt_PerNo_S',
                txt_PerName_S: 'txt_PerName_S',
                txt_Comp_S: 'txt_Comp_S',
                txt_Dep_S: 'txt_Dep_S',
                txt_yyyy_S: 'txt_yyyy_S',

                div_GenTax: 'div_GenTax',
                txt_yyyy_gen: 'txt_yyyy_gen',

                div_reportTax: 'div_reportTax',
                txt_yyyy_rep: 'txt_yyyy_rep',

                div_Data: 'div_Data',
                div_MList: 'div_MList',

                td_yyyy: 'td_yyyy',
                td_iitPerNo: 'td_iitPerNo',
                td_iitPerName: 'td_iitPerName',
                td_iitPerDep: 'td_iitPerDep',
                td_iitPerIDNumber: 'td_iitPerIDNumber',
                td_iitPassPort: 'td_iitPassPort',
                td_iitPerResidentAddr: 'td_iitPerResidentAddr',
                td_iitPerAdds: 'td_iitPerAdds',
                td_iitComName: 'td_iitComName',
                td_iitComUniform: 'td_iitComUniform',
                td_iitInstitutionCode: 'td_iitInstitutionCode',
                ddls_iitFormat: 'ddls_iitFormat',
                ddls_iitMark: 'ddls_iitMark',
                ddls_iitManner: 'ddls_iitManner',
                txt_iitPaySum: 'txt_iitPaySum',
                txt_iitPayTax: 'txt_iitPayTax',
                txt_iitPayAmount: 'txt_iitPayAmount',
                txt_iitYearStart: 'txt_iitYearStart',
                txt_iitYearEnd: 'txt_iitYearEnd',
                txt_iitStock: 'txt_iitStock',
                txt_iitIdentify: 'txt_iitIdentify',
                txt_iitErrMark: 'txt_iitErrMark',
                txt_iitHouseTax: 'txt_iitHouseTax',
                txt_iitIndustryCode: 'txt_iitIndustryCode',

                hid_iitGuid:'hid_iitGuid'
            },



            Inin: function () {
                this.List();
            },

            List: function () {
                // typ ='Y' 第一次進入畫面 top200
                var PerNo = $('#' + this.Id.txt_PerNo_S).val();
                var PerName = $('#' + this.Id.txt_PerName_S).val();
                var Com = $('#' + this.Id.txt_Comp_S).val()
                var Dep = $('#' + this.Id.txt_Dep_S).val();
                var yyyy = $('#' + this.Id.txt_yyyy_S).val();
                var typ = "";


                if (PerNo == "" && PerName == "" && Com == "" && Dep == "" && yyyy == "") {
                    typ = "Y";
                }


                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var opt = {
                    url: '../handler/Tax/ashx_TaxList.ashx',
                    v: 'PerNo=' + PerNo +
                       '&PerName=' + PerName +
                       '&Company=' + Com +
                       '&Dep=' + Dep +
                       '&yyyy=' + yyyy + '&typ=' + typ,
                    type: 'xml',
                    success: function (xmldoc) {

                        var msg = CommonEven.XmlNodeGetValue(xmldoc, "dList");
                        switch (msg) {
                            case "d":
                                CommonEven.goErrorPage();
                                break;
                            case "t":
                                alert('登入逾時');
                                CommonEven.goLogin();
                                break;
                            case "e":
                                alert('資料發生錯誤，請聯絡管理者');
                                break;
                            default:
                                var div = document.getElementById(JsEven.Id.div_MList);
                                var dList = xmldoc.getElementsByTagName('dList');
                                var dView = xmldoc.getElementsByTagName('dView');

                                if (dView.length != 0) {
                                    CmFmCommon.Xsl(xmldoc, '../xslt/Tax/xsl_Tax.xsl', div);
                                    LicEven.tblClass();

                                } else { div.innerHTML = '目前無任何資料'; }

                                document.getElementById(JsEven.Id.div_Search).style.display = "none";
                                document.getElementById(JsEven.Id.div_Data).style.display = "block";
                                $("#" + JsEven.Id.div_MList).tableHeadFixer();
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
                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                $.ajax({
                    type: "POST",
                    url: '../handler/Tax/ashx_TaxList.ashx',
                    data: 'guid=' + guid,
                    dataType: 'xml',  //xml, json, script, text, html
                    success: function (xmldoc) {
                        var CView = xmldoc.getElementsByTagName('dView');
                        if (CView.length == 1) {
                            var e = CView[0];
                            var Guid = CommonEven.XmlNodeGetValue(e, "iitGuid");

                            
                            $('#' + JsEven.Id.hid_EditType).val("Edit");
                            $('#' + JsEven.Id.td_yyyy).html(CommonEven.XmlNodeGetValue(e, "iitYyyy"));
                            $('#' + JsEven.Id.td_iitPerNo).html(CommonEven.XmlNodeGetValue(e, "iitPerNo"));
                            $('#' + JsEven.Id.td_iitPerName).html(CommonEven.XmlNodeGetValue(e, "iitPerName"));
                            $('#' + JsEven.Id.td_iitPerDep).html(CommonEven.XmlNodeGetValue(e, "iitPerDep"));
                            $('#' + JsEven.Id.td_iitPerIDNumber).html(CommonEven.XmlNodeGetValue(e, "iitPerIDNumber"));
                            $('#' + JsEven.Id.td_iitPassPort).html(CommonEven.XmlNodeGetValue(e, "iitPassPort"));
                            $('#' + JsEven.Id.td_iitPerResidentAddr).html(CommonEven.XmlNodeGetValue(e, "iitPerResidentAddr"));
                            $('#' + JsEven.Id.td_iitPerAdds).html(CommonEven.XmlNodeGetValue(e, "iitPerAdds"));
                            $('#' + JsEven.Id.td_iitComName).html(CommonEven.XmlNodeGetValue(e, "iitComName"));
                            $('#' + JsEven.Id.td_iitComUniform).html(CommonEven.XmlNodeGetValue(e, "iitComUniform"));                            
                            $('#' + JsEven.Id.td_iitInstitutionCode).html(CommonEven.XmlNodeGetValue(e, "iitInstitutionCode"));
                            $('#' + JsEven.Id.ddls_iitFormat).val(CommonEven.XmlNodeGetValue(e, "iitFormat"));
                            $('#' + JsEven.Id.ddls_iitMark).val(CommonEven.XmlNodeGetValue(e, "iitMark"));
                            $('#' + JsEven.Id.ddls_iitManner).val(CommonEven.XmlNodeGetValue(e, "iitManner"));
                            $('#' + JsEven.Id.txt_iitPaySum).val(CommonEven.XmlNodeGetValue(e, "iitPaySum"));
                            $('#' + JsEven.Id.txt_iitPayTax).val(CommonEven.XmlNodeGetValue(e, "iitPayTax"));
                            $('#' + JsEven.Id.txt_iitPayAmount).val(CommonEven.XmlNodeGetValue(e, "iitPayAmount"));
                            $('#' + JsEven.Id.txt_iitYearStart).val(CommonEven.XmlNodeGetValue(e, "iitYearStart"));
                            $('#' + JsEven.Id.txt_iitYearEnd).val(CommonEven.XmlNodeGetValue(e, "iitYearEnd"));
                            $('#' + JsEven.Id.txt_iitStock).val(CommonEven.XmlNodeGetValue(e, "iitStock"));
                            $('#' + JsEven.Id.txt_iitIdentify).val(CommonEven.XmlNodeGetValue(e, "iitIdentify"));
                            $('#' + JsEven.Id.txt_iitErrMark).val(CommonEven.XmlNodeGetValue(e, "iitErrMark"));
                            $('#' + JsEven.Id.txt_iitHouseTax).val(CommonEven.XmlNodeGetValue(e, "iitHouseTax"));
                            $('#' + JsEven.Id.txt_iitIndustryCode).val(CommonEven.XmlNodeGetValue(e, "iitIndustryCode"));

                        }
                        else {
                            alert('資料發生錯誤')
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


            Edit: function () {

                var iitGuid = $('#' + this.Id.hid_iitGuid).val();
                if (iitGuid != "") {
                    var iitPaySum = $('#' + this.Id.txt_iitPaySum).val();
                    var iitPayTax = $('#' + this.Id.txt_iitPayTax).val();
                    var iitPayAmount = $('#' + this.Id.txt_iitPayAmount).val();
                    var iitYearStart = $('#' + this.Id.txt_iitYearStart).val();
                    var iitYearEnd = $('#' + this.Id.txt_iitYearEnd).val();
                    var iitStock = $('#' + this.Id.txt_iitStock).val();
                    var iitIdentify = $('#' + this.Id.txt_iitIdentify).val();
                    var iitErrMark = $('#' + this.Id.txt_iitErrMark).val();
                    var iitHouseTax = $('#' + this.Id.txt_iitHouseTax).val();
                    var iitIndustryCode = $('#' + this.Id.txt_iitIndustryCode).val();

                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    $.ajax({
                        type: "POST",
                        url: '../handler/Payroll/ashx_PayEdit.ashx',
                        data: 'iitGuid=' + iitGuid +
                              '&iitPaySum=' + iitPaySum +
                              '&iitPayTax=' + iitPayTax +
                              '&iitPayAmount=' + iitPayAmount +
                              '&iitYearStart=' + iitYearStart +
                              '&iitYearEnd=' + iitYearEnd +
                              '&iitStock=' + iitStock +
                              '&iitIdentify=' + iitIdentify +
                              '&iitErrMark=' + iitErrMark +
                              '&iitHouseTax=' + iitHouseTax +
                              '&iitIndustryCode=' + iitIndustryCode,
                        dataType: 'text',  //xml, json, script, text, html
                        success: function (msg) {
                            switch (msg) {
                                case "ok":
                                    alert('儲存成功');
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
                } else { alert('請選擇要修改的資料'); }


            },


            reSearch: function () {
                document.getElementById(JsEven.Id.div_Search).style.display = "block";
                document.getElementById(JsEven.Id.div_Data).style.display = "none";
                document.getElementById(JsEven.Id.div_GenTax).style.display = "none";
            },
            //查詢視窗
            openfancybox: function (item) {
                switch ($(item).attr("id")) {
                    case "img_Company":
                        link = "SearchWindow.aspx?v=Comp";
                        break;
                    case "img_Dep":
                        link = "SearchWindow.aspx?v=Dep";
                        break;
                    case "img_Person":
                        link = "SearchWindow.aspx?v=Personnel";
                        break;
                    case "img_SalaryRange":
                        $('#' + this.Id.hid_RangeType).val('S');
                        link = "SearchWindow.aspx?v=SalaryRange";
                        break;
                    case "img_SalaryRange_Gen":
                        $('#' + this.Id.hid_RangeType).val('Payroll');
                        link = "SearchWindow.aspx?v=SalaryRange";
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

            opGenPayroll: function () {
                document.getElementById(JsEven.Id.div_GenTax).style.display = "block";
                document.getElementById(JsEven.Id.div_Search).style.display = "none";
                document.getElementById(JsEven.Id.div_Data).style.display = "none";

            },

            opReportPayroll: function () {

                document.getElementById(JsEven.Id.div_reportTax).style.display = "block";
                document.getElementById(JsEven.Id.div_Search).style.display = "none";
                document.getElementById(JsEven.Id.div_Data).style.display = "none";

            },

            Cancel: function () {
                document.getElementById(JsEven.Id.div_GenTax).style.display = "none";
                document.getElementById(JsEven.Id.div_reportTax).style.display = "none";
                document.getElementById(JsEven.Id.div_Search).style.display = "none";
                document.getElementById(JsEven.Id.div_Data).style.display = "block";

            },

            genTax: function () {

                var yyyy = $('#' + this.Id.txt_yyyy_gen).val();
                if (yyyy != "" && yyyy.length == 4) {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    var opt = {
                        url: '../handler/Tax/ashx_GenTax.ashx',
                        v: 'yyyy=' + yyyy,
                        type: 'text',
                        success: function (msg) {

                            switch (msg) {
                                case "d":
                                    CommonEven.goErrorPage();
                                    break;
                                case "t":
                                    alert('登入逾時');
                                    CommonEven.goLogin();
                                    break;
                                case "e":
                                    alert('資料發生錯誤，請聯絡管理者');
                                    break;
                                default:
                                    JsEven.List();
                                    document.getElementById(JsEven.Id.div_GenTax).style.display = "none";
                                    document.getElementById(JsEven.Id.div_Search).style.display = "none";
                                    document.getElementById(JsEven.Id.div_Data).style.display = "block";
                                    alert('所得稅資料產生完成');
                                    break;
                            }
                            $.unblockUI();
                        }
                    }
                    CmFmCommon.ajax(opt);
                } else { alert('請輸入年度'); }

            },


            //DDL
            getddl: function (gno, tagName) {
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
                })
            },




            ExportExcel: function () {
                var yyyy = $('#' + this.Id.txt_yyyy_rep).val();
                if (yyyy != '') {

                    window.location = "../handler/Payroll/ashx_ExportPayroll.ashx?yyyy=" + yyyy;
                } else { alert('請輸入要匯出的年度'); }
            }
        }


        //fancybox回傳
        function setReturnValue(type, gv, str, str2) {
            switch (type) {
                case "Comp":
                    $("#" + JsEven.id.txt_CompanyNo).val(str);
                    $("#" + JsEven.id.hid_CGuid).val(gv);
                    $("#" + JsEven.id.sp_CName).html(str2);
                    $("#" + JsEven.id.sp_CName).css("color", "");
                    $("#" + JsEven.id.hid_CStatus).val("Y");
                    break;
                case "Dep":
                    $("#" + JsEven.id.txt_Dep).val(str);
                    $("#" + JsEven.id.hid_DepGuid).val(gv);
                    $("#" + JsEven.id.sp_DepName).html(str2);
                    $("#" + JsEven.id.sp_DepName).css("color", "");
                    $("#" + JsEven.id.hid_Depstatus).val("Y");
                    break;
                case "Personnel":
                    $("#" + JsEven.id.txt_PerNo).val(str);
                    $("#" + JsEven.id.sp_PerName).html(str2);
                    $("#" + JsEven.id.hid_PerGuid).val(str);
                    break;
                case "SalaryRange":
                    var t = $('#' + JsEven.Id.hid_RangeType).val();
                    if (t == "S") {
                        $("#" + JsEven.Id.sp_sDate).html(str);
                        $("#" + JsEven.Id.sp_eDate).html(str2);
                        $("#" + JsEven.Id.txt_SalaryRang_S).val(gv);
                    }
                    else
                    {
                        $("#" + JsEven.Id.sp_sDate_Gen).html(str);
                        $("#" + JsEven.Id.sp_eDate_Gen).html(str2);
                        $("#" + JsEven.Id.txt_SalaryRang_Gen).val(gv);
                    }
                    break;
            }
        }

        document.body.onload = function () {

            JsEven.getddl("22", "#" + JsEven.Id.ddls_iitMark);
            JsEven.getddl("23", "#" + JsEven.Id.ddls_iitFormat);
            JsEven.getddl("24", "#" + JsEven.Id.ddls_iitManner);
            JsEven.Inin();
            //$("#" + JsEven.Page2Id.txt_Date_m + ",#" + JsEven.Page2Id.txt_Date_s + ",#" + JsEven.Page2Id.txt_Date_e).datepicker({
            //    changeMonth: true,
            //    changeYear: true,
            //    dateFormat: 'yy/mm/dd',
            //    dayNamesMin: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
            //    monthNamesShort: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
            //    yearRange: '-100:+0',
            //    onClose: function (dateText, inst) {
            //        $(this).datepicker('option', 'dateFormat', 'yy/mm/dd');
            //    }
            //});
        }
    </script>

















</asp:Content>

