var message = {};  //for error messages
var AssetValidator = (function(){
  var _validateAssetName = function(name){
    
    let regex =  /^[a-zA-Z][a-zA-Z' ]{3,30}$/;
    if (name.length == 0){
      message.assetName = "Please Name your place..";
      return false;
    }
    else if (!regex.test(name)){
      message.assetName = "Invalid name (Start with charecter and minimum 4 charecters)";
      return false;
    }
    else{
      message.assetName = "ok";
      return true;
    }
  };
  var _validateDimension = function(dimension){
    let regex = /^[0-9]{1,3}[a-zA-z.]{1,10} [x|X] [0-9]{1,3}[a-zA-z.]{1,10}/;
    if (dimension.length == 0){
      message.assetDimension = "Please enter a valid dimension";
      return false;
    }
    else if (!regex.test(dimension)){
      message.assetDimension = "Unsupported dimension formate (try follow given example)";
      return false;
    }
    else{
      message.assetDimension = "ok";
      return true;
    }
  };

  var _validateDescription = function(description){
    if (description.length < 20){
      message.assetDescription = "Length of the description should be atleast 20 charecters";
      return false;
    }
    else{
      message.assetDescription = "ok";
      return true;
    }
  };

  var _validateAssetPrice = function(price){
    if (price.length == 0){
      message.assetPrice = "Enter the price please";
      return false;
    }    
    else if (!(/^[0-9][0-9]{1,10}$/.test(price))){
      message.assetPrice = "Enter valid price (Enter numbers only)";
      return false;
    }
    else{
      message.assetPrice = "ok";
      return true;
    }
  };

  var _validateLocationText = function(text){
    let regex = /^[a-zA-Z][a-zA-Z ]{2,30}$/;
    if (text.length == 0){
      message.location = "Enter required location data";
      return false;
    }
    else if (!regex.test(text)){
      message.location = "Invalid formate (start with a charecter and enter minimum 3 charecters)";
      return false;
    }
    else{
      message.location = "ok";
      return true;
    }
  };

  var _validatePincode = function(pincode){
    let regex =  /^[0-9][0-9]{2,20}$/;
    if (pincode.length == 0){
      message.pincode = "Enter pincode";
      return false;
    }
    else if (!regex.test(pincode)){
      message.pincode = "Invalid formate(Enter numbers only)";
      return false;
    }
    else{
      message.pincode = "ok";
      return true;
    }
  };

  var _validateAddress = function(address){
    if (address.length == 0){
      message.address = "Enter the particulars"
      return false;
    }
    else{
      message.address = "ok";
      return true;
    }
  };

  var _tagsValidator = function(tagName){
    var regex = /^[A-Z][a-zA-Z ]{2,20}$/;
    return regex.test(tagName);
  };
  return {
    validateAssetName: _validateAssetName,
    validateAssetDimension: _validateDimension,
    validateAssetDescription: _validateDescription,
    validateAssetPrice: _validateAssetPrice,
    validateLocationText: _validateLocationText,
    validatePincode: _validatePincode,
    validateAddress: _validateAddress,
    tagsValidator: _tagsValidator
  };
})();

function showWarn(element, errorType, validationFunction){
  postButtonManager();
  let valStatus = validationFunction(element.val());
  if (!valStatus){
    element.css("border", "2px solid red");
    element.parent().children("div.feedback-warning").text(message[errorType]).css("display", "block");
  }
  else{
    element.parent().children("div.feedback-warning").css("display", "none");
    element.css("border", "2px solid green");
  }
}
/* ---------For reading and displaying uploaded images-------------------------- */
function readImage() {
  postButtonManager();
  var files = event.target.files;
  const preview = $(".preview-images");
  preview.children().remove();
  if (files.length > 6){
    message.pictures = "Please limit your uplaods upto 6 pictures";
    preview.next().text(message.pictures);
    return;
  }
  else{
    message.pictures = "ok"
    preview.next().text("");
  }
  for(i = 0; i < files.length; i++){
    let file = files[i];

    var picReader = new FileReader();

    picReader.addEventListener("load", function(event){
      var picReader = event.target;
      var html =  '<div class="preview-image">' +
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
    const input = $("#add_asset_tags");
    const event_tags = $("#event_tags")
    const viewTags = $(".view-event-tags");
    var html = '<div class="event-tags bg-warning">' + 
                  input.val() +
                  '<span class="remove-event-tag fa fa-times"></span>' +
                '</div>';
    viewTags.append(html);
    event_tags.val(event_tags.val() + input.val() + ",");
    console.log(event_tags.val());
    
    input.val("");
    $(this).attr("disabled", true);
  });
  //---------------------------------------------------------------------
  //-----Removing tags-------------------------------------------------------
  $(document).on("click",".remove-event-tag", function(){
    const event_tags = $("#event_tags");
    event_tags.val(event_tags.val().replace(($(this).parent().text() + ","), ""));
    //console.log(event_tags.val());

    $(this).parent().remove();
  });
  //------------------------------------------------------------------------------
  //------------ validate tag input ---------------------------------------------------
  $("#add_asset_tags").on("keyup", function(){
    const addBtn = $("#add_tags");
    
    if(AssetValidator.tagsValidator($(this).val()))
      addBtn.removeAttr("disabled");
    else
      addBtn.attr("disabled", true);
  });
  //-------------------------------------------------------------------------------------
  /* -------------------------------------------------------------------------------- */

  /* ----------Validations for asset fields--------------------------------------- */
  $("#asset_name").on("keyup", function(){
    showWarn($(this), "assetName", AssetValidator.validateAssetName);
  });

  $("#asset_dimension").on("keyup", function(){
    showWarn($(this), "assetDimension", AssetValidator.validateAssetDimension);
  });

  $("#asset_description").on("keyup", function(){
    showWarn($(this), "assetDescription", AssetValidator.validateAssetDescription);
  });

  $("#asset_price").on("keyup", function(){
    showWarn($(this), "assetPrice", AssetValidator.validateAssetPrice);
  });

  $("#asset_address").on("keyup", function(){
    showWarn($(this), "address", AssetValidator.validateAddress);
  });

  $("#place").on("keyup", function(){
    showWarn($(this), "location", AssetValidator.validateLocationText);
  });

  $("#city").on("keyup", function(){
    showWarn($(this), "location", AssetValidator.validateLocationText);
  });

  /* $("#pincode").on("keyup", function(){
    showWarn($(this), "pincode", AssetValidator.validatePincode);
  }); */
  /* -------------------------------------------------------------------------------- */
});


function postButtonManager(){
  var postBtn = $("#post_ad");
  for (const prop in message){
    if (message[prop] != "ok"){
      postBtn.attr("disabled", true);
      return;
    }
  }
  postBtn.removeAttr("disabled");
}