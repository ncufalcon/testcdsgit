<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Payroll.aspx.cs" Inherits="webpage_page_Payroll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


            <div class="WrapperMain">
 
            <div class="fixwidth">
                <div class="twocol underlineT1 margin10T">
                    <div class="left font-light">首頁 / 薪資管理 / <span class="font-black font-bold">發薪紀錄建立</span></div>
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
                                        <div class="font-title titlebackicon">計薪週期</div>
                                    </td>
                                    <td class="width35">
                                         <table>
                                             <tr>
                                                 <td style="width:150px">日期起:<span id="sp_sDate"></span></td>
                                                 <td style="width:150px">日期迄:<span id="sp_eDate"></span></td>
                                                 <td><img src="../images/btn-search.gif" id="img_SalaryRange" onclick="JsEven.openfancybox(this)" style="cursor:pointer;"/>
                                                     <input id="txt_SalaryRang_S" type="hidden" />
                                                 </td>
                                             </tr>
                                         </table>
<%--                                        <span id="sp_SalaryRang"></span>
                                        <input type="hidden" id="txt_SalaryRang_S" class="inputex width40"  />--%>
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

        <div id="div_GenPayroll" class=" gentable font-normal" style="display:none; height:200px">
          <table  border="0" cellspacing="0" cellpadding="0" style="width:100%">
              <tr>
                  <td ><span class="font-title titlebackicon">日期起</span><span id="sp_sDate_Gen"></span></td>
                  <td ><span class="font-title titlebackicon">日期迄</span><span id="sp_eDate_Gen"></span></td>
                  <td><img src="../images/btn-search.gif" id="img_SalaryRange_Gen" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                      <input id="txt_SalaryRang_Gen" type="hidden" />
                  </td>

              </tr>
              <tr>
                  <td><span class="font-title titlebackicon">員工</span><span id="sp_perName_Gen"></span></td>
                  <td><img src="../images/btn-search.gif" id="img_Person_Gen" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                      <input id="hid_perGuid_Gen" type="hidden" />
                  </td>
                  <td  style="text-align:right">
                      <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.genPayroll();">開始計算薪資</a>
                      <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.genClear();">清除</a>
                      <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.Cancel();">取消</a>
                  </td>

              </tr>

          </table> 
          <div class="font-red" >ps.如需計算個人薪資請選擇人員</div>  
        </div>



        <div id="div_Data">
                    <div class="twocol margin15T">
                            <div class="right">
                                <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.reSearch();">查詢</a>
                                <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.opGenPayroll();">計算薪資</a>
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
                        <li><a href="#tabs-2">計薪資料二</a></li>
                        <li><a href="#tabs-3" >法扣</a></li>
                    </ul>
                    <div id="tabs-1">
                            <div class="twocol margin15TB">
                               <span class="font-red">*請將要修改的欄位修改後，按重新計算，計算完成後請確認數字是否正確，再按儲存。</span>
                                <div class="right">
                                    <a href="javascript:void(0);" id="a_reset" class="keybtn" onclick="JsEven.reSetPay();">重新計算</a>  
                                    <a href="javascript:void(0);" id="a_submit" class="keybtn" onclick="JsEven.Edit();" >儲存</a>                                 
                                </div>
                            </div>
                        <div class="gentable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">員工編號</div></td>
                                    <td class="width15" id="td_PerNo"></td>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">姓名</div></td>
                                    <td class="width15" id="td_PerName"></td>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">申報公司</div></td>
                                    <td class="width15" id="td_PerCom"></td>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">部門</div></td>
                                    <td class="width15" id="td_PerDep"></td>
                                </tr>
                                </table><br /><br />
                                <table width="98%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="width:15%" ></td>
                                        <td style="width:7%;text-align:center"><div class="font-title">時數</div></td>
                                        <td style="width:7%;text-align:center"><div class="font-title">薪資</div></td>
                                        <td style="width:15%"></td>
                                        <td style="width:7%;text-align:center"><div class="font-title">時數</div></td>
                                        <td style="width:7%;text-align:center"><div class="font-title">薪資</div></td>
                                        <td style="width:15%"></td>
                                        <td style="width:7%;text-align:center"><div class="font-title">時數</div></td>
                                        <td style="width:7%;text-align:center"><div class="font-title">薪資</div></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">平日加班時數-1類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pWeekdayTime1" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pWeekdaySalary1"/></td>

                                        <td align="right"><div class="font-title titlebackicon">例假日加班-1類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pHolidayTime1" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pHolidaySalary1"/></td>

                                        <td align="right"><div class="font-title titlebackicon">特休假</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pAnnualLeaveTimes"/></td>
                                        <td><input type="text" class="inputex width95" id="txt_pAnnualLeaveSalary"/></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">平日加班時數-2類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pWeekdayTime2" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pWeekdaySalary2"/></td>

                                        <td align="right"><div class="font-title titlebackicon">例假日加班-2類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pHolidayTime2" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pHolidaySalary2"/></td>

                                        <td align="right"><div class="font-title titlebackicon">婚假</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pMarriageLeaveTimes" /></td>
                                        <td><input type="text" class="inputex width95" id="txt_pMarriageLeaveSalary"/></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">平日加班時數-3類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pWeekdayTime3" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pWeekdaySalary3"/></td>

                                        <td align="right"><div class="font-title titlebackicon">例假日加班-3類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pHolidayTime3" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pHolidaySalary3"/></td>

                                        <td align="right"><div class="font-title titlebackicon">病假</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pSickLeaveTimes" /></td>
                                        <td><input type="text" class="inputex width95" id="txt_pSickLeaveSalary" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">休息日加班時數-1類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pOffDayTime1"  /></td>
                                        <td><input type="text" class="inputex width95" id="txt_pOffDaySalary1" /></td>

                                        <td align="right"><div class="font-title titlebackicon">例假日加班-4類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pHolidayTime4" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pHolidaySalary4"/></td>

                                        <td align="right"><div class="font-title titlebackicon">喪假</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pFuneralLeaveTimes" /></td>
                                        <td><input type="text" class="inputex width95" id="txt_pFuneralLeaveSalary"/></td>


                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">休息日加班時數-2類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pOffDayTime2"  /></td>
                                        <td><input type="text" class="inputex width95" id="txt_pOffDaySalary2" /></td>


                                        <td align="right"><div class="font-title titlebackicon">國定假日加班-1類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysTime1" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysSalary1"/></td>

                                        
                                        <td align="right"><div class="font-title titlebackicon">產假</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pMaternityLeaveTimes" /></td>
                                        <td><input type="text" class="inputex width95" id="txt_pMaternityLeaveSalary"/></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">休息日加班時數-3類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pOffDayTime3"  /></td>
                                        <td><input type="text" class="inputex width95" id="txt_pOffDaySalary3" /></td>

                                        <td align="right"><div class="font-title titlebackicon">國定假日加班-2類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysTime2" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysSalary2"/></td>

                                        <td align="right"><div class="font-title titlebackicon">陪產假</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pProductionLeaveTimes" /></td>
                                        <td><input type="text" class="inputex width95" id="txt_pProductionLeaveSalary"/></td>
                                    </tr>

                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">國定假日加班-3類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysTime3" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysSalary3"/></td>

                                        <td align="right"><div class="font-title titlebackicon">兵役假</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pMilitaryLeaveTimes" /></td>
                                        <td><input type="text" class="inputex width95" id="txt_pMilitaryLeaveSalary"/></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">本薪</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pSalary" /></td>
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">國定假日加班-4類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysTime4" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysSalary4"/></td>
                                        <td align="right"><div class="font-title titlebackicon">流產假</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pAbortionLeaveTimes" /></td>
                                        <td><input type="text" class="inputex width95" id="txt_pAbortionLeaveSalary"/></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">例假日加班免稅時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pHolidayDutyFree"  /></td>
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">國定假加班免稅時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysDutyFree" /></td>                                       
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon" style="display:none">假日加班免稅時數</div></td>
                                        <td><input style="display:none" type="text" class="inputex width95" id="txt_pHolidaySumDutyFree" /></td>                                       
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">例假日加班課稅時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pHolidayTaxation"  /></td>
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">國定假加班課稅時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysTaxation" /></td>                                       
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon " style="display:none">假日加班課稅時數</div></td>
                                        <td><input type="text" style="display:none" class="inputex width95" id="txt_pHolidaySumTaxation" /></td>                                       
                                        <td>&nbsp;</td>
                                    </tr>

                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">出勤天數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pAttendanceDays" /></td>
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">加班費免稅金額</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pOverTimeDutyfree" /></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">出勤時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pAttendanceTimes"/></td>
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">加班費課稅金額</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pOverTimeTaxation" /></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">跨期調整金額</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pIntertemporal" /></td>
                                    </tr>
                                </table>
                        </div><br /><br />
                        <hr />
                         <span class="font-size3 font-bold ">個人津貼</span>
                        <div class="stripeMe font-normal" id="div_All" >
                        </div>
                    </div><!-- tabs-1 -->
                    <div id="tabs-2">
                            <div class="twocol margin15TB">
                                <div class="right">                                    
                                    <a href="javascript:void(0);" class="keybtn" onclick="JsEven.Edit();">儲存</a>                                 
                                </div>
                            </div>
                        <div class="gentable">

                            <table width="100%" border="0" cellspacing="0" cellpadding="0">

                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">實付金額</div></td>
                                    <td><input type="text" class="inputex width60" id="txt_pPay"/></td>
                                    <td align="right"><div class="font-title titlebackicon">課稅所得</div></td>
                                    <td><input type="text" class="inputex width60" id="txt_pTaxation"/></td>
                                    <td align="right"><div class="font-title titlebackicon">扣繳稅額</div></td>
                                    <td><input type="text" class="inputex width60" id="txt_pTax"/></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">補充保費</div></td>
                                    <td><input type="text" class="inputex width60" id="txt_pPremium"/></td>
                                    <td align="right"><div class="font-title titlebackicon">健保費</div></td>
                                    <td><input type="text" class="inputex width60" id="txt_pPersonInsurance"/></td>
                                    <td align="right"><div class="font-title titlebackicon">勞保費</div></td>
                                    <td><input type="text" class="inputex width60" id="txt_pPersonLabor"/></td>
                                </tr>
                     </table>
                            <hr />
                            <span class="font-size3 font-bold ">退休金</span>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">

                                <tr>
                                    <td class="width15" align="right"><div class="font-title titlebackicon">員工本月提繳金額</div></td>
                                    <td class="width10"><input type="text" class="inputex width60" id="txt_pPersonPension" /></td>
                                    <td class="width15" align="right"><div class="font-title titlebackicon">公司本月提繳金額</div></td>
                                    <td class="width10"><input type="text" class="inputex width60" id="txt_pCompanyPension"/></td>
                                    <td class="width15" align="right"><div class="font-title titlebackicon">員工累計提繳金額</div></td>
                                    <td class="width10"><input type="text" class="inputex width60" id="txt_pPersonPensionSum"/></td>
                                    <td class="width15" align="right"><div class="font-title titlebackicon">公司累計提繳金額</div></td>
                                    <td class="width10"><input type="text" class="inputex width60" id="txt_pCompanyPensionSum"/></td>
                                </tr>
                            </table>

                        </div>
                    </div><!-- tabs-1 -->
                    <div id="tabs-3">
                        <div class="stripeMe font-normal" id="div_Buckle">
                            <%--<table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <th nowrap="nowrap">債權人</th>
                                    <th nowrap="nowrap">移轉比率</th>
                                    <th nowrap="nowrap">分配金額</th>
                                    <th nowrap="nowrap">手續費</th>
                                    <th nowrap="nowrap">實際匯款金額</th>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap">台灣銀行</td>
                                    <td nowrap="nowrap">14%</td>
                                    <td nowrap="nowrap">6700</td>
                                    <td nowrap="nowrap">30</td>
                                    <td nowrap="nowrap">6700</td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap">台灣銀行</td>
                                    <td nowrap="nowrap">14%</td>
                                    <td nowrap="nowrap">6700</td>
                                    <td nowrap="nowrap">30</td>
                                    <td nowrap="nowrap">6700</td>
                                </tr>

                            </table>--%>
                        </div>
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

            Id:{
                div_Search: 'div_Search',
                div_Data: 'div_Data',
                txt_PerNo_S:'txt_PerNo_S',
                txt_PerName_S: 'txt_PerName_S',
                txt_Comp_S: 'txt_Comp_S',
                txt_Dep_S: 'txt_Dep_S',
                txt_SalaryRang_S: 'txt_SalaryRang_S',
                hid_perGuid: 'hid_perGuid',
                hid_pGuid:'hid_pGuid',
                hid_pPsmGuid: 'hid_pPsmGuid',
                hid_EditType: 'hid_EditType',
                div_MList: 'div_MList',
                sp_sDate: 'sp_sDate',
                sp_eDate: 'sp_eDate',
                hid_RangeType: 'hid_RangeType',
                sp_sDate_Gen: 'sp_sDate_Gen',
                sp_eDate_Gen: 'sp_eDate_Gen',
                txt_SalaryRang_Gen: 'txt_SalaryRang_Gen',
                div_GenPayroll: 'div_GenPayroll',
                hid_perGuid_Gen: 'hid_perGuid_Gen',
                sp_perName_Gen: 'sp_perName_Gen'
            },

            Page1Id: {
                div_All:'div_All',
                //人員資料
                td_PerNo: 'td_PerNo',
                td_PerName: 'td_PerName',
                td_PerCom: 'td_PerCom',
                td_PerDep: 'td_PerDep',

                //加班類別
                txt_pWeekdayTime1: 'txt_pWeekdayTime1',                                        
                txt_pWeekdayTime2: 'txt_pWeekdayTime2',
                txt_pWeekdayTime3: 'txt_pWeekdayTime3',
                txt_pWeekdaySalary1: 'txt_pWeekdaySalary1',
                txt_pWeekdaySalary2: 'txt_pWeekdaySalary2',
                txt_pWeekdaySalary3: 'txt_pWeekdaySalary3',

                txt_pHolidayTime1: 'txt_pHolidayTime1',
                txt_pHolidaySalary1:'txt_pHolidaySalary1',
                txt_pHolidayTime2: 'txt_pHolidayTime2',
                txt_pHolidaySalary2:'txt_pHolidaySalary2',
                txt_pHolidayTime3: 'txt_pHolidayTime3',
                txt_pHolidaySalary3:'txt_pHolidaySalary3',
                txt_pHolidayTime4: 'txt_pHolidayTime4',
                txt_pHolidaySalary4: 'txt_pHolidaySalary4',

                txt_pOffDayTime1:'txt_pOffDayTime1',
                txt_pOffDaySalary1:'txt_pOffDaySalary1',
                txt_pOffDayTime2:'txt_pOffDayTime2',
                txt_pOffDaySalary2:'txt_pOffDaySalary2',
                txt_pOffDayTime3:'txt_pOffDayTime3',
                txt_pOffDaySalary3:'txt_pOffDaySalary3',

                txt_pNationalholidaysTime1:'txt_pNationalholidaysTime1',
                txt_pNationalholidaysSalary1:'txt_pNationalholidaysSalary1',
                txt_pNationalholidaysTime2:'txt_pNationalholidaysTime2',
                txt_pNationalholidaysSalary2:'txt_pNationalholidaysSalary2',
                txt_pNationalholidaysTime3:'txt_pNationalholidaysTime3',
                txt_pNationalholidaysSalary3:'txt_pNationalholidaysSalary3',
                txt_pNationalholidaysTime4:'txt_pNationalholidaysTime4',
                txt_pNationalholidaysSalary4:'txt_pNationalholidaysSalary4',

                //給薪假
                txt_pAnnualLeaveTimes:'txt_pAnnualLeaveTimes',
                txt_pAnnualLeaveSalary:'txt_pAnnualLeaveSalary',
                txt_pMarriageLeaveTimes:'txt_pMarriageLeaveTimes',
                txt_pMarriageLeaveSalary:'txt_pMarriageLeaveSalary',
                txt_pSickLeaveTimes:'txt_pSickLeaveTimes',
                txt_pSickLeaveSalary:'txt_pSickLeaveSalary',
                txt_pFuneralLeaveTimes:'txt_pFuneralLeaveTimes',
                txt_pFuneralLeaveSalary:'txt_pFuneralLeaveSalary',
                txt_pMaternityLeaveTimes:'txt_pMaternityLeaveTimes',
                txt_pMaternityLeaveSalary:'txt_pMaternityLeaveSalary',
                txt_pProductionLeaveTimes: 'txt_pProductionLeaveTimes',
                txt_pProductionLeaveSalary: 'txt_pProductionLeaveSalary',
                txt_pMilitaryLeaveTimes: 'txt_pMilitaryLeaveTimes',
                txt_pMilitaryLeaveSalary: 'txt_pMilitaryLeaveSalary',
                txt_pAbortionLeaveTimes: 'txt_pAbortionLeaveTimes',
                txt_pAbortionLeaveSalary: 'txt_pAbortionLeaveSalary',
                
                txt_pHolidayDutyFree: 'txt_pHolidayDutyFree',
                txt_pHolidayTaxation: 'txt_pHolidayTaxation',
                txt_pNationalholidaysTaxation: 'txt_pNationalholidaysTaxation',
                txt_pNationalholidaysDutyFree: 'txt_pNationalholidaysDutyFree',
                txt_pHolidaySumDutyFree: 'txt_pHolidaySumDutyFree',
                txt_pHolidaySumTaxation: 'txt_pHolidaySumTaxation',

                //出勤
                txt_pAttendanceDays: 'txt_pAttendanceDays',
                txt_pAttendanceTimes: 'txt_pAttendanceTimes',

                txt_pPayLeave: 'txt_pPayLeave',
                txt_pOverTimeDutyfree: 'txt_pOverTimeDutyfree',
                txt_pOverTimeTaxation: 'txt_pOverTimeTaxation',
                txt_pIntertemporal: 'txt_pIntertemporal',

                txt_pSalary: 'txt_pSalary'


            },

            Page2Id: {                
                txt_pPay: 'txt_pPay',
                txt_pTaxation: 'txt_pTaxation',
                txt_pTax:'txt_pTax',
                txt_pPremium: 'txt_pPremium',
                txt_pPersonInsurance: 'txt_pPersonInsurance',
                txt_pPersonLabor: 'txt_pPersonLabor',
                txt_pPersonPension: 'txt_pPersonPension',
                txt_pCompanyPension: 'txt_pCompanyPension',
                txt_pPersonPensionSum: 'txt_pPersonPensionSum',
                txt_pCompanyPensionSum: 'txt_pCompanyPensionSum',
            },
            Page3Id: {
                div_Buckle: 'div_Buckle'
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


                if (PerNo == "" && PerName == "" && Com == "" && Dep == "" && rangDate == "" ) {
                    typ = "Y";
                }


                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var opt = {
                    url: '../handler/Payroll/ashx_PayList.ashx',
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

            AllList: function (perGuid, pPsmGuid) {


                var opt = {
                    url: '../handler/Payroll/ashx_AllList.ashx',
                    v: 'psaPerGuid=' + perGuid +
                       '&psaPsmGuid=' + pPsmGuid,
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
                                var div = document.getElementById(JsEven.Page1Id.div_All);
                                var dList = xmldoc.getElementsByTagName('dList');
                                var dView = xmldoc.getElementsByTagName('dView');

                                if (dView.length != 0) {
                                    CmFmCommon.Xsl(xmldoc, '../xslt/PayRoll/xsl_Allowance.xsl', div);
                                    LicEven.tblClass();

                                } else { div.innerHTML = '目前無任何資料'; }

                                document.getElementById(JsEven.Id.div_Search).style.display = "none";
                                document.getElementById(JsEven.Id.div_Data).style.display = "block";
                                //tableHeadFixer();
                                //$.fn.tableHeadFixer($('.table'));
                                break;
                        }
                    }
                }
                CmFmCommon.ajax(opt);
            },
            
            BuckleList: function () {

                var perGuid = $('#' + this.Id.hid_perGuid).val();
                var pPsmGuid = $('#' + this.Id.hid_pPsmGuid).val();

                if (perGuid != '' && pPsmGuid != '') {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    var opt = {
                        url: '../handler/Payroll/ashx_BuckleList.ashx',
                        v: 'psbPerGuid=' + perGuid +
                           '&psbPsmGuid=' + pPsmGuid,
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
                                    var div = document.getElementById(JsEven.Page3Id.div_Buckle);
                                    var dList = xmldoc.getElementsByTagName('dList');
                                    var dView = xmldoc.getElementsByTagName('dView');

                                    if (dView.length != 0) {
                                        CmFmCommon.Xsl(xmldoc, '../xslt/PayRoll/xsl_Buckle.xsl', div);
                                        LicEven.tblClass();

                                    } else { div.innerHTML = '目前無任何資料'; }
                                    break;
                            }
                            $.unblockUI();
                        }
                    }
                    CmFmCommon.ajax(opt);
                }
            },
            
            view: function (a) {
                var guid = a.getAttribute('guid');
                $.ajax({
                    type: "POST",
                    url: '../handler/Payroll/ashx_SelPayroll.ashx',
                    data: 'guid=' + guid,
                    dataType: 'xml',  //xml, json, script, text, html
                    success: function (xmldoc) {
                        var msg = CommonEven.XmlNodeGetValue(xmldoc, "dList");

                        switch (msg) {
                            case "DangerWord":
                                CommonEven.goErrorPage();
                                break;
                            case "Timeout":
                                alert("請重新登入");
                                CommonEven.goLogin();
                                break;
                            default:


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
                                    JsEven.BuckleList();
                                }
                                else {
                                    alert('資料發生錯誤')
                                }

                                break;
                        }


                    },
                    error: function (xhr, statusText) {
                        //alert(xhr.status);
                        alert('資料發生錯誤');
                    }
                });
            },
      


            
            viewReSet: function (guid) {
                //var guid = a.getAttribute('guid');
                $.ajax({
                    type: "POST",
                    url: '../handler/Payroll/ashx_SelPayrollTmp.ashx',
                    data: 'guid=' + guid,
                    dataType: 'xml',  //xml, json, script, text, html
                    success: function (xmldoc) {
                        var msg = CommonEven.XmlNodeGetValue(xmldoc, "dList");

                        switch (msg) {
                            case "DangerWord":
                                CommonEven.goErrorPage();
                                break;
                            case "Timeout":
                                alert("請重新登入");
                                CommonEven.goLogin();
                                break;
                            default:


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
                                    JsEven.BuckleListReSet();
                                }
                                else {
                                    alert('資料發生錯誤')
                                }

                                break;
                        }


                    },
                    error: function (xhr, statusText) {
                        //alert(xhr.status);
                        alert('資料發生錯誤');
                    }
                });
            },

            AllListReSet: function () {

                var perGuid = $('#' + this.Id.hid_perGuid).val();
                var pPsmGuid = $('#' + this.Id.hid_pPsmGuid).val();
                var opt = {
                    url: '../handler/Payroll/ashx_AllTmpList.ashx',
                    v: 'psaPerGuid=' + perGuid +
                       '&psaPsmGuid=' + pPsmGuid,
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
                                var div = document.getElementById(JsEven.Page1Id.div_All);
                                var dList = xmldoc.getElementsByTagName('dList');
                                var dView = xmldoc.getElementsByTagName('dView');

                                if (dView.length != 0) {
                                    CmFmCommon.Xsl(xmldoc, '../xslt/PayRoll/xsl_Allowance.xsl', div);
                                    LicEven.tblClass();

                                } else { div.innerHTML = '目前無任何資料'; }

                                document.getElementById(JsEven.Id.div_Search).style.display = "none";
                                document.getElementById(JsEven.Id.div_Data).style.display = "block";
                                //tableHeadFixer();
                                //$.fn.tableHeadFixer($('.table'));
                                break;
                        }
                    }
                }
                CmFmCommon.ajax(opt);
            },

            BuckleListReSet: function () {

                var perGuid = $('#' + this.Id.hid_perGuid).val();
                var pPsmGuid = $('#' + this.Id.hid_pPsmGuid).val();
                if (perGuid != '' && pPsmGuid != '') {
                    //$.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    var opt = {
                        url: '../handler/Payroll/ashx_BuckleListTmp.ashx',
                        v: 'psbPerGuid=' + perGuid +
                           '&psbPsmGuid=' + pPsmGuid,
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
                                    var div = document.getElementById(JsEven.Page3Id.div_Buckle);
                                    var dList = xmldoc.getElementsByTagName('dList');
                                    var dView = xmldoc.getElementsByTagName('dView');

                                    if (dView.length != 0) {
                                        CmFmCommon.Xsl(xmldoc, '../xslt/PayRoll/xsl_Buckle.xsl', div);
                                        LicEven.tblClass();

                                    } else { div.innerHTML = '目前無任何資料'; }
                                    break;
                            }
                            //$.unblockUI();
                        }
                    }
                    CmFmCommon.ajax(opt);
                }
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
                    //var pWeekdayTime1 = $('#' + this.Page1Id.txt_pWeekdayTime1).val();
                    //var pWeekdayTime2 = $('#' + this.Page1Id.txt_pWeekdayTime2).val();
                    //var pWeekdayTime3 = $('#' + this.Page1Id.txt_pWeekdayTime3).val();
                    //var pWeekdaySalary1 = $('#' + this.Page1Id.txt_pWeekdaySalary1).val();
                    //var pWeekdaySalary2 = $('#' + this.Page1Id.txt_pWeekdaySalary2).val();
                    //var pWeekdaySalary3 = $('#' + this.Page1Id.txt_pWeekdaySalary3).val();
                    //var pOffDayTime1 = $('#' + this.Page1Id.txt_pOffDayTime1).val();
                    //var pOffDayTime2 = $('#' + this.Page1Id.txt_pOffDayTime2).val();
                    //var pOffDayTime3 = $('#' + this.Page1Id.txt_pOffDayTime3).val();
                    //var pOffDaySalary1 = $('#' + this.Page1Id.txt_pOffDaySalary1).val();
                    //var pOffDaySalary2 = $('#' + this.Page1Id.txt_pOffDaySalary2).val();
                    //var pOffDaySalary3 = $('#' + this.Page1Id.txt_pOffDaySalary3).val();
                    //var pHolidayTime1 = $('#' + this.Page1Id.txt_pHolidayTime1).val();
                    //var pHolidayTime2 = $('#' + this.Page1Id.txt_pHolidayTime2).val();
                    //var pHolidayTime3 = $('#' + this.Page1Id.txt_pHolidayTime3).val();
                    //var pHolidayTime4 = $('#' + this.Page1Id.txt_pHolidayTime4).val();
                    //var pHolidaySalary1 = $('#' + this.Page1Id.txt_pHolidaySalary1).val();
                    //var pHolidaySalary2 = $('#' + this.Page1Id.txt_pHolidaySalary2).val();
                    //var pHolidaySalary3 = $('#' + this.Page1Id.txt_pHolidaySalary3).val();
                    //var pHolidaySalary4 = $('#' + this.Page1Id.txt_pHolidaySalary4).val();
                    //var pHolidayDutyFree = $('#' + this.Page1Id.txt_pHolidayDutyFree).val();
                    //var pHolidayTaxation = $('#' + this.Page1Id.txt_pHolidayTaxation).val();
                    //var pNationalholidaysTime1 = $('#' + this.Page1Id.txt_pNationalholidaysTime1).val();
                    //var pNationalholidaysTime2 = $('#' + this.Page1Id.txt_pNationalholidaysTime2).val();
                    //var pNationalholidaysTime3 = $('#' + this.Page1Id.txt_pNationalholidaysTime3).val();
                    //var pNationalholidaysTime4 = $('#' + this.Page1Id.txt_pNationalholidaysTime4).val();
                    //var pNationalholidaysSalary1 = $('#' + this.Page1Id.txt_pNationalholidaysSalary1).val();
                    //var pNationalholidaysSalary2 = $('#' + this.Page1Id.txt_pNationalholidaysSalary2).val();
                    //var pNationalholidaysSalary3 = $('#' + this.Page1Id.txt_pNationalholidaysSalary3).val();
                    //var pNationalholidaysSalary4 = $('#' + this.Page1Id.txt_pNationalholidaysSalary4).val();
                    //var pNationalholidaysTaxation = $('#' + this.Page1Id.txt_pNationalholidaysTaxation).val();
                    //var pNationalholidaysDutyFree = $('#' + this.Page1Id.txt_pNationalholidaysDutyFree).val();

                    //var pHolidaySumDutyFree = $('#' + this.Page1Id.txt_pHolidaySumDutyFree).val();
                    //var pHolidaySumTaxation = $('#' + this.Page1Id.txt_pHolidaySumTaxation).val();
                    //var pAnnualLeaveTimes = $('#' + this.Page1Id.txt_pAnnualLeaveTimes).val();
                    //var pAnnualLeaveSalary = $('#' + this.Page1Id.txt_pAnnualLeaveSalary).val();
                    //var pMarriageLeaveTimes = $('#' + this.Page1Id.txt_pMarriageLeaveTimes).val();
                    //var pMarriageLeaveSalary = $('#' + this.Page1Id.txt_pMarriageLeaveSalary).val();
                    //var pSickLeaveTimes = $('#' + this.Page1Id.txt_pSickLeaveTimes).val();
                    //var pSickLeaveSalary = $('#' + this.Page1Id.txt_pSickLeaveSalary).val();
                    //var pFuneralLeaveTimes = $('#' + this.Page1Id.txt_pFuneralLeaveTimes).val();
                    //var pFuneralLeaveSalary = $('#' + this.Page1Id.txt_pFuneralLeaveSalary).val();
                    //var pMaternityLeaveTimes = $('#' + this.Page1Id.txt_pMaternityLeaveTimes).val();
                    //var pMaternityLeaveSalary = $('#' + this.Page1Id.txt_pMaternityLeaveSalary).val();

                    //var pProductionLeaveTimes = $('#' + this.Page1Id.txt_pProductionLeaveTimes).val();
                    //var pProductionLeaveSalary = $('#' + this.Page1Id.txt_pProductionLeaveSalary).val();
                    //var pMilitaryLeaveTimes = $('#' + this.Page1Id.txt_pMilitaryLeaveTimes).val();
                    //var pMilitaryLeaveSalary = $('#' + this.Page1Id.txt_pMilitaryLeaveSalary).val();
                    //var pAbortionLeaveTimes = $('#' + this.Page1Id.txt_pAbortionLeaveTimes).val();
                    //var pAbortionLeaveSalary = $('#' + this.Page1Id.txt_pAbortionLeaveSalary).val();

                    //var pAttendanceDays = $('#' + this.Page1Id.txt_pAttendanceDays).val();
                    //var pAttendanceTimes = $('#' + this.Page1Id.txt_pAttendanceTimes).val();
                    //var pOverTimeDutyfree = $('#' + this.Page1Id.txt_pOverTimeDutyfree).val();
                    //var pOverTimeTaxation = $('#' + this.Page1Id.txt_pOverTimeTaxation).val();
                    //var pIntertemporal = $('#' + this.Page1Id.txt_pIntertemporal).val();
                    //var pSalary = $('#' + this.Page1Id.txt_pSalary).val();
                    
                    //var pPay = $('#' + this.Page2Id.txt_pPay).val();
                    //var pTaxation = $('#' + this.Page2Id.txt_pTaxation).val();
                    //var pTax = $('#' + this.Page2Id.txt_pTax).val();
                    //var pPremium = $('#' + this.Page2Id.txt_pPremium).val();
                    //var pPersonInsurance = $('#' + this.Page2Id.txt_pPersonInsurance).val();
                    //var pPersonLabor = $('#' + this.Page2Id.txt_pPersonLabor).val();
                    //var pPersonPension = $('#' + this.Page2Id.txt_pPersonPension).val();
                    //var pCompanyPension = $('#' + this.Page2Id.txt_pCompanyPension).val();


                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    $.ajax({
                        type: "POST",
                        url: '../handler/Payroll/ashx_PayEdit.ashx',
                        data: 'pGuid=' + pGuid,
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
                } else { alert('請選擇要修改的資料');}


            },

            reSetPay:function(){
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

                    var pAttendanceDays = $('#' + this.Page1Id.txt_pAttendanceDays).val();
                    var pAttendanceTimes = $('#' + this.Page1Id.txt_pAttendanceTimes).val();
                      
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    $.ajax({
                        type: "POST",
                        url: '../handler/Payroll/ashx_reSetPay.ashx',
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
                              '&pSalary=' + pSalary,
                        dataType: 'text',  //xml, json, script, text, html
                        success: function (msg) {
                            switch (msg) {
                                case "ok":
                                    JsEven.viewReSet(pGuid);
                                    JsEven.AllListReSet();
                                    JsEven.AllList();                                   
                                    alert('重新計算成功，請確認資訊後按儲存');
                                    $.unblockUI();
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
                document.getElementById(JsEven.Id.div_GenPayroll).style.display = "none";
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
                    case "img_Person_Gen":
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
                document.getElementById(JsEven.Id.div_GenPayroll).style.display = "block";
                document.getElementById(JsEven.Id.div_Search).style.display = "none";
                document.getElementById(JsEven.Id.div_Data).style.display = "none";

            },

            Cancel: function () {
                document.getElementById(JsEven.Id.div_GenPayroll).style.display = "none";
                document.getElementById(JsEven.Id.div_Search).style.display = "none";
                document.getElementById(JsEven.Id.div_Data).style.display = "block";

            },

            genPayroll: function () {

                var rGuid = $('#' + this.Id.txt_SalaryRang_Gen).val();
                var perGuid = $('#' + this.Id.hid_perGuid_Gen).val();
                if (rGuid != "") {
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    var opt = {
                        url: '../handler/Payroll/ashx_GenPayroll.ashx',
                        v: 'rGuid=' + rGuid + '&perGuid=' + perGuid,
                        type: 'text',
                        success: function (msg) {

                            switch (msg) {
                                case "DangerWord":
                                    CommonEven.goErrorPage();
                                    $.unblockUI();
                                    break;
                                case "Timeout":
                                    alert('登入逾時');
                                    CommonEven.goLogin();
                                    $.unblockUI();
                                    break;
                                case "error":
                                    alert('資料發生錯誤，請聯絡管理者');
                                    $.unblockUI();
                                    break;
                                default:
                                    JsEven.List();
                                    document.getElementById(JsEven.Id.div_GenPayroll).style.display = "none";
                                    document.getElementById(JsEven.Id.div_Search).style.display = "none";
                                    document.getElementById(JsEven.Id.div_Data).style.display = "block";
                                    alert('薪資計算完成');
                                    break;
                            }
                            
                        }
                    }
                    CmFmCommon.ajax(opt);
                } else { alert('請選擇計薪週期');}

            },

            genClear:function(){
                $('#' + this.Id.sp_sDate_Gen).html('');
                $('#' + this.Id.sp_eDate_Gen).html('');
                $('#' + this.Id.sp_perName_Gen).html('');
                $('#' + this.Id.hid_perGuid_Gen).val('');
            },

            payChange: function () {

                var pSalary = $('#' + this.Page1Id.txt_pSalary).val(); //本薪
                var pWeekdaySalary1 = $('#' + this.Page1Id.txt_pWeekdaySalary1).val();//平日加班時數-1類
                var pWeekdaySalary2 = $('#' + this.Page1Id.txt_pWeekdaySalary2).val();//平日加班時數-2類
                var pWeekdaySalary3 = $('#' + this.Page1Id.txt_pWeekdaySalary3).val();//平日加班時數-3類

                var pOffDaySalary1 = $('#' + this.Page1Id.txt_pOffDaySalary1).val();//休息日加班時數-1類
                var pOffDaySalary2 = $('#' + this.Page1Id.txt_pOffDaySalary2).val();//休息日加班時數-2類
                var pOffDaySalary3 = $('#' + this.Page1Id.txt_pOffDaySalary3).val();//休息日加班時數-3類

                var pHolidaySalary1 = $('#' + this.Page1Id.txt_pHolidaySalary1).val();//例假日加班-1類
                var pHolidaySalary2 = $('#' + this.Page1Id.txt_pHolidaySalary2).val();//例假日加班-2類
                var pHolidaySalary3 = $('#' + this.Page1Id.txt_pHolidaySalary3).val();//例假日加班-3類
                var pHolidaySalary4 = $('#' + this.Page1Id.txt_pHolidaySalary4).val();//例假日加班-4類

                var pNationalholidaysSalary1 = $('#' + this.Page1Id.txt_pNationalholidaysSalary1).val();//國定假日加班-1類
                var pNationalholidaysSalary2 = $('#' + this.Page1Id.txt_pNationalholidaysSalary2).val();//國定假日加班-2類
                var pNationalholidaysSalary3 = $('#' + this.Page1Id.txt_pNationalholidaysSalary3).val();//國定假日加班-3類
                var pNationalholidaysSalary4 = $('#' + this.Page1Id.txt_pNationalholidaysSalary4).val();//國定假日加班-4類

                var pAnnualLeaveSalary = $('#' + this.Page1Id.txt_pAnnualLeaveSalary).val();//特休假
                var pMarriageLeaveSalary = $('#' + this.Page1Id.txt_pMarriageLeaveSalary).val();//婚假
                var pSickLeaveSalary = $('#' + this.Page1Id.txt_pSickLeaveSalary).val();//病假
                var pFuneralLeaveSalary = $('#' + this.Page1Id.txt_pFuneralLeaveSalary).val();//喪假
                var pMaternityLeaveSalary = $('#' + this.Page1Id.txt_pMaternityLeaveSalary).val();//產假
                var pProductionLeaveSalary = $('#' + this.Page1Id.txt_pProductionLeaveSalary).val();//陪產假
                var pMilitaryLeaveSalary = $('#' + this.Page1Id.txt_pMilitaryLeaveSalary).val();//兵役假
                var pAbortionLeaveSalary = $('#' + this.Page1Id.txt_pAbortionLeaveSalary).val();//流產假

                var pPremium = $('#' + this.Page1Id.txt_pPremium).val();//補充保費
                var pPersonInsurance = $('#' + this.Page1Id.txt_pPersonInsurance).val();//健保費
                var pPersonLabor = $('#' + this.Page1Id.txt_pPersonLabor).val();//勞保費
                var pPersonPension = $('#' + this.Page1Id.txt_pPersonPension).val();//員工本月提繳金額
            },

            chkData: function (val) {
                return (val != "") ? val : 0;
            },

            delPayroll: function (a) {
                if (confirm('刪除後無法回復，您確定要刪除嗎?')) {
                    var pGuid = a.getAttribute('guid');
                    $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                    $.ajax({
                        type: "POST",
                        url: '../handler/Payroll/ashx_DelPayroll.ashx',
                        data: 'pGuid=' + pGuid,
                        dataType: 'text',  //xml, json, script, text, html
                        success: function (msg) {
                            switch (msg) {
                                case "ok":
                                    alert('刪除成功');
                                    var tbl = document.getElementById('tbl_List');
                                    var trTag = tbl.getElementsByTagName('tr');
                                    for (var i = 0; i < trTag.length; i++) {
                                        var tag = trTag[i];
                                        if (tag.getAttribute('guid') == pGuid)
                                            tag.parentNode.removeChild(tag);
                                    }
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
                            alert('資料發生錯誤');

                        }
                    });
                }

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
                    $("#" + JsEven.Id.sp_perName_Gen).html(str2 + '(' + str + ')');
                    $("#" + JsEven.Id.hid_perGuid_Gen).val(gv);
                    //alert(gv);
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
            JsEven.Inin();
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

