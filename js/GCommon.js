
CommonEven = {

    //抓元素
    getElement:function(id)
    {
        var i = document.getElementById(id);
        return i;
    },



    //給input 值
   setValue: function (id, Value) {
       $('#' + id).val(Value);
    },

    //傳回Input值
    getValue: function (id) {
        return (document.getElementById(id) != null) ? document.getElementById(id).value : "";
    },

    InputFocus: function (InputID) {
        document.getElementById(InputID).focus();
    },


    //取xml節點值
    XmlNodeGetValue: function (e, Name) {
        try {
            return e.getElementsByTagName(Name)[0].firstChild != null ? e.getElementsByTagName(Name)[0].firstChild.data.toString() : '';
        }
        catch (ex) { return '' }
    },


    //新增xml節點
    addXmlNode: function (xmlDoc, tbody, CreateName, value) {
        var CreateName = xmlDoc.createElement(CreateName);
        CreateName.appendChild(xmlDoc.createTextNode(value));
        tbody.appendChild(CreateName);
    },

    //開啟loading
    openBlockUI: function () {
        $.blockUI({ message: '<img src="../images/loading.gif" />處理中，請稍待...' });
    },

    //關閉啟loading
    closeBlockUI: function () {
        $.unblockUI();
    },


    adJqDailog: function (id, width, hieght) {
        $("#" + id).dialog({
            autoOpen: false,
            width: width,
            height: hieght,
            resizable: false, //可否調整大小
            draggable: false, //可否拖拉
            modal: true //背景鎖定
        });
    },

    OpDailog: function (id) {
        $("#" + id).dialog("open");

    },

    CloseDailog: function (id) {
        $("#" + id).dialog("close");
    }

}


CheckFormat = {
    //驗證數字
    CheckInt: function (Id) {
        var inp = document.getElementById(Id);
        var val = inp.value;
        if (val != "") {
            var re = /^[0-9]+$/;
            if (!re.test(val)) {
                alert("請輸入正確的數字");
                inp.focus();
                return false;                                                                                                                                                                                                                                                 
            }
        }
    },

    //驗證統一編號
    CheckIdennum: function (Id) {
        var inp = document.getElementById(Id);
        var Idennum = inp.value;
        if (Idennum != "") {
            var invalidList = "00000000,11111111";
            if (/^\d{8}$/.test(Idennum) == false || invalidList.indexOf(Idennum) != -1) {
                alert('統一編號格式錯誤');
                inp.focus();
                return false;
            }
        }

        var validateOperator = [1, 2, 1, 2, 1, 2, 4, 1],
        sum = 0,
        calculate = function (product) { // 個位數 + 十位數
            var ones = product % 10,
                tens = (product - ones) / 10;
            return ones + tens;

        }

        for (var i = 0; i < validateOperator.length; i++) {
            sum += calculate(Idennum[i] * validateOperator[i]);

        }

        if (sum % 10 == 0 || (Idennum[6] == "7" && (sum + 1) % 10 == 0)) {
            return true;
        } else {
            alert('統一編號格式錯誤');
            return false;
        }
    },

    //驗證網址
    CheckUrl: function (Id) {
        var inp = document.getElementById(Id);
        var url = inp.value;


        var regUrl = "^((https|http|ftp|rtsp|mms)?://)"
+ "?(([0-9a-z_!~*'().&amp;=+$%-]+: )?[0-9a-z_!~*'().&amp;=+$%-]+@)?" //ftp的user@
+ "(([0-9]{1,3}\.){3}[0-9]{1,3}" // IP形式的URL- 199.194.52.184
+ "|" // 允許IP和DOMAIN（域名）
+ "([0-9a-z_!~*'()-]+\.)*" // 域名- www.
+ "([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\." // 二級域名
+ "[a-z]{2,6})" // first level domain- .com or .museum
+ "(:[0-9]{1,4})?" // 埠- :80
+ "((/?)|" // a slash isn't required if there is no file name
+ "(/[0-9a-z_!~*'().;?:@&amp;=+$,%#-]+)+/?)$";

        var re = new RegExp(regUrl);
        if (!re.test(url)) {
            //Input.value = "";
            alert("網址格式不正確");
            inp.focus();
            return false;
        }
    },

    //驗證信箱
    CheckEmail: function (id) {
        var inp = document.getElementById(id);
        var mail = inp.value;
        if (mail != "") {
            if (mail.search(/^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/) != -1) {
                return true;
            } else {
                alert('電子信箱格式不正確');
                inp.focus();
                return false;
            }            
        }
    },

    //驗證英文&數字
    CheckIntAndE: function (Id) {
        var inp = document.getElementById(Id);
        var val = inp.value;
        if (val != "") {
            var re = /^[a-zA-Z0-9]+$/;
            if (!re.test(val)) {
                alert("請勿輸入非英文字母或數字以外之字元");
                inp.focus();
                return false;
            }
        }
    },

}



