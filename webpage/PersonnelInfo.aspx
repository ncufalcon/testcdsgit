<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/MasterPage.master" AutoEventWireup="true" CodeFile="PersonnelInfo.aspx.cs" Inherits="webpage_PersonnelInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
          
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="WrapperMain">


                <div class="fixwidth">
                    <div class="twocol underlineT1 margin10T">
                        <div class="left font-light">首頁 / 人事資料管理 / <span class="font-black font-bold">基本資料管理</span></div>
                    </div>
                    <div class="twocol margin15T">
                        <div class="left">資料管理:<a href="#" class="keybtn fancybox">匯入WorkDay資料</a></div>
                        <div class="right">
                            <a href="page-route-detail.html" class="keybtn fancybox">新增人員</a>
                            <a href="#searchblock" class="keybtn fancybox">查詢人員</a>
                        </div>
                    </div>
                </div>
                <br /><br />
                <div class="fixwidth">

                    <div class="stripeMe fixTable" style="height:175px;">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <thead>
                                <tr>
                                    <th nowrap="nowrap">操作</th>
                                    <th nowrap="nowrap">編號</th>
                                    <th nowrap="nowrap">姓名</th>
                                    <th nowrap="nowrap">英文姓名</th>
                                    <th nowrap="nowrap">所屬分店</th>
                                    <th nowrap="nowrap">性別</th>
                                    <th nowrap="nowrap">補助等級</th>
                                    <th nowrap="nowrap">投保身分</th>
                                    <th nowrap="nowrap">到職日</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>
                                    <td nowrap="nowrap">252559</td>
                                    <td nowrap="nowrap">張三</td>
                                    <td nowrap="nowrap">John</td>
                                    <td nowrap="nowrap">內湖店</td>
                                    <td nowrap="nowrap">男</td>
                                    <td nowrap="nowrap">0</td>
                                    <td nowrap="nowrap">4</td>
                                    <td nowrap="nowrap">2015/12/15</td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>
                                    <td nowrap="nowrap">252560</td>
                                    <td nowrap="nowrap">李四</td>
                                    <td nowrap="nowrap">Elson</td>
                                    <td nowrap="nowrap">內湖店</td>
                                    <td nowrap="nowrap">男</td>
                                    <td nowrap="nowrap">0</td>
                                    <td nowrap="nowrap">4</td>
                                    <td nowrap="nowrap">2015/12/15</td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>
                                    <td nowrap="nowrap">252561</td>
                                    <td nowrap="nowrap">王五</td>
                                    <td nowrap="nowrap">Mary</td>
                                    <td nowrap="nowrap">內湖店</td>
                                    <td nowrap="nowrap">女</td>
                                    <td nowrap="nowrap">0</td>
                                    <td nowrap="nowrap">4</td>
                                    <td nowrap="nowrap">2015/12/15</td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>
                                    <td nowrap="nowrap">252562</td>
                                    <td nowrap="nowrap">AAA</td>
                                    <td nowrap="nowrap">Linda</td>
                                    <td nowrap="nowrap">北投店</td>
                                    <td nowrap="nowrap">女</td>
                                    <td nowrap="nowrap">0</td>
                                    <td nowrap="nowrap">4</td>
                                    <td nowrap="nowrap">2015/12/15</td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>
                                    <td nowrap="nowrap">252563</td>
                                    <td nowrap="nowrap">BBB</td>
                                    <td nowrap="nowrap">Jack</td>
                                    <td nowrap="nowrap">北投店</td>
                                    <td nowrap="nowrap">男</td>
                                    <td nowrap="nowrap">0</td>
                                    <td nowrap="nowrap">4</td>
                                    <td nowrap="nowrap">2015/12/15</td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>
                                    <td nowrap="nowrap">252564</td>
                                    <td nowrap="nowrap">CCC</td>
                                    <td nowrap="nowrap">Jone</td>
                                    <td nowrap="nowrap">北投店</td>
                                    <td nowrap="nowrap">女</td>
                                    <td nowrap="nowrap">0</td>
                                    <td nowrap="nowrap">4</td>
                                    <td nowrap="nowrap">2015/12/15</td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>
                                    <td nowrap="nowrap">252565</td>
                                    <td nowrap="nowrap">DDD</td>
                                    <td nowrap="nowrap">&nbsp;</td>
                                    <td nowrap="nowrap">北投店</td>
                                    <td nowrap="nowrap">女</td>
                                    <td nowrap="nowrap">0</td>
                                    <td nowrap="nowrap">4</td>
                                    <td nowrap="nowrap">2015/12/15</td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>
                                    <td nowrap="nowrap">252566</td>
                                    <td nowrap="nowrap">EEE</td>
                                    <td nowrap="nowrap">&nbsp;</td>
                                    <td nowrap="nowrap">高雄店</td>
                                    <td nowrap="nowrap">女</td>
                                    <td nowrap="nowrap">0</td>
                                    <td nowrap="nowrap">4</td>
                                    <td nowrap="nowrap">2015/12/15</td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>
                                    <td nowrap="nowrap">252567</td>
                                    <td nowrap="nowrap">FFF</td>
                                    <td nowrap="nowrap">&nbsp;</td>
                                    <td nowrap="nowrap">高雄店</td>
                                    <td nowrap="nowrap">女</td>
                                    <td nowrap="nowrap">0</td>
                                    <td nowrap="nowrap">4</td>
                                    <td nowrap="nowrap">2015/12/15</td>
                                </tr>
                                <tr>
                                    <td align="center" nowrap="nowrap" class="font-normal"><a href="#">刪除</a></td>
                                    <td nowrap="nowrap">252568</td>
                                    <td nowrap="nowrap">GGG</td>
                                    <td nowrap="nowrap">&nbsp;</td>
                                    <td nowrap="nowrap">高雄店</td>
                                    <td nowrap="nowrap">女</td>
                                    <td nowrap="nowrap">0</td>
                                    <td nowrap="nowrap">4</td>
                                    <td nowrap="nowrap">2015/12/15</td>
                                </tr>
                            </tbody>
                        </table>
                    </div><!-- overwidthblock -->

                </div><!-- fixwidth -->
                <div class="fixwidth" style="margin-top:10px;">
                    <!-- 詳細資料start -->
                    <div class="statabs margin10T">
                        <ul>
                            <li><a href="#tabs-1">基本資料</a></li>
                            <li><a href="#tabs-2">保險關聯</a></li>
                            <li><a href="#tabs-3">計薪資料</a></li>
                            <li><a href="#tabs-4">眷屬資料</a></li>
                            <li><a href="#tabs-5">法院執行命令</a></li>
                            <li><a href="#tabs-6">個人津貼</a></li>
                        </ul>
                        <div id="tabs-1">

                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">員工編號</div></td>
                                        <td class="width15"><input type="text" class="inputex width100" /></td>
                                        <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">員工姓名</div></td>
                                        <td class="width15"><input type="text" class="inputex width100" /></td>
                                        <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">公司別</div></td>
                                        <td class="width15">
                                            <input type="text" class="inputex width60" /><img src="images/btn-search.gif" />
                                        </td>
                                        <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">部門</div></td>
                                        <td class="width15">
                                            <input type="text" class="inputex width60" /><img src="images/btn-search.gif" />
                                        </td>

                                    </tr>
                                    <tr>

                                        <td align="right"><div class="font-title titlebackicon" style="color:Red">性別</div></td>
                                        <td><input type="radio" name="2" />男<input type="radio" name="2" />女</td>
                                        <td align="right"><div class="font-title titlebackicon" >婚姻狀況</div></td>
                                        <td><input type="radio" name="3" />已婚<input type="radio" name="3" />未婚</td>
                                        <td class="width10" align="right"><div class="font-title titlebackicon" style="color:Red">職務</div></td>
                                        <td class="width15">
                                            <select class="inputex width95" name="D1">
                                                <option>請選擇</option>
                                                <option value="01">一般</option>
                                                <option value="02">季節</option>
                                            </select>

                                        </td>
                                    </tr>           
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">出生日期</div></td>
                                        <td><input type="text" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon" style="color:Red">身分證<br />居留證編號</div></td>
                                        <td><input type="text" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon" style="color:Red">合約別</div></td>
                                        <td><input type="radio" name="1" />正式<input type="radio" name="1" />季節</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon" style="color:Red">到職日期</div></td>
                                        <td><input type="text" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">離職日期</div></td>
                                        <td><input type="text" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">體檢日期</div></td>
                                        <td ><input type="text" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">體檢到期日</div></td>
                                        <td ><input type="text" class="inputex width100" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">合約/試用期滿日</div></td>
                                        <td><input type="text" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">居留證到期日</div></td>
                                        <td><input type="text" class="inputex width100" /></td>
                                    </tr>
                                    <tr>


                                        <td align="right"><div class="font-title titlebackicon">電話</div></td>
                                        <td><input type="text" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">手機號碼</div></td>
                                        <td><input type="text" class="inputex width100" /></td>


                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">Email</div></td>
                                        <td colspan="3"><input type="text" class="inputex width100" /></td>

                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">通訊地址</div></td>
                                        <td colspan="7"><input type="text" class="inputex width10" />(郵遞區號)-<input type="text" class="inputex width75" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">戶籍地址</div></td>
                                        <td colspan="7">
                                        <input type="text" class="inputex width10" />(郵遞區號)-<input type="text" class="inputex width75" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">緊急聯絡人</div></td>
                                        <td><input type="text" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">緊急聯電話</div></td>
                                        <td><input type="text" class="inputex width100" /></td>
                                        <td align="right"><div class="font-title titlebackicon">關係</div></td>
                                        <td><input type="text" class="inputex width100" /></td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">備註</div></td>
                                        <td colspan="7"><input type="text" class="inputex width99" /></td>
                                    </tr>
                                </table>
                            </div>

                        </div><!-- tabs-1 -->
                        <div id="tabs-2">
                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="width15" align="right"><div class="font-title titlebackicon">二代健保身分類別</div></td>
                                        <td class="width35">
                                            <select class="inputex width95" name="D1">
                                                <option>請選擇</option>
                                                <option value="01">一般投保員工</option>
                                                <option value="02">一般兼職人員(非在本單位投保健保者)</option>
                                                <option value="03">兼職人員(未達基本工資免扣繳者)</option>
                                                <option value="04">免扣繳者</option>
                                            </select>                                      
                                        </td>
                                        <td class="width15" align="right"><div class="font-title titlebackicon">投保身分</div></td>
                                        <td class="width35">
                                            <select class="inputex width95" name="D1">
                                                <option>請選擇</option>
                                                <option value="01">內湖店</option>
                                                <option value="02">北投店</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">團保保險</div></td>
                                        <td>
                                            <select class="inputex width95" name="D4">
                                                <option value="00">未參加</option>
                                                <option value="01">XXXX</option>
                                                <option value="02">YYYY</option>
                                                <option value="03">ZZZZ</option>
                                            </select>
                                        </td>
                                        <td align="right" class="auto-style3"><div class="font-title titlebackicon">勞保補助身分</div></td>
                                        <td>
                                            <input type="text" class="inputex width95" />
                                        </td>

                                    </tr>
                                    <tr>

                                        <td align="right"><div class="font-title titlebackicon">健保補助身分</div></td>
                                        <td><input type="text" class="inputex width95" /></td>
                                    </tr>
                                </table>
                            </div>
                        </div><!-- tabs-2 -->
                        <div id="tabs-3">
                            <div class="gentable">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td class="width15" align="right"><div class="font-title titlebackicon">計薪別</div></td>
                                        <td class="width35">
                                            <select class="inputex width95" name="D8">
                                                <option>請選擇</option>
                                                <option value="01">時薪</option>
                                                <option value="02">月薪</option>
                                            </select>
                                        </td>
                                        <td align="right"><div class="font-title titlebackicon">課稅方式</div></td>
                                        <td>
                                            <select class="inputex width95" name="D9">
                                                <option>請選擇</option>
                                                <option value="01">依法扣繳</option>
                                                <option value="02">XXXX</option>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">底薪</div></td>
                                        <td>
                                            <input type="text" class="inputex width95" />
                                        </td>
                                        <td align="right"><div class="font-title titlebackicon">職能加給</div></td>
                                        <td>
                                            <input type="text" class="inputex width95" />
                                        </td>

                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">薪資轉入帳戶名</div></td>
                                        <td>
                                            <input type="text" class="inputex width95" />
                                        </td>
                                        <td align="right">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="right"><div class="font-title titlebackicon">薪資轉入行(局)號</div></td>
                                        <td>
                                            <input type="text" class="inputex width95" />
                                        </td>
                                        <td align="right"><div class="font-title titlebackicon">薪資轉入帳號</div></td>
                                        <td>
                                            <input type="text" class="inputex width95" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div><!-- tabs-3 -->
                        <div id="tabs-4">

                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="#" class="keybtn fancybox">新增眷屬</a>
                                </div>
                            </div>
                            <div class="stripeMe font-normal">
                                <table width="100%" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <th width="60" nowrap="nowrap" rowspan="2">操作</th>
                                        <th nowrap="nowrap" rowspan="2">眷屬姓名</th>
                                        <th nowrap="nowrap" rowspan="2">眷屬稱謂</th>
                                        <th nowrap="nowrap" rowspan="2">眷屬生日</th>
                                        <th nowrap="nowrap" rowspan="2">眷屬身分證字號</th>
                                        <th nowrap="nowrap" colspan="2">健保</th>
                                        <th nowrap="nowrap" rowspan="2">團險加保</th>
                                    </tr>
                                    <tr>
                                        <th nowrap="nowrap">加保</th>
                                        <th nowrap="nowrap">補助代號</th>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#">刪除</a></td>
                                        <td nowrap="nowrap">張一</td>
                                        <td nowrap="nowrap">父親</td>
                                        <td nowrap="nowrap">20000101</td>
                                        <td nowrap="nowrap">H123456789</td>
                                        <td nowrap="nowrap"></td>
                                        <td nowrap="nowrap"></td>
                                        <td nowrap="nowrap"></td>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#">刪除</a></td>
                                        <td nowrap="nowrap">張一</td>
                                        <td nowrap="nowrap">父親</td>
                                        <td nowrap="nowrap">20000101</td>
                                        <td nowrap="nowrap">H123456789</td>
                                        <td nowrap="nowrap"></td>
                                        <td nowrap="nowrap"></td>
                                        <td nowrap="nowrap"></td>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#">刪除</a></td>
                                        <td nowrap="nowrap">張一</td>
                                        <td nowrap="nowrap">父親</td>
                                        <td nowrap="nowrap">20000101</td>
                                        <td nowrap="nowrap">H123456789</td>
                                        <td nowrap="nowrap"></td>
                                        <td nowrap="nowrap"></td>
                                        <td nowrap="nowrap"></td>
                                    </tr>
                                </table>
                            </div><br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="#" class="keybtn">儲存</a>
                                </div>
                            </div>
                            <div class="gentable">
                                <div class="gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">眷屬姓名</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">健保加保</div></td>
                                            <td class="width15"><input type="radio" />是<input type="radio" />否</td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">團險加保</div></td>
                                            <td class="width15"><input type="radio" />是<input type="radio" />否</td>



                                        </tr>    
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">眷屬身分證字號</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">補助代號</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                        </tr>  
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">稱謂</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                            <td align="right"><div class="font-title titlebackicon" style="color:Red">生日</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                        </tr>                                     
                                    </table>
                                </div>
                            </div>
                        </div><!-- tabs-4 -->
                        <div id="tabs-5">


                           <div class="gentable font-normal">
                               <table>
                                   <tr>
                                       <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">執行明令發文字號</div></td>
                                       <td class="width15"><input type="text" class="inputex width100" /></td>
                                       <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">執行扣押薪資比例</div></td>
                                       <td class="width15"><input type="text" class="inputex width100" /></td>
                                   </tr>
                                   <tr>
                                       <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">每月應領薪津</div></td>
                                       <td class="width15"><input type="text" class="inputex width100" /></td>
                                       <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">年終獎金</div></td>
                                       <td class="width15"><input type="text" class="inputex width100" /></td>
                                   </tr>
                               </table>
                           </div><br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="#" class="keybtn">新增法院強制扣繳來源</a><a href="#" class="keybtn">重新計算分配比例</a>
                                </div>
                            </div>
                        
                            <div class="stripeMe font-normal">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <th width="60" nowrap="nowrap">操作</th>
                                        <th nowrap="nowrap">債權人序號</th>
                                        <th nowrap="nowrap">債權人</th>
                                        <th nowrap="nowrap">債權金額</th>
                                        <th nowrap="nowrap">移轉比例</th>
                                        <th nowrap="nowrap">執行命令<br />發文日期</th>
                                        <th nowrap="nowrap">繳款方式</th>
                                        <th nowrap="nowrap">法扣轉入<br />戶名</th>
                                        <th nowrap="nowrap">法扣行轉入<br />局號</th>
                                        <th nowrap="nowrap">法扣轉入<br />帳號</th>
                                        <th nowrap="nowrap">匯款手續費/<br />掛號郵資</th>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#" class="fancybox">刪除</a>&nbsp;&nbsp;</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">台新銀行</td>
                                        <td nowrap="nowrap">100000</td>
                                        <td nowrap="nowrap">20%</td>
                                        <td nowrap="nowrap">20170101</td>
                                        <td nowrap="nowrap">匯款</td>
                                        <td nowrap="nowrap">台新銀</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">78909</td>
                                        <td nowrap="nowrap">10</td>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#" class="fancybox">刪除</a>&nbsp;&nbsp;</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">花旗</td>
                                        <td nowrap="nowrap">100000</td>
                                        <td nowrap="nowrap">20%</td>
                                        <td nowrap="nowrap">20170101</td>
                                        <td nowrap="nowrap">匯款</td>
                                        <td nowrap="nowrap">台新銀</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">78909</td>
                                        <td nowrap="nowrap">10</td>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#" class="fancybox">刪除</a>&nbsp;&nbsp;</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">國泰</td>
                                        <td nowrap="nowrap">100000</td>
                                        <td nowrap="nowrap">20%</td>
                                        <td nowrap="nowrap">20170101</td>
                                        <td nowrap="nowrap">匯款</td>
                                        <td nowrap="nowrap">台新銀</td>
                                        <td nowrap="nowrap">123456</td>
                                        <td nowrap="nowrap">78909</td>
                                        <td nowrap="nowrap">10</td>
                                    </tr>
                                </table>
                            </div>
                            <!--<div class="twocol margin5TB">
                                <div class="right">
                                    <div class="font-title ">
                                        總金額
                                        <span>22000</span>
                                    </div>
                                </div>

                            </div>--><br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="#" class="keybtn">儲存</a>
                                </div>
                            </div>
                            <div class="gentable">
                                <div class="gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="width15" align="right"><div class="font-title titlebackicon" style="color:Red">債權人</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">債權金額</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">執行命令發文日期</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>

                                        </tr>
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon">解款行代號</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                            <td align="right"><div class="font-title titlebackicon">收款人帳號</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                        </tr>
                                        <tr>
                                            <td align="right"><div class="font-title titlebackicon">戶名</div></td>
                                            <td colspan="3"><input type="text" class="inputex width100" /></td>
                                            <td align="right"><div class="font-title titlebackicon">繳款方式</div></td>
                                            <td><input type="radio" />支票<input type="radio" />匯款</td>
                                        </tr>
                                        <tr>

                                            <td align="right"><div class="font-title titlebackicon">債權人承辦人</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                            <td align="right"><div class="font-title titlebackicon">聯絡電話</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                            <td align="right"><div class="font-title titlebackicon">匯款手續費<br />掛號郵資</div></td>
                                            <td><input type="text" class="inputex width100" /></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div><!-- tabs-5 -->
                        <div id="tabs-6">

                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="#" class="keybtn fancybox">新增</a>
                                </div>
                            </div>
                            <div class="stripeMe font-normal">
                                <table width="100%" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <th width="60" nowrap="nowrap" >操作</th>
                                        <th nowrap="nowrap" >津貼扣款代號</th>
                                        <th nowrap="nowrap" >津貼扣款名稱</th>
                                        <th nowrap="nowrap" >加扣別</th>
                                        <th nowrap="nowrap" >金額</th>
                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#">刪除</a></td>
                                        <td nowrap="nowrap">0001</td>
                                        <td nowrap="nowrap">捐款</td>
                                        <td nowrap="nowrap">扣</td>
                                        <td nowrap="nowrap">1500</td>

                                    </tr>
                                    <tr>
                                        <td align="center" nowrap="nowrap"><a href="#">刪除</a></td>
                                        <td nowrap="nowrap">0002</td>
                                        <td nowrap="nowrap">其它津貼</td>
                                        <td nowrap="nowrap">加</td>
                                        <td nowrap="nowrap">1000</td>    
                                    </tr>

                                </table>
                            </div><br />
                            <div class="twocol margin10B">
                                <div class="right">
                                    <a href="#" class="keybtn">儲存</a>
                                </div>
                            </div>
                            <div class="gentable">
                                <div class="gentable">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">津貼代號</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">津貼名稱</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>
                                            <td class="width13" align="right"><div class="font-title titlebackicon" style="color:Red">金額</div></td>
                                            <td class="width15"><input type="text" class="inputex width100" /></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div><!-- tabs-4 -->
                    </div><!-- statabs -->
                    <!-- 詳細資料end -->
                </div><!-- fixwidth -->

            </div>
</asp:Content>

