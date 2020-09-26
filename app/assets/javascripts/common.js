$(function(){
  $(".notifications").fadeOut(2000);
  var message_flg = "hidden"
  $(".comments").hide();
  $(".comments_open").on("click", function(){
    if(message_flg == "hidden"){
      $(this).find("#open_message").text("▲コメントを隠す");
      message_flg = "open";
    } else {
      $(this).find("#open_message").text("▼コメントを表示");
      message_flg = "hidden";
    }
    $(this).siblings(".comments").slideToggle();
  });
});
