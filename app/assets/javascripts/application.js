// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require_tree .
$(document).ready(function(){
  $('.slider').slider({full_width: true});

  $('.fades1').delay( 200 ).fadeTo('slow', 1);
  $('.fades2').delay( 700 ).fadeTo('slow', 1);
  $('.fades0').delay( 1200 ).fadeTo('slow', 1);

  dreams = function(i){
    return function(){
      var $this = $(this); // caching $(this)
      $this.data('initialText', $this.text());
      $this.text([gon.amount[i-1] + ' Dreams']);
    }
  }

  for (var i = 1; i < 13; i++) {
    $('.cat' + i).hover(
      dreams(i),
      function() {
          var $this = $(this); // caching $(this)
          $this.text($this.data('initialText'));
      });

  }
});
