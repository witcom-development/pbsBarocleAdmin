$(window).load(function() {
	$("select").selectify();
});
$(document).ready(function(){
	$("#email_selc").on("change", function () {
        $('#email_input').val($(this).val());
    });
    $("#loan_std_btn").click(function(e) {
		$(this).toggleClass("on");
		$("#loan_std_cont").toggle();    
		e.preventDefault();	
    });
    $(function(){
        var argee = $(".detail_show");
        argee.each(function(){
            $(this).click(function(e){
                $(this).parent().parent().children('.priv_layer').slideToggle(200,'easeInCirc');
                e.preventDefault();
            });
        });
    });
    $(function(){
    	var slider = $(".com_slider");
    	var thum = $(".com_slider_thum .inner");
    	var caption = $(".caption .text");
    	var note = $(".note .inner");
	    thum.flexslider({
			animation: "slide",
			controlNav: false,
			animationLoop: false,
			slideshow: false,
			itemWidth: 141,
			itemMargin: 9,
			asNavFor: slider
		});
		slider.flexslider({
			animation: "slide",
			controlNav: false,
			animationLoop: false,
			slideshow: false,
			sync: thum
		});
		$(".com_slider_thum .inner li").each(function(){
            var ind = $(this).index();
            $(this).click(function(e){
                $(caption).hide().eq(ind).show();
                e.preventDefault();
            });
        });
        $(".com_slider_print_thum .inner li").each(function(){
            var ind = $(this).index();
            $(this).click(function(e){
                $(note).hide().eq(ind).show();
                e.preventDefault();
            });
            note.hide();
            note.eq(0).show();
        });
	});
});