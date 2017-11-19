<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="Page-PayrollPrint.aspx.cs" Inherits="webpage_Page_PayrollPrint" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <script src="../tinymce/tinymce.min.js" type="text/javascript"></script>




<script type="text/javascript">
    tinymce.init({
        selector: "textarea",
        language: "zh_TW",
        //menubar: false, //上方工具列顯示or隱藏
        file_browser_callback: function (field_name, url, type, win) {
            if (type == "image") {
                tinymce.activeEditor.windowManager.close();
                tinymce.activeEditor.windowManager.open({
                    title: "圖片上傳",
                    url: '<%= ResolveUrl("~/tinymce/ImageUpload/upload.aspx") %>',
                    width: 300,
                    height: 120
                });
            }
        },
        plugins: ["advlist autolink lists image link charmap print preview searchreplace visualblocks code fullscreen insertdatetime table contextmenu paste pagebreak textcolor image"],
        font_formats: "新細明體=新細明體;標楷體=標楷體;微軟正黑體=微軟正黑體;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Comic Sans MS=comic sans ms,sans-serif;Times New Roman=times new roman,times;",
        pagebreak_separator: "<!--pagebreak-->",
        image_advtab: true, //圖片進階選項
        relative_urls: false,
        remove_script_host: false,
        convert_urls: true,
        toolbar1: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link pagebreak table image | forecolor backcolor | fontselect fontsizeselect"
    });
</script>


    <script type="text/javascript">
        //確認公司&部門
            $(document).on("change", "#txt_CompanyNo,#txt_Dep", function () {
                if (this.id == "txt_CompanyNo") type = "Company"
            else type = "Dep"
            checkData(type, $("#" + this.id).val());
        });

    </script>
        
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10TB">
                <div class="left font-light">首頁 / 薪資管理 /<span class="font-black font-bold">保密薪資條列印</span></div>
            </div>

        </div>
        <!-- fixwidth -->
        <div id="div_List" runat="server" >
        <div class="fixwidth">
            <div class="twocol margin15TB">
                <div class="right">
                    <a href="javascript:void(0);" class="keybtn" onclick="JsEven.ExportExcel()" >列印</a>
                    <a href="javascript:void(0);" class="keybtn" onclick="JsEven.ExportExcel()" >預覽</a>
                    <a href="javascript:void(0);" class="keybtn" onclick="JsEven.List()" >設計憑證</a>

                    <asp:LinkButton ID="lkb_print" CssClass="keybtn" runat="server">列印</asp:LinkButton>
                    <asp:LinkButton ID="lkb_browse" CssClass="keybtn" runat="server">預覽</asp:LinkButton>
                    <asp:LinkButton ID="lkb_design"  CssClass="keybtn" runat="server" OnClick="lkb_design_Click">設計憑證</asp:LinkButton>
                    <!--<a href="#" class="keybtn">取消</a>-->
                </div>
            </div>
        </div>

        <div class="fixwidth" style="margin-top: 20px;">
            <div class="statabs margin10T">
                <div class="gentable ">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                        <td class="width13" align="right"><div class="font-title titlebackicon">計薪週期</div></td>
                        <td class="width20" colspan="3">
                            <table>
                                <tr>
                                    <td style="width:150px" ><span class="font-title titlebackicon">日期起</span><span id="sp_sDate"></span></td>
                                    <td style="width:150px" ><span class="font-title titlebackicon">日期迄</span><span id="sp_eDate"></span></td>
                                    <td><img src="../images/btn-search.gif" id="img_SalaryRange" onclick="JsEven.openfancybox(this)" style="cursor:pointer"/>
                                        <input id="hid_SalaryRangeGuid" type="hidden" runat="server"  />
                                    </td>
                                </tr>
                            </table>                                 
                            </td>
                          </tr>   
                        <tr>
                            <td style="width:15%" align="right"><div class="font-title titlebackicon">匯出應發金額為零</div></td>
                            <td><input type="checkbox" id="chk_ShouldPay" /></td>
                            <td style="width:15%" align="right"><div class="font-title titlebackicon">匯出已離職</div></td>
                            <td><input type="checkbox" id="chk_Leave" /></td>
                        </tr>
                        <tr>
                            <td class="width13" align="right"><div class="font-title titlebackicon">員工編號</div></td>
                            <td class="width20"><input type="text" class="inputex" id="txt_PerNo" /></td>
                            <td class="width13" align="right"><div class="font-title titlebackicon">姓名</div></td>
                            <td class="width20"><input type="text" class="inputex" id="txt_PerName" /></td>
                        </tr>
                        <tr>
                            <td class="width13" align="right"><div class="font-title titlebackicon">公司別</div></td>
                            <td class="width20"><input type="text" class="inputex" id="txt_CompanyNo" /></td>
                            <td class="width13" align="right"><div class="font-title titlebackicon">部門</div></td>
                            <td class="width20"><input type="text" class="inputex" id="txt_Dep" /></td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        </div>
        <br />
        <%--<div class="fixwidth ">    
        <table style="width:100%">
            <tr><td style="text-align:center">[D003]</td><td style="text-align:center">[D002]</td><td style="text-align:center">[D001]</td><td style="text-align:center">:[D005] [D006]</td></tr>

        </table>
        <table width="99%" border="1" cellspacing="0" cellpadding="0">
        <tr>
            <td colspan="8" style="text-align:center">應發項目</td>
            <td colspan="2" style="text-align:center">應扣項目</td>
        </tr>
        <tr>
            <td style="text-align:center">項目</td>
            <td style="text-align:center; width:10% ">時數/天數</td>
            <td style="text-align:center; width:10%">金額</td>
            <td style="text-align:center; width:18%" colspan="2">加班別</td>
            <td style="text-align:center">倍率</td>
            <td style="text-align:center">時數</td>
            <td style="text-align:center">金額</td>
            <td style="text-align:center">勞工自負額</td>
            <td style="text-align:center">金額</td>
        </tr>
        <tr>
            <td style="text-align:center">基本薪資</td>
            <td style="text-align:right">[A001]</td>
            <td style="text-align:right">[A002]</td>
            <td style="text-align:center" colspan="2" rowspan="3">平日加班</td>         
            <td style="text-align:right">[B001]</td>
            <td style="text-align:right">[B002]</td>
            <td style="text-align:right">[B003]</td>
            <td style="text-align:center">代扣勞保費</td>
            <td style="text-align:right">[C001]</td>
        </tr>
        <tr>
            <td style="text-align:center">BestSA獎金</td>
            <td></td>
            <td style="text-align:right">[A003]</td>
            <td style="text-align:right">[B004]</td>
            <td style="text-align:right">[B005]</td>
            <td style="text-align:right">[B006]</td>
            <td style="text-align:center">代扣健保費</td>
            <td style="text-align:right">[C002]</td>
        </tr>
        <tr>
            <td>體檢補助</td>
            <td></td>
            <td style="text-align:right">[A004]</td>
            <td style="text-align:right">[B007]</td>
            <td style="text-align:right">[B008]</td>
            <td style="text-align:right">[B009]</td>
            <td style="text-align:center">代扣福利金</td>
            <td style="text-align:right">[C003]</td>
        </tr>
        <tr>
            <td>其它津貼</td>
            <td></td>
            <td style="text-align:right">[A005]</td>
            <td style="text-align:center" rowspan="4">休息日加班</td>
            <td style="width:9%">2小以內</td>
            <td style="text-align:right">[B010]</td>
            <td style="text-align:right">[B011]</td>
            <td style="text-align:right">[B012]</td>
            <td style="text-align:center">勞退自提</td>
            <td style="text-align:right">[C004]</td>
        </tr>
        <tr>
            <td>職災補償</td>
            <td></td>
            <td style="text-align:right">[A006]</td>
            <td >2~8小時</td>
            <td style="text-align:right">[B013]</td>
            <td style="text-align:right">[B014]</td>
            <td style="text-align:right">[B015]</td>
            <td style="text-align:center">代扣補充保費</td>
            <td style="text-align:right">[C005]</td>
        </tr>
        <tr>
            <td>資遣費</td>
            <td></td>
            <td style="text-align:right">[A007]</td>
            <td >8~12小時</td>
            <td style="text-align:right">[B016]</td>
            <td style="text-align:right">[B017]</td>
            <td style="text-align:right">[B018]</td>
            <td style="text-align:center">其它津貼扣項</td>
            <td></td>
        </tr>
        <tr>
            <td>勞保費調整</td>
            <td></td>
            <td style="text-align:right">[A008]</td>
            <td >12小時以上</td>
            <td style="text-align:right">[B019]</td>
            <td style="text-align:right">[B020]</td>
            <td style="text-align:right">[B021]</td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>健保費調整</td>
            <td></td>
            <td style="text-align:right">[A009]</td>
            <td style="text-align:center" rowspan="4">例假/國定假日加班</td>
            <td>8小時內</td>
            <td style="text-align:right">[B022]</td>
            <td style="text-align:right">[B023]</td>
            <td style="text-align:right">[B024]</td>
            <td></td>
             <td></td>
        </tr>
        <tr>
            <td>勞退自提調整</td>
            <td></td>
            <td style="text-align:right">[A010]</td>
            <td >8~10小時</td>
            <td style="text-align:right">[B025]</td>
            <td style="text-align:right">[B026]</td>
            <td style="text-align:right">[B027]</td>
            <td style="text-align:right"></td>
            <td></td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td>10~12小時</td>
            <td style="text-align:right">[B028]</td>
            <td style="text-align:right">[B029]</td>
            <td style="text-align:right">[B030]</td>
            <td></td>
            <td></td>
        </tr>

        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td>12小時以上</td>
            <td style="text-align:right">[B031]</td>
            <td style="text-align:right">[B032]</td>
            <td style="text-align:right">[B033]</td>
            <td></td>
            <td></td>
        </tr>



        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
             <td></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>合計(A)</td>
            <td></td>
            <td style="text-align:right">[A011]</td>
            <td>合計(B)</td>
            <td></td>
            <td></td>
            <td></td>
            <td style="text-align:right">[B034]</td>
             <td>合計(C)</td>
             <td style="text-align:right">[C011]</td>
        </tr>
        <tr>
            <td colspan="8"></td>
            <td>實發金額<br />(A)+(B)-(C)</td>
            <td style="text-align:right">[D015]</td>
        </tr>

    </table>
        <table style="width:100%">
            <tr><th colspan="2">個人特休假</th><th colspan="2">保險資訊</th></tr>
            <tr><td >可請休期間</td><td>[D007]</td><td>勞保/健保投保級距</td><td>[D010]/[D011]</td></tr>
            <tr><td >可休日數</td><td>[D008]</td><td>勞退提撥工資/%</td><td>:[D011]</td></tr>
            <tr><td >已休日數</td><td>[D009]</td><td>提撥金額</td><td></td></tr>
        </table>
        </div>--%>



        <div id="div_Edit" style="display:none" runat="server">
        <div class="fixwidth">
            <div class="twocol margin15TB">
                <div class="right">
                    <a href="javascript:void(0);" class="keybtn" onclick="JsEven.Edit()" >儲存</a>
                    <a href="javascript:void(0);" class="keybtn" onclick="JsEven.cancel()" >取消</a>
                    <asp:LinkButton ID="lkb_subimt" CssClass="keybtn" runat="server" OnClick="lkb_subimt_Click">儲存</asp:LinkButton>
                    <asp:LinkButton ID="lkb_Cancel" CssClass="keybtn" runat="server" OnClick="lkb_Cancel_Click">取消</asp:LinkButton>
                    <!--<a href="#" class="keybtn">取消</a>-->
                </div>
            </div>
        </div>
        <div id="div_design" class="fixwidth " >
            <table style="height:500px" >
                <tr>
                    <td>
                        <textarea id="tex_designContent" runat="server" rows="800" cols="50" style="height:500px; width:500px;"  ></textarea>     
                    </td>
                </tr>
                <tr>
                    <td >
                     <div class="font-size3 stripeMe">
                     <table  width="99%" border="0" cellspacing="0" cellpadding="0" style="vertical-align:top;">
                         <tr>
                             <th>加項1</th>
                             <th>加項2</th>
                             <th>扣項</th>
                             <th>其它</th>
                         </tr>
                         <tr>
                             <td>                                     
                                基本薪資時數:[A001]<br />  
                                基本薪資金額:[A002]<br />                                  
                                BestSA獎金:[A003]<br />
                                體檢補助:[A004]<br />
                                其它津貼:[A005]<br />
                                職災補償:[A006]<br />
                                資遣費:[A007]<br />
                                勞保費調整:[A008]<br />
                                健保費調整:[A009]<br />
                                勞退自提調整:[A010]<br />
                                加項1金額合計:[A011]<br />
                             </td>
                             <td>
                                平日加班1類倍率:[B001]<br />
                                平日加班1類時數:[B002]<br />
                                平日加班1類金額:[B003]<br />  
                                平日加班2類倍率:[B004]<br />
                                平日加班2類時數:[B005]<br />  
                                平日加班2類金額:[B006]<br />
                                平日加班3類倍率:[B007]<br />
                                平日加班3類時數:[B008]<br />  
                                平日加班3類金額:[B009]<br /> 
                                  
                                休息加班1類倍率:[B010]<br />
                                休息加班1類時數:[B011]<br />  
                                休息加班1類金額:[B012]<br />  
                                休息加班2類倍率:[B013]<br />
                                休息加班2類時數:[B014]<br />  
                                休息加班2類金額:[B015]<br />
                                休息加班3類倍率:[B016]<br />                                    
                                休息加班3類時數:[B017]<br />  
                                休息加班3類金額:[B018]<br /> 
                                休息加班4類倍率:[B019]<br />                                    
                                休息加班4類時數:[B020]<br />  
                                休息加班4類金額:[B021]<br /> 

                                例假日/國定加班1類倍率:[B022]<br />   
                                例假日/國定加班1類時數:[B023]<br />                                   
                                例假日/國定加班1類金額:[B024]<br />
                                例假日/國定加班2類倍數:[B025]<br />                                    
                                例假日/國定加班2類時數:[B026]<br />  
                                例假日/國定加班2類金額:[B027]<br />
                                例假日/國定加班3類倍數:[B028]<br />                                    
                                例假日/國定加班3類時數:[B029]<br />  
                                例假日/國定加班3類金額:[B030]<br />
                                例假日/國定加班4類倍數:[B031]<br />                                    
                                例假日/國定加班4類時數:[B032]<br />  
                                例假日/國定加班4類金額:[B033]<br />                                                  
                                加項2金額合計:[B034]<br /> 
                             </td>
                             <td>
                                 代扣健保費:[C001]<br />  
                                 代扣勞保費:[C002]<br /> 
                                 代扣福利金:[C003]<br /> 
                                 勞退自提:[C004]<br />  
                                 代扣補充保費:[C005]<br />  
                                 代扣勞保費調整:[C006]<br />
                                 代扣健保費調整:[C007]<br />
                                 代扣勞退自提調整:[C008]<br />
                                 代法院執行:[C009]<br />
                                 代扣繳-捐:[C010]<br />
                                 應扣合計:[C011]<br />
                             </td>
                             <td>
                                 姓名:[D001]<br />
                                 工號:[D002]<br />
                                 部門:[D003]<br />
                                 部門代號:[D004]<br />  
                                 年月:[D005]<br />  
                                 計薪區間:[D006]<br />
                                 可請休期間:[D007]<br />                                 
                                 可休日數:[D008]<br />
                                 以休日數:[D009]<br />
                                 勞保投保級距:[D010]<br />
                                 健保投保級距:[D011]<br />
                                 勞退提撥工資:[D012]<br />
                                 勞退提撥率:[D013]<br />
                                 提撥金額:[D014]<br />
                                 實發金額:[D015]<br />
                             </td>
                         </tr>
                     </table>
                    </div>
                    </td>
                </tr>
            </table>
        </div>
        </div>
    </div>



    <br /><br /><br /><br />



    <!-- WrapperMain -->
    <input type="hidden" id="hid_pspGuid" />
    <script type="text/javascript">

        JsEven = {

            Id: {
                hid_pspGuid: 'hid_pspGuid',
                tex_designContent: 'tex_designContent',
                div_List: 'div_List',
                div_Edit: 'div_Edit',
                hid_SalaryRangeGuid: '<%=hid_SalaryRangeGuid.ClientID%>',
                sp_sDate: 'sp_sDate',
                sp_eDate: 'sp_eDate'
            },

            List: function () {

                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                var opt = {
                    url: '../handler/Payroll/ashx_SelPayrollPrint.ashx',
                    v: '',
                    type: 'html',
                    success: function (msg) {

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
                                document.getElementById(JsEven.Id.div_List).style.display = "none";
                                document.getElementById(JsEven.Id.div_Edit).style.display = "block";
                                tinyMCE.get(JsEven.Id.tex_designContent).setContent(msg);
                                break;
                        }
                        $.unblockUI();
                    }
                }
                CmFmCommon.ajax(opt);
            },

            Edit: function () {

                var contetn = tinyMCE.get(this.Id.tex_designContent).getContent();

                if (contetn == "") { alert('內容不可為空'); return false; }
                $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
                $.ajax({
                    type: "POST",
                    url: '../handler/Payroll/ashx_EditPayroll.ashx',
                    data: 'pspContent=' + encodeURIComponent(contetn),
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
            },

            cancel: function () {
                document.getElementById(JsEven.Id.div_List).style.display = "block";
                document.getElementById(JsEven.Id.div_Edit).style.display = "none";
            },

            //查詢視窗
            openfancybox: function (item) {
                switch ($(item).attr("id")) {
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
        }


        //fancybox回傳
        function setReturnValue(type, gv, str, str2) {
            switch (type) {
                case "SalaryRange":
                    {
                        $("#" + JsEven.Id.sp_sDate).html(str);
                        $("#" + JsEven.Id.sp_eDate).html(str2);
                        $("#" + JsEven.Id.hid_SalaryRangeGuid).val(gv);
                    }
                    break;
            }
        }




    </script>










</asp:Content>

