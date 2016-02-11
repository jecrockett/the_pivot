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

  $('.fades1').delay( 500 ).fadeTo('slow', 1);
  $('.fades2').delay( 1200 ).fadeTo('slow', 1);
  $('.fades0').delay( 1800 ).fadeTo('slow', 1);

  // $('.cat-card').hover(function(){
  //   $(this).text("I'm replaced!");
  //   }, function() {
  //   $(this).text("Replace me please");
  // });


  $('.cat1').hover(
    function() {
        var $this = $(this); // caching $(this)
        var donations = gon.amount
        $this.data('initialText', $this.text());
        $this.text([gon.amount[0] + ' Dreams']);
    },
    function() {
        var $this = $(this); // caching $(this)
        $this.text($this.data('initialText'));
    });

    $('.cat2').hover(
      function() {
          var $this = $(this); // caching $(this)
          var donations = gon.amount
          $this.data('initialText', $this.text());
          $this.text([gon.amount[1] + ' Dreams']);
      },
      function() {
          var $this = $(this); // caching $(this)
          $this.text($this.data('initialText'));
      });




});
