var AssetValidator = (function(){
  
})();

var message = {};  //for error messages

/* ---------For reading and displaying uploaded images-------------------------- */
function readImage() {
  var files = event.target.files;
  var preview = $(".preview-images");

  for(i = 0; i < files.length; i++){
    var file = files[i];

    if(!file.type.match("image")){
      message.image = "File type is not image"
      continue;
    }

    var picReader = new FileReader();

    picReader.addEventListener("load", function(event){
      var picReader = event.target;
      var html =  '<div class="preview-image">' +
                    '<div class="fa fa-times image-cancel"></div>' +
                    '<img src= "' + picReader.result + '">' 
                  '</div>';
      preview.append(html);
    });
    picReader.readAsDataURL(file);
  }      
}
/* ---------------------------------------------------------------------------- */


$(document).on("turbolinks:load", function(){
  $("#asset_pictures").on("change", readImage); //read images..

  $(document).on("click", ".image-cancel", function(){
    $(this).parent().remove();
  }); // remove images

  /* ---------Event tags management-------------------------------------- */
  //----------- adding tag --------------------------------------------
  $("#add_tags").on("click", function(){
    var input = $("#add_asset_tags");
    var event_tags = $("#event_tags")
    var viewTags = $(".view-event-tags");
    var html = '<div class="event-tags bg-warning">' + 
                  input.val() +
                  '<span class="remove-event-tag fa fa-times"></span>' +
                '</div>';
    viewTags.append(html);
    event_tags.val(event_tags.val() + " " + input.val());
    console.log(event_tags.val());
    
    input.val("");
  });
  //---------------------------------------------------------------------
  //-----Removing tags-------------------------------------------------------
  $(document).on("click",".remove-event-tag", function(){
    var event_tags = $("#event_tags");
    event_tags.val(event_tags.val().replace($(this).parent().text(), ""));
    console.log(event_tags.val());

    $(this).parent().remove();
  });
  //------------------------------------------------------------------------------
  /* -------------------------------------------------------------------------------- */
});


