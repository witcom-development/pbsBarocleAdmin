jQuery(function(){
	/*
	 ******************************************************************
	 * Window Popup
	 * ----------------------------------------------------------------
	 * ----------------------------------------------------------------
	 ******************************************************************
	*/
	
	
	var winwidth = jQuery(window).innerWidth();
	var winheight = jQuery(window).innerHeight();
	jQuery(document.body).on("click",".winNewPop",function(e){
		e.preventDefault();
		jQuery("body").append("<div class='popmask'></div>");
		var purl = jQuery(this).attr("href");
		var ptt = escape(jQuery(this).attr("title"));
		var pwidth = jQuery(this).attr("data-width");
		var pheight = jQuery(this).attr("data-height");
		var paramt = jQuery(this).attr("data-pmt");
		var scrn = jQuery(this).attr("data-screen");
		var srcurl = jQuery(this).attr("data-src");
		if(srcurl) purl = srcurl;
		var winL = (screen.width-pwidth)/2;
		var winT = (screen.height-pheight)/2;
		
		if(jQuery(this).hasClass("modal")==true){
			winspop("model");
			jQuery(".popmask").show();
			jQuery(".popmask").css({"width":"99999px","height":"99999px"});
			jQuery(".popmask").on("click", function(){
				alert('정보창이 닫은 후 사용이 가능하십니다.');
			})
		}else{
			winspop("winpop");	
		}
		function winspop(wid){
			if(scrn) window.open(purl+"?outptt="+ptt+paramt,""+wid+"","height="+ screen.height + ",width=" + screen.width + ", scrollbars=yes");
			else window.open(purl+"?outptt="+ptt+paramt,""+wid+"","width="+pwidth+", height="+pheight+",top="+winT+",left="+winL+",scrollbars=yes");
		}
		return false
	});
	jQuery(".popclose").on("click", function(){
		opener.location.href = "javascript:maskhide()";
		self.close();
	})
	jQuery.urlParam = function(name){
		var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
		if (results==null){
		   return null;
		}else{
		   return results[1] || 0;
		}
	};
	//var winh = jQuery(window).innerHeight();
	//var ptth = 40;
	//var wph = (winh-ptth)-39;
	//jQuery(".cntbox").css({"height":wph+"px","overflow-x":"hidden"});
	var inPtt = unescape(jQuery.urlParam('outptt'));
	jQuery(".popTt").text(inPtt);	
	/*
	 ******************************************************************
	 * break point
	 * ----------------------------------------------------------------
	 * ----------------------------------------------------------------
	 ******************************************************************
	*/
	var wNum = jQuery(window).innerWidth();
	if(wNum > 1000){
		jQuery("body").removeClass("ie8m");
		jQuery("body").removeClass("ie8t");
		jQuery("link[title='ie8chn']").attr("href","/css/pw.css");
		jQuery("#pagingMobile").css("display","none");
		jQuery("#pagingWeb").css("display","inline");
	}
	if(wNum < 1000 && wNum > 700 ){
		jQuery("body").removeClass("ie8m");
		jQuery("body").addClass("ie8t");
		//document.createStyleSheet('../css/tdvcss.css');
		jQuery("link[title='ie8chn']").attr("href","/css/tdvcss.css")
		jQuery("#pagingMobile").css("display","none");
		jQuery("#pagingWeb").css("display","inline");
	}
	if(wNum < 700){
		jQuery("body").removeClass("ie8t");
		jQuery("body").addClass("ie8m");
		jQuery(".shBox").css("display","none");
		//document.createStyleSheet('../css/mdvcss.css');
		jQuery("link[title='ie8chn']").attr("href","/css/mdvcss.css")
		jQuery("#pagingWeb").css("display","none");
		jQuery("#pagingMobile").css("display","inline");
	}
	
	jQuery(window).resize(function() {
		wNum = jQuery(window).innerWidth();
		if(wNum > 1000){
			jQuery("body").removeClass("ie8m");
			jQuery("body").removeClass("ie8t");
			jQuery(".layerMenuArea").css("display","none")
			jQuery(".shBox").css("display","block")
			jQuery("link[title='ie8chn']").attr("href","/css/pw.css");
			jQuery("#pagingMobile").css("display","none");
			jQuery("#pagingWeb").css("display","inline");
		}
		if(wNum < 1000 && wNum > 700 ){
			jQuery("body").removeClass("ie8m");
			jQuery("body").addClass("ie8t");
			jQuery(".shBox").css("display","block")
			jQuery("link[title='ie8chn']").attr("href","/css/tdvcss.css");
			jQuery("#pagingMobile").css("display","none");
			jQuery("#pagingWeb").css("display","inline");
		}
		if(wNum < 700){
			jQuery("body").removeClass("ie8t");
			jQuery("body").addClass("ie8m");
			if(!jQuery(".downtitle").hasClass("on") ){
				jQuery(".shBox").css("display","none")
			}
			jQuery("link[title='ie8chn']").attr("href","/css/mdvcss.css")
			jQuery("#pagingWeb").css("display","none");
			jQuery("#pagingMobile").css("display","inline");
		}
	});




	/*
	 ******************************************************************
	 * layerMenu
	 ******************************************************************
	*/
	jQuery(".leftmenu dd > a").on("click",function(){
		var idx = jQuery(this).next();
		if(idx.css("display") === "block"){
			jQuery(".leftmenu dd ul").css("display","none")	;	
		}else{
			jQuery(".leftmenu dd ul").css("display","none")	;			
			idx.css("display","block");
		}
	});
	jQuery(".dep1 > li > span").on("click",function(){
		var idx = jQuery(this).next();
		if(idx.css("display") === "block"){
			jQuery(".dep2").css("display","none");		
			jQuery(".dep3").css("display","none");		
		}else{
			jQuery(".dep2").css("display","none");				
			idx.css("display","block");
		}
	});
	jQuery(".dep2 > li > span").on("click",function(){
		var idx = jQuery(this).next();
		if(idx.css("display") === "block"){
			jQuery(".dep3").css("display","none")	;	
		}else{
			jQuery(".dep3").css("display","none");				
			idx.css("display","block");
		}
	});
	jQuery(".openMenu").on("click",function(){
		jQuery(".layerMenuArea").css("display","block");
		jQuery(".layerMenu").animate({right: "0%"}, 500);
		jQuery("html,body").attr("scroll","no");
		jQuery("html,body").css({"height":"100%","overflow":"hidden"});
	});
	jQuery(".close,.dim").on("click",function(){
		jQuery(".layerMenu").animate({right: "-100%"}, 500,function(){
			jQuery(".layerMenuArea").css("display","none");
		});
		jQuery("html,body").attr("scroll","yes");
		jQuery("html,body").css({"height":"100%","overflow":"auto"});
	});

	/*
	 ******************************************************************
	 * DATA PICKER
	 ******************************************************************
	*/

	$(".datepicker").datepicker({
		changeYear: true,
		changeMonth: true,
		showMonthAfterYear: true ,
		dateFormat: "yy-mm-dd",
		dayNamesMin: ["일","월","화","수","목","금","토"],
		monthNames: ["1","2","3","4","5","6","7","8","9","10","11","12"],
		monthNamesShort : ["1","2","3","4","5","6","7","8","9","10","11","12"],
		nextText: "<button>다음 달</button>",
		prevText: "<button>이전 달</button>",
		showOn: "button",
		buttonImage: "/images/btn_cal.png",
		buttonText: "달력보기 및 선택"
		//isRTL : "before"
	});


	jQuery(document.body).on("focusout",".ui-date-table table tbody td a:last",function(){
		jQuery(".datepicker").datepicker("hide");
		date_btn.focus();
		jQuery("#ui-datepicker-div").removeAttr("tabindex");
	}).on("click",".allwrap",function(){		
		if(jQuery("#ui-datepicker-div").css("display") != "none"){
			jQuery(".datepicker").datepicker("hide");
			jQuery("#ui-datepicker-div").removeAttr("tabindex");
			//date_btn.focus();
		};
	});
	
	/*
	 ******************************************************************
	 * mobile srhBox
	 ******************************************************************
	*/
	jQuery(".downtitle").on("click",function(){
		var pageW = jQuery(".page").width(),
			shBoxW = pageW - (0.04*pageW);
		//shdowH = jQuery(".shBox_mWrap").height()

		if(jQuery(".downtitle").hasClass("on")){
			jQuery(".shBox").css("display","none")
			jQuery(".downtitle").removeClass("on")
			jQuery(this).find("img").attr("src",jQuery(this).find("img").attr("src").replace("_on.png",".png"))
			jQuery(".shBox_m").css("position","relative")

		}else{
			jQuery(".shBox").css("display","block")
			jQuery(".downtitle").addClass("on")
			jQuery(this).find("img").attr("src",jQuery(this).find("img").attr("src").replace(".png","_on.png"))
		}

		
	});
	/*
	 ******************************************************************
	 * #Fly Banner
	 * ----------------------------------------------------------------
	 ******************************************************************
	*//*
	if(jQuery(".shBox_m").css("display") == "block"){
		var pos = jQuery(".content").offset().top;
		jQuery(window).on("scroll",function(){
			var targetTop = jQuery(window).scrollTop(),
				pageW = jQuery(".page").width(),
				shBoxW = pageW - (0.04*pageW)
				shdowH = jQuery(".shBox_mWrap").height()
			jQuery(".shBox_mWrap").css("width",shBoxW - 2)
			if(targetTop == 0 ){
				jQuery(".shBox_m").removeAttr("style")
				jQuery(".shBox_mWrap").css("position","relative")	
				jQuery(".shBox_mWrap").stop().animate({"top":0},600,"easeInOutExpo",function(){
					jQuery(".shBox_mWrap").remove("moving")
				});
			}else{
				jQuery(".shBox_m").css("height",shdowH)
				jQuery(".shBox_mWrap").css("position","fixed")
				jQuery(".shBox_mWrap").css("top",pos)
				jQuery(".shBox_mWrap").addClass("moving")
				//jQuery(".shBox_m").stop().animate({"top":result},600,"easeInOutExpo");
			}
		});
	};*/
		
	/*
	 ******************************************************************
	 * Map Position infomation
	 * ----------------------------------------------------------------
	 * ----------------------------------------------------------------
	 ******************************************************************
	*/
	jQuery(".mappos").on("click", function(){
		jQuery(".stamapinfo").hide();
		jQuery(this).next().show();
		return false
	});
	jQuery(".mpclose").on("click", function(){
		jQuery(".stamapinfo").hide();
		return false
	});

	/*
	 ******************************************************************
	 * #fileBox
	 * ----------------------------------------------------------------
	 ******************************************************************
	*/

	jQuery(document.body).on("focusin",".ph input",function(){
		var fom = jQuery(this);
		fom.next().hide();				
	}).on("focusout",".ph input",function(){
		var fom = jQuery(this);
		if(!fom.val()) fom.next().show();
	}).on("focusin",".fileBox .ph input",function(){
		jQuery(".file input").click();
	}).on("change",".file input",function(){
		if(!jQuery(this).val()) {
			jQuery(".fileBox .ph em").show();
		}else{
			jQuery(".fileBox .ph em").hide();
		};
		jQuery(".fileBox .ph input").val(jQuery(this).val());
	}).on("focusin",".pholder input",function(){
		jQuery(this).parent().addClass("holder");
	}).on("focusout",".pholder input",function(){
		if(!jQuery(this).val()){
			jQuery(this).parent().removeClass("holder");
		}
	});

	/*
	 ******************************************************************
	 * #TAB
	 * ----------------------------------------------------------------
	 * Type별 탭메뉴
	 * ----------------------------------------------------------------
	 ******************************************************************
	*/
	jQuery(document.body).on("click",".tabWrap.type1 .tab button",function(){
		jQuery(".tabWrap.type1 .tab").removeClass("on");
		jQuery(this).parent().addClass("on");
	}).on("click",".tabWrap.type2 .tab button",function(){
		jQuery(".tabWrap.type2 .tab").removeClass("on");
		jQuery(this).parent().addClass("on");
	}).on("click",".tabWrap.type3 .tab button",function(){
		var idx = jQuery(".tabWrap.type3 .tab button").index(this);
		jQuery(".tabWrap.type3 .tab").removeClass("on");
		jQuery(".tabWrap.type3 .tabCon").removeClass("on").eq(idx).addClass("on");
		jQuery(this).parent().addClass("on");
	});

});
/*IE-excluding conditional comment*/
if(document.documentMode===10){
	document.documentElement.className+=' ie10';
}else if(document.documentMode===11){
	document.documentElement.className+=' ie11';
};
/* Popup Block */
function maskhide(){
	jQuery(document.body).find(".popmask").remove();
}






