$(document).ready(function(){

	$('#copy_new_link').click(function(){
		let $alert_copy_to_clipboard = $('#alert_copy_to_clipboard');
		$alert_copy_to_clipboard.show();
		setTimeout(() => $alert_copy_to_clipboard.hide(), 1500);
	
		let selBox = document.createElement('textarea');
		selBox.style.position = 'fixed';
		selBox.style.left = '0';
		selBox.style.top = '0';
		selBox.style.opacity = '0';
		selBox.value = $('#new_link').val();
		document.body.appendChild(selBox);
		selBox.focus();
		selBox.select();
		document.execCommand('copy');
		document.body.removeChild(selBox);
		$(this).blur();
	})
	
	const $menu = $('#menu_box'), $top = $('#top');
	function scroll() {
		let window_scrolltop = $(window).scrollTop(), top_height = $top.height() + 8;
		if(window_scrolltop >= top_height) {
			$menu.css('top',0);
		}else{
			$menu.css('top',top_height - window_scrolltop);
		}
	}
	scroll();
	document.onscroll = scroll;

	$("#facebook_side").hover(function(){
			$(this).stop(true,false).animate({right: "0px"}, 500 );},
		function(){
			$(this).stop(true,false).animate({right: "-300px"}, 500 );
		}
	);

	if(!localStorage.rodo_accepted) {
		$("#rodo-message").modal('show');
	}
});

function closeRodoWindow(){
	localStorage.rodo_accepted = true;
	$("#rodo-message").modal('hide');
}

$(window).on("load", function (){
	let $js_scroll_page = $('#js_scroll_page')
  	if($js_scroll_page.length>0){
		position = $js_scroll_page.offset().top;
		if($(window).scrollTop()+$(window).height()<position){
			$('html, body').stop().animate({scrollTop: (position-110)}, 300);
		}
	}
});

function checkCookies(){
	if(!localStorage.cookies_accepted) {
		cookies_message = document.getElementById("cookies-message").style.display="block"
	}
}

function closeCookiesWindow(){
	localStorage.cookies_accepted = true;
	var cookie_window = document.getElementById("cookies-message");
  cookie_window.parentNode.removeChild(cookie_window);
}

window.onload = checkCookies;
