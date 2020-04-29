$(document).on("turbolinks:load", function(){
  
  $(".stars > span").on("mouseover", function(){    
    $(this).css("opacity", "0.6").prevAll().css("opacity", "0.6");
  });
  $(".stars > span").on("mouseleave", function(){
    $(this).css("opacity", "1").prevAll().css("opacity", "1");
  });
  $(".stars > span").on("click", function(){
    $(this).attr("class", "fa fa-star checked").prevAll().attr("class", "fa fa-star checked");
    $(this).nextAll().attr("class", "fa fa-star unchecked");
    $("#rating_score").val($(this).attr("id"));    
  });

});
