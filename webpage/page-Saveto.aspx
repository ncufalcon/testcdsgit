<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="page-Saveto.aspx.cs" Inherits="webpage_page_Saveto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript" src="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.js?v=2.1.5") %>"></script>
    <link href="<%= ResolveUrl("~/js/fancybox/jquery.fancybox.css?v=2.1.5") %>" rel="stylesheet" type="text/css"  />
    <script type="text/javascript">
        $(function () {
            $("#txt_filename").val(getDate_yyyymmdd() + "-");
        });
        //*******************日期格式化yyyyMMdd********************//
        function getDate_yyyymmdd() {
            d = new Date();
            var yyyy = d.getFullYear().toString();
            var MM = pad(d.getMonth() + 1, 2);
            var dd = pad(d.getDate(), 2);
            return yyyy + MM + dd;
        }
        function pad(number, length) {
            var str = '' + number;
            while (str.length < length) {
                str = '0' + str;
            }
            return str;
        }
        //*******************日期格式化yyyyMMdd  END********************//

        //查詢視窗
        function openfancybox(item) {
            var link = "";
            switch ($(item).attr("id")) {
                case "citybkBox":
                    link = "SearchWindow.aspx?v=CityBankSR";
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
        }

        //fancybox回傳
        function setReturnValue(type, gv, str, str2, str3, str4) {
            switch (type) {
                case "CityBankSR":
                    $("#txt_paydate").val(str);
                    break;
            }
        }

        //多選查詢視窗
        function openMutiBox(item) {
            var link = "";
            switch ($(item).attr("id")) {
                case "mPersonBox":
                    link = "MutiSearch.aspx?v=" + $("#tmpUID").val();
                    break;
            }
            $.fancybox({
                href: link,
                type: "iframe",
                width: "400",
                minHeight: "600",
                closeClick: false,
                openEffect: 'elastic',
                closeEffect: 'elastic'
            });
        }

        function mutiReturn(str,str2) {
            $("#tmpUID").val(str);
            $("#tmpName").val(str2);
            str2 = str2.replace(/,/g, "、");
            $("#uName").html(str2)
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="hidden" id="tmpUID" />
    <input type="hidden" id="tmpName" />
    <div class="WrapperMain">
        <div class="fixwidth">
            <div class="twocol underlineT1 margin10TB">
                <div class="left font-light">首頁 / 薪資管理 /<span class="font-black font-bold">薪資轉存花旗媒體產生</span></div>
            </div>
        </div>
        <!-- fixwidth -->
        <div class="fixwidth">
            <div class="twocol margin15TB">
                <div class="right">
                    <a href="file/花旗轉媒體檔範例檔.txt" class="keybtn">依查詢條件轉成txt</a>
                    <a href="javascript:void(0);" class="keybtn">取消</a>
                </div>
            </div>
        </div>
        <div class="fixwidth" style="margin-top: 20px;">
            <div class="statabs margin10T">
                <div class="gentable ">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td align="right">
                                <div class="font-title titlebackicon">發薪年月</div>
                            </td>
                            <td><input type="text" class="inputex width80" value="201601" id="txt_paydate" /><img id="citybkBox" src="../images/btn-search.gif" onclick="openfancybox(this)" style="cursor:pointer;" /></td>
                            <!--<td align="right"><div class="font-title titlebackicon" >選擇發放日期</div></td>
                                    <td><input type="text" class="inputex width95" /></td>-->
                            <td align="right"><div class="font-title titlebackicon">媒體檔案名稱</div></td>
                            <td><input type="text" class="inputex width95" id="txt_filename" /></td>
                            <td align="right"><div class="font-title titlebackicon">轉存日期</div></td>
                            <td><input type="text" class="inputex width95" id="txt_turnsavedate" value="2017/01/01" /></td>
                        </tr>
                        <tr>
                            <td align="right"><div class="font-title titlebackicon">公司代碼</div></td>
                            <td><input type="text" class="inputex width45" value="046552" id="txt_comno" /></td>
                            <td align="right"><div class="font-title titlebackicon">匯出類別</div></td>
                            <td>
                                <input type="radio" name="radio_export_type" value="0" />薪資
                                <input type="radio" name="radio_export_type" value="1" />法扣
                            </td>
                        </tr>
                        <tr>
                            <td align="right"><div class="font-title titlebackicon">選擇人員</div></td>
                            <td colspan="5">
                                <img id="mPersonBox" src="../images/btn-search.gif" onclick="openMutiBox(this)" style="cursor: pointer;" />
                                <span id="uName"></span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>

    </div>
    <!-- WrapperMain -->
</asp:Content>

