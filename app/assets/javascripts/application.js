// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker-es
//= require bootstrap-carousel
//= require bootstrap-transition
//= require bootstrap-dropdown
//= require bootstrap-collapse
//= require_tree .

$(function(){	
  $('.carousel').carousel({interval: 2500});
  $('#appointment_date').datepicker();
});

function goTo(id){
  $('html,body').animate({scrollTop: $("#"+id).offset().top},'slow');
}

function resize(){
  var new_heigth = window.innerHeight;
  $('#intro').css('height', new_heigth-219);
  $('#company').css('height', new_heigth);
  $('#technology').css('height', new_heigth);
  $('#contact').css('height', new_heigth);
}

$(document).ready(function(){
	resize();
	if ($('.alert-error').text()) {
		goTo('contact');
	}
});

$(document).ready(function(){
	$('nav li#menu1 a').hover(function(){$('#menu1 aside').animate({width: '47px'},200);},
														function(){$('#menu1 aside').animate({width: '0px'},200);});
	$('nav li#menu2 a').hover(function(){$('#menu2 aside').animate({width: '73px'},200);},
														function(){$('#menu2 aside').animate({width: '0px'},200);});
	$('nav li#menu3 a').hover(function(){$('#menu3 aside').animate({width: '87px'},200);},
														function(){$('#menu3 aside').animate({width: '0px'},200);});
	$('nav li#menu4 a').hover(function(){$('#menu4 aside').animate({width: '98px'},200);},
														function(){$('#menu4 aside').animate({width: '0px'},200);});
});

$(document).ready(function(){
	var maxTime = 1000,
			target = $('.carousel'),
			startX = 0,
    	startTime = 0,
    	touch = "ontouchend" in document,
    	startEvent = 'touchstart',
    	moveEvent = 'touchmove',
    	endEvent = 'touchend';
    	
  target
  	.bind(startEvent, function(e){
  		e.preventDefault();
      startTime = e.timeStamp;
      startX = e.originalEvent.touches ? e.originalEvent.touches[0].pageX : e.pageX;
      target.carousel('pause');
  	})
		.bind(endEvent, function(e){
			startTime = 0;
      startX = 0;
      target.carousel('cycle')
		})
		.bind(moveEvent, function(e){
        e.preventDefault();
        var currentX = e.originalEvent.touches ? e.originalEvent.touches[0].pageX : e.pageX,
            currentDistance = (startX === 0) ? 0 : Math.abs(currentX - startX),
            // allow if movement < 1 sec
            currentTime = e.timeStamp;
        if (startTime !== 0 && currentTime - startTime < maxTime) {
            if (currentX < startX) {
                // swipe left code here
                target.carousel('next');
            }
            if (currentX > startX) {
                // swipe right code here
                 target.carousel('prev');
            }
            startTime = 0;
            startX = 0;
        }
    });		
});
