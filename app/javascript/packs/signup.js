$(document).on("turbolinks:load", function(){
  $("#user_profile_picture").on("change", function(event){
    console.log("Getting the image..");
    
    $("#upload_profile_pic").attr("src", URL.createObjectURL(event.target.files[0]));
  });
});