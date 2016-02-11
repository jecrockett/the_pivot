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
