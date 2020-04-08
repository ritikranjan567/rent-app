var message = {}
var filesStore = new FormData();

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
                  '</div>'
      preview.append(html);
    });
    filesStore.append("asset_pictures", file);
    picReader.readAsDataURL(file);
  }
      
}


$(document).on("turbolinks:load", function(){
  $("#asset_pictures").on("change", readImage);

  $(document).on("click", ".image-cancel", function(){
    $(this).parent().remove();
  });

  /*var asset_form = document.getElementById("new_asset");
  asset_form.addEventListener('submit', function(event){
    event.preventDefault();
    var request = new XMLHttpRequest();
    request.open("POST", "/assets");
    request.send(filesStore);
  });*/
});