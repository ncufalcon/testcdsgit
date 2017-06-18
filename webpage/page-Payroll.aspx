<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Payroll.aspx.cs" Inherits="webpage_page_Payroll" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

            <div class="WrapperMain">
 
            <div class="fixwidth">
                <div class="twocol underlineT1 margin10T">
                    <div class="left font-light">首頁 / 薪資管理 / <span class="font-black font-bold">薪資管理</span></div>
                </div>
                <div class="twocol margin15T">
                    <div class="right">
                        <a href="" class="keybtn">計算薪資</a>
                        <a href="" class="keybtn">查詢</a>
                    </div>
                </div>
            </div>
            <br /><br />
            <div class="fixwidth">

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

        <div class="stripeMe fixTable" style="height:175px;" id="div_Data">
<%--           <div class="right">
               <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.reSearch();">查詢</a>
               <a href="Javascript:void(0)" class="keybtn" onclick="JsEven.Ins();">新增</a>
           </div>--%>

           <div id="div_MList" class="stripeMe fixTable" style="min-height:175px;max-height:175px">
           </div>

                <%--<table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <thead>
                            <tr>
                                <th nowrap="nowrap">員工編號</th>
                                <th nowrap="nowrap">姓名</th>
                                <th nowrap="nowrap">發薪年月</th>
                                <th nowrap="nowrap">申報公司</th>
                                <th nowrap="nowrap">部門</th>
                                <th nowrap="nowrap">出勤天數</th>
                                <th nowrap="nowrap">出勤時數</th>
                                <th nowrap="nowrap">實付金額</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td nowrap="nowrap">000001</td>
                                <td nowrap="nowrap">黃榮廣</td>
                                <td nowrap="nowrap">2017/01</td>
                                <td nowrap="nowrap">CDST</td>
                                <td nowrap="nowrap">中壢店</td>
                                <td nowrap="nowrap">26</td>
                                <td nowrap="nowrap">193</td>
                                <td nowrap="nowrap">27000</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">000001</td>
                                <td nowrap="nowrap">黃榮廣</td>
                                <td nowrap="nowrap">2016/12</td>
                                <td nowrap="nowrap">CDST</td>
                                <td nowrap="nowrap">中壢店</td>
                                <td nowrap="nowrap">26</td>
                                <td nowrap="nowrap">193</td>
                                <td nowrap="nowrap">27000</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">000001</td>
                                <td nowrap="nowrap">黃榮廣</td>
                                <td nowrap="nowrap">2016/11</td>
                                <td nowrap="nowrap">CDST</td>
                                <td nowrap="nowrap">中壢店</td>
                                <td nowrap="nowrap">26</td>
                                <td nowrap="nowrap">193</td>
                                <td nowrap="nowrap">27000</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">000001</td>
                                <td nowrap="nowrap">黃榮廣</td>
                                <td nowrap="nowrap">2016/10</td>
                                <td nowrap="nowrap">CDST</td>
                                <td nowrap="nowrap">中壢店</td>
                                <td nowrap="nowrap">26</td>
                                <td nowrap="nowrap">193</td>
                                <td nowrap="nowrap">27000</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">000001</td>
                                <td nowrap="nowrap">黃榮廣</td>
                                <td nowrap="nowrap">2017/01</td>
                                <td nowrap="nowrap">CDST</td>
                                <td nowrap="nowrap">中壢店</td>
                                <td nowrap="nowrap">26</td>
                                <td nowrap="nowrap">193</td>
                                <td nowrap="nowrap">27000</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">000001</td>
                                <td nowrap="nowrap">黃榮廣</td>
                                <td nowrap="nowrap">2016/09</td>
                                <td nowrap="nowrap">CDST</td>
                                <td nowrap="nowrap">中壢店</td>
                                <td nowrap="nowrap">26</td>
                                <td nowrap="nowrap">193</td>
                                <td nowrap="nowrap">27000</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">000001</td>
                                <td nowrap="nowrap">黃榮廣</td>
                                <td nowrap="nowrap">2016/08</td>
                                <td nowrap="nowrap">CDST</td>
                                <td nowrap="nowrap">中壢店</td>
                                <td nowrap="nowrap">26</td>
                                <td nowrap="nowrap">193</td>
                                <td nowrap="nowrap">27000</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">000001</td>
                                <td nowrap="nowrap">黃榮廣</td>
                                <td nowrap="nowrap">2016/07</td>
                                <td nowrap="nowrap">CDST</td>
                                <td nowrap="nowrap">中壢店</td>
                                <td nowrap="nowrap">26</td>
                                <td nowrap="nowrap">193</td>
                                <td nowrap="nowrap">27000</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">000001</td>
                                <td nowrap="nowrap">黃榮廣</td>
                                <td nowrap="nowrap">2016/06</td>
                                <td nowrap="nowrap">CDST</td>
                                <td nowrap="nowrap">中壢店</td>
                                <td nowrap="nowrap">26</td>
                                <td nowrap="nowrap">193</td>
                                <td nowrap="nowrap">27000</td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">000001</td>
                                <td nowrap="nowrap">黃榮廣</td>
                                <td nowrap="nowrap">2016/05</td>
                                <td nowrap="nowrap">CDST</td>
                                <td nowrap="nowrap">中壢店</td>
                                <td nowrap="nowrap">26</td>
                                <td nowrap="nowrap">193</td>
                                <td nowrap="nowrap">27000</td>
                            </tr>
                        </tbody>
                    </table>--%>
       </div><!-- overwidthblock -->





            </div><!-- fixwidth -->
            <div class="fixwidth" style="margin-top:10px;">
                <!-- 詳細資料start -->
                <div class="statabs margin10T">
                    <ul>
                        <li><a href="#tabs-1">第一頁</a></li>
                        <li><a href="#tabs-2">第二頁</a></li>
                        <li><a href="#tabs-3">第三頁</a></li>
                    </ul>
                    <div id="tabs-1">
                        <div class="gentable">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">員工編號</div></td>
                                    <td class="width15" id="td_PerNo"></td>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">姓名</div></td>
                                    <td class="width15" id="td_PerName"></td>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">申報公司</div></td>
                                    <td class="width15" id="PerCom"></td>
                                    <td class="width10" align="right"><div class="font-title titlebackicon">部門</div></td>
                                    <td class="width15" id="PerDep"></td>
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

                                        
                                        <td align="right"><div class="font-title titlebackicon">(流)產假</div></td>
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
                                    </tr>

                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">國定假日加班-3類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysTime3" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysSalary3"/></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">國定假日加班-4類</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysTime4" /></td>                                       
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysSalary4"/></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">例假日加班免稅時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pHolidayDutyFree"  /></td>
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">國定假加班免稅時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysDutyFree" /></td>                                       
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">假日加班免稅時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pHolidaySumDutyFree" /></td>                                       
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">例假日加班課稅時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pHolidayTaxation"  /></td>
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">國定假加班課稅時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pNationalholidaysTaxation" /></td>                                       
                                        <td>&nbsp;</td>
                                        <td align="right"><div class="font-title titlebackicon">假日加班課稅時數</div></td>
                                        <td><input type="text" class="inputex width95" id="txt_pHolidaySumTaxation" /></td>                                       
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
                        </div>
                        <div class="stripeMe font-normal">
                            <table width="100%" cellspacing="0" cellpadding="0">
                                <tr>
                                    <th nowrap="nowrap">津貼扣款代號</th>
                                    <th nowrap="nowrap">津貼扣款名稱</th>
                                    <th nowrap="nowrap">加扣別</th>
                                    <th nowrap="nowrap">金額</th>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap">0001</td>
                                    <td nowrap="nowrap">捐款</td>
                                    <td nowrap="nowrap">扣</td>
                                    <td nowrap="nowrap">1000</td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap">0002</td>
                                    <td nowrap="nowrap">年節禮金</td>
                                    <td nowrap="nowrap">加</td>
                                    <td nowrap="nowrap">1000</td>
                                </tr>

                            </table>
                        </div>
                    </div><!-- tabs-1 -->
                    <div id="tabs-2">

                        <div class="gentable">

                            <table width="100%" border="0" cellspacing="0" cellpadding="0">

                                <tr>
                                    <td align="right"><div class="font-title titlebackicon">扣稅所得</div></td>
                                    <td><input type="text" class="inputex width60" id="txt_pTaxDeduction" /></td>
                                    <td align="right"><div class="font-title titlebackicon">實付金額</div></td>
                                    <td><input type="text" class="inputex width60" id="txt_pPay"/></td>
                                    <td align="right"><div class="font-title titlebackicon">課稅所得</div></td>
                                    <td><input type="text" class="inputex width60" id="txt_pTaxation"/></td>
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




            <input id="hid_Guid" type="hidden" />
    <input id="hid_EditType" type="hidden" />

    <script type="text/javascript">


        JsEven = {

            Id:{
                div_Search: 'div_Search',

            },

            Page1Id: {
                //人員資料
                td_PerNo: 'td_PerNo',
                td_PerName: 'td_PerName',
                PerCom: 'td_PerCom',
                PerDep: 'td_PerDep',

                //加班類別
                txt_pWeekdayTime1: 'txt_pWeekdayTime1',                                        
                txt_pWeekdayTime2: 'txt_pWeekdayTime2',
                txt_pWeekdayTime3: 'txt_pWeekdayTime3',
                txt_pWeekdaySalary1: 'txt_pWeekdaySalary1',
                txt_pWeekdaySalary2: 'txt_pWeekdaySalary2',
                txt_pWeekdaySalary3: 'txt_pWeekdaySalary3',

                txt_pHolidayTime1: 'txt_pHolidayTime1',
                txt_pHolidaySalary1:'txt_pHolidaySalary1',
                txt_pHolidayTime1: 'txt_pHolidayTime2',
                txt_pHolidaySalary1:'txt_pHolidaySalary2',
                txt_pHolidayTime1: 'txt_pHolidayTime3',
                txt_pHolidaySalary1:'txt_pHolidaySalary3',
                txt_pHolidayTime1: 'txt_pHolidayTime4',
                txt_pHolidaySalary1: 'txt_pHolidaySalary4',

                txt_pOffDayTime1:'txt_pOffDayTime1',
                txt_pOffDaySalary1:'txt_pOffDaySalary1',
                txt_pOffDayTime1:'txt_pOffDayTime2',
                txt_pOffDaySalary1:'txt_pOffDaySalary2',
                txt_pOffDayTime1:'txt_pOffDayTime3',
                txt_pOffDaySalary1:'txt_pOffDaySalary3',

                txt_pNationalholidaysTime1:'txt_pNationalholidaysTime1',
                txt_pNationalholidaysSalary1:'txt_pNationalholidaysSalary1',
                txt_pNationalholidaysTime1:'txt_pNationalholidaysTime2',
                txt_pNationalholidaysSalary1:'txt_pNationalholidaysSalary2',
                txt_pNationalholidaysTime1:'txt_pNationalholidaysTime3',
                txt_pNationalholidaysSalary1:'txt_pNationalholidaysSalary3',
                txt_pNationalholidaysTime1:'txt_pNationalholidaysTime4',
                txt_pNationalholidaysSalary1:'txt_pNationalholidaysSalary4',

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
                                   
                pHolidayDutyFree:'pHolidayDutyFree',
                pHolidayTaxation: 'pHolidayTaxation',
                pNationalholidaysTaxation: 'pNationalholidaysTaxation',
                pNationalholidaysDutyFree: 'pNationalholidaysDutyFree',
                pHolidaySumDutyFree: 'pHolidaySumDutyFree',
                pHolidaySumTaxation: 'pHolidaySumTaxation',

                //出勤
                pAttendanceDays: 'pAttendanceDays',
                pAttendanceTimes: 'pAttendanceTimes',

                pPayLeave: 'pPayLeave',
                pOverTimeDutyfree: 'pOverTimeDutyfree',
                pOverTimeTaxation: 'pOverTimeTaxation',
                pIntertemporal: 'pIntertemporal',




            },

            Page2Id: {
                
                pTaxDeduction: 'pTaxDeduction',
                pPay: 'pPay',
                pTaxation: 'pTaxation',
                pPremium: 'pPremium',
                pPersonInsurance: 'pPersonInsurance',
                pPersonLabor: 'pPersonLabor',
                pPersonPension: 'pPersonPension',
                pCompanyPension: 'pCompanyPension',
                pPersonPensionSum: 'pPersonPensionSum',
                pCompanyPensionSum: 'pCompanyPensionSum',
            },
            Page3Id: {
                div_Buckle: 'div_Buckle'
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

