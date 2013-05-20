$(document).ready(function(){
  //This loads the first image to show on the FEEDS SHOW page
  $('.show-photo').first().toggleClass('hidden');

  // When user clicks the 'next' button, the next next photo
  //gets turned on, slides up, and the current photo turns off
  $(".slideup").click(function(){
      var photo = $(this).closest('.show-photo');
      $(photo).next().toggleClass('hidden');
      $(photo).slideUp(500, function(){
          $(photo).toggleClass('hidden');
      });
   });

  // When user clicks 'previous' button, prev photo shows,
  // slides in, and current photo hides
  $(".slidedown").click(function(){
      var photo = $(this).closest('.show-photo');
      $(photo).prev().toggleClass('hidden');
      $(photo).prev().slideDown(500, function(){
        $(photo).toggleClass('hidden');
      });
   });
});