LicEven = {

    tblClass:function(){
        $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
        $(".stripeMe tr:even").addClass("alt");
    },

    //add Select control
    addOp: function (id, Json) {
        var e = CommonEven.getElement(id);
        if (e != null) {
            while (e.firstChild) { e.removeChild(e.firstChild); }
            var op1 = new Option("請選擇", "");
            e.add(op1);
            for (i = 0; i < Json.length; i++) {
                var op = new Option(Json[i].Text, Json[i].Value);
                e.add(op);
            }
        }
    },

    //add Select control
    addOp: function (id, Json, Status) {
        var e = CommonEven.getElement(id);
        if (e != null) {
            while (e.firstChild) { e.removeChild(e.firstChild); }
            var op1 = new Option("請選擇", "");
            e.add(op1);
            for (i = 0; i < Json.length; i++) {
                var op = new Option(Json[i].Text, Json[i].Value);
                e.add(op);
            }
            if (Status == "Y") {
                var op2 = new Option("全部", "");
                e.add(op2);
            }
        }
    },
    //add Select control
    addOp_checkbox: function (id, Json) {
        var e = CommonEven.getElement(id);
        if (e != null) {
            while (e.firstChild) { e.removeChild(e.firstChild); }
            var op1 = new Option("", "");
            e.add(op1);
            for (i = 0; i < Json.length; i++) {
                //var op = new Option(Json[i].Text, Json[i].Value);
                var op = '<input text='+ Json[i].Text + ' values='+ Json[i].Value +' type="checkbox">';               
                e.add(op);
            }
        }
    },

    //代碼檔
    SelType: function (ClassStr, func) {
        $.ajax({
            type: "POST",
            url: '../handler/ashx_CodeTable.ashx',
            data: 'Class=' + ClassStr,
            dataType: 'json',  //xml, json, script, text, html
            success: func,
            //function (jsonstr) {
            //    return jsonstr;
            //},
            error: function (xhr, statusText) {
                //alert(xhr.status);
                alert('資料發生錯誤');
            }
        });
    },

    //開啟選人視窗
    OpComperList: function (id) {
        var KeyWord = document.getElementById(id).value.replace('可輸入姓名及工號查詢', '');
        window.open('opcomperList.aspx?KeyWord=' + KeyWord, '555', "height=450, width=720, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, status=no");
    },

    

    //開窗
    OpenCBox: function (hrefstr) {
        $.fancybox({
            href: '#' + hrefstr,
        });
        //$(".fancybox").fancybox({
        //    'width': 400,
        //    'height': 300,
        //    'autoSize': false,
        //    href: '#' + hrefstr
        //});
    },

    //關窗
    CloseCBox: function () {
        $.fancybox.close();
    },

    //清空input
    ClearInput: function (id) {
        var div = document.getElementById(id);
        var txt = div.getElementsByTagName('input');
        for (var i = 0; i < txt.length; i++) {
            var t = txt[i];
            switch (t.getAttribute('type')) {
                case "text":
                    t.value = "";
                    break;
                case "checkbox":
                    t.checked = false;
                    break;
                case "password":
                    t.value = "";
                    break;
            }

        }

        var sel = div.getElementsByTagName('select');
        for (var i = 0; i < sel.length; i++) {
            sel[i].selectedIndex = "";
        }

        var textarea = div.getElementsByTagName('textarea');
        for (var i = 0; i < textarea.length; i++) {
            textarea[i].value = "";
        }



    },




//    //分頁
//    var opt =
//    {
//    id:PageCode.id,
//    quity: quity, //資料總數量
//    paging: paging, //分幾頁
//    cur: cur, //目前頁數
//    click: function() {
                 
                                   
//    } //按下頁碼後執行什麼事件
                 
    //}
    //CmFmCommon.page(opt);*/
    page: function (opt) {

        if (opt.parentCss == null) opt.parentCss = 'PageCss';
        //共 50 筆資料 總計 5 頁
        if (opt.pageInfomationCss == null) opt.pageInfomationCss = 'pageInfomationCss';
        if (opt.Curcss == null) opt.Curcss = '';
        if (opt.Pagecss == null) opt.Pagecss = '';
        if (opt.page_areaCss == null) opt.page_areaCss = 'page_areaCss';
        if (opt.button_up_next_css == null) opt.button_up_next_css = '';
        if (opt.pageShowQuity == null) opt.pageShowQuity = 7;//一頁顯示幾個頁碼
        if (opt.id != null) opt.parentID = opt.id;
        if (opt.quity != null) opt.total = opt.quity;

        /* var opt =
                            {
                                id:PageCode.id,
                                quity: quity, //資料總數量
                                paging: paging, //分幾頁
                                cur: cur, //目前頁數
                                click: function() {
                 
                                   
                                } //按下頁碼後執行什麼事件
                 
                            }
                 CmFmCommon.page(opt);*/
        //var options =
        //           {
        //               total: this._Quity, //資料總數量
        //               paging: this._paging, //分幾頁
        //               cur: this._cur, //目前頁數
        //               parentID: 'pageCodeInfoatiom', //建立在哪個物件ID上
        //               parentCss: 'Comemyfamily_Public01_PageCodeAll_BLUE01', //物件CSS
        //               pageInfomationCss: 'Comemyfamily_Public01_PageInfomationCss_BLUE01', //顯示目前在第幾頁的樣式
        //               Curcss: 'Comemyfamily_Public01_PageCodeAllCur_BLUE01', //目前頁面的樣式
        //               Pagecss: 'Comemyfamily_Public01_PageCodeAllPage_BLUE01', //普通頁碼的樣式
        //               pageShowQuity: 7, //一頁顯示幾個頁碼
        //               page_areaCss: '', //頁碼Code CSS
        //               button_up_next_css: 'Comemyfamily_Public01_BtnCss_BLUE01',
        //               Warp:true, // 總數量1，總頁數1，目前在第1頁 這段字 是否要換行
        //               ImageWidth:'',//圖片大小 只需要寫數字 單位都皆為 px
        //               ImageHeight:'',//圖片大小 只需要寫數字 單位都皆為 px
        //               front_Image_src:'',//第一頁
        //               up_Image_src:'',//上一頁
        //               next_Image_src:'',//下一頁
        //               lastPage:'',//最後一頁
        //               is_SHOW_Details:true,
        //               is_Search:true, //是否需要搜尋
        //               is_Search_value:'搜尋文章',
        //               is_Search_set_value:'', //給他值
        //               Search_Event:function(){this.SearchName },
        //               click: function() {

        //                   CreateMsgResponse(this.cur);
        //               } //按下頁碼後執行什麼事件

        //           }
        //Comemyfamily_JavaScript_Ajax_Create_PageCode(options);




        function FmCommonPage(options) {
            options.is_SHOW_Details = (options.is_SHOW_Details != null) ? options.is_SHOW_Details : true;
            var mainOBJ = document.getElementById(options.parentID);
            if (mainOBJ != null) {

                while (mainOBJ.firstChild) {
                    mainOBJ.removeChild(mainOBJ.firstChild);
                }

                var pagecount = parseInt(parseInt(options.total, 10) / parseInt(options.paging, 10), 10);

                pagecount += parseInt((parseInt(options.total, 10) % parseInt(options.paging, 10) == 0) ? 0 : 1, 10);


                if (parseInt(pagecount, 10) > 0) {
                    var page_area_all = document.createElement('div');
                    page_area_all.setAttribute('class', options.parentCss);
                    page_area_all.setAttribute('className', options.parentCss);



                    var page_area_infomation = document.createElement('span');
                    page_area_infomation.setAttribute('class', options.pageInfomationCss);
                    page_area_infomation.setAttribute('className', options.pageInfomationCss);
                    // page_area_infomation.innerHTML = '總數量' + options.total + '，總頁數' + pagecount + '，目前在第' + options.cur + '頁';
                    if (options.is_SHOW_Details) page_area_infomation.innerHTML = '共 ' + options.total + ' 筆資料 總計 ' + pagecount + ' 頁';
                    if (options.Warp) {
                        page_area_infomation.appendChild(document.createElement('br'));
                    }
                    var page_area = document.createElement('span');
                    page_area.setAttribute('class', options.page_areaCss);
                    page_area.setAttribute('className', options.page_areaCss);
                    var n = options.pageShowQuity;
                    var page = parseInt(options.cur, 10);
                    var maxValue = page + n;
                    var minValue = page - n;

                    var up = ((parseInt(options.cur, 10) - 1) < 1) ? 1 : parseInt(options.cur, 10) - 1;
                    var next = ((parseInt(options.cur, 10) + 1) >= pagecount) ? pagecount : parseInt(options.cur, 10) + 1;

                    var start = (minValue < 1) ? 1 : minValue;
                    var end = (maxValue > parseInt(pagecount, 10)) ? parseInt(pagecount, 10) : maxValue;
                    var i;

                    var upPage;
                    var onePage;

                    if (options.cur != '1') {
                        onePage = document.createElement('a'); upPage = document.createElement('a');
                        FmCommonPage.prototype.click(onePage, options);
                        FmCommonPage.prototype.click(upPage, options);
                    } else { onePage = document.createElement('span'); upPage = document.createElement('span'); onePage.style.color = '#888'; onePage.style.border = '0'; upPage.style.color = '#888'; upPage.style.border = '0'; }
                    onePage.style.cursor = 'pointer';

                    if (options.front_Image_src == '' || options.front_Image_src == null) {
                        if (options.front_innerHTML == '' || options.front_innerHTML == null)
                        { onePage.innerHTML = '第一頁'; }
                        else { onePage.innerHTML = options.front_innerHTML; }

                    } else {
                        var front_Image = document.createElement('img');
                        front_Image.style.border = '0';
                        front_Image.style.width = (options.ImageWidth != null) ? options.ImageWidth + 'px' : 'auto';
                        front_Image.style.height = (options.ImageHeight != null) ? options.ImageHeight + 'px' : 'auto';
                        front_Image.src = options.front_Image_src;
                        onePage.appendChild(front_Image);
                    }


                    onePage.setAttribute('pageCode', '1');
                    onePage.setAttribute('class', options.button_up_next_css);
                    onePage.setAttribute('className', options.button_up_next_css);

                    page_area.appendChild(onePage);



                    upPage.style.cursor = 'pointer';


                    if (options.up_Image_src == '' || options.up_Image_src == null) {
                        if (options.up_innerHTML == '' || options.up_innerHTML == null)
                        { upPage.innerHTML = '上一頁'; }
                        else { upPage.innerHTML = options.up_innerHTML; }

                    } else {
                        var up_Image = document.createElement('img');
                        up_Image.style.border = '0';
                        up_Image.style.marginLeft = '5px';
                        up_Image.style.marginRight = '5px';
                        up_Image.style.width = (options.ImageWidth != null) ? options.ImageWidth + 'px' : 'auto';
                        up_Image.style.height = (options.ImageHeight != null) ? options.ImageHeight + 'px' : 'auto';
                        up_Image.src = options.up_Image_src;
                        upPage.appendChild(up_Image);
                    }
                    upPage.setAttribute('pageCode', up);
                    upPage.setAttribute('class', options.button_up_next_css);
                    upPage.setAttribute('className', options.button_up_next_css);


                    page_area.appendChild(upPage);

                    for (i = start; i <= end; i++) {

                        var pageCode = document.createElement('a');
                        pageCode.style.cursor = 'pointer';
                        pageCode.setAttribute('pageCode', i);

                        FmCommonPage.prototype.click(pageCode, options);

                        pageCode.innerHTML = i;

                        if (i == options.cur) {

                            pageCode.setAttribute('class', options.Curcss);
                            pageCode.setAttribute('className', options.Curcss);
                        } else {
                            pageCode.setAttribute('class', options.Pagecss);
                            pageCode.setAttribute('className', options.Pagecss);
                        }

                        page_area.appendChild(pageCode);
                    }
                    var nextPage;
                    var lastPage;
                    if (pagecount != options.cur) {
                        nextPage = document.createElement('a'); lastPage = document.createElement('a');
                        FmCommonPage.prototype.click(nextPage, options);
                        FmCommonPage.prototype.click(lastPage, options);
                    } else { nextPage = document.createElement('span'); lastPage = document.createElement('span'); nextPage.style.color = '#888'; nextPage.style.border = '0'; lastPage.style.color = '#888'; lastPage.style.border = '0'; }


                    nextPage.style.cursor = 'pointer';
                    if (options.next_Image_src == '' || options.next_Image_src == null) {
                        if (options.next_innerHTML == '' || options.next_innerHTML == null)
                        { nextPage.innerHTML = '下一頁'; }
                        else { nextPage.innerHTML = options.next_innerHTML; }

                    } else {
                        var next_Image = document.createElement('img');
                        next_Image.style.border = '0';
                        next_Image.style.width = (options.ImageWidth != null) ? options.ImageWidth + 'px' : 'auto';
                        next_Image.style.height = (options.ImageHeight != null) ? options.ImageHeight + 'px' : 'auto';
                        next_Image.style.marginLeft = '5px';
                        next_Image.style.marginRight = '5px';
                        next_Image.src = options.next_Image_src;
                        nextPage.appendChild(next_Image);
                    }
                    nextPage.setAttribute('pageCode', next);
                    nextPage.setAttribute('class', options.button_up_next_css);
                    nextPage.setAttribute('className', options.button_up_next_css);
                    FmCommonPage.prototype.click(nextPage, options);

                    page_area.appendChild(nextPage);



                    lastPage.style.cursor = 'pointer';

                    if (options.last_Image_src == '' || options.last_Image_src == null) {
                        if (options.last_innerHTML == '' || options.last_innerHTML == null)
                        { lastPage.innerHTML = '最後一頁'; }
                        else { lastPage.innerHTML = options.last_innerHTML; }

                    } else {
                        var last_Image = document.createElement('img');
                        last_Image.style.border = '0';
                        last_Image.style.width = (options.ImageWidth != null) ? options.ImageWidth + 'px' : 'auto';
                        last_Image.style.height = (options.ImageHeight != null) ? options.ImageHeight + 'px' : 'auto';
                        last_Image.src = options.last_Image_src;
                        lastPage.appendChild(last_Image);
                    }
                    lastPage.setAttribute('pageCode', pagecount);
                    lastPage.setAttribute('class', options.button_up_next_css);
                    lastPage.setAttribute('className', options.button_up_next_css);
                    FmCommonPage.prototype.click(lastPage, options);

                    page_area.appendChild(lastPage);


                    page_area_all.appendChild(page_area);
                    page_area_all.appendChild(page_area_infomation);


                    if (options.is_Search != null && options.is_Search) {

                        var TextBox = document.createElement('input');
                        TextBox.style.width = '100px';
                        TextBox.style.height = '20px';
                        TextBox.style.marginLeft = '5px'
                        TextBox.style.marginTop = '2px'
                        TextBox.style.color = '#888';
                        if (options.is_Search_value != null && (options.is_Search_set_value == null || options.is_Search_set_value == '')) {
                            TextBox.setAttribute('DefaultValue', options.is_Search_value);
                            TextBox.value = options.is_Search_value;
                        } else {

                            TextBox.value = options.is_Search_set_value;
                            TextBox.style.color = '#000';
                        }

                        TextBox.onfocus = function () {
                            var TMPVALUE = this.value.replace(this.getAttribute('DefaultValue'), '');
                            if (TMPVALUE == '') {
                                this.value = TMPVALUE;

                            } else { this.style.color = '#000'; }
                        }
                        TextBox.onkeyup = function () {
                            var TMPVALUE = this.value.replace(this.getAttribute('DefaultValue'), '');
                            if (TMPVALUE != '') {
                                this.style.color = '#000';
                            }
                        }


                        TextBox.onblur = function () {
                            if (this.value.replace(this.getAttribute('DefaultValue'), '') == '') {
                                this.value = this.getAttribute('DefaultValue');
                                this.style.color = '#888';
                            }
                        }

                        var TextBoxButton = document.createElement('a'); TextBoxButton.style.border = '0px';
                        TextBoxButton.setAttribute('title', options.is_Search_value);
                        TextBoxButton.style.cursor = 'pointer';

                        var img = document.createElement('img'); img.style.border = '0px';
                        img.src = CmFmCommon.PhyPath() + 'Image/magnifier/magnifier01.png';

                        TextBoxButton.appendChild(img);

                        var Text_Span = document.createElement('span');
                        Text_Span.appendChild(TextBox);
                        Text_Span.appendChild(TextBoxButton);

                        Text_Span.style.cssFloat = 'left';
                        Text_Span.style.cssFloat = 'left';
                        TextBox.style.cssFloat = 'left';
                        TextBox.style.cssFloat = 'left';
                        TextBoxButton.style.cssFloat = 'left';
                        TextBoxButton.style.cssFloat = 'left';

                        mainOBJ.setAttribute('tabindex', '0');
                        mainOBJ.onfocus = function () {
                            TextBox.onkeydown = keyDown;
                            function keyDown(e) {
                                var currKey = 0;
                                e = e || event;
                                currKey = e.keyCode || e.which || e.charCode;
                                //判斷是否按下Enter鍵
                                if (currKey == 13) {
                                    SearchAlbumButton.click();
                                }
                            }
                        }


                        mainOBJ.appendChild(Text_Span);


                        //搜尋的事件

                        TextBoxButton.onclick = function () {
                            if (options.Search_Event != null) {
                                options.SearchName = TextBox.value.replace(TextBox.getAttribute('DefaultValue'), '');
                                options.Search_Event.call(options);
                            }
                        }
                    }

                    mainOBJ.appendChild(page_area_all);
                }
            }
        }

        FmCommonPage.prototype = {
            click: function (link, options) {
                link.onclick = function () {
                    options.cur = this.getAttribute('pageCode');
                    options.click.call(options);
                }
            }
        }

        FmCommonPage(opt);

    }
}

