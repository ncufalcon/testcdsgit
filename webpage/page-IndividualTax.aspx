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
                  <td class="width35"><input type="text" id="txt_yyyy_gen" autofocus="autofocus" maxlength="4" class="inputex width60"  /></td>
                  <td  style="text-align:right">
                      <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.genPayroll();">開始計算所得稅資料</a>
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
                                    <td id="td_iitPerResidentAddr"></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">通訊地址</div></td>
                                    <td id="td_iitPerAdds"></td>
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
                                        <td style="width:15%"><div class="font-title">憑單格式</div></td>
                                        <td style="width:7%"><select id="ddls_iitFormat" ></select></td>
                                        <td style="width:15%"><div class="font-title">註記</div></td>
                                        <td style="width:7%;text-align:center"><select id="ddls_iitMark" ></select></td>
                                        <td style="width:15%"><div class="font-title">憑單填發方式</div></td>
                                        <td style="width:7%;text-align:center"><select id="ddls_iitManner" ></select></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">給付總額</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_iitPaySum" /></td>             
                                        <td align="right"><div class="font-title titlebackicon">扣繳稅額</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_iitPayTax"/></td>
                                        <td align="right"><div class="font-title titlebackicon">給付淨額</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_iitPayAmount"/></td>
                                   </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">所屬年月起</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_iitYearStart" /></td>                                   
                                        <td align="right"><div class="font-title titlebackicon">所屬年月迄</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_iitYearEnd" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">自提退休金加總</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_iitStock" /></td>                                     
                                        <td align="right"><div class="font-title titlebackicon">證號別</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_iitIdentify" /></td>                                       
                                        <td align="right"><div class="font-title titlebackicon">錯誤註記</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pSickLeaveTimes" /></td>
                                    </tr>
                                      <tr>
                                        <td align="right"><div class="font-title titlebackicon">房屋稅及編號</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_iitHouseTax" /></td>                                     
                                        <td align="right"><div class="font-title titlebackicon">執行業別代號</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_iitIndustryCode" /></td>                                       
                                    </tr>  

                                </table>
                        </div><br /><br />

                    </div><!-- tabs-1 -->

                </div><!-- statabs -->
                <!-- 詳細資料end -->
            </div><!-- fixwidth -->


        </div><!-- WrapperMain -->



    <input id="hid_perGuid" type="hidden" />
    <input id="hid_pPsmGuid" type="hidden" />
    <input id="hid_pGuid" type="hidden" />
    
    <input id="hid_EditType" type="hidden" />
    <input id="hid_RangeType" type="hidden" />
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
                txt_pSickLeaveTimes: 'txt_pSickLeaveTimes',
                txt_iitHouseTax: 'txt_iitHouseTax',
                txt_iitIndustryCode: 'txt_iitIndustryCode'
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
                var rangDate = $('#' + this.Id.txt_SalaryRang_S).val();
                var typ = "";


                if (PerNo == "" && PerName == "" && Com == "" && Dep == "" && rangDate == "") {
                    typ = "Y";
                }


                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var opt = {
                    url: '../handler/Tax/ashx_TaxList.ashx',
                    v: 'PerNo=' + PerNo +
                       '&PerName=' + PerName +
                       '&Company=' + Com +
                       '&Dep=' + Dep +
                       '&SalaryRang=' + rangDate + '&typ=' + typ,
                    type: 'xml',
                    success: function (xmldoc) {

                        var msg = CommonEven.XmlNodeGetValue(xmldoc, "dList");
                        switch (msg) {
                            case "DangerWord":
                                CommonEven.goErrorPage();
                                break;
                            case "Timeout":
                                alert('登入逾時');
                                CommonEven.goLogin();
                                break;
                            case "error":
                                alert('資料發生錯誤，請聯絡管理者');
                                break;
                            default:
                                var div = document.getElementById(JsEven.Id.div_MList);
                                var dList = xmldoc.getElementsByTagName('dList');
                                var dView = xmldoc.getElementsByTagName('dView');

                                if (dView.length != 0) {
                                    CmFmCommon.Xsl(xmldoc, '../xslt/PayRoll/xsl_Payroll.xsl', div);
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
                $.ajax({
                    type: "POST",
                    url: '../handler/Tax/ashx_TaxList.ashx',
                    data: 'guid=' + guid,
                    dataType: 'xml',  //xml, json, script, text, html
                    success: function (xmldoc) {
                        var CView = xmldoc.getElementsByTagName('dView');
                        if (CView.length == 1) {
                            var e = CView[0];
                            var pGuid = CommonEven.XmlNodeGetValue(e, "pGuid");
                            var perGuid = CommonEven.XmlNodeGetValue(e, "pPerGuid");
                            var pPsmGuid = CommonEven.XmlNodeGetValue(e, "pPsmGuid");

                            $('#' + JsEven.Id.hid_perGuid).val(perGuid);
                            $('#' + JsEven.Id.hid_pPsmGuid).val(pPsmGuid);
                            $('#' + JsEven.Id.hid_EditType).val("Edit");
                            $('#' + JsEven.Id.hid_pGuid).val(pGuid);

                            $('#' + JsEven.Page1Id.td_PerNo).html(CommonEven.XmlNodeGetValue(e, "pPerNo"));
                            $('#' + JsEven.Page1Id.td_PerName).html(CommonEven.XmlNodeGetValue(e, "pPerName"));
                            $('#' + JsEven.Page1Id.td_PerCom).html(CommonEven.XmlNodeGetValue(e, "pPerCompanyName"));
                            $('#' + JsEven.Page1Id.td_PerDep).html(CommonEven.XmlNodeGetValue(e, "pPerDep"));

                            $('#' + JsEven.Page1Id.txt_pWeekdayTime1).val(CommonEven.XmlNodeGetValue(e, "pWeekdayTime1"));
                            $('#' + JsEven.Page1Id.txt_pWeekdayTime2).val(CommonEven.XmlNodeGetValue(e, "pWeekdayTime2"));
                            $('#' + JsEven.Page1Id.txt_pWeekdayTime3).val(CommonEven.XmlNodeGetValue(e, "pWeekdayTime3"));
                            $('#' + JsEven.Page1Id.txt_pWeekdaySalary1).val(CommonEven.XmlNodeGetValue(e, "pWeekdaySalary1"));
                            $('#' + JsEven.Page1Id.txt_pWeekdaySalary2).val(CommonEven.XmlNodeGetValue(e, "pWeekdaySalary2"));
                            $('#' + JsEven.Page1Id.txt_pWeekdaySalary3).val(CommonEven.XmlNodeGetValue(e, "pWeekdaySalary3"));

                            $('#' + JsEven.Page1Id.txt_pOffDayTime1).val(CommonEven.XmlNodeGetValue(e, "pOffDayTime1"));
                            $('#' + JsEven.Page1Id.txt_pOffDayTime2).val(CommonEven.XmlNodeGetValue(e, "pOffDayTime2"));
                            $('#' + JsEven.Page1Id.txt_pOffDayTime3).val(CommonEven.XmlNodeGetValue(e, "pOffDayTime3"));
                            $('#' + JsEven.Page1Id.txt_pOffDaySalary1).val(CommonEven.XmlNodeGetValue(e, "pOffDaySalary1"));
                            $('#' + JsEven.Page1Id.txt_pOffDaySalary2).val(CommonEven.XmlNodeGetValue(e, "pOffDaySalary2"));
                            $('#' + JsEven.Page1Id.txt_pOffDaySalary3).val(CommonEven.XmlNodeGetValue(e, "pOffDaySalary3"));

                            $('#' + JsEven.Page1Id.txt_pHolidayTime1).val(CommonEven.XmlNodeGetValue(e, "pHolidayTime1"));
                            $('#' + JsEven.Page1Id.txt_pHolidayTime2).val(CommonEven.XmlNodeGetValue(e, "pHolidayTime2"));
                            $('#' + JsEven.Page1Id.txt_pHolidayTime3).val(CommonEven.XmlNodeGetValue(e, "pHolidayTime3"));
                            $('#' + JsEven.Page1Id.txt_pHolidayTime4).val(CommonEven.XmlNodeGetValue(e, "pHolidayTime4"));
                            $('#' + JsEven.Page1Id.txt_pHolidaySalary1).val(CommonEven.XmlNodeGetValue(e, "pHolidaySalary1"));
                            $('#' + JsEven.Page1Id.txt_pHolidaySalary2).val(CommonEven.XmlNodeGetValue(e, "pHolidaySalary2"));
                            $('#' + JsEven.Page1Id.txt_pHolidaySalary3).val(CommonEven.XmlNodeGetValue(e, "pHolidaySalary3"));
                            $('#' + JsEven.Page1Id.txt_pHolidaySalary4).val(CommonEven.XmlNodeGetValue(e, "pHolidaySalary4"));

                            $('#' + JsEven.Page1Id.txt_pNationalholidaysTime1).val(CommonEven.XmlNodeGetValue(e, "pNationalholidaysTime1"));
                            $('#' + JsEven.Page1Id.txt_pNationalholidaysTime2).val(CommonEven.XmlNodeGetValue(e, "pNationalholidaysTime2"));
                            $('#' + JsEven.Page1Id.txt_pNationalholidaysTime3).val(CommonEven.XmlNodeGetValue(e, "pNationalholidaysTime3"));
                            $('#' + JsEven.Page1Id.txt_pNationalholidaysTime4).val(CommonEven.XmlNodeGetValue(e, "pNationalholidaysTime4"));
                            $('#' + JsEven.Page1Id.txt_pNationalholidaysSalary1).val(CommonEven.XmlNodeGetValue(e, "pNationalholidaysSalary1"));
                            $('#' + JsEven.Page1Id.txt_pNationalholidaysSalary2).val(CommonEven.XmlNodeGetValue(e, "pNationalholidaysSalary2"));
                            $('#' + JsEven.Page1Id.txt_pNationalholidaysSalary3).val(CommonEven.XmlNodeGetValue(e, "pNationalholidaysSalary3"));
                            $('#' + JsEven.Page1Id.txt_pNationalholidaysSalary4).val(CommonEven.XmlNodeGetValue(e, "pNationalholidaysSalary4"));

                            $('#' + JsEven.Page1Id.txt_pAnnualLeaveTimes).val(CommonEven.XmlNodeGetValue(e, "pAnnualLeaveTimes"));
                            $('#' + JsEven.Page1Id.txt_pAnnualLeaveSalary).val(CommonEven.XmlNodeGetValue(e, "pAnnualLeaveSalary"));
                            $('#' + JsEven.Page1Id.txt_pMarriageLeaveTimes).val(CommonEven.XmlNodeGetValue(e, "pMarriageLeaveTimes"));
                            $('#' + JsEven.Page1Id.txt_pMarriageLeaveSalary).val(CommonEven.XmlNodeGetValue(e, "pMarriageLeaveSalary"));
                            $('#' + JsEven.Page1Id.txt_pSickLeaveTimes).val(CommonEven.XmlNodeGetValue(e, "pSickLeaveTimes"));
                            $('#' + JsEven.Page1Id.txt_pSickLeaveSalary).val(CommonEven.XmlNodeGetValue(e, "pSickLeaveSalary"));
                            $('#' + JsEven.Page1Id.txt_pFuneralLeaveTimes).val(CommonEven.XmlNodeGetValue(e, "pFuneralLeaveTimes"));
                            $('#' + JsEven.Page1Id.txt_pFuneralLeaveSalary).val(CommonEven.XmlNodeGetValue(e, "pFuneralLeaveSalary"));
                            $('#' + JsEven.Page1Id.txt_pMaternityLeaveTimes).val(CommonEven.XmlNodeGetValue(e, "pMaternityLeaveTimes"));
                            $('#' + JsEven.Page1Id.txt_pMaternityLeaveSalary).val(CommonEven.XmlNodeGetValue(e, "pMaternityLeaveSalary"));

                            $('#' + JsEven.Page1Id.txt_pProductionLeaveTimes).val(CommonEven.XmlNodeGetValue(e, "pProductionLeaveTimes"));
                            $('#' + JsEven.Page1Id.txt_pProductionLeaveSalary).val(CommonEven.XmlNodeGetValue(e, "pProductionLeaveSalary"));
                            $('#' + JsEven.Page1Id.txt_pMilitaryLeaveTimes).val(CommonEven.XmlNodeGetValue(e, "pMilitaryLeaveTimes"));
                            $('#' + JsEven.Page1Id.txt_pMilitaryLeaveSalary).val(CommonEven.XmlNodeGetValue(e, "pMilitaryLeaveSalary"));
                            $('#' + JsEven.Page1Id.txt_pAbortionLeaveTimes).val(CommonEven.XmlNodeGetValue(e, "pAbortionLeaveTimes"));
                            $('#' + JsEven.Page1Id.txt_pAbortionLeaveSalary).val(CommonEven.XmlNodeGetValue(e, "pAbortionLeaveSalary"));

                            $('#' + JsEven.Page1Id.txt_pHolidayDutyFree).val(CommonEven.XmlNodeGetValue(e, "pHolidayDutyFree"));
                            $('#' + JsEven.Page1Id.txt_pHolidayTaxation).val(CommonEven.XmlNodeGetValue(e, "pHolidayTaxation"));
                            $('#' + JsEven.Page1Id.txt_pNationalholidaysTaxation).val(CommonEven.XmlNodeGetValue(e, "pNationalholidaysTaxation"));
                            $('#' + JsEven.Page1Id.txt_pNationalholidaysDutyFree).val(CommonEven.XmlNodeGetValue(e, "pNationalholidaysDutyFree"));
                            $('#' + JsEven.Page1Id.txt_pHolidaySumDutyFree).val(CommonEven.XmlNodeGetValue(e, "pHolidaySumDutyFree"));
                            $('#' + JsEven.Page1Id.txt_pHolidaySumTaxation).val(CommonEven.XmlNodeGetValue(e, "pHolidaySumTaxation"));
                            $('#' + JsEven.Page1Id.txt_pAttendanceDays).val(CommonEven.XmlNodeGetValue(e, "pAttendanceDays"));
                            $('#' + JsEven.Page1Id.txt_pAttendanceTimes).val(CommonEven.XmlNodeGetValue(e, "pAttendanceTimes"));


                            //$('#' + JsEven.Page1Id.txt_pPayLeave).val(CommonEven.XmlNodeGetValue(e, "pPayLeave"));
                            $('#' + JsEven.Page1Id.txt_pOverTimeDutyfree).val(CommonEven.XmlNodeGetValue(e, "pOverTimeDutyfree"));
                            $('#' + JsEven.Page1Id.txt_pOverTimeTaxation).val(CommonEven.XmlNodeGetValue(e, "pOverTimeTaxation"));
                            $('#' + JsEven.Page1Id.txt_pIntertemporal).val(CommonEven.XmlNodeGetValue(e, "pIntertemporal"));
                            $('#' + JsEven.Page1Id.txt_pSalary).val(CommonEven.XmlNodeGetValue(e, "pSalary"));


                            $('#' + JsEven.Page2Id.txt_pPay).val(CommonEven.XmlNodeGetValue(e, "pPay"));
                            $('#' + JsEven.Page2Id.txt_pTaxation).val(CommonEven.XmlNodeGetValue(e, "pTaxation"));
                            $('#' + JsEven.Page2Id.txt_pTax).val(CommonEven.XmlNodeGetValue(e, "pTax"));
                            $('#' + JsEven.Page2Id.txt_pPremium).val(CommonEven.XmlNodeGetValue(e, "pPremium"));
                            $('#' + JsEven.Page2Id.txt_pPersonInsurance).val(CommonEven.XmlNodeGetValue(e, "pPersonInsurance"));
                            $('#' + JsEven.Page2Id.txt_pPersonLabor).val(CommonEven.XmlNodeGetValue(e, "pPersonLabor"));
                            $('#' + JsEven.Page2Id.txt_pPersonPension).val(CommonEven.XmlNodeGetValue(e, "pPersonPension"));
                            $('#' + JsEven.Page2Id.txt_pCompanyPension).val(CommonEven.XmlNodeGetValue(e, "pCompanyPension"));
                            $('#' + JsEven.Page2Id.txt_pPersonPensionSum).val(CommonEven.XmlNodeGetValue(e, "pPersonPensionSum"));
                            $('#' + JsEven.Page2Id.txt_pCompanyPensionSum).val(CommonEven.XmlNodeGetValue(e, "pCompanyPensionSum"));


                            JsEven.AllList(perGuid, pPsmGuid);
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
                        url: '',
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

                var pGuid = $('#' + this.Id.hid_pGuid).val();
                if (pGuid != "") {
                    var pWeekdayTime1 = $('#' + this.Page1Id.txt_pWeekdayTime1).val();
                    var pWeekdayTime2 = $('#' + this.Page1Id.txt_pWeekdayTime2).val();
                    var pWeekdayTime3 = $('#' + this.Page1Id.txt_pWeekdayTime3).val();
                    var pWeekdaySalary1 = $('#' + this.Page1Id.txt_pWeekdaySalary1).val();
                    var pWeekdaySalary2 = $('#' + this.Page1Id.txt_pWeekdaySalary2).val();
                    var pWeekdaySalary3 = $('#' + this.Page1Id.txt_pWeekdaySalary3).val();
                    var pOffDayTime1 = $('#' + this.Page1Id.txt_pOffDayTime1).val();
                    var pOffDayTime2 = $('#' + this.Page1Id.txt_pOffDayTime2).val();
                    var pOffDayTime3 = $('#' + this.Page1Id.txt_pOffDayTime3).val();
                    var pOffDaySalary1 = $('#' + this.Page1Id.txt_pOffDaySalary1).val();
                    var pOffDaySalary2 = $('#' + this.Page1Id.txt_pOffDaySalary2).val();
                    var pOffDaySalary3 = $('#' + this.Page1Id.txt_pOffDaySalary3).val();
                    var pHolidayTime1 = $('#' + this.Page1Id.txt_pHolidayTime1).val();
                    var pHolidayTime2 = $('#' + this.Page1Id.txt_pHolidayTime2).val();
                    var pHolidayTime3 = $('#' + this.Page1Id.txt_pHolidayTime3).val();
                    var pHolidayTime4 = $('#' + this.Page1Id.txt_pHolidayTime4).val();
                    var pHolidaySalary1 = $('#' + this.Page1Id.txt_pHolidaySalary1).val();
                    var pHolidaySalary2 = $('#' + this.Page1Id.txt_pHolidaySalary2).val();
                    var pHolidaySalary3 = $('#' + this.Page1Id.txt_pHolidaySalary3).val();
                    var pHolidaySalary4 = $('#' + this.Page1Id.txt_pHolidaySalary4).val();
                    var pHolidayDutyFree = $('#' + this.Page1Id.txt_pHolidayDutyFree).val();
                    var pHolidayTaxation = $('#' + this.Page1Id.txt_pHolidayTaxation).val();
                    var pNationalholidaysTime1 = $('#' + this.Page1Id.txt_pNationalholidaysTime1).val();
                    var pNationalholidaysTime2 = $('#' + this.Page1Id.txt_pNationalholidaysTime2).val();
                    var pNationalholidaysTime3 = $('#' + this.Page1Id.txt_pNationalholidaysTime3).val();
                    var pNationalholidaysTime4 = $('#' + this.Page1Id.txt_pNationalholidaysTime4).val();
                    var pNationalholidaysSalary1 = $('#' + this.Page1Id.txt_pNationalholidaysSalary1).val();
                    var pNationalholidaysSalary2 = $('#' + this.Page1Id.txt_pNationalholidaysSalary2).val();
                    var pNationalholidaysSalary3 = $('#' + this.Page1Id.txt_pNationalholidaysSalary3).val();
                    var pNationalholidaysSalary4 = $('#' + this.Page1Id.txt_pNationalholidaysSalary4).val();
                    var pNationalholidaysTaxation = $('#' + this.Page1Id.txt_pNationalholidaysTaxation).val();
                    var pNationalholidaysDutyFree = $('#' + this.Page1Id.txt_pNationalholidaysDutyFree).val();

                    var pHolidaySumDutyFree = $('#' + this.Page1Id.txt_pHolidaySumDutyFree).val();
                    var pHolidaySumTaxation = $('#' + this.Page1Id.txt_pHolidaySumTaxation).val();
                    var pAnnualLeaveTimes = $('#' + this.Page1Id.txt_pAnnualLeaveTimes).val();
                    var pAnnualLeaveSalary = $('#' + this.Page1Id.txt_pAnnualLeaveSalary).val();
                    var pMarriageLeaveTimes = $('#' + this.Page1Id.txt_pMarriageLeaveTimes).val();
                    var pMarriageLeaveSalary = $('#' + this.Page1Id.txt_pMarriageLeaveSalary).val();
                    var pSickLeaveTimes = $('#' + this.Page1Id.txt_pSickLeaveTimes).val();
                    var pSickLeaveSalary = $('#' + this.Page1Id.txt_pSickLeaveSalary).val();
                    var pFuneralLeaveTimes = $('#' + this.Page1Id.txt_pFuneralLeaveTimes).val();
                    var pFuneralLeaveSalary = $('#' + this.Page1Id.txt_pFuneralLeaveSalary).val();
                    var pMaternityLeaveTimes = $('#' + this.Page1Id.txt_pMaternityLeaveTimes).val();
                    var pMaternityLeaveSalary = $('#' + this.Page1Id.txt_pMaternityLeaveSalary).val();

                    var pProductionLeaveTimes = $('#' + this.Page1Id.txt_pProductionLeaveTimes).val();
                    var pProductionLeaveSalary = $('#' + this.Page1Id.txt_pProductionLeaveSalary).val();
                    var pMilitaryLeaveTimes = $('#' + this.Page1Id.txt_pMilitaryLeaveTimes).val();
                    var pMilitaryLeaveSalary = $('#' + this.Page1Id.txt_pMilitaryLeaveSalary).val();
                    var pAbortionLeaveTimes = $('#' + this.Page1Id.txt_pAbortionLeaveTimes).val();
                    var pAbortionLeaveSalary = $('#' + this.Page1Id.txt_pAbortionLeaveSalary).val();

                    var pAttendanceDays = $('#' + this.Page1Id.txt_pAttendanceDays).val();
                    var pAttendanceTimes = $('#' + this.Page1Id.txt_pAttendanceTimes).val();
                    var pOverTimeDutyfree = $('#' + this.Page1Id.txt_pOverTimeDutyfree).val();
                    var pOverTimeTaxation = $('#' + this.Page1Id.txt_pOverTimeTaxation).val();
                    var pIntertemporal = $('#' + this.Page1Id.txt_pIntertemporal).val();
                    var pSalary = $('#' + this.Page1Id.txt_pSalary).val();

                    var pPay = $('#' + this.Page2Id.txt_pPay).val();
                    var pTaxation = $('#' + this.Page2Id.txt_pTaxation).val();
                    var pTax = $('#' + this.Page2Id.txt_pTax).val();
                    var pPremium = $('#' + this.Page2Id.txt_pPremium).val();
                    var pPersonInsurance = $('#' + this.Page2Id.txt_pPersonInsurance).val();
                    var pPersonLabor = $('#' + this.Page2Id.txt_pPersonLabor).val();
                    var pPersonPension = $('#' + this.Page2Id.txt_pPersonPension).val();
                    var pCompanyPension = $('#' + this.Page2Id.txt_pCompanyPension).val();


                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    $.ajax({
                        type: "POST",
                        url: '../handler/Payroll/ashx_PayEdit.ashx',
                        data: 'pGuid=' + pGuid +
                              '&pWeekdayTime1=' + pWeekdayTime1 +
                              '&pWeekdayTime2=' + pWeekdayTime2 +
                              '&pWeekdayTime3=' + pWeekdayTime3 +
                              '&pWeekdaySalary1=' + pWeekdaySalary1 +
                              '&pWeekdaySalary2=' + pWeekdaySalary2 +
                              '&pWeekdaySalary3=' + pWeekdaySalary3 +

                              '&pOffDayTime1=' + pOffDayTime1 +
                              '&pOffDayTime2=' + pOffDayTime2 +
                              '&pOffDayTime3=' + pOffDayTime3 +
                              '&pOffDaySalary1=' + pOffDaySalary1 +
                              '&pOffDaySalary2=' + pOffDaySalary2 +
                              '&pOffDaySalary3=' + pOffDaySalary3 +

                              '&pHolidayTime1=' + pHolidayTime1 +
                              '&pHolidayTime2=' + pHolidayTime2 +
                              '&pHolidayTime3=' + pHolidayTime3 +
                              '&pHolidayTime4=' + pHolidayTime4 +
                              '&pHolidaySalary1=' + pHolidaySalary1 +
                              '&pHolidaySalary2=' + pHolidaySalary2 +
                              '&pHolidaySalary3=' + pHolidaySalary3 +
                              '&pHolidaySalary4=' + pHolidaySalary4 +

                              '&pNationalholidaysTime1=' + pNationalholidaysTime1 +
                              '&pNationalholidaysTime2=' + pNationalholidaysTime2 +
                              '&pNationalholidaysTime3=' + pNationalholidaysTime3 +
                              '&pNationalholidaysTime4=' + pNationalholidaysTime4 +
                              '&pNationalholidaysSalary1=' + pNationalholidaysSalary1 +
                              '&pNationalholidaysSalary2=' + pNationalholidaysSalary2 +
                              '&pNationalholidaysSalary3=' + pNationalholidaysSalary3 +
                              '&pNationalholidaysSalary4=' + pNationalholidaysSalary4 +
                              '&pAnnualLeaveTimes=' + pAnnualLeaveTimes +
                              '&pAnnualLeaveSalary=' + pAnnualLeaveSalary +
                              '&pMarriageLeaveTimes=' + pMarriageLeaveTimes +
                              '&pMarriageLeaveSalary=' + pMarriageLeaveSalary +
                              '&pSickLeaveTimes=' + pSickLeaveTimes +
                              '&pSickLeaveSalary=' + pSickLeaveSalary +
                              '&pFuneralLeaveTimes=' + pFuneralLeaveTimes +
                              '&pFuneralLeaveSalary=' + pFuneralLeaveSalary +
                              '&pMaternityLeaveTimes=' + pMaternityLeaveTimes +
                              '&pMaternityLeaveSalary=' + pMaternityLeaveSalary +
                              '&pProductionLeaveTimes=' + pProductionLeaveTimes +
                              '&pProductionLeaveSalary=' + pProductionLeaveSalary +
                              '&pMilitaryLeaveTimes=' + pMilitaryLeaveTimes +
                              '&pMilitaryLeaveSalary=' + pMilitaryLeaveSalary +
                              '&pAbortionLeaveTimes=' + pAbortionLeaveTimes +
                              '&pAbortionLeaveSalary=' + pAbortionLeaveSalary +

                              '&pHolidayDutyFree=' + pHolidayDutyFree +
                              '&pHolidayTaxation=' + pHolidayTaxation +
                              '&pNationalholidaysTaxation=' + pNationalholidaysTaxation +
                              '&pNationalholidaysDutyFree=' + pNationalholidaysDutyFree +
                              '&pHolidaySumDutyFree=' + pHolidaySumDutyFree +
                              '&pHolidaySumTaxation=' + pHolidaySumTaxation +
                              '&pAttendanceDays=' + pAttendanceDays +
                              '&pAttendanceTimes=' + pAttendanceTimes +
                              '&pOverTimeDutyfree=' + pOverTimeDutyfree +
                              '&pOverTimeTaxation=' + pOverTimeTaxation +
                              '&pIntertemporal=' + pIntertemporal +
                              '&pPay=' + pPay +
                              '&pTaxation=' + pTaxation +
                              '&pTax=' + pTax +
                              '&pPremium=' + pPremium +
                              '&pPersonInsurance=' + pPersonInsurance +
                              '&pPersonLabor=' + pPersonLabor +
                              '&pPersonPension=' + pPersonPension +
                              '&pCompanyPension=' + pCompanyPension +
                              '&pSalary=' + pSalary,
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

            countCost: function () {
                var p = $('#' + JsEven.Page2Id.txt_Pric_m).val();
                var q = $('#' + JsEven.Page2Id.txt_Quantity_m).val();

                p = (p != "") ? p : 0;
                q = (q != "") ? q : 0;
                $('#' + JsEven.Page2Id.txt_Cost_m).val(p * q);

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

            Cancel: function () {
                document.getElementById(JsEven.Id.div_GenTax).style.display = "none";
                document.getElementById(JsEven.Id.div_Search).style.display = "none";
                document.getElementById(JsEven.Id.div_Data).style.display = "block";

            },

            genPayroll: function () {

                var yyyy = $('#' + this.Id.txt_yyyy_gen).val();
                if (yyyy != "") {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    var opt = {
                        url: '../handler/Payroll/ashx_GenTax.ashx',
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
                                    alert('薪資計算完成');
                                    break;
                            }
                            $.unblockUI();
                        }
                    }
                    CmFmCommon.ajax(opt);
                } else { alert('請選擇計薪週期'); }

            },

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

