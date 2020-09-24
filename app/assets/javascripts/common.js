$(function(){
  $(".notifications").fadeOut(2000);
  $(".comments").hide();
  $(".comments_open").on("click", function(){
    $(this).siblings(".comments").slideToggle();
  });
});
