// JavaScript Document
$(document).ready(function(){
//修改下拉選單寬度
$(".nav ul li:nth-child(2) ul li a").css("width","150px");
	
//雙色表單
$(".stripeMe tr").mouseover(function() {$(this).addClass("over");}).mouseout(function() {$(this).removeClass("over");});
$(".stripeMe tr:even").addClass("alt");
//資料列表
$(".gentable tr:last-child td").css("border-bottom-width","0");
//按鈕
$(".genbtn").hover(
       function(){ $(this).addClass('genbtnhover') },
       function(){ $(this).removeClass('genbtnhover') }
)
$(".genbtnS").hover(
       function(){ $(this).addClass('genbtnShover') },
       function(){ $(this).removeClass('genbtnShover') }
)
$(".keybtn").hover(
       function(){ $(this).addClass('keybtnhover') },
       function(){ $(this).removeClass('keybtnhover') }
)
$(".keybtnS").hover(
       function(){ $(this).addClass('keybtnShover') },
       function(){ $(this).removeClass('keybtnShover') }
)
//捲軸美化
$(".overwidthblock").mCustomScrollbar({
    axis:"x", // horizontal scrollbar
	theme:"inset-dark",
	//autoHideScrollbar:true,
	//setLeft:"150px"
});

});