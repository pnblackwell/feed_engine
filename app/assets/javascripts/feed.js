//This loads the first image to show on the FEEDS SHOW page
$(document).ready(function(){
  $('.show-photo').first().toggleClass('hidden');

  $(".slideup").click(function(){
      var photo = $(this).closest('.show-photo');
      $(photo).next().toggleClass('hidden');
      $(photo).slideUp(500, function(){
          $(photo).toggleClass('hidden');
      });
   });

  $(".slidedown").click(function(){
      var photo = $(this).closest('.show-photo');
      $(photo).prev().toggleClass('hidden');
      $(photo).prev().slideDown(500, function(){
        $(photo).toggleClass('hidden');
      });
   });
});
