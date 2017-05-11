<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MutiSearch.aspx.cs" Inherits="webpage_MutiSearch" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript" src="<%= ResolveUrl("~/js/jquery-1.10.2.min.js") %>"></script>
<script type="text/javascript" src="<%= ResolveUrl("~/js/downfile.js") %>"></script>
<script type="text/javascript" src="<%= ResolveUrl("~/js/Pager.js") %>"></script>
<script type="text/javascript" src="<%= ResolveUrl("~/js/treeview/demo/jquery.cookie.js") %>"></script>
<script type="text/javascript" src="<%= ResolveUrl("~/js/treeview/jquery.treeview.js") %>"></script>
	<link rel="stylesheet" href="<%= ResolveUrl("~/js/treeview/jquery.treeview.css") %>" />
	
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript">
        $(document).ready(function () {
            getData($.getParamValue('v'));

            $(document).on("change", "input:checkbox", function () {
                var $chk = $(this),
                    $li = $chk.closest('li'),
                    $ul, $parent;
                if ($li.has('ul')) {
                    $li.find(':checkbox').not(this).prop('checked', this.checked)
                }
                do {
                    $ul = $li.parent();
                    $parent = $ul.siblings(':checkbox');
                    if ($chk.is(':checked')) {
                        $parent.prop('checked', $ul.has(':checkbox:not(:checked)').length == 0)
                    } else {
                        $parent.prop('checked', false)
                    }
                    $chk = $parent;
                    $li = $chk.closest('li');
                } while ($ul.is(':not(.someclass)'));
            });



            $(document).on("click", "#subbtn", function () {
                var tmpuid = "";
                $("input[name='per']:checked").each(function () {
                    if (tmpuid != "") tmpuid += ",";
                    tmpuid += this.value;
                });
                var tmpname = "";
                $("input[name='per']:checked").each(function () {
                    if (tmpname != "") tmpname += ",";
                    tmpname += $(this).attr("uname");
                });
                parent.mutiReturn(tmpuid, tmpname);
                parent.$.fancybox.close();
            });
        });

        function getData(uid) {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../handler/mtSearch.ashx",
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("mtSearch Error");
                        return false;
                    }

                    if (data != null) {
                        data = $.parseXML(data);
                        $("#tree").empty();
                        var tabstr = '';
                        //公司
                        if ($(data).find("company").length > 0) {
                            $(data).find("company").each(function (i) {
                                tabstr += '<li><input type="checkbox" />' + $(this).attr("name");
                                //部門
                                if ($(this).find("dep").length > 0) {
                                    tabstr += '<ul>';
                                    $(this).find("dep").each(function () {
                                        tabstr += '<li><input type="checkbox" />' + $(this).attr("name");
                                        //人員
                                        if ($(this).find("per").length > 0) {
                                            tabstr += '<ul>';
                                            $(this).find("per").each(function () {
                                                if (uid.indexOf($(this).attr("id")) != -1)
                                                    tabstr += '<li><input type="checkbox" name="per" value="' + $(this).attr("id") + '" uname="' + $(this).attr("name") + '" checked="checked" />' + $(this).attr("name") + '</li>';
                                                else
                                                    tabstr += '<li><input type="checkbox" name="per" value="' + $(this).attr("id") + '" uname="' + $(this).attr("name") + '" />' + $(this).attr("name") + '</li>';
                                            });
                                            tabstr += '</ul>';
                                        }
                                    });
                                    tabstr += '</ul>';
                                }
                                tabstr += '</li>';
                            });
                        }
                        $("#tree").append(tabstr);
                        $("#tree").treeview({
                            collapsed: true,
                            animated: "fast",
                            control: "#sidetreecontrol",
                            persist: "location"
                        });
                    }
                }
            });
        }
    </script>
    <style>
        .treepoint li { list-style:none;}
        .keybtnS{background:url(../images/BginfoBtnOut.gif) repeat-x bottom #ffdd98; border:1px solid #ffdd98; text-decoration:none; padding:3px 10px;*padding:5px;_padding:5px;color:#87712e; font-size:12px; margin:0px 2px;-webkit-border-radius:8px;-moz-border-radius:8px;border-radius:8px;font-weight:bold;text-decoration:none;}
        .keybtnShover{background:url(../images/BginfoBtnOver.gif) repeat-x bottom #ffb51a; border:1px solid #ffb51a; padding:3px 10px;*padding:5px;_padding:5px;color:#491a00; font-size:12px; cursor:pointer; margin:0px 2px;-webkit-border-radius:8px;-moz-border-radius:8px;border-radius:8px;font-weight:bold;text-decoration:none;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-size:12pt;">
            <div id="sidetreecontrol"><a href="javascript:void(0);">全部收合</a> | <a href="javascript:void(0);">全部展開</a></div>
            <div style="margin-top:5px;"><ul id="tree" class="treepoint"></ul></div>
        </div>
        <div style="text-align:right;">
            <input id="subbtn" type="button" value="確定" class="keybtnS" />
        </div>
    </form>
</body>
</html>
