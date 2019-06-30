$(document).ready(function(){
	$('.sideMenu').find('ul').prev('li').click(function(){
		$(this).nextAll('ul').toggle();
	}).nextAll('ul').hide();
});