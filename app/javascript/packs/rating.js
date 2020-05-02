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

  var starDisplay = document.getElementsByClassName("display-stars");
  
  if(starDisplay.length > 0){
    for (j = 0; j < starDisplay.length; j++){
      starDisplay[j].innerHTML = setStars(starDisplay[j]);
    }
  }

});

function setStars(parantElement) {
  
  var score = Number(parantElement.getAttribute("data"));
  var html = "";
  for (i = 0; i < 5; i++){
    if (i < score){
      html = html + '<span class="fa fa-star checked"></span>';
      continue;
    }
    html = html + '<span class="fa fa-star unchecked"></span>';
  }
  return html;
}