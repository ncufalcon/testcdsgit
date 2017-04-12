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
                        <li><a href="#tabs-1">批次新增津貼</a></li>
                        <li><a href="#tabs-2">津貼管理</a></li>
                    </ul>
                    <div id="tabs-1">
                        <div class="twocol margin15T">
                            <div class="right">
                                <a href="" class="keybtn">產生津貼明細</a>
                            </div>
                        </div>
                        <div class="gentable" style="margin-top:15px">

                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">選擇公司別</div></td>
                                    <td><textarea class="inputex width60" rows="6"></textarea><img src="images/btn-search.gif" /></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">職等</div></td>
                                    <td><textarea class="inputex width60" rows="6"></textarea><img src="images/btn-search.gif" /></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">部門</div></td>
                                    <td><textarea class="inputex width60" rows="6"></textarea><img src="images/btn-search.gif" /></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">員工代號</div></td>
                                    <td>
                                        <input type="text" class="inputex width60" /><img src="images/btn-search.gif" /><br />
                                        <input type="text" class="inputex width60" /><img src="images/btn-search.gif" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">年月</div></td>
                                    <td><input type="text" class="inputex width60" /></td>
                                </tr>

                            </table>

                        </div>
                        <br /><br /><br />
                        <div class="tabfixwidth">
                            <div class="stripeMe fixTable" style="max-height:175px;margin-top:15px">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <thead>
                                        <tr>
                                            <th nowrap="nowrap">操作</th>
                                            <th nowrap="nowrap">津貼扣款代號</th>
                                            <th nowrap="nowrap">津貼扣款名稱</th>
                                            <th nowrap="nowrap">加/扣別</th>
                                            <th nowrap="nowrap">單價</th>
                                            <th nowrap="nowrap">數量</th>
                                            <th nowrap="nowrap">金額</th>
                                        </tr>
                                    </thead>
                                    <tr>
                                        <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>                                
                                        <td align="center" nowrap="nowrap">0001</td>
                                        <td align="center" nowrap="nowrap">誤餐費</td>
                                        <td align="center" nowrap="nowrap">加</td>
                                        <td align="center" nowrap="nowrap">1500</td>
                                        <td align="center" nowrap="nowrap">1</td>
                                        <td align="center" nowrap="nowrap">1500</td>
                             
                                    </tr>
                                
                                </table>
                            </div><!-- overwidthblock -->
                        </div><!-- fixwidth -->
                        <div class="twocol margin15T">
                            <div class="right">
                                <a href="" class="keybtn">增加</a>
                            </div>
                        </div>
                        <div class="gentable" style="margin-top:15px">

                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">項目</div></td>
                                    <td><input type="text" class="inputex width60" /><img src="images/btn-search.gif" /></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">單價</div></td>
                                    <td><input type="text" class="inputex width60" /></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">數量</div></td>
                                    <td><input type="text" class="inputex width60" /></td>
                                </tr>
                                <tr>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">金額</div></td>
                                    <td><input type="text" class="inputex width60" /></td>
                                    <td align="right"><div class="font-title titlebackicon" style="color:Red">備註</div></td>
                                    <td><input type="text" class="inputex width60" /></td>
                                </tr>
                            </table>
                        </div>
                    </div><!-- tabs-1 -->
                    <div id="tabs-2">

                        <div class="tabfixwidth gentable font-normal" id="div_Search" style="display:none">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">員工編號</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_PerNo" autofocus="autofocus" class="inputex width80"  /><img src="../images/btn-search.gif" />
                                    </td>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">姓名</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_PerName"  class="inputex width80" />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">津貼代號</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_AllowanceCode" class="inputex width80"  /><img src="../images/btn-search.gif" />
                                    </td>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">金額</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_Cost"  class="inputex width80" />
                                    </td>
                                </tr>

                                
                                <tr>
                                    <td class="width15" align="right">
                                        <div class="font-title titlebackicon">日期</div>
                                    </td>
                                    <td class="width35">
                                        <input type="text" id="txt_Date" class="inputex width80"  />
                                    </td>
                                </tr>

                            </table>
                            <div class="twocol margin15T">
                                <div class="right">
                                    <a href="Javascript:void(0)" class="keybtn">查詢</a>
                                </div>
                            </div>
                        </div>




                        <div id="div_Data" >
                        <div class="twocol margin15T">
                            <div class="right">
                                <a href="" class="keybtn">查詢</a>
                                <a href="" class="keybtn">新增</a>
                                <a href="" class="keybtn">匯入</a>
                            </div>
                        </div>
                        <div class="tabfixwidth">
                            <div id="div_MList" class="stripeMe fixTable" style="max-height:175px;margin-top:15px">
 
                            </div><!-- overwidthblock -->
                        </div><!-- fixwidth -->
                        <div class="tabfixwidth" style="margin-top:20px;">
                            <div class="twocol margin15TB">
                                <div class="right">
                                    <a href="Javascript:void(0)" class="keybtn">儲存</a>
                                </div>
                            </div>
                        </div>
                        <div class="tabfixwidth" style="margin-top:20px;">
                            <!-- 詳細資料start -->
                            <div class="statabs margin10T">
                                <div class="gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td><span class="font-title titlebackicon">維護狀態</span><span id="sp_Status">新增</span></td>
                                        </tr>
                                        <tr>
                                            <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">員工代號</div></td>
                                            <td class="width13">
                                                <input type="text" id="txt_PerNo_m" class="inputex width60" />
                                                <img id="img_Person" src="../images/btn-search.gif" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                                                <span id="sp_PerName_m" class="showStr"></span>
                                                <input id="hid_PerGuid_m" type="hidden" />
                                            </td>
                                            <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">津貼代號</div></td>
                                            <td class="width13"><input type="text" id="txt_txt_AllowanceCode_m" class="inputex width60"  /><img id="img_Code" src="../images/btn-search.gif" onclick="JsEven.openfancybox(this)" style="cursor:pointer" /></td>
                                            <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">日期</div></td>
                                            <td class="width13"><input type="text" class="inputex width60" id="txt_Date_m" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">單價</div></td>
                                            <td><input type="text" class="inputex width60" id="txt_Pric_m" /></td>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">數量</div></td>
                                            <td><input type="text" class="inputex width60" id="txt_Quantity_m"  /></td>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">金額</div></td>
                                            <td><input type="text" class="inputex width60" id="txt_Cost_m" /></td>
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


    <script type="text/javascript">


        JsEven = {

            Page1Id: {
                ddd: "ddd"
            },

            Page2Id: {
                div_Search: 'div_Search',
                txt_PerNo: 'txt_PerNo',
                txt_PerName: 'txt_PerName',
                txt_AllowanceCode: 'txt_AllowanceCode',
                txt_Cost: 'txt_Cost',
                txt_Date: 'txt_Date',
                div_MList: 'div_MList',
                hid_Guid: 'hid_Guid',
                txt_PerNo_m: 'txt_PerNo_m',
                txt_txt_AllowanceCode_m: 'txt_txt_AllowanceCode_m',
                txt_Pric_m: 'txt_Pric_m',
                txt_Quantity_m: 'txt_Quantity_m',
                txt_Cost_m: 'txt_Cost_m',
                txt_Date_m: 'txt_Date_m',
                txt_Ps_m: 'txt_Ps_m',
                div_Data: 'div_Data',
                sp_Status: 'sp_Status',
                sp_PerName_m: 'sp_PerName_m',
                hid_PerGuid_m: 'hid_PerGuid_m',

            },


            Inin: function () {
                this.List('Y');
            },

            List: function (typ) {
                // typ ='Y' 第一次進入畫面 top200
                var PerNo = $('#' + this.Page2Id.txt_PerNo).val();
                var PerName = $('#' + this.Page2Id.txt_PerName).val();
                var Code = $('#' + this.Page2Id.txt_AllowanceCode).val()
                var Cost = $('#' + this.Page2Id.txt_Cost).val();
                var Date = $('#' + this.Page2Id.txt_Date).val();

                if (typ != 'Y') {
                    if (PerNo == "" && PerName == "" && Code == "" && Cost == "" && Date == "") {
                        alert('請至少選擇一項查詢條件');
                        return false;
                    }
                }

                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var opt = {
                    url: '../handler/Allowance/ashx_AllList.ashx',
                    v: 'PerNo=' + PerNo +
                       '&PerName=' + PerName +
                       '&Code=' + Code +
                       '&Cost=' + Cost +
                       '&Date=' + Date + '&typ=' + typ,
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
                                    //TelEven.tblClass();

                                } else { div.innerHTML = '目前無任何資料'; }

                                document.getElementById(JsEven.Page2Id.div_Search).style.display = "none";
                                document.getElementById(JsEven.Page2Id.div_Data).style.display = "block";
                                break;
                        }
                        $.unblockUI();
                    }
                }
                CmFmCommon.ajax(opt);
            },

























            //點放大鏡 查詢視窗
            openfancybox: function (item) {
                switch ($(item).attr("id")) {
                    case "img_Code":
                        link = "SearchWindow.aspx?v=PLv";
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



        }


        function setReturnValue(gv, pno, pname) {
            $("#" + JsEven.Page2Id.txt_PerNo_m).val(pno);
            $("#" + JsEven.Page2Id.sp_PerName_m).html(pname);
            $("#" + JsEven.Page2Id.hid_PerGuid_m).val(gv);
        }

        document.body.onload = function () {
            JsEven.Inin();
            $("#" + JsEven.Page2Id.txt_Date_m).datepicker({
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


