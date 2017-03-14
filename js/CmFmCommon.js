var CmFmCommon = {
    loginCookiename: 'comemyfamilyuser',
    request: function (strParame) {
        var args = new Object();
        var query = location.search.substring(1);
        if (query != '') {
            var pairs = query.split("&"); // Break at ampersand 
            for (var i = 0; i < pairs.length; i++) {
                var pos = pairs[i].indexOf('=');
                if (pos == -1) continue;
                var argname = pairs[i].substring(0, pos);
                var value = pairs[i].substring(pos + 1);
                value = decodeURIComponent(value);
                args[argname] = value;
            }
            return args[strParame];
        } else return '';
    } ,
    EventListener: function (elem, evnt, func, before) {

        if (elem.addEventListener)  // W3C DOM
            elem.addEventListener(evnt, func, before);
        else if (elem.attachEvent) { // IE DOM
            elem.attachEvent("on" + evnt, func);
        }
        else { // No much to do
            elem[evnt] = func;
        }
    },
    ajax: function (opt) {
        /*
            var opt = {
                success:function(){

                },
                v:'post 變數'

            }
        */


        opt.url =  opt.url;
        opt.call = opt.success;
        opt.Variable = opt.v;
        opt.type = opt.type || 'text';
        
        this.AjaxPost(opt);
    },
    XmlRequest: function () {
        var XMLHttpFactories = [
         function () { return new XMLHttpRequest() },
         function () { return new ActiveXObject("Msxml2.XMLHTTP") },
         function () { return new ActiveXObject("Msxml3.XMLHTTP") },
         function () { return new ActiveXObject("MSXML2.XMLHTTP.6.0") },
         function () { return new ActiveXObject("Microsoft.XMLHTTP") }
        ];

        var xmlHttp = false;

        for (var i = 0; i < XMLHttpFactories.length; i++) {
            try { xmlHttp = XMLHttpFactories[i](); }
            catch (e) { continue; }
            break;
        }
        if (xmlHttp.overrideMimeType) xmlHttp.overrideMimeType('text/xml');
        
        return xmlHttp;
    },
    AjaxPost: function (options) {
        try{
            var AjaxType = options.type || 'post';
            var xmlHttp = CmFmCommon.XmlRequest();
            xmlHttp.onreadystatechange = function () {
             
                if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                    switch (AjaxType.toString().toLowerCase()) {
                        default:
                        
                            options.call(xmlHttp.responseText);
                            break;

                        case "xml":

                            var xmlDoc = xmlHttp.responseXML;
                            options.call(xmlDoc, xmlHttp.responseText);
                            break;
                    }

                    delete xmlHttp;
                    xmlHttp = null;
                } else {

                    if (xmlHttp.readyState == 4 && typeof xmlHttp.status == 'number') {
                        if (typeof options.error == 'function')
                            options.error(xmlHttp.status, xmlHttp.responseText);

                        delete xmlHttp;
                        xmlHttp = null;
                    }
                }
            }

            
            xmlHttp.open("post", options.url, true);
             
            if (xmlHttp.responseType != null && xmlHttp.responseType!='') xmlHttp.responseType = 'msxml-document';
            xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); //**重要一定要加上
            xmlHttp.setRequestHeader("pragma", "no-cache");
          
            xmlHttp.send(options.Variable);
        
            return xmlHttp;
        } catch (ex) { alert(ex); }
    }, //Ajax
    XmlDoc: function () {
        var xmlDoc = null;
        if (window.ActiveXObject || "ActiveXObject" in window) {
            xmlDoc = new ActiveXObject('Microsoft.XMLDOM');
            xmlDoc.async = false;
        } else if (document.implementation && document.implementation.createDocument) {
            xmlDoc = document.implementation.createDocument("", "", null);
        }

        xmlDoc.async = false;
        var Xml_head = xmlDoc.createProcessingInstruction('xml', "version=\"1.0\" encoding='utf-8'");
        xmlDoc.appendChild(Xml_head);

        return xmlDoc;
    }, //傳回XmlDoc
    XmlDoc_Get: function (XmlDocument) {
        return XmlDocument.xml ? XmlDocument.xml : (new XMLSerializer()).serializeToString(XmlDocument);
    },
    Xsl: function (DocXML, XslUrl, Container, Parameter, increase) {

        function loadXMLDoc(filename) {

            if (window.ActiveXObject || "ActiveXObject" in window) {
                xhttp = new ActiveXObject("Msxml2.XMLHTTP");
            }
            else {
                xhttp = new XMLHttpRequest();
            }
            xhttp.open("GET", filename, false);
            try { xhttp.responseType = "msxml-document" } catch (err) { } // Helping IE11
            xhttp.send("");


            return xhttp.responseXML;


        }


        var i = 0;
        var e1 = Container;
        if (increase == null) increase = false;
        if (increase != true) {
            while (e1.firstChild) {
                e1.removeChild(e1.firstChild);
            }
        }

        if (window.ActiveXObject || "ActiveXObject" in window) {

            var oXslDom = new ActiveXObject("Msxml2.FreeThreadedDOMDocument.3.0");
            oXslDom.async = false;
            oXslDom.load(XslUrl);

            var oXslTemplate = new ActiveXObject("Msxml2.XSLTemplate.3.0");
            oXslTemplate.stylesheet = oXslDom;

            var oXslProcessor = oXslTemplate.createProcessor();
            oXslProcessor.input = DocXML;
            if (Parameter != null) {
                var ParaterLength = Parameter.length;
                for (i = 0; i < ParaterLength; i++) {
                    var value = Parameter[i].value;
                    var text = Parameter[i].text;
                    oXslProcessor.addParameter(text, value);
                }
            }
            oXslProcessor.transform();
            var output = oXslProcessor.output;




            if (increase != true)
                e1.innerHTML = output;

            else
                e1.innerHTML = e1.innerHTML + output;




            delete oXslDom;
            delete oXslTemplate;
            delete oXslProcessor;
            oXslDom = null;
            oXslTemplate = null;
            oXslProcessor = null;


            //            var xmlstr = DocXML.transformNode(xsltHTML);
            //            e1.innerHTML = xmlstr;
        }
            // code for Mozilla, Firefox, Opera, etc.
        else if (document.implementation && document.implementation.createDocument) {
            var xsltHTML = loadXMLDoc(XslUrl);



            var xsltProcessor = new XSLTProcessor();
            xsltProcessor.importStylesheet(xsltHTML);

            if (Parameter != null) {
                var ParaterLength = Parameter.length;
                for (i = 0; i < ParaterLength; i++) {
                    var value = Parameter[i].value;
                    var text = Parameter[i].text;
                    xsltProcessor.setParameter(null, text, value);
                }
            }


            var resultDocument = xsltProcessor.transformToFragment(DocXML, document);

            if (resultDocument != null) {
                if (increase != true)
                    e1.appendChild(resultDocument);
                else
                    e1.appendChild(resultDocument);
            } else { CmFmCommon.alert(resultDocument); }

            delete xsltProcessor;
            xsltProcessor = null;
        }

        delete xsltHTML;
        xmlHttp = null;

    }, //傳Xsl
    fmXslMenu: function (xslurl, parameter, Container) {
        var XmlDoc = this.XmlDoc();
        this.Xsl(XmlDoc, this.PhyPath() + xslurl, Container, parameter);
    },
    GUID: function () {
        var S4 = function () {
            return Math.floor(
                    Math.random() * 0x10000 /* 65536 */
                ).toString(16);
        };

        return (
                S4() + S4() + "-" +
                S4() + "-" +
                S4() + "-" +
                S4() + "-" +
                S4() + S4() + S4()
            );

    },
    PhyPath: function () {
         
        var url = location.protocol + '//' + location.host;
      
        
        var nUpLn, sDir = "", sPath = location.pathname.replace(/[^\/]*$/, '../'.replace(/(\/|^)(?:\.?\/+)+/g, "$1"));
        for (var nEnd, nStart = 0; nEnd = sPath.indexOf("/../", nStart), nEnd > -1; nStart = nEnd + nUpLn) {
            nUpLn = /^\/(?:\.\.\/)*/.exec(sPath.slice(nEnd))[0].length;
            sDir = (sDir + sPath.substring(nStart, nEnd)).replace(new RegExp("(?:\\\/+[^\\\/]*){0," + ((nUpLn - 1) / 3) + "}$"), "/");
        }

        if (url.indexOf('WebSite1')>=0) if (sDir == '/') sDir = '/WebSite1/';

        return url + sDir;
    }, //傳回實體路徑

    absolute: function (sRelPath) {
        var nUpLn, sDir = "", sPath = location.pathname.replace(/[^\/]*$/, sRelPath.replace(/(\/|^)(?:\.?\/+)+/g, "$1"));
        for (var nEnd, nStart = 0; nEnd = sPath.indexOf("/../", nStart), nEnd > -1; nStart = nEnd + nUpLn) {
            nUpLn = /^\/(?:\.\.\/)*/.exec(sPath.slice(nEnd))[0].length;
            sDir = (sDir + sPath.substring(nStart, nEnd)).replace(new RegExp("(?:\\\/+[^\\\/]*){0," + ((nUpLn - 1) / 3) + "}$"), "/");
        }
        return sDir + sPath.substr(nStart);
    },
    AjaxPostXsl: function (call_ajax_Options) {
        if (call_ajax_Options.Cancel_Load != true) {
            if (call_ajax_Options.xsl.obj.watingLoad != null)
                Comemyfamily_LOAD(false, { id: call_ajax_Options.xsl.obj.watingLoad });
            call_ajax_Options.xsl.obj.watingLoad = Comemyfamily_LOAD(true, { id: call_ajax_Options.xsl.obj.id, background: '#fff', C: 0, height: 'auto' });
        }


        var option = {

            url: call_ajax_Options.ashx,   //呼叫哪個 ashx
            call: function (XmlDoc) {
                if (call_ajax_Options.Cancel_Load != true)
                    Comemyfamily_LOAD(false, { id: call_ajax_Options.xsl.obj.watingLoad });
                CmFmCommon.Xsl(XmlDoc, call_ajax_Options.xsl.path, call_ajax_Options.xsl.obj, call_ajax_Options.xsl.param, call_ajax_Options.increase);
                call_ajax_Options.xml = XmlDoc;
                call_ajax_Options.Success.call(call_ajax_Options);
            }, //拿到值以後 呼叫哪個 function
            Variable: call_ajax_Options.v, //傳遞變數
            type: 'xml', //回傳類型
            show_alert: false //是不是要秀alert
        }
        new CmFmCommon.AjaxPost(option);
    },
    Xpath: function (xmlDoc, Xpath) {
        if (window.ActiveXObject || "ActiveXObject" in window) {
            return xmlDoc.selectNodes(Xpath);
        }
        else {
            try {
                var xpe = new XPathEvaluator();

                var nsResolver = xpe.createNSResolver(xmlDoc.ownerDocument == null ? xmlDoc.documentElement : xmlDoc.ownerDocument.documentElement);

                var result = xpe.evaluate(Xpath, xmlDoc, nsResolver, XPathResult.ANY_TYPE, null);

                var found = [];

                var res;
                while (res = result.iterateNext())
                    found.push(res);

                return found;
            } catch (ex) { alert(ex); }
        }
    },
    XpathV: function (xmlDoc, Xpath, n) {

        var S = this.Xpath(xmlDoc, Xpath);
        if (n == null)
            return (S[0] == null) ? "" : (S[0].firstChild == null) ? "" : S[0].firstChild.data.toString();
        else return (S[n] == null) ? "" : (S[n].firstChild == null) ? "" : S[n].firstChild.data.toString();

    },
    alert: function (Msg, AlertMode, url) {

        function comemyfamily_alert(Msg, AlertMode, url) {
            /*錯誤:F  成功:S  警告:W*/

            var options = {
                AlertMode: AlertMode,
                Msg: Msg,
                url: url || ''

            }
            comemyfamily_alert.prototype.init(options);
            //comemyfamily_alert.prototype.Assembled(); //20150428Mark Loading div
        }

        comemyfamily_alert.prototype = {

            init: function (options) { this._options = options; },
            outermost: function () {
                var msgObj = document.createElement("div")

                msgObj.setAttribute('tabindex', '0');
                msgObj.style.background = 'Transparent';
                msgObj.style.position = 'fixed';
                msgObj.style.font = "12px/1.6em Verdana, Geneva, Arial, Helvetica, sans-serif";

                msgObj.style.lineHeight = "25px";
                msgObj.style.zIndex = '9999999';
                msgObj.onfocus = function () {
                    this.style.outline = '0';
                }

                var div = document.createElement('div');
                div.style.width = '287px';
                div.style.margin = '0 auto';
                div.style.height = '152px';
                div.style.display = 'table';
                div.style.background = "url('" + CmFmCommon.PhyPath() + "Image/comemyfamily_alert/comemyfamily_alert_backgroundcolor.png')";
                div.style.backgroundRepeat = 'no-repeat';

                var Second = document.createElement('div');
                Second.style.display = 'table-cell';
                Second.style.verticalAlign = 'middle';
                Second.style.height = '100%';

                div.appendChild(Second);
                msgObj.appendChild(div);
                document.body.appendChild(msgObj);

                this.__comemyfamily_alert_msgObj = msgObj;

                msgObj.onkeydown = function (e) {

                    comemyfamily_alert.prototype.Cancel();
                }
                return Second;

            },
            outermostTable: function (ParentNode) {

                var table = document.createElement('table');
                table.style.margin = '0 auto';
                table.style.width = '100%';

                var tbody = document.createElement('tbody');
                var tr = document.createElement('tr');
                var td = document.createElement('td'); td.style.paddingTop = '10px';
                var div = document.createElement('div');

                td.appendChild(div);
                tr.appendChild(td);
                tbody.appendChild(tr);
                table.appendChild(tbody);

                ParentNode.appendChild(table);
                return div;

            },
            contentTable: function () {

                var table = document.createElement('table');
                table.style.width = '100%';
                var tbody = document.createElement('tbody');
                var tr = document.createElement('tr');
                var trMsg = document.createElement('tr');
                var tr1 = document.createElement('tr');

                var td = document.createElement('td'); td.style.padding = '5p';
                var tdMsg = document.createElement('td'); tdMsg.setAttribute('Valign', 'middle'); tdMsg.style.padding = '3px';
                var td1 = document.createElement('td');
                td1.style.textAlign = 'right';
                td1.setAttribute('colSpan', '2');

                var img = document.createElement('img');
                img.style.height = '85px';
                img.style.width = '85px';
                var AlertMode = this._options.AlertMode || 'E';
                switch (AlertMode.toString().toUpperCase()) {

                    default: img.src = CmFmCommon.PhyPath() + 'images/loading.gif';
                        img.style.marginLeft = '10px';
                        img.style.height = '75px';
                        img.style.width = '75px';
                        break;
                    case "S":
                        img.src = CmFmCommon.PhyPath() + 'Image/comemyfamily_alert/O_comemyfamily_alert.png';
                        break;

                    case "W":
                        img.src = CmFmCommon.PhyPath() + 'Image/comemyfamily_alert/W_comemyfamily_alert.png';
                        img.style.marginLeft = '10px';
                        break;
                }
                img.style.verticalAlign = 'middle';

                //        img.onload = function() {
                //            td.style.width = this.offsetWidth + 'px';
                //            tdMsg.style.width = this.offsetWidth - comemyfamily_alert.prototype.__comemyfamily_alert_msgObj.offsetWidth + 'px';
                //        }

                var content_span = document.createElement('span');
                content_span.style.fontSize = '16px';
                try {
                    content_span.innerHTML = this._options.Msg.replace('/\\n/g', '<br />');
                } catch (ex) { content_span.innerHTML = this._options.Msg; }


                var spanButton = document.createElement('span');
                spanButton.style.marginRight = '10px';
                spanButton.innerHTML = '任一鍵關閉..';
                spanButton.style.fontWeight = 'bold';
                td.appendChild(img);

                tdMsg.appendChild(content_span);
                td1.appendChild(spanButton);

                tr.appendChild(td);
                tr.appendChild(tdMsg);
                tr1.appendChild(td1);

                tbody.appendChild(tr);
                tbody.appendChild(trMsg);
                tbody.appendChild(tr1);

                table.appendChild(tbody);
                td.style.width = '0';
                tdMsg.style.width = '100%';
                return table;

            },
            bgObj: function () {
                var bgObj = document.createElement("div");
                bgObj.style.position = "fixed";
                bgObj.style.top = "0";
                bgObj.style.background = '#000';
                bgObj.style.filter = 'alpha(opacity=70)';
                bgObj.style.opacity = '0.7';
                bgObj.style.left = "0";
                bgObj.style.width = "100%";
                bgObj.style.height = "100%";
                bgObj.style.zIndex = '9999998';
                document.body.appendChild(bgObj);

                this.__comemyfamily_alert_bgObj = bgObj;

                bgObj.onclick = function () {
                    comemyfamily_alert.prototype.Cancel();
                }
            },
            Cancel: function () {

                try {
                    document.body.removeChild(this.__comemyfamily_alert_bgObj);
                    document.body.removeChild(this.__comemyfamily_alert_msgObj);

                    if (this._options.url != '') {
                        location.replace(this._options.url);
                    }
                } catch (ex) { this.__comemyfamily_alert_bgObj.style.display = 'none'; this.__comemyfamily_alert_msgObj.style.display = 'none'; }
            },
            Assembled: function () {

                var outermost = this.outermost();
                var outermostTable = this.outermostTable(outermost);
                var contentTable = this.contentTable();
                this.bgObj();
                outermostTable.appendChild(contentTable);

                var TOP_position = (this.documentWH().winH - this.__comemyfamily_alert_msgObj.offsetHeight) / 2 - 150 + 'px';;
                var LEFT_position = ((this.documentWH().winW / 2) - (this.__comemyfamily_alert_msgObj.offsetWidth / 2)) + 'px';

                this.__comemyfamily_alert_msgObj.style.top = TOP_position;
                this.__comemyfamily_alert_msgObj.style.left = LEFT_position;

                this.__comemyfamily_alert_msgObj.focus();

            },
            documentWH: function () {
                var winW = 0; var winH = 0;
                if (document.body && document.body.offsetWidth) {
                    winW = document.body.offsetWidth;
                    winH = document.body.offsetHeight;
                }
                if (document.compatMode == 'CSS1Compat' &&
                        document.documentElement &&
                        document.documentElement.offsetWidth) {
                    winW = document.documentElement.offsetWidth;
                    winH = document.documentElement.offsetHeight;
                }
                if (window.innerWidth && window.innerHeight) {
                    winW = window.innerWidth;
                    winH = window.innerHeight;
                }

                return { winW: winW, winH: winH };
            }
        }

        comemyfamily_alert(Msg, AlertMode, url);
    },
    c_time: function (eObj, Opt) {
        /*
            var Opt={
                title:'', //前置詞
                Isdown:true, //是否倒數計時
                downend:function(){
                    this.sender //計算的物件
                }//倒數計時結束以後
            }
        
        */


        var o = eObj.innerHTML.trim();
        var s = new Date();
        var e = Date.parse(eObj.innerHTML);
        var spantime = (s - e) / 1000;
        if (Opt != null && Opt.Isdown) {
            spantime = (e - s) / 1000;
        }
        eObj.setAttribute('CmFmCommon_Regist_time', eObj.innerHTML);
        var dd = setInterval(function () {


            if (Opt != null && Opt.Isdown) {
                spantime--;
                countDown(eObj, spantime, Opt);
            }
            else {
                spantime++; startTime(eObj, spantime);
            }


        }, 1000);
        if (Opt != null && Opt.Isdown) {
            countDown(eObj, spantime, Opt);
        } else {
            startTime(eObj, spantime);
        }

        //倒數計時
        function countDown(eObj, spantime, Opt) {
            Opt.title = Opt.title || '';
            spantime--;
            var yy = Math.floor(spantime / (24 * 3600)) / 30 / 12;
            var mm = Math.floor(spantime / (24 * 3600)) / 30;
            var d = Math.floor(spantime / (24 * 3600));
            var h = Math.floor((spantime % (24 * 3600)) / 3600);
            var m = Math.floor((spantime % 3600) / (60));
            var s = Math.floor(spantime % 60);
            //var millisecond = 1000;
            //var millisecondIndex = 0;

            //var millisecondstart = setInterval(function () {
            //    millisecondIndex += 1;


            //    if (millisecondIndex >= millisecond) {
            //        clearInterval(millisecondstart);
            //    } else {
            //        str = Opt.title + d + "天 " + h + "時 " + m + "分 " + s + "秒." + millisecondIndex.toString();
            //        eObj.innerHTML = str;
            //    }

            //}, 1);

            str = Opt.title + d + "天 " + h + "時 " + m + "分 " + s + "秒";
            if (d <= 0) str = Opt.title + h + "時 " + m + "分 " + s + "秒";
            if (h <= 0) str = Opt.title + m + "分 " + s + "秒";
            if (m <= 0) str = Opt.title + s + "秒";

            eObj.innerHTML = str;

            if (spantime <= 0) {

                clearInterval(dd);
                if (typeof (Opt.downend) == 'function') {
                    Opt.timeText = eObj.getAttribute('CmFmCommon_Regist_time'); //原來時間
                    Opt.sender = eObj;
                    Opt.downend.call(Opt);
                }
            }
        }
        //計時
        function startTime(eObj, spantime) {
            var yy = Math.floor(spantime / (24 * 3600)) / 30 / 12;
            var mm = Math.floor(spantime / (24 * 3600)) / 30;
            var d = Math.floor(spantime / (24 * 3600));
            var h = Math.floor((spantime % (24 * 3600)) / 3600);
            var m = Math.floor((spantime % 3600) / (60));
            var s = Math.floor(spantime % 60);
            str = d + "天 " + h + "時 " + m + "分 " + s + "秒 ";
            if (d == 0 && h == 0 && m == 0) {
                str = s + "秒前";
            }

            if (d == 0 && h == 0 && m != 0) {
                str = m + "分鐘前";
            }


            if (d == 0 && h != 0) {
                str = h + "小時前";
            }


            if (d != 0 && mm >= 1) {
                str = parseInt(mm, 10) + "個月前";
            } else {

                if (d != 0) {
                    str = d + "天前";
                }
            }

            if (yy >= 1) {
                str = parseInt(yy, 10) + '年前';
            }

            eObj.innerHTML = str;
        }
    },
    AjaxW: function (Msg) {
        /* CmFmCommon.AjaxW(true, { id: self.id, background: 'Transparent', C: 0, height: 'auto' });
            this.__AlbumList_PageCode = Comemyfamily_LOAD(true, { id: this.__Options.AlbumList_PageCode });
            CmFmCommon.AjaxW(false, { id: e.__AlbumList_PageCode });*/
        function Comemyfamily_Wait_Loading(Msg) {
            Comemyfamily_Wait_Loading.prototype.init(Msg);
            Comemyfamily_Wait_Loading.prototype.Assembled();
        }
        Comemyfamily_Wait_Loading.prototype = {
            init: function (Msg) {
                this.__Msg = Msg || '處理中';
            },
            outermost: function () {
                var msgObj = document.createElement("div");

                msgObj.setAttribute('tabindex', '0');
                msgObj.style.background = 'Transparent';
                msgObj.style.background = "url('" + CmFmCommon.PhyPath() + "Image/public/load/comemyfamily_load_backgroundcolor.png')";
                msgObj.style.backgroundRepeat = 'no-repeat';
                msgObj.style.position = 'fixed';
                msgObj.style.font = "12px/1.6em Verdana, Geneva, Arial, Helvetica, sans-serif";

                msgObj.style.lineHeight = "25px";
                msgObj.style.zIndex = '4999999';
                msgObj.onfocus = function () {
                    this.style.outline = '0';
                }

                var div = document.createElement('div');

                div.style.width = '150px';
                div.style.margin = '0 auto';
                div.style.height = '50px';
                div.style.padding = '10px';


                var img = document.createElement('img');
                img.setAttribute('title', 'Loading');
                img.setAttribute('alt', 'Loading');
                img.src = Comemyfamily_PhysicalPath() + 'Image/loading/progress_loading.gif';


                var spanMsg = document.createElement('span');
                spanMsg.innerHTML = this.__Msg;





                var table = document.createElement('table'); table.style.widht = '100%'; table.style.marginLeft = '30px';
                var tbody = document.createElement('tbody');
                var tr = document.createElement('tr');
                var td1 = document.createElement('td');
                var td2 = document.createElement('td');

                td1.appendChild(img);
                td2.appendChild(spanMsg);
                td2.style.width = '100%';

                tr.appendChild(td1);
                tr.appendChild(td2);
                tbody.appendChild(tr);
                table.appendChild(tbody);

                div.appendChild(table);

                msgObj.appendChild(div);
                document.body.appendChild(msgObj);

                this.__Comemyfamily_Wait_Loading_msgObj = msgObj;



            },
            bgObj: function () {
                var bgObj = document.createElement("div");
                bgObj.style.position = "fixed";
                bgObj.style.top = "0";
                bgObj.style.background = '#000';
                bgObj.style.filter = 'alpha(opacity=70)';
                bgObj.style.opacity = '0.7';
                bgObj.style.left = "0";
                bgObj.style.width = "100%";
                bgObj.style.height = "100%";
                bgObj.style.zIndex = '4999998';
                document.body.appendChild(bgObj);

                this.__Comemyfamily_Wait_Loading_bgObj = bgObj;


            },
            Assembled: function () {

                this.outermost();
                this.bgObj();


                var TOP_position = (this.documentWH().winH - this.__Comemyfamily_Wait_Loading_msgObj.offsetHeight) / 2 - 150 + 'px';;
                var LEFT_position = ((this.documentWH().winW / 2) - (this.__Comemyfamily_Wait_Loading_msgObj.offsetWidth / 2)) + 'px';

                this.__Comemyfamily_Wait_Loading_msgObj.style.top = TOP_position;
                this.__Comemyfamily_Wait_Loading_msgObj.style.left = LEFT_position;

                this.__Comemyfamily_Wait_Loading_msgObj.focus();

            },
            Cancel: function () {

                if (this.__Comemyfamily_Wait_Loading_bgObj != null) {
                    document.body.removeChild(this.__Comemyfamily_Wait_Loading_bgObj);
                }
                if (this.__Comemyfamily_Wait_Loading_msgObj != null) {
                    document.body.removeChild(this.__Comemyfamily_Wait_Loading_msgObj);
                }

            },
            documentWH: function () {
                var winW = 0; var winH = 0;
                if (document.body && document.body.offsetWidth) {
                    winW = document.body.offsetWidth;
                    winH = document.body.offsetHeight;
                }
                if (document.compatMode == 'CSS1Compat' &&
                        document.documentElement &&
                        document.documentElement.offsetWidth) {
                    winW = document.documentElement.offsetWidth;
                    winH = document.documentElement.offsetHeight;
                }
                if (window.innerWidth && window.innerHeight) {
                    winW = window.innerWidth;
                    winH = window.innerHeight;
                }

                return { winW: winW, winH: winH };
            }
        }
    },
    dimg: function (ImgD, FitWidth, FitHeight, Hard) { //|| Hard 是否不管三七二十一就調整就對了
        try {
            if (Hard == null) Hard = false;
            if (ImgD != null) {
                var image = new Image();
                image.src = ImgD.src;
                // ImgD.style.removeAttribute('display');
                //  ImgD.src = Comemyfamily_PhysicalPath() + "Image/loading/load_ajax.gif";
                if (image.width > 0 && image.height > 0) {

                    if (image.width / image.height >= FitWidth / FitHeight) {
                        if (image.width > FitWidth || Hard) {
                            ImgD.style.width = FitWidth + "px";
                            ImgD.style.height = (image.height * FitWidth) / image.width + "px";
                        } else {
                            ImgD.style.width = image.width + "px";
                            ImgD.style.height = image.height + "px";
                        }
                    } else {
                        if (image.height > FitHeight || Hard) {
                            ImgD.style.height = FitHeight + "px";
                            ImgD.style.width = (image.width * FitHeight) / image.height + "px";
                        } else {
                            ImgD.style.width = image.width + "px";
                            ImgD.style.height = image.height + "px";
                        }
                    }

                }
                ImgD.onload = function () { }
                ImgD.src = image.src;

                //ImgD.style.removeAttribute('display');
            }
        } catch (ex) { alert(ex); }
    },
    is_disabled_scroll: function (disabled) {
        function wheel(e) {
            preventDefault(e);
        }

        function disable_scroll() {
            if (window.addEventListener) {

                window.addEventListener('DOMMouseScroll', wheel, false);
            }
            window.onmousewheel = document.onmousewheel = wheel;
            //    document.onkeydown = keydown;
        }

        function enable_scroll() {
            if (window.removeEventListener) {
                window.removeEventListener('DOMMouseScroll', wheel, false);
            }
            window.onmousewheel = document.onmousewheel = document.onkeydown = null;
        }
        if (!disabled)
            enable_scroll();
        else disable_scroll();
    }, //是不是要啟用 滾輪 
    ScorllBar: function (id, CmFun) {
        /* 
        var Options={
            ScrollbarEnd:function(){ } //最後
        }*/

        function jsScrollbar(o, s, a, ev) {
            var self = this;

            this.reset = function (re, reo) {
                //Arguments that were passed
                if (re == null) {
                    this._parent = o;
                    this._src = s;
                    this.auto = a ? a : false;
                    this.eventHandler = ev ? ev : function () { };
                    //Component Objects
                    //   this._up = this._findComponent("Scrollbar-Up", this._parent);
                    //   this._down = this._findComponent("Scrollbar-Down", this._parent);
                    this._yTrack = this._findComponent("Scrollbar-Track", this._parent);
                    this._yHandle = this._findComponent("Scrollbar-Handle", this._yTrack);
                    //Height and position properties
                    this._trackTop = findOffsetTop(this._yTrack);
                    this._trackHeight = this._yTrack.offsetHeight;
                    this._handleHeight = this._yHandle.offsetHeight;

                    this._x = 0;
                    this._y = 0;

                    //Misc. variables
                    this._scrollDist = 5;
                    this._scrollTimer = null;
                    this._selectFunc = null;
                    this._grabPoint = null;
                    this._tempTarget = null;
                    this._tempDistX = 0;
                    this._tempDistY = 0;
                    this._disabled = false;
                    this._ratio = (this._src.totalHeight - this._src.viewableHeight) / (this._trackHeight - this._handleHeight);

                    this._yHandle.ondragstart = function () { return false; };
                    this._yHandle.onmousedown = function () { return false; };

                    this._addEvent(this._src.content, "mousewheel", this._scrollbarWheel);
                    this._addEvent(this._src.content, "DOMMouseScroll", this._scrollbarWheel); // firefox
                    this._removeEvent(this._parent, "mousedown", this._scrollbarClick);
                    this._addEvent(this._parent, "mousedown", this._scrollbarClick);

                    this._src.reset();
                    with (this._yHandle.style) {
                        top = "0px";
                        left = "0px";
                    }
                    this._moveContent();

                    if (this._src.totalHeight < this._src.viewableHeight) {
                        this._disabled = true;
                        this._yHandle.style.visibility = "hidden";
                        if (this.auto) this._parent.style.visibility = "hidden";
                    } else {
                        this._disabled = false;
                        this._yHandle.style.visibility = "visible";
                        this._parent.style.visibility = "visible";
                    }

                } else {
                    this._src = reo;
                    this._ratio = (this._src.totalHeight - this._src.viewableHeight) / (this._trackHeight - this._handleHeight);
                    this._moveContent();
                }
            };
            this._addEvent = function (o, t, f) {

                if (o.addEventListener) { o.addEventListener(t, f, false); }
                else if (o.attachEvent) { o.attachEvent('on' + t, f); }
                else o['on' + t] = f;
            };
            this._removeEvent = function (o, t, f) {
                if (o.removeEventListener) o.removeEventListener(t, f, false);
                else if (o.detachEvent) o.detachEvent('on' + t, f);
                else o['on' + t] = null;
            };
            this._findComponent = function (c, o) {
                var kids = o.childNodes;
                for (var i = 0; i < kids.length; i++) {
                    if (kids[i].getAttribute('CmScrollBar') == c) {
                        return kids[i];
                    }
                }
            };
            //Thank you, Quirksmode
            function findOffsetTop(o) {
                var t = 0;
                if (o.offsetParent) {
                    while (o.offsetParent) {
                        t += o.offsetTop;
                        o = o.offsetParent;
                    }
                }
                return t;
            };
            this._scrollbarClick = function (e) {
                if (self._disabled) return false;

                e = e ? e : event;
                if (!e.target) e.target = e.srcElement;

                if (e.target.getAttribute('CmScrollBar') == "Scrollbar-Up") self._scrollUp(e);
                else if (e.target.getAttribute('CmScrollBar') == "Scrollbar-Down") self._scrollDown(e);
                else if (e.target.getAttribute('CmScrollBar') == "Scrollbar-Track") self._scrollTrack(e);
                else if (e.target.getAttribute('CmScrollBar') == "Scrollbar-Handle") self._scrollHandle(e);

                self._tempTarget = e.target;
                self._selectFunc = document.onselectstart;
                document.onselectstart = function () { return false; };

                self.eventHandler(e.target, "mousedown");
                self._addEvent(document, "mouseup", self._stopScroll, false);

                return false;
            };
            this._scrollbarDrag = function (e) {
                e = e ? e : event;
                var t = parseInt(self._yHandle.style.top);
                var v = e.clientY + document.body.scrollTop - self._trackTop;
                with (self._yHandle.style) {
                    if (v >= self._trackHeight - self._handleHeight + self._grabPoint)
                        top = self._trackHeight - self._handleHeight + "px";
                    else if (v <= self._grabPoint) top = "0px";
                    else top = v - self._grabPoint + "px";
                    self._y = parseInt(top);
                }

                self._moveContent();
            };
            this._scrollbarWheel = function (e) {

                var wheelDistance = function (evt) {
                    if (!evt) evt = event;
                    var w = evt.wheelDelta, d = evt.detail;
                    if (d) {
                        if (w) return w / d / 40 * d > 0 ? 1 : -1; // Opera
                        else return -d / 3;              // Firefox;         TODO: do not /3 for OS X
                    } else return w / 120;             // IE/Safari/Chrome TODO: /3 for Chrome OS X
                };

                e = e ? e : event;

                var dir = 0;

                //if (wheelDistance(e) >= 120) dir = -1;
                //if (wheelDistance(e) <= -120) dir = 1;

                dir = wheelDistance(e);
                if (dir < 0) dir = 1;
                else dir = -1;

                self.scrollBy(0, dir * 50);


                e.returnValue = false;
            };
            this._startScroll = function (x, y) {
                this._tempDistX = x;
                this._tempDistY = y;
                this._scrollTimer = window.setInterval(function () {
                    self.scrollBy(self._tempDistX, self._tempDistY);
                }, 1);
            };
            this._stopScroll = function () {
                self._removeEvent(document, "mousemove", self._scrollbarDrag, false);
                self._removeEvent(document, "mouseup", self._stopScroll, false);

                if (self._selectFunc) document.onselectstart = self._selectFunc;
                else document.onselectstart = function () { return true; };

                if (self._scrollTimer) window.clearInterval(self._scrollTimer);
                self.eventHandler(self._tempTarget, "mouseup");
            };
            this._scrollUp = function (e) { this._startScroll(0, -this._scrollDist); };
            this._scrollDown = function (e) { this._startScroll(0, this._scrollDist); };
            this._scrollTrack = function (e) {
                var curY = e.clientY + document.body.scrollTop;
                this._scroll(0, curY - this._trackTop - this._handleHeight / 2);
            };
            this._scrollHandle = function (e) {
                var curY = e.clientY + document.body.scrollTop;
                this._grabPoint = curY - findOffsetTop(this._yHandle);
                this._addEvent(document, "mousemove", this._scrollbarDrag, false);
            };
            this._scroll = function (x, y) {
                if (y > this._trackHeight - this._handleHeight)
                    y = this._trackHeight - this._handleHeight;
                if (y < 0) y = 0;

                this._yHandle.style.top = y + "px";
                this._y = y;

                this._moveContent();
            };
            this._moveContent = function () {
                this._src.scrollTo(0, Math.round(this._y * this._ratio));
            };

            this.scrollBy = function (x, y) {
                this._scroll(0, (-this._src._y + y) / this._ratio);
            };
            this.scrollTo = function (x, y) {
                this._scroll(0, y / this._ratio);
            };
            this.swapContent = function (o, w, h) {
                this._removeEvent(this._src.content, "mousewheel", this._scrollbarWheel, false);
                this._removeEvent(this._src.content, "DOMMouseScroll", this._scrollbarWheel, false);
                this._src.swapContent(o, w, h);
                this.reset();
            };

            this.reset();

            return this;
        };



        //Written by Nathan Faubion: http://n-son.com
        //Use this or edit how you want, just give me
        //some credit!

        function jsScroller(o, w, h, CmFun) {
            var self = this;
            //var list = o.getElementsByTagName("div");
            //for (var i = 0; i < list.length; i++) {
            //    if (list[i].className.indexOf("Scroller-Container") > -1) {
            //        o = list[i];
            //    }
            //}

            //Private methods


            this._setPos = function (x, y) {


                if (x < this.viewableWidth - this.totalWidth)
                    x = this.viewableWidth - this.totalWidth;
                if (x > 0) x = 0;
                if (y < this.viewableHeight - this.totalHeight)
                    y = this.viewableHeight - this.totalHeight;
                if (y > 0) y = 0;
                this._x = x;
                this._y = y;
                var m = (this.viewableHeight - this.totalHeight);
                if (y == m) {
                    if (CmFun != null) {
                        var CmResize = this.content.getAttribute('CmResizeOK');
                        if (CmResize == null || CmResize == 'ok') {
                            this.content.setAttribute('CmResizeOK', '');
                            CmFun.content = this.content;

                            var img = document.createElement('img');
                            img.setAttribute('id', CmFmCommon.GUID());
                            img.src = CmFmCommon.PhyPath() + 'Image/loading/ajax_loader.gif';
                            CmFun.content.parentNode.appendChild(img);
                            CmFun.content.setAttribute('imgID', img.id);
                            img.style.position = 'absolute';
                            img.style.left = '50%';
                            img.style.bottom = 0;
                            CmFun.imgID = img.id;
                            var qq = setTimeout(function () {

                                CmFun.ContainerHeight = CmFun.Container.offsetHeight;
                                CmFun.y = y;
                                CmFun.totalHeight = this.totalHeight;
                                CmFun.d = 20;
                                CmFun.o = o;


                                CmFun.OK = function () {
                                    var content = CmFun.content;
                                    var ccc = document.getElementById(this.id);
                                    if (ccc != null) {

                                        this.sender.Scrollbar.tweenTo(Math.abs(CmFun.y) - CmFun.d);
                                    }
                                    this.ok = null;
                                    //o.style.top = -(Math.abs(CmFun.y) - CmFun.d) + 'px';
                                    content.setAttribute('CmResizeOK', 'ok');
                                }


                                if (CmFun.end != true)
                                    CmFun.ScrollbarEnd.call(CmFun);
                                else {
                                    if (CmFun.OnEnd != null)
                                        CmFun.OnEnd.call();
                                }
                                clearTimeout(qq);
                            }, 500);
                        }

                    }
                }

                var style = window.getComputedStyle(o, null);

                o.setAttribute('Scorball_now_x', style.left);
                o.setAttribute('Scorball_now_y', style.top);
                o.setAttribute('Scorball_x', this._x);
                o.setAttribute('Scorball_y', this._y);

                if (style.left < this._y) {
                    o.setAttribute('Scorball_Method', 'D');
                } else { o.setAttribute('Scorball_Method', 'A'); } //遞增


                var i = 10;
                var ss = setInterval(function () {

                    var c = true; //是否繼續
                    var now_x = parseInt(o.getAttribute('Scorball_now_x'), 10); //目前的值
                    var now_y = parseInt(o.getAttribute('Scorball_now_y'), 10);//目前的值
                    var x = parseInt(o.getAttribute('Scorball_x'), 10); //移到哪裡
                    var y = parseInt(o.getAttribute('Scorball_y'), 10);//移到哪裡
                    var Method = '';

                    if (o.getAttribute('Scorball_Method_Edit') == 'update') {
                        if (now_y < y) {
                            o.setAttribute('Scorball_Method', 'D');  //遞減 
                        } else { o.setAttribute('Scorball_Method', 'A'); } //遞增
                    }
                    Method = o.getAttribute('Scorball_Method');

                    if (now_y != y) {
                        if (Method == 'D') {
                            now_y = now_y + i;
                            o.setAttribute('Scorball_Method_Edit', 'read');
                            if (now_y >= y) {
                                c = false;
                                clearInterval(ss);
                                o.setAttribute('Scorball_Method_Edit', 'update');
                            }
                        }
                        else {
                            now_y = now_y - i;
                            o.setAttribute('Scorball_Method_Edit', 'read');
                            if (now_y <= y) {
                                c = false;
                                clearInterval(ss);
                                o.setAttribute('Scorball_Method_Edit', 'update');
                            }
                        }
                    } else {
                        clearInterval(ss);
                    }
                    o.setAttribute('Scorball_now_y', now_y);

                    if (c) {
                        with (o.style) {
                            left = now_x + "px";
                            top = now_y + "px";
                        }
                    } else {
                        with (o.style) {
                            left = x + "px";
                            top = y + "px";
                        }
                    }

                }, 1);

                //with (o.style) {
                //    left = this._x + "px";
                //    top = this._y + "px";
                //}
            };

            //Public Methods
            this.reset = function () {
                this.content = o;
                this.totalHeight = o.offsetHeight;
                this.totalWidth = o.offsetWidth;
                this._x = 0;
                this._y = 0;
                with (o.style) {
                    left = "0px";
                    top = "0px";
                }
            };
            this.scrollBy = function (x, y) {
                this._setPos(this._x + x, this._y + y);
            };
            this.scrollTo = function (x, y) {
                this._setPos(-x, -y);
            };
            this.stopScroll = function () {
                if (this.scrollTimer) window.clearInterval(this.scrollTimer);
            };
            this.startScroll = function (x, y) {
                this.stopScroll();
                this.scrollTimer = window.setInterval(
                    function () { self.scrollBy(x, y); }, 1
                );
            };
            this.swapContent = function (c, w, h) {
                o = c;
                //var list = o.getElementsByTagName("div");
                //for (var i = 0; i < list.length; i++) {
                //    if (list[i].className.indexOf("Scroller-Container") > -1) {
                //        o = list[i];
                //    }
                //}
                if (w) this.viewableWidth = w;
                if (h) this.viewableHeight = h;
                this.reset();
            };

            //variables
            this.content = o;
            this.viewableWidth = w;
            this.viewableHeight = h;
            this.totalWidth = o.offsetWidth;
            this.totalHeight = o.offsetHeight;
            this.scrollTimer = null;
            this.reset();
        };


        function jsScrollerTween(o, t, s) {
            var self = this;

            this._tweenTo = function (y) {
                if (self._idle) {
                    var tHeight = self._parent._src ? self._parent._src.totalHeight : self._parent.totalHeight;
                    var vHeight = self._parent._src ? self._parent._src.viewableHeight : self._parent.viewableHeight;
                    var scrollY = self._parent._src ? self._parent._src._y : self._parent._y;

                    if (y < 0) y = 0;
                    if (y > tHeight - vHeight) y = tHeight - vHeight;

                    var dist = y - (-scrollY);

                    self._inc = 0;
                    self._timer = null;
                    self._values = [];
                    self._idle = false;
                    //for (var i = 0; i < self.steps.length; i++) {
                    self._values = Math.round((-scrollY) + dist * (self.steps / 100));
                    //}
                    self._timer = window.setInterval(function () {
                        self._parent.scrollTo(0, y);

                        window.clearTimeout(self._timer);
                        self._idle = true;

                    }, self.stepDelay);
                }
            };
            this._tweenBy = function (y) {
                var scrollY = self._parent._src ? self._parent._src._y : self._parent._y;
                self._tweenTo(-scrollY + y);
            };
            this._trackTween = function (e) {
                e = e ? e : event;
                self._parent.canScroll = false;
                var curY = e.clientY + document.body.scrollTop;
                self._tweenTo((curY - self._parent._trackTop - self._parent._handleHeight / 2) * self._parent._ratio);
            };

            this.stepDelay = 1;
            this.steps = 1;
            this._values = [];
            this._parent = o;
            this._timer = [];
            this._idle = true;

            o.tweenTo = this._tweenTo;
            o.tweenBy = this._tweenBy;
            o.trackTween = this._trackTween;

            if (t) o._scrollTrack = function (e) {
                this.trackTween(e);
            };
        };


        /*
        var Options={
            ScrollbarEnd:function(){
        
            } //最後
        }
        
        */

        function CmScorllBar(id, CmFun) {



            var Container = document.getElementById(id);
            Container.style.position = 'absolute';
            Container.parentNode.style.position = 'relative';
            Container.parentNode.style.overflow = 'hidden';

            //Container.parentNode.style.backgroundColor = '#EEE';


            /*Scrollbar-Container*/
            var ScrollbarContainer = document.createElement('div');
            ScrollbarContainer.setAttribute('id', CmFmCommon.GUID());
            ScrollbarContainer.style.position = 'absolute';
            ScrollbarContainer.style.right = '0';
            /*Scrollbar-Container*/

            /*Scrollbar up*/
            var ScrollbarUp = document.createElement('div');
            ScrollbarUp.setAttribute('CmScrollBar', 'Scrollbar-Up');
            ScrollbarUp.style.position = 'absolute';
            ScrollbarUp.style.width = '0px';
            ScrollbarUp.style.height = '0px';
            ScrollbarUp.style.backgroundColor = '#ccc';
            ScrollbarUp.style.fontSize = '0px';
            /*Scrollbar up*/

            /*Scrollbar-Down*/
            var ScrollbarDown = document.createElement('div');
            ScrollbarDown.setAttribute('CmScrollBar', 'Scrollbar-Down');
            // ScrollbarDown.style.position = 'absolute';
            ScrollbarDown.style.width = '10px';
            ScrollbarDown.style.height = '0px';
            ScrollbarDown.style.backgroundColor = '#ccc';
            ScrollbarDown.style.fontSize = '0px';
            ScrollbarDown.style.top = '190px';
            /*Scrollbar-Down*/
            //  width: 10px; height: 10px; background-color: #CCC; font-size: 0px;

            /*Scrollbar Track*/
            var ScrollbarTrack = document.createElement('div');
            ScrollbarTrack.setAttribute('CmScrollBar', 'Scrollbar-Track');
            ScrollbarTrack.style.position = 'absolute';
            ScrollbarTrack.style.width = '10px';
            ScrollbarTrack.style.height = (Container.parentNode.offsetHeight * 0.98) + 'px';
            ScrollbarTrack.style.backgroundColor = '#EEE';

            /*Scrollbar Track*/


            /*Scrollbar Track - Scrollbar-Handle*/
            var ScrollbarHandle = document.createElement('div');
            ScrollbarHandle.setAttribute('CmScrollBar', 'Scrollbar-Handle');
            ScrollbarHandle.setAttribute('class', 'Scrollbar-Handle');
            ScrollbarHandle.setAttribute('className', 'Scrollbar-Handle');
            ScrollbarHandle.style.position = 'absolute';
            ScrollbarHandle.style.width = '10px';
            //  ScrollbarHandle.style.height = (parseInt(Container.parentNode.offsetHeight, 10) * 0.4) + 'px';
            ScrollbarHandle.style.backgroundColor = '#CCC';
            /*Scrollbar Track- Scrollbar-Handle*/

            /*HTML
            
            <div id="Scrollbar-Container">
                <div class="Scrollbar-Up"></div>
                <div class="Scrollbar-Down"></div>
                <div class="Scrollbar-Track">
                    <div class="Scrollbar-Handle"></div>
                </div>
            </div>
            */

            ScrollbarContainer.appendChild(ScrollbarUp);
            ScrollbarContainer.appendChild(ScrollbarDown);
            ScrollbarContainer.appendChild(ScrollbarTrack);
            ScrollbarTrack.appendChild(ScrollbarHandle);


            Container.parentNode.appendChild(ScrollbarContainer);
            //  scroller = new jsScroller(Container, Container.parentNode.offsetWidth, Container.parentNode.offsetHeight);
            //   scrollbar = new jsScrollbar(ScrollbarContainer, scroller, true, scrollbarEvent);


            if (Container.offsetHeight > Container.parentNode.offsetHeight && Container.getAttribute('ScrollbarContainer') == null) {
                Container.style.width = (parseInt(Container.offsetWidth, 10) - parseInt(ScrollbarContainer.offsetWidth, 10)) + 'px';
                Container.setAttribute('ScrollbarContainer', 'true');
            }



            Container.parentNode.setAttribute('ScrollbarContainerID', ScrollbarContainer.id);
            ScrollbarContainer.style.filter = "alpha(opacity=0)";
            ScrollbarContainer.style.opacity = 0;


            function preventDefault(e) {
                e = e || window.event;
                if (e.preventDefault)
                    e.preventDefault();
                e.returnValue = false;
            }



            function wheel(e) {
                preventDefault(e);
            }

            function disable_scroll() {
                if (window.addEventListener) {

                    window.addEventListener('DOMMouseScroll', wheel, false);
                }
                window.onmousewheel = document.onmousewheel = wheel;
                //    document.onkeydown = keydown;
            }

            function enable_scroll() {
                if (window.removeEventListener) {
                    window.removeEventListener('DOMMouseScroll', wheel, false);
                }
                window.onmousewheel = document.onmousewheel = document.onkeydown = null;
            }


            var Options =
                          {
                              obj: Container.parentNode, //誰觸發
                              over: function () {
                                  var s = document.getElementById(this.NOW_OBJECT.getAttribute('ScrollbarContainerID'));
                                  if (s != null) {
                                      disable_scroll();
                                      var max = 100;
                                      var i = 0;
                                      var Scrollbar = setInterval(function () {
                                          if (i <= max) {
                                              s.style.filter = "alpha(opacity=" + i + ")";
                                              s.style.opacity = i * 0.01;
                                          } else { clearInterval(Scrollbar); }
                                          i = i + 5;
                                      }, 1);
                                  }
                              },
                              out: function () {
                                  var s = document.getElementById(this.NOW_OBJECT.getAttribute('ScrollbarContainerID'));
                                  if (s != null) {
                                      enable_scroll();
                                      var max = 0;
                                      var i = 100;
                                      var Scrollbar = setInterval(function () {
                                          if (i >= max) {
                                              s.style.filter = "alpha(opacity=" + i + ")";
                                              s.style.opacity = i * 0.01;
                                          } else { clearInterval(Scrollbar); }
                                          i = i - 5;
                                      }, 1);
                                  }
                              }
                          }

            CmFmCommon.mouse(Options);
            var O = new Object;
            O.Container = Container.parentNode;
            O.ScrollbarHandle = ScrollbarHandle;
            O.ScrollbarTrack = ScrollbarTrack;
            O.resize = function () {
                this.ScrollbarHandle.style.height = ((parseInt(this.Container.offsetHeight, 10) - parseInt(this.ScrollbarTrack.offsetHeight, 10)) * 0.1 * 50) + 'px';
            }
            O.resize();

            if (CmFun != null) {
                CmFun.Container = Container;
                CmFun.ContainerHeight = Container.offsetHeight;
                CmFun.ScrollbarTrackHeight = ScrollbarTrack.offsetHeight;
                CmFun.ScrollbarHandle = ScrollbarHandle;
            }

            var Scroller = new jsScroller(Container, Container.parentNode.offsetWidth, Container.parentNode.offsetHeight, CmFun);
            var Scrollbar = new jsScrollbar(ScrollbarContainer, Scroller, true, scrollbarEvent);
            new jsScrollerTween(Scrollbar, true);
            O.Scrollbar = Scrollbar;
            Container.O = O;
            Container.Scroller = Scroller;
            Container.resize = setInterval(function () {
                if (Container.getAttribute('resize') == null)
                    Container.setAttribute('resize', Container.offsetHeight);

                if (Container.offsetHeight != Container.getAttribute('resize')) {
                    Container.setAttribute('CmResize', 'true');
                    Container.Scroller.totalHeight = Container.offsetHeight;
                    Container.O.Scrollbar.reset(true, Container.Scroller);
                    Container.setAttribute('resize', Container.offsetHeight);
                }
            }, 500);

            if (CmFun != null) {
                CmFun.id = id;
                CmFun.sender = O;
            }
            return O;
        }


        function scrollbarEvent(o, type) {
            if (type == "mousedown") {
                if (o.getAttribute('CmScrollBar') == "Scrollbar-Track") o.style.backgroundColor = "#E3E3E3";
                else o.style.backgroundColor = "#BBB";
            } else {
                if (o.getAttribute('CmScrollBar') == "Scrollbar-Track") o.style.backgroundColor = "#EEE";
                else o.style.backgroundColor = "#CCC";
            }
        }

        return CmScorllBar(id, CmFun);
    },//scroll bar 
    //給cookie中的值
    setCookie: function (name, value, expireday) {

        var exp = new Date();
        exp.setTime(exp.getTime() + expireday * 24 * 60 * 60 * 1000); //设置cookie的期限
        document.cookie = name + "=" + escape(value) + "; expires" + "=" + exp.toGMTString(); //创建cookie

    },
    //提取cookie中的值
    getCookie: function (name) {

        var cookieStr = document.cookie;
        var value = '';
        if (cookieStr.length > 0) {

            var cookieArr = cookieStr.split(";"); //将cookie信息转换成数组

            for (var i = 0; i < cookieArr.length; i++) {

                var cookieVal = cookieArr[i].split("="); //将每一组cookie(cookie名和值)也转换成数组

                if (cookieVal[0] == name) {

                    value = unescape(cookieVal[1]); //返回需要提取的cookie值
                    break;
                }
            }
        }

        return value;
    },
    //刪除Cookie
    delCookie: function (cookieName) {
        var expires = new Date();
        expires.setTime(expires.getTime() - 1); //将expires设为一个过去的日期，浏览器会自动删除它
        document.cookie = cookieName + "=; expires=" + expires.toGMTString();
    },
    page: function (opt) {

        if (opt.parentCss == null) opt.parentCss = 'Comemyfamily_Public01_PageCodeAll_BLUE01';
        if (opt.pageInfomationCss == null) opt.pageInfomationCss = 'Comemyfamily_Public01_PageInfomationCss_BLUE01';
        if (opt.Curcss == null) opt.Curcss = 'Comemyfamily_Public01_PageCodeAllCur_BLUE01';
        if (opt.Pagecss == null) opt.Pagecss = 'Comemyfamily_Public01_PageCodeAllPage_BLUE01';
        if (opt.page_areaCss == null) opt.page_areaCss = '';
        if (opt.button_up_next_css == null) opt.button_up_next_css = 'Comemyfamily_Public01_BtnCss_BLUE01';
        if (opt.pageShowQuity == null) opt.pageShowQuity = 7;//一頁顯示幾個頁碼
        opt.parentID = opt.id;
        opt.total = opt.quity;
         
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
                    if (options.is_SHOW_Details) page_area_infomation.innerHTML = '每頁' + options.paging + '筆/共' + options.total + '筆  ' + options.cur + '/' + pagecount + '';
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


                    page_area_infomation.appendChild(page_area);
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

    },

    slideImg: {
        init: function (Opt) {

            /*
            滑動圖片

            li display:inline-block;    word-spacing:0;     list-style:none;

            使用 HTML
            
            
                
            <div class="cm_slide_img_area" id="cm_slide_img_area">
                     <ul id="ul01">
                          <li><img src="ComemyfamilyVirtualPath/Activity/hahaha/146/8aa4ab72cbd74045920746d28b74fa9d.Jpg" /></li>   
                     </ul>
                 </div> 
             <a href="JavaScript:void(0)" id="left">左邊</a>  <a id="right" style="float:right;" href="JavaScript:void(0)">往右邊</a>
             
             ----------------------
            使用JS

              var Opt = {
                id: 'cm_slide_img_area', //div id
                width: 860, //div width
                height: 133, // div height
                rightId: 'right', //right object id
                rightClick:function(){

                },
                leftId: 'left',//left object id
                leftClick:function(){

                },
                few: 5, // 一頁有幾筆
                speed:1 //速度
            }

            new cm_slideImg.init(Opt);

            ----------------------
            */
            CmFmCommon.slideImg.Opt = Opt;
            CmFmCommon.slideImg.start();
        },
        disabled: function (sender, Isdiable) {

            sender.disabled = Isdiable;
            if (Isdiable) {
                sender.style.display = 'none';
                sender.removeAttribute('href');
            } else {
                sender.setAttribute('href', 'JavaScript:void(0)');
                sender.style.removeProperty("display");
            }
        },
        start: function () {
            var id = this.Opt.id;
            var sild_area = document.getElementById(id);
            
            var sild_area_w = sild_area.offsetWidth;
            var ul = sild_area.getElementsByTagName('ul');
            var rightBtn = document.getElementById(this.Opt.rightId);
            var leftBtn = document.getElementById(this.Opt.leftId);

            rightBtn.style.removeProperty('display');
            leftBtn.style.removeProperty('display');

            if (ul.length > 0 && rightBtn != null && leftBtn != null) {
                //  ul[0].setAttribute('style', ' display:table;    word-spacing:-1em; margin:0; padding:0;  position:absolute;   list-style:none; white-space: nowrap;');

                var li = sild_area.getElementsByTagName('li');
                var i = 0;


                if (li.length > 0) {

                    //for (i = 0; i < li.length; i++) {
                    //    li[i].setAttribute('style', '  ');
                    //}
                    var li_w = li[0].offsetWidth;
                    var few = sild_area.offsetWidth / li_w;

                    var max_li_w = li_w * few;
                    var ul_li_w = ul[0].offsetWidth;
                    var total = parseInt(ul_li_w / sild_area_w, 10);
                    this.set_cm_speed(rightBtn, this.Opt.speed);
                    this.set_cm_speed(leftBtn, this.Opt.speed);

                    this.cm_li_w(rightBtn, leftBtn, li_w);
                    this.cm_few(rightBtn, leftBtn, few);
                    this.ul_id(rightBtn, leftBtn, ul[0].id);

                    this.right(rightBtn, leftBtn);
                    this.left(leftBtn, rightBtn);

                    this.setDefaultPage(ul[0]);

                    this.disabled(leftBtn, true);

                    if (this.total(ul[0], sild_area_w) == 1) {
                        this.disabled(rightBtn, true);
                    }
                }

                var Monitor = setInterval(function () {
                  
                    var nowPage = CmFmCommon.slideImg.getPage(ul[0]);
                    var total = ul[0].offsetWidth / sild_area_w;
                    var num = new Number(total);
                    if (nowPage < num.toFixed(1)) { CmFmCommon.slideImg.disabled(rightBtn, false); }
                    else { CmFmCommon.slideImg.disabled(rightBtn, true); }

                 
                     if (nowPage > Math.ceil(num)) leftBtn.click();
                   

                }, 1);
            }

        },
        total: function (sender, sild_area_w) {
            if (sild_area_w != null)
                sender.setAttribute('cm_sild_area_w', sild_area_w);

            return Math.round(sender.offsetWidth / parseInt(sender.getAttribute('cm_sild_area_w'), 10));
        },

        setDefaultPage: function (sender) {
            sender.setAttribute('cm_slidPage', 1);
        },
        setaddPage: function (sender) {
            sender.setAttribute('cm_slidPage', this.getPage(sender) + 1);
        },
        setMinusPage: function (sender) {
            sender.setAttribute('cm_slidPage', this.getPage(sender) - 1);
        },

        getPage: function (sender) {

            if (sender.getAttribute('cm_slidPage') != null)
                return parseInt(sender.getAttribute('cm_slidPage'), 10);
            else return 1;

        },

        /*速度*/
        set_cm_speed: function (sender, speend) {

            sender.setAttribute('cm_slidImg_speed', speend);
        },
        get_cm_speed: function (sender) {

            if (sender.getAttribute('cm_slidImg_speed') != null)
                return parseInt(sender.getAttribute('cm_slidImg_speed'), 10);
            else return 1;

        },
        /*li 單筆一 width*/
        cm_li_w: function (rightBtn, leftBtn, li_w) {
            rightBtn.setAttribute('cm_li_w', li_w);
            leftBtn.setAttribute('cm_li_w', li_w);
        },
        /*取 得li 單筆 width*/
        get_cm_li_w: function (sender) {

            if (sender.getAttribute('cm_li_w') == null) {
                return 0;
            } else {
                return parseInt(sender.getAttribute('cm_li_w'), 10);
            }
        },
        /*一頁顯示幾筆*/
        cm_few: function (rightBtn, leftBtn, few) {
            rightBtn.setAttribute('cm_few', few);
            leftBtn.setAttribute('cm_few', few);
        },
        /*取 一頁顯示幾筆*/
        get_cm_few: function (sender) {

            if (sender.getAttribute('cm_few') == null) {
                return 0;
            } else {
                return parseInt(sender.getAttribute('cm_few'), 10);
            }
        },
        /*取 一頁顯示幾筆*/
        get_cm_fewFloat: function (sender) {

            if (sender.getAttribute('cm_few') == null) {
                return 0;
            } else {
                return parseFloat(sender.getAttribute('cm_few'));
            }
        },
        /*ul id*/
        ul_id: function (rightBtn, leftBtn, ul_id) {
            rightBtn.setAttribute('ul_id', ul_id);
            leftBtn.setAttribute('ul_id', ul_id);
        },
        /*get ul id*/
        get_ul_id: function (sender) {
            return sender.getAttribute('ul_id');

        },
        /* 紀錄已滑過紀錄 指標*/
        set_cm_right: function (sender, cm_right) {
            var ul = document.getElementById(sender.getAttribute('ul_id'));
            ul.setAttribute('cm_right', cm_right);
        },
        /*取得 紀錄已滑過紀錄 指標*/
        get_cm_right: function (sender) {
            var ul = document.getElementById(sender.getAttribute('ul_id'));
            if (ul.getAttribute('cm_right') == null) return 0
            else
                return parseInt(ul.getAttribute('cm_right'), 10);
        },
        /* 紀錄已滑過紀錄 最大*/
        set_cm_slideImg_max: function (sender, cm_slideImg_max) {
            var ul = document.getElementById(sender.getAttribute('ul_id'));
            ul.setAttribute('cm_slideImg_max', cm_slideImg_max);
        },
        /*取得 紀錄已滑過紀錄 最大*/
        get_cm_slideImg_max: function (sender, cm_right) {
            var ul = document.getElementById(sender.getAttribute('ul_id'));

            if (ul.getAttribute('cm_slideImg_max') == null) return 0
            else
                return parseInt(ul.getAttribute('cm_slideImg_max'), 10);
        },
        right: function (rightBtn, leftBtn) {
            var e = CmFmCommon.slideImg;
            var cm_right = 0;

            rightBtn.setAttribute('leftBtn', leftBtn.id);
            rightBtn.onclick = function () {
                var sender = this;
                if ((sender.tagName.toString().toLowerCase() == 'a' && sender.getAttribute('href') != null)
                     || sender.tagName.toString().toLowerCase() != 'a') {

                    var leftBtn = document.getElementById(sender.getAttribute('leftBtn'));
                    leftBtn.disabled = false;

                    /*滑動的時候要 diabled*/
                    sender.disabled = true;

                    var cm_li_w = e.get_cm_li_w(sender);
                    var cm_few = e.get_cm_few(sender);
                    var _tmp_ul_id = e.get_ul_id(sender);
                    var ul = document.getElementById(_tmp_ul_id);
                    var ul_max = ul.offsetWidth;
                    var total = e.total(ul);

                    var cm_slideImg_max = (cm_li_w * cm_few);
                    var stop = parseFloat(cm_li_w * e.get_cm_fewFloat(sender));
                    /*一筆多寬*/
                    var cm_slideImg_w = cm_slideImg_max;

                    /*cm_slideImg_max 紀錄已滑過紀錄 最大*/
                    if (e.get_cm_slideImg_max(sender) != null) {
                        var _cm_slideImg_max = parseInt(e.get_cm_slideImg_max(sender), 10);
                        if (_cm_slideImg_max <= 0) _cm_slideImg_max = 0;
                        cm_slideImg_max += _cm_slideImg_max;
                    }

                    var startRight = setInterval(function () {
                        e.disabled(leftBtn, true);
                        if (e.get_cm_right(sender) != null) {
                            cm_right = e.get_cm_right(sender);
                        }
                        cm_right += e.get_cm_speed(sender);

                        if (cm_right > cm_slideImg_max) {
                            cm_right = cm_slideImg_max;
                            clearInterval(startRight);

                            /*紀錄已滑過紀錄 最大 */
                            e.set_cm_slideImg_max(sender, cm_slideImg_max);
                            e.setaddPage(ul);
                            /*假如到底的話*/
                            if (e.getPage(ul) >= total) {
                                e.disabled(sender, true);
                                e.Opt.Rend = true;
                            } else {
                                e.disabled(sender, false);
                            }
                            /*假如到底的話*/

                            e.disabled(leftBtn, false);
                            e.Opt.sender = sender;
                            e.Opt.few = cm_few;
                            e.Opt.rightClick.call(e.Opt);
                        }
                        ul.style.left = "-" + cm_right + "px";


                        /* 紀錄已滑過紀錄 指標*/
                        e.set_cm_right(sender, cm_right);
                    }, 1);
                }
            }

        },
        left: function (leftBtn, rightBtn) {
            var e = CmFmCommon.slideImg;
            var cm_right = 0;

            leftBtn.setAttribute('rightBtn', rightBtn.id);

            leftBtn.onclick = function () {
                var sender = this;
                if ((sender.tagName.toString().toLowerCase() == 'a' && sender.getAttribute('href') != null)
                    || sender.tagName.toString().toLowerCase() != 'a') {
                    var rightBtn = document.getElementById(sender.getAttribute('rightBtn'));
                    e.disabled(rightBtn, false);
                    /*滑動的時候要 diabled*/
                    e.disabled(sender, true);

                    var cm_li_w = e.get_cm_li_w(sender);
                    var cm_few = e.get_cm_few(sender);
                    var _tmp_ul_id = e.get_ul_id(sender);
                    var ul = document.getElementById(_tmp_ul_id);
                    var ul_max = ul.offsetWidth;


                    var cm_slideImg_max = (cm_li_w * cm_few);

                    /*一筆多寬*/
                    var cm_slideImg_w = cm_slideImg_max;

                    /*cm_slideImg_max 紀錄已滑過紀錄 最大*/
                    if (e.get_cm_slideImg_max(sender) != null) {
                        cm_slideImg_max = parseInt(e.get_cm_slideImg_max(sender), 10) - cm_slideImg_max;
                    }

                    var startLeft = setInterval(function () {
                        e.disabled(rightBtn, true);
                        if (e.get_cm_right(sender) != null) {
                            cm_right = e.get_cm_right(sender);
                        }
                        cm_right -= e.get_cm_speed(sender);

                        if (cm_right < cm_slideImg_max) {
                            cm_right = cm_slideImg_max;
                            clearInterval(startLeft);

                            /*紀錄已滑過紀錄 最大 */
                            e.set_cm_slideImg_max(sender, cm_slideImg_max);
                            e.setMinusPage(ul);

                            /*假如到底的話*/
                            if (1 <= e.getPage(ul)) {
                                if (cm_slideImg_max > 0) e.disabled(sender, false);
                            } else e.disabled(sender, true);
                            /*假如到底的話*/

                            e.disabled(rightBtn, false);
                            e.Opt.sender = sender;
                            e.Opt.few = cm_few;
                            e.Opt.leftClick.call(e.Opt);
                        }
                        ul.style.left = "-" + cm_right + "px";


                        /* 紀錄已滑過紀錄 指標*/
                        e.set_cm_right(sender, cm_right);
                    }, 1);
                }
            }

        }

    },

    position: {
        // findPos() by quirksmode.org
        // Finds the absolute position of an element on a page
        findPos: function (obj) {

            var curleft = curtop = 0;
            if (obj.offsetParent) {
                do {
                    curleft += obj.offsetLeft;
                    curtop += obj.offsetTop;
                } while (obj = obj.offsetParent);
            }
            var obj = new Object();
            obj.x = curleft;
            obj.y = curtop;
            return obj;
        },
        // getPageScroll() by quirksmode.org
        // Finds the scroll position of a page
        getPageScroll: function () {
            var xScroll, yScroll;
            if (self.pageYOffset) {
                yScroll = self.pageYOffset;
                xScroll = self.pageXOffset;
            } else if (document.documentElement && document.documentElement.scrollTop) {
                yScroll = document.documentElement.scrollTop;
                xScroll = document.documentElement.scrollLeft;
            } else if (document.body) {// all other Explorers
                yScroll = document.body.scrollTop;
                xScroll = document.body.scrollLeft;
            }

            var obj = new Object();
            obj.x = xScroll;
            obj.y = yScroll;
            return obj;
        },

        // Finds the position of an element relative to the viewport.
        findPosRelativeToViewport: function (obj) {
            var objPos = this.findPos(obj)
            var scroll = this.getPageScroll()

            var obj = new Object();
            obj.x = parseInt(objPos.x, 10) - parseInt(scroll.x, 10);
            obj.y = parseInt(objPos.y, 10) - parseInt(scroll.y, 10);

            return obj;
        },
        //自動滑動 scroll 到哪個物件上
        AutoSlidScrollForObj: function (Opt) {
            /*
                var Opt={
                    Incr:1,     //'移動的時候每次增加多少,預設1'
                    target:obj, //'在哪個物件內移動,預設body'
                    id:'',      //移動到哪個物件,一定要加
                    Speed:'',   //setInterval 多久執行一次,預設1
                    marginTop:0 //往上空格多少 預設0
                }
            CmFmCommon.position.AutoSlidScrollForObj(Opt);
            */
            Opt.marginTop = (Opt.marginTop == null) ? 0 : Opt.marginTop;
            Opt.Incr = (Opt.Incr == null) ? 100 : Opt.Incr;
            Opt.Speed = (Opt.Speed == null) ? 1 : Opt.Speed;
            var ele = Opt.target || document.body;
            var targetScroll = CmFmCommon.position.getPageScroll();
            var Obj = document.getElementById(Opt.id);
            var nowObjScrollY = targetScroll.y;
            var nowtargetScrollY = CmFmCommon.position.findPos(Obj).y - (Obj.offsetHeight) + Opt.marginTop;

            Obj.setAttribute('nowtargetScrollY', nowtargetScrollY);
            Obj.setAttribute('nowObjScrollY', nowObjScrollY);

            MouseScroll();

            if (nowObjScrollY <= nowtargetScrollY) {
                var startSlideScrollbar = setInterval(function () {

                    var nowPositionY = parseInt(Obj.getAttribute('nowObjScrollY'), 10);
                    var max = parseInt(Obj.getAttribute('nowtargetScrollY'), 10);

                    nowPositionY += Opt.Incr;

                    if (nowPositionY <= max) {
                        if (ele == document.body) { scroll(0, nowPositionY); }
                        else { ele.scrollTop = nowPositionY; }
                        Obj.setAttribute('nowObjScrollY', nowPositionY);
                    } else {
                        if (ele == document.body) { scroll(0, max); }
                        else { ele.scrollTop = max; }
                        MouseScroll();
                    }


                }, Opt.Speed);
            } else {
                var startSlideScrollbar = setInterval(function () {

                    var nowPositionY = parseInt(Obj.getAttribute('nowObjScrollY'), 10);
                    var max = parseInt(Obj.getAttribute('nowtargetScrollY'), 10);
                    nowPositionY -= Opt.Incr;
                    if (nowPositionY >= max) {
                        if (ele == document.body) { scroll(0, nowPositionY); }
                        else { ele.scrollTop = nowPositionY; }
                        Obj.setAttribute('nowObjScrollY', nowPositionY);
                    } else {
                        if (ele == document.body) { scroll(0, max); }
                        else { ele.scrollTop = max; }
                        MouseScroll();
                    }
                }, Opt.Speed);
            }



            ele.onmousewheel = function () {
                MouseScroll();
            }

            if (ele.addEventListener) {    // all browsers except IE before version 9
                // Internet Explorer, Opera, Google Chrome and Safari
                ele.addEventListener("mousewheel", MouseScroll);
                // Firefox
                ele.addEventListener("DOMMouseScroll", MouseScroll);
            }
            else {
                if (ele.attachEvent) { // IE before version 9
                    ele.attachEvent("onmousewheel", MouseScroll);
                }
            }

            function MouseScroll() {
                try {
                    clearInterval(startSlideScrollbar);
                } catch (ex) { throw ex; }
            }
        }
    },

    bodyWH: function () {
        var winW = 0, winH = 0;
        if (document.body && document.body.offsetWidth) {
            winW = document.body.offsetWidth;
            winH = document.body.offsetHeight;
        }
        if (document.compatMode == 'CSS1Compat' &&
    document.documentElement &&
    document.documentElement.offsetWidth) {
            winW = document.documentElement.offsetWidth;
            winH = document.documentElement.offsetHeight;
        }
        if (window.innerWidth && window.innerHeight) {
            winW = window.innerWidth;
            winH = window.innerHeight;
        }

        var body = new Object();
        body.w = winW;
        body.h = winH;

        return body;
    },

    load: {
        //換頁中效果
        href: function (msg,opt) {
            if (CmFmCommon.load.sender == null) {

                if (opt == null) opt = {};
                var CW_options = {
                    bgObj_zIndex: opt.index || '9999999',  //背景 層次
                    bgObj_background: opt.background || '#fff', //背景顏色
                    bgObj_filter: 90, //透明度
                    msgObj_options: 'absolute', //顯示內容的定位
                    min_width: 90, //顯示內容的寬比例
                    min_height: 50, //顯示內容的長比例
                    msgObj_Unit: 'px',
                    msgObj_background: 'Transparent', //顯示內容的背景顏色
                    msgObj_zIndex: '99999991', //顯示內容的層次
                    close: false, //是否要點背景就可以關閉
                    is_closeImg: false,//是否需要產生 close img
                    close_img_src: CmFmCommon.PhyPath() + 'Image/ComemyfamilyWindowBox/X1.png',
                    close_Top: 18,
                    close_Right: 18,
                    EventCancel: function () {
                    },
                    Shadow: false, //要不要陰影
                    NEED_CW_RESIZE: false
                }

                var CW = CmFmCommon.winbox(CW_options);
                var div = document.createElement('div');
                div.setAttribute('style', 'font-size:15px;margin:0 auto;padding:2px;font-weight:bold;text-align:center;');
                div.innerHTML = "<div><span cmfmmode=\'cmfmLoad\'>" + msg + "</span><img src='" + CmFmCommon.PhyPath().replace('/WebPage','') + "images/wait.gif'></img></div>";
                CW.appendChild(div);
                CmFmCommon.load.sender = CW;
            } else {
                var o = CmFmCommon.load.sender;
                var spanList = o.getElementsByTagName('span');
                for (var i = 0 ; i < spanList.length; i++) {
                    var sender = spanList[i];
                    if (sender.getAttribute('cmfmmode') != null) {
                        sender.innerHTML = msg;
                        break;
                    }
                }
                 
            }
        },

        close: function () {
            if (CmFmCommon.load.sender != null) {
                CmFmCommon.load.sender.cancel();
                CmFmCommon.load.sender = null;
            }
        }

    },

    winbox: function (opt) {
        //var options = {
        //    bgObj_zIndex: '1000',  //背景 層次
        //    bgObj_background: '#ccc', //背景顏色
        //    bgObj_filter: 60, //透明度
        //    msgObj_options: 'absolute', //顯示內容的定位
        //    msgObj_width: 35, //顯示內容的寬比例
        //    msgObj_height: 95, //顯示內容的長比例
        //    min_width:100,
        //    min_height:95,
        //    msgObj_Unit: 'px',
        //    msgObj_background: 'Transparent', //顯示內容的背景顏色
        //    msgObj_zIndex: '1001', //顯示內容的層次
        //    close: true, //是否要點背景就可以關閉
        //    Default_top:0,
        //    Default_left:0,
        //    marginTop:0, //空格
        //    is_closeImg:false,//是否需要產生 close img
        //    close_img_src: CmFmCommon.PhyPath() + 'Image/ComemyfamilyWindowBox/X.png',
        //    close_Top: 10,
        //    close_Right: 10,
        //    EventCancel: function() {
        //        document.body.appendChild(text1);
        //        text1.style.display = 'none';
        //    },
        //    Shadow:true, //要不要陰影
        //    NEED_CW_RESIZE:true
        //}
      

        CmWinBox = function (options) {

         


            var bgObj = document.createElement("div");
            bgObj.setAttribute('id', CmFmCommon.GUID());
            bgObj.setAttribute('closeID', CmFmCommon.GUID());
            bgObj.style.position = "fixed";
            bgObj.style.top = "0";
            bgObj.style.background = options.bgObj_background;
            bgObj.style.filter = 'alpha(opacity=' + options.bgObj_filter + ')';
            bgObj.style.opacity = options.bgObj_filter * 0.010;
            bgObj.style.left = "0";
            bgObj.style.width = "100%";
            bgObj.style.height = "100%";
            bgObj.style.zIndex = options.bgObj_zIndex;


            var msgObj = document.createElement("div")
            msgObj.setAttribute("id", CmFmCommon.GUID());
            msgObj.setAttribute('tabindex', '0');
            msgObj.style.top = CmWinBox.prototype.scroll().Y + 'px'; msgObj.setAttribute('scrollY', CmWinBox.prototype.scroll().Y);
            msgObj.style.left = "0";
            msgObj.setAttribute('bgObj', bgObj.id);
            msgObj.setAttribute('closeID', bgObj.getAttribute('closeID'));
            msgObj.style.background = options.msgObj_background;
            msgObj.style.position = options.msgObj_options;
            msgObj.style.font = "12px/1.6em Verdana, Geneva, Arial, Helvetica, sans-serif";
            if (options.is_Proportion || options.is_Proportion == null && options.msgObj_Unit == '%') {
                if (options.min_width == null)
                    msgObj.style.width = CmWinBox.prototype.documentWidth() * (options.msgObj_width / 100) + 'px';   //ComemyfamilyWindowBox.prototype.documentWidth()
                else
                    msgObj.style.minWidth = CmWinBox.prototype.documentWidth() * (options.min_width / 100) + 'px';

                if (options.min_height == null)
                    msgObj.style.height = CmWinBox.prototype.documentHeight() * (options.msgObj_height / 100) + 'px';  //ComemyfamilyWindowBox.prototype.documentHeight()
                else
                    msgObj.style.minHeight = CmWinBox.prototype.documentHeight() * (options.min_height / 100) + 'px';
            } else {

                if (options.min_width == null)
                    msgObj.style.width = options.msgObj_width + options.msgObj_Unit;   //ComemyfamilyWindowBox.prototype.documentWidth()
                else
                    msgObj.style.minWidth = options.min_width + options.msgObj_Unit;

                if (options.min_height == null)
                    msgObj.style.height = options.msgObj_height + options.msgObj_Unit;
                else
                    msgObj.style.minHeight = options.min_height + options.msgObj_Unit;
            }
            msgObj.style.lineHeight = "25px";
            msgObj.style.zIndex = options.msgObj_zIndex;

            document.body.appendChild(bgObj);
            document.body.appendChild(msgObj);
            CmWinBox.prototype.init(bgObj, msgObj, options);
            CmWinBox.prototype.postion(msgObj);

            if (options.close) {
                bgObj.onclick = function () {
                    if (document.getElementById(this.getAttribute('closeID')) != null) {
                        document.getElementById(this.getAttribute('closeID')).click();
                    }
                }
            }

            msgObj.onfocus = function () {
                this.style.outline = 0;
            }

            CmWinBox.prototype.Create_CloseImg(bgObj.id, msgObj.id, bgObj.getAttribute('closeID'), options);
            CmWinBox.prototype.Regist_ESC_KeyDown(msgObj);


            msgObj.Options = options;
            msgObj.EventCancel = function () {
                if (this.Options.EventCancel != null)
                    this.Options.EventCancel.call(this.Options);
            }
            msgObj.cancel = function () {
                CmWinBox.prototype.cancel(this);
            }
            msgObj._bgObj = bgObj;
            msgObj._msgObj = msgObj;
            return msgObj;
        }

        CmWinBox.prototype = {
            init: function (bgObj, msgObj, options) {
                this.Shadow = (options.Shadow != null) ? options.Shadow : true;
                this._bgObj = bgObj;
                this._msgObj = msgObj;
                this._options = options;
                this._Top = (options.close_Top != null) ? options.close_Top : 20; //Close poition top 
                this._Right = (options.close_Right != null) ? options.close_Right : 18; //Close poition left 
                this._INIT = true;
                if (CmWinBox.prototype._options.Default_top == null) {
                    CmWinBox.prototype._options.Default_top = 'auto';
                }
                msgObj.focus();
                msgObj.setAttribute('_INIT_left', 'true');
                msgObj.setAttribute('_INIT_top', 'true');
                msgObj.setAttribute('_INIT_left_OK', 'false');
                msgObj.setAttribute('_INIT_top_OK', 'false');
                if (options.Shadow) {
                    msgObj.style.boxShadow = '10px 10px 10px #444444'; /* Firefox */
                    msgObj.style.MozBoxShadow = '10px 10px 10px #444444'; /* Safari 和 Chrome */
                    msgObj.style.WebkitBoxShadow = '10px 10px 10px #444444'; /* Opera 10.5 + */
                }
            },
            CW_Cancel: function (CW) {

                var bgObj = document.getElementById(CW.getAttribute('bgObj'));
                bgObj.parentNode.removeChild(bgObj);
                CW.parentNode.removeChild(CW);

            },
            cancel: function (o) {
                if (o == null) {
                    if (this._options.EventCancel != null)
                        this._options.EventCancel.call(this._options);
                    try {
                        document.body.removeChild(this._bgObj);
                        document.body.removeChild(this._msgObj);
                    } catch (ex) {

                    }
                } else {

                    o.EventCancel();
                    try {
                        document.body.removeChild(o._bgObj);
                        document.body.removeChild(o._msgObj);
                    } catch (ex) {

                    }
                }

            },
            Regist_ESC_KeyDown: function (msgObj) {


                msgObj.onkeydown = function (e) {


                    var currKey = 0;
                    e = e || event;
                    currKey = e.keyCode || e.which || e.charCode;
                    //判斷是否按下Enter鍵


                    if (currKey == 27) {
                        this.cancel();
                    }
                }

            },
            Create_CloseImg: function (bgID, MsgID, CloseID, options) {
                var is_closeImg = (CmWinBox.prototype._options.is_closeImg == null) ? true : CmWinBox.prototype._options.is_closeImg;

                if (is_closeImg) {
                    var closeImg = document.createElement('img');
                    closeImg.setAttribute('id', CloseID);
                    closeImg.setAttribute('bgID', bgID);
                    closeImg.setAttribute('MsgID', MsgID);
                    if (CmWinBox.prototype._options.close_img_src == null) {
                        closeImg.style.width = '32px';
                        closeImg.style.height = '32px';
                    }
                    closeImg.src = (CmWinBox.prototype._options.close_img_src != null) ? CmWinBox.prototype._options.close_img_src : CmFmCommon.PhyPath() + 'Image/ComemyfamilyWindowBox/RoundX.png';


                    //  this._msgObj.innerHTML = closeImg.src;

                    closeImg.style.position = "absolute";
                    closeImg.style.right = "-" + this._Right + "px";
                    closeImg.style.top = "-" + this._Top + "px";
                    // closeImg.style.margin = '5px';
                    closeImg.style.zIndex = parseInt(this._options.msgObj_zIndex, 10) + 1;
                    closeImg.style.cursor = 'pointer';
                    closeImg.onmouseover = function () {
                        this.src = (CmWinBox.prototype._options.close_img_src != null) ? CmWinBox.prototype._options.close_img_src : CmFmCommon.PhyPath() + 'Image/ComemyfamilyWindowBox/RoundX.png';
                    }
                    closeImg.onmouseout = function () {
                        this.src = (CmWinBox.prototype._options.close_img_src != null) ? CmWinBox.prototype._options.close_img_src : CmFmCommon.PhyPath() + 'Image/ComemyfamilyWindowBox/RoundX.png';
                    }

                    closeImg.onclick = function () {

                        if (options.EventCancel != null)
                            options.EventCancel.call(CmWinBox.prototype._options);

                        document.body.removeChild(document.getElementById(this.getAttribute('bgID')));
                        document.body.removeChild(document.getElementById(this.getAttribute('MsgID')));
                    }

                    closeImg.setAttribute('title', '關閉');

                    this._msgObj.appendChild(closeImg);
                }
            },
            postion: function (msgObj) {





                msgObj.setAttribute('msgObj_options', this._options.msgObj_options);
                msgObj.setAttribute('_marginTop', this._options.marginTop);
                msgObj.setAttribute('_Top', this._Top);

                if (msgObj.getAttribute('_INIT_left') == 'true' && msgObj.getAttribute('_INIT_top') == 'true' && msgObj.getAttribute('_INIT_left_OK') == 'false' && msgObj.getAttribute('_INIT_top_OK') == 'false')
                    this.RESIZE(msgObj, this._options.msgObj_options, this._options.marginTop, this._Top, 500);
                if (this._options.NEED_CW_RESIZE != false) {
                    msgObj.onresize = function () {
                        //  if (msgObj.getAttribute('_INIT_left') == 'false' && msgObj.getAttribute('_INIT_top') == 'false' && msgObj.getAttribute('_INIT_left_OK') == 'true' && msgObj.getAttribute('_INIT_top_OK') == 'true')
                        CmWinBox.prototype.RESIZE(this, this.getAttribute('msgObj_options'), this.getAttribute('_marginTop'), this.getAttribute('_Top'), 100);
                    }


                    var nAgt = navigator.userAgent;

                    if ((nAgt.indexOf("MSIE")) == -1) {
                        msgObj.tmpH = msgObj.offsetHeight;
                        clearInterval(msgObj.timer);
                       // CmWinBox.prototype.RESIZE(msgObj, msgObj.getAttribute('msgObj_options'), msgObj.getAttribute('_marginTop'), msgObj.getAttribute('_Top'), 100);
                       msgObj.timer = setInterval(function () {
                       
                           if (msgObj.tmpH != msgObj.offsetHeight) {
                       
                               //  msgObj.tmpH = msgObj.offsetHeight;
                               if (msgObj.getAttribute('_INIT_left') == 'false' && msgObj.getAttribute('_INIT_top') == 'false' && msgObj.getAttribute('_INIT_left_OK') == 'true' && msgObj.getAttribute('_INIT_top_OK') == 'true')
                                   CmWinBox.prototype.RESIZE(msgObj, msgObj.getAttribute('msgObj_options'), msgObj.getAttribute('_marginTop'), msgObj.getAttribute('_Top'), 100);
                       
                           }
                       
                       }, 500);
                    }

                }


                window.onresize = function () {
                    if (msgObj.getAttribute('_INIT_left') == 'false' && msgObj.getAttribute('_INIT_top') == 'false' && msgObj.getAttribute('_INIT_left_OK') == 'true' && msgObj.getAttribute('_INIT_top_OK') == 'true')
                        CmWinBox.prototype.RESIZE(msgObj, msgObj.getAttribute('msgObj_options'), msgObj.getAttribute('_marginTop'), msgObj.getAttribute('_Top'), 100);
                }


                var form = document.body.getElementsByTagName('form')[0];
                form.onresize = function () {
                    if (msgObj.getAttribute('_INIT_left') == 'false' && msgObj.getAttribute('_INIT_top') == 'false' && msgObj.getAttribute('_INIT_left_OK') == 'true' && msgObj.getAttribute('_INIT_top_OK') == 'true')
                        CmWinBox.prototype.RESIZE(msgObj, msgObj.getAttribute('msgObj_options'), msgObj.getAttribute('_marginTop'), msgObj.getAttribute('_Top'), 100);
                }

            },
            RESIZE: function (OBJ, msgObj_options, _marginTop, _Top, i) {
                i = (i == null) ? 20 : i;

                if (i == null) OBJ.style.top = 0;

                var MarginTop = 0;
                if (msgObj_options == 'fixed') {
                    MarginTop = (this.documentHeight() - OBJ.offsetHeight) / 2;
                } else {
                    MarginTop = parseInt(OBJ.getAttribute('scrollY'), 10) + (this.documentHeight() - OBJ.offsetHeight) / 2;
                }

                var CustomMarginTop = (_marginTop != null && _marginTop != 'undefined') ? _marginTop : -100;



                var Tmp = (MarginTop < 0) ? _Top : MarginTop;
                if (Tmp < _Top) { Tmp = _Top; }

                //OBJ.style.left = ((this.documentWidth() / 2) - (OBJ.offsetWidth / 2)) - parseInt(_Top, 10) + 'px';


                var MAX_OR_TOP_MIN = parseInt(Tmp, 10) + parseInt(CustomMarginTop, 10);
                var NOW_TOP_VALUE = (OBJ.getAttribute('NOW_VALUEXX') != null) ? OBJ.getAttribute('NOW_VALUEXX') : CmWinBox.prototype.GetTopLeft(OBJ).curtop;

                var MAX_OR_LEFT_MIN = ((this.documentWidth() / 2) - (OBJ.offsetWidth / 2)) - parseInt(_Top, 10);
                var NOW_LEFT_VALUE = (OBJ.getAttribute('NOW_VALUEXX_LEFT') != null) ? OBJ.getAttribute('NOW_VALUEXX_LEFT') : CmWinBox.prototype.GetTopLeft(OBJ).curleft;

                if (CmWinBox.prototype._options.Default_top != 'auto') {
                    MAX_OR_TOP_MIN = CmWinBox.prototype._options.Default_top;
                    NOW_TOP_VALUE = CmWinBox.prototype._options.Default_top;
                }

                OBJ.style.top = MAX_OR_TOP_MIN + 'px';
                OBJ.style.left = MAX_OR_LEFT_MIN + 'px';

                this.TMP_setInterval_TOP(OBJ, NOW_TOP_VALUE, MAX_OR_TOP_MIN, i);
                this.TMP_setInterval_LEFT(OBJ, NOW_LEFT_VALUE, MAX_OR_LEFT_MIN, i);

            },
            TMP_setInterval_LEFT: function (OBJ, NOW_VALUE, MAX_OR_MIN, i) {
                i = (i == null) ? 20 : i;
                OBJ.setAttribute('NOW_VALUEXX_LEFT', NOW_VALUE);
                OBJ.setAttribute('MAX_OR_MINXX_LEFT', MAX_OR_MIN);
                OBJ.setAttribute('_INIT_left', 'true');
                var MODE = (parseInt(NOW_VALUE, 10) < parseInt(MAX_OR_MIN, 10)) ? 'LEFT_MIN' : 'LEFT_MAX';
                OBJ.setAttribute('MODEXX', MODE);
                var START = setInterval(function () {
                    var M = 0;
                    var TMP_MODE = OBJ.getAttribute('MODEXX');
                    var TMP_NOW_VALUE = parseInt(OBJ.getAttribute('NOW_VALUEXX_LEFT'), 10);
                    var TMP_MAX_OR_MIN = parseInt(OBJ.getAttribute('MAX_OR_MINXX_LEFT'), 10);



                    if (

                    ((TMP_MODE == 'LEFT_MIN') && parseInt(TMP_NOW_VALUE, 10) >= parseInt(TMP_MAX_OR_MIN, 10)) ||
                    ((TMP_MODE == 'LEFT_MAX') && parseInt(TMP_NOW_VALUE, 10) <= parseInt(TMP_MAX_OR_MIN, 10))
                    ) {
                        clearInterval(START); OBJ.setAttribute('NOW_VALUEXX_LEFT', 0);
                        OBJ.style.left = TMP_MAX_OR_MIN + 'px';

                        OBJ.setAttribute('_INIT_left', 'false');
                        OBJ.setAttribute('_INIT_left_OK', 'true');
                        //_INIT_left_OK
                    } else {
                        if (TMP_MODE == 'LEFT_MIN') {

                            M = parseInt(TMP_NOW_VALUE, 10) + i;


                            if (M >= parseInt(TMP_MAX_OR_MIN, 10)) {
                                M = parseInt(TMP_MAX_OR_MIN, 10);
                            }

                            TMP_NOW_VALUE = M;

                        } else {
                            M = parseInt(TMP_NOW_VALUE, 10) - i;
                            if (M <= parseInt(TMP_MAX_OR_MIN, 10)) {
                                M = parseInt(TMP_MAX_OR_MIN, 10);
                            }

                            TMP_NOW_VALUE = M;
                        }
                    }

                    OBJ.setAttribute('NOW_VALUEXX_LEFT', TMP_NOW_VALUE);
                    OBJ.style.left = TMP_NOW_VALUE + 'px';

                }, 1);
            },
            TMP_setInterval_TOP: function (OBJ, NOW_VALUE, MAX_OR_MIN, i) {
                i = (i == null) ? 20 : i;
                OBJ.setAttribute('NOW_VALUEXX', NOW_VALUE);
                OBJ.setAttribute('MAX_OR_MINXX', MAX_OR_MIN);
                OBJ.setAttribute('_INIT_top', 'true');
                var TOP_MODE = (parseInt(NOW_VALUE, 10) < parseInt(MAX_OR_MIN, 10)) ? 'TOP_MIN' : 'TOP_MAX';
                OBJ.setAttribute('TOP_MODE', TOP_MODE);
                var START_TOP = setInterval(function () {
                    var M = 0;
                    var TMP_MODE = OBJ.getAttribute('TOP_MODE');
                    var TMP_NOW_VALUE = parseInt(OBJ.getAttribute('NOW_VALUEXX'), 10);
                    var TMP_MAX_OR_MIN = parseInt(OBJ.getAttribute('MAX_OR_MINXX'), 10);
                    if (

                    ((TMP_MODE == 'TOP_MIN') && parseInt(TMP_NOW_VALUE, 10) >= parseInt(TMP_MAX_OR_MIN, 10)) ||
                    ((TMP_MODE == 'TOP_MAX') && parseInt(TMP_NOW_VALUE, 10) <= parseInt(TMP_MAX_OR_MIN, 10))
                    ) {
                        clearInterval(START_TOP); OBJ.setAttribute('NOW_VALUEXX', TMP_MAX_OR_MIN);
                        OBJ.style.top = TMP_MAX_OR_MIN + 'px';
                        OBJ.setAttribute('_INIT_top', 'false');
                        OBJ.setAttribute('_INIT_top_OK', 'true');
                        //_INIT_top_OK
                    } else {
                        if (TMP_MODE == 'TOP_MIN') {
                            M = parseInt(TMP_NOW_VALUE, 10) + i;
                            if (M >= parseInt(TMP_MAX_OR_MIN, 10)) {
                                M = parseInt(TMP_MAX_OR_MIN, 10);
                            }
                            TMP_NOW_VALUE = M;
                        } else {
                            M = parseInt(TMP_NOW_VALUE, 10) - i;
                            if (M <= parseInt(TMP_MAX_OR_MIN, 10)) {
                                M = parseInt(TMP_MAX_OR_MIN, 10);
                            }
                            TMP_NOW_VALUE = M;
                        }
                    }

                    OBJ.setAttribute('NOW_VALUEXX', TMP_NOW_VALUE);
                    OBJ.style.top = TMP_NOW_VALUE + 'px';

                }, 1);
            },
            GetTopLeft: function (OBJ) {

                var curleft = curtop = 0;
                if (OBJ.offsetParent) {


                    do {
                        curleft += OBJ.offsetLeft;
                        curtop += OBJ.offsetTop;
                    } while (OBJ = OBJ.offsetParent);
                }

                return { curleft: curleft, curtop: curtop }
            },
            documentWidth: function () {
                var winW = 0;
                if (document.body && document.body.offsetWidth) {
                    winW = document.body.offsetWidth;
                    winH = document.body.offsetHeight;
                }
                if (document.compatMode == 'CSS1Compat' &&
            document.documentElement &&
            document.documentElement.offsetWidth) {
                    winW = document.documentElement.offsetWidth;
                    winH = document.documentElement.offsetHeight;
                }
                if (window.innerWidth && window.innerHeight) {
                    winW = window.innerWidth;
                    winH = window.innerHeight;
                }

                return winW;
            },
            scroll: function () {

                var scrollX, scrollY;

                if (document.all) {
                    if (!document.documentElement.scrollLeft)
                        scrollX = document.body.scrollLeft;
                    else
                        scrollX = document.documentElement.scrollLeft;
                    if (!document.documentElement.scrollTop)
                        scrollY = document.body.scrollTop;
                    else
                        scrollY = document.documentElement.scrollTop;
                } else {
                    scrollX = window.pageXOffset;
                    scrollY = window.pageYOffset;
                }
                return { X: scrollX, Y: scrollY }
            },
            documentHeight: function () {
                var winH = 0;
                if (document.body && document.body.offsetWidth) {
                    winW = document.body.offsetWidth;
                    winH = document.body.offsetHeight;
                }
                if (document.compatMode == 'CSS1Compat' &&
            document.documentElement &&
            document.documentElement.offsetWidth) {
                    winW = document.documentElement.offsetWidth;
                    winH = document.documentElement.offsetHeight;
                }
                if (window.innerWidth && window.innerHeight) {
                    winW = window.innerWidth;
                    winH = window.innerHeight;
                }
                return winH;
            }

        }

        return CmWinBox(opt);
    },
    mouse: function (Options) {
        /* var Options=
        {
            obj: Family_introduce_EDIT_PERENT_DIV,
            over: function () { new Comemyfamily_Gradually_transparency(({ id: e.__Options.div.Family_introduce_EDIT, disappear: false })); },
            out: function () {
                new Comemyfamily_Gradually_transparency(({ id: e.__Options.div.Family_introduce_EDIT, disappear: true }));
            }
        }*/

        Comemyfamily_onmouseover(Options);
        Comemyfamily_onmouseout(Options);

        function Comemyfamily_onmouseover(Options) {
            if (Options.obj != null) {
                Options.obj.onmouseover = function (e) {
                    if (checkHover(e, this)) {
                        Options.NOW_OBJECT = this;
                        Options.over.call(Options);
                    }
                }
            }
        }
        function Comemyfamily_onmouseout(Options) {
            if (Options.obj != null) {
                Options.obj.onmouseout = function (e) {
                    if (checkHover(e, this)) {
                        Options.NOW_OBJECT = this;
                        Options.out.call(Options);
                    }
                }
            }
        }
        function contains(parentNode, childNode) {
            return parentNode.contains ? parentNode != childNode && parentNode.contains(childNode) : !!(parentNode.compareDocumentPosition(childNode) & 16);
        }
        function checkHover(e, target) {
            if (getEvent(e).type == "mouseover")
                return !contains(target, getEvent(e).relatedTarget || getEvent(e).fromElement) && !((getEvent(e).relatedTarget || getEvent(e).fromElement) === target);
            else {
                return !contains(target, getEvent(e).relatedTarget || getEvent(e).toElement) && !((getEvent(e).relatedTarget || getEvent(e).toElement) === target);
            }
        } function getEvent(e) { return e || window.event; }
    },
    confirm: function (Prompt_MSG, OK) {
        function Comemyfamily_confirm(Prompt_MSG, OK) {
            Comemyfamily_confirm.prototype.Prompt_MSG = Prompt_MSG;
            Comemyfamily_confirm.prototype.OK = OK;
            Comemyfamily_confirm.prototype.Page_Load();

        }

        Comemyfamily_confirm.prototype = {
            Page_Load: function () {


                var CW = this.Window();
                var MSGDIV = this.WindowContent(CW);
                this.WindowTable(MSGDIV);
                this.WindowButton(MSGDIV);


            },

            Window: function () {
                var ComemyfamilyWindowBox_Options = {
                    bgObj_zIndex: '9999998',  //背景 層次
                    bgObj_background: '#000', //背景顏色
                    bgObj_filter: 60, //透明度
                    msgObj_options: 'fixed', //顯示內容的定位
                    msgObj_width: 250, //顯示內容的寬比例
                    msgObj_height: 115, //顯示內容的長比例
                    msgObj_Unit: 'px',
                    msgObj_background: 'Transparent', //顯示內容的背景顏色
                    msgObj_zIndex: '9999999', //顯示內容的層次
                    close: false, //是否要點背景就可以關閉
                    marginTop: -100, //空格
                    is_closeImg: false,
                    EventCancel: function () {

                    }
                }
                return ComemyfamilyWindowBox(ComemyfamilyWindowBox_Options);
            },

            WindowContent: function (CW) {
                var MSGDIV = document.createElement('div');
                // width:250px;  height:115px; margin:0 auto; background-color:Transparent; background-image:url('Image/comemyfamily_alert/Comemyfamily_Confirm_Background_Color.png'); background-repeat:no-repeat; 
                //display:table-cell;
                //vertical-align:middle;
                MSGDIV.style.width = '250px';
                MSGDIV.style.height = '115px';
                MSGDIV.style.margin = '0 auto';
                MSGDIV.style.background = 'Transparent';
                MSGDIV.style.background = "url('" + CmFmCommon.PhyPath() + "Image/comemyfamily_alert/Comemyfamily_Confirm_Background_Color.png')";
                MSGDIV.style.backgroundRepeat = 'no-repeat';


                CW.appendChild(MSGDIV);
                return MSGDIV;

            },

            WindowTable: function (MSGDIV) {

                var table = document.createElement('table'); table.style.padding = '5px';
                var tbody = document.createElement('tbody');
                var tr = document.createElement('tr');
                var ImgTd = document.createElement('td');
                var MsgTd = document.createElement('td');

                var img = document.createElement('img'); img.style.width = '64px'; img.style.height = '64px';
                img.src = CmFmCommon.PhyPath() + 'Image/ExclamationMark/images.jpg';
                var Msg = document.createElement('div'); Msg.style.fontSize = '15px';
                Msg.innerHTML = Comemyfamily_confirm.prototype.Prompt_MSG;

                ImgTd.appendChild(img);
                MsgTd.appendChild(Msg);

                tr.appendChild(ImgTd);
                tr.appendChild(MsgTd);
                tbody.appendChild(tr);
                table.appendChild(tbody);
                MSGDIV.appendChild(table);
            },

            WindowButton: function (MSGDIV) {



                var BtnDIV = document.createElement('div'); BtnDIV.style.textAlign = 'center';

                var SUBMITBTN = document.createElement('input'); SUBMITBTN.style.marginRight = '5px';
                SUBMITBTN.setAttribute('type', 'button');
                SUBMITBTN.value = '確定';
                SUBMITBTN.style.border = '1px solid #009FCC';
                SUBMITBTN.style.background = '#009FCC';
                SUBMITBTN.onmouseover = function () {
                    this.style.border = '1px solid #FF5511';
                    this.style.background = '#FF5511';
                }
                SUBMITBTN.onmouseout = function () {
                    this.style.border = '1px solid #009FCC';
                    this.style.background = '#009FCC';
                }
                SUBMITBTN.style.color = '#fff';
                SUBMITBTN.onclick = function () {
                    ComemyfamilyWindowBox.prototype.cancel();

                    //   Comemyfamily_confirm.prototype.options.ok = true;
                    //   Comemyfamily_confirm.prototype.options.click.call(Comemyfamily_confirm.prototype.options);

                    Comemyfamily_confirm.prototype.OK(true);
                }


                var CANCELMITBTN = document.createElement('input');
                CANCELMITBTN.setAttribute('type', 'button');
                CANCELMITBTN.value = '取消';
                CANCELMITBTN.style.border = '0';
                CANCELMITBTN.style.background = '#ccc';
                CANCELMITBTN.style.color = '#fff';
                CANCELMITBTN.onclick = function () {
                    ComemyfamilyWindowBox.prototype.cancel();
                }
                CANCELMITBTN.onmouseover = function () {
                    this.style.background = '#888';
                }
                CANCELMITBTN.onmouseout = function () {
                    this.style.background = '#ccc';
                }
                BtnDIV.appendChild(SUBMITBTN);
                BtnDIV.appendChild(CANCELMITBTN);


                MSGDIV.appendChild(BtnDIV);
                MSGDIV.setAttribute('tabindex', '0');
                MSGDIV.onkeydown = function (e) {
                    var currKey = 0;
                    e = e || event;
                    currKey = e.keyCode || e.which || e.charCode;


                    if (currKey == 13) {
                        SUBMITBTN.click();
                    } else if (currKey == 27) {
                        CANCELMITBTN.click();
                    }
                }
                MSGDIV.onfocus = function () {
                    this.style.outline = 'none';
                }
                MSGDIV.focus();


            }


          


        }
        /* Comemyfamily_confirm('解散家族?', function(z) {
                  var disband = ObjectLinkButton.getAttribute('comemyfamily_Disband');
                  Comemyfamily_Wait_Loading('解散中...');
                  Comemyfamily_Myfamily.prototype.disband_start(disband);
              });*/

        Comemyfamily_confirm(Prompt_MSG, OK);
    },

    login: {

        click: function (act, pwd,fun) {
            try {
                if (act != '' && pwd != '') {
                    var AjaxOption = {

                        url: CmFmCommon.PhyPath() + 'ashx/login/comemyfamilyLogin.ashx',   //呼叫哪個 ashx
                        call: function (xmldoc) {
                            this.xmldoc = xmldoc;
                            fun.call(this);
                        }, //拿到值以後 呼叫哪個 function
                        Variable: 'Comemyfamily_account=' + act + '&Comemyfamily_pwd=' + pwd, //傳遞變數
                        type: 'xml', //回傳類型
                        show_alert: false //是不是要秀alert
                    }
                    CmFmCommon.AjaxPost(AjaxOption);

                } else {
                    var Error = '';
                    if (act == '') {
                        Error += '帳號未輸入 \n';
                    }

                    if (pwd == '') {
                        Error += '密碼未輸入 \n';
                    }

                    CmFmCommon.alert(Error);
                }
            } catch (ex) { CmFmCommon.alert(ex); }

        }

    }

    
}

