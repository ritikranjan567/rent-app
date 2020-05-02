messages = {};
var Validator = (function(){
  var _validateName = function(name){
    var regex = /^[a-zA-Z ]{2,30}$/;
    //var num_match = name.match(/[0-9]/g)
    if (name.length == 0){
      messages.name = "Fill your name";
      return false;
    }
    else if(!regex.test(name)){
      messages.name = "Invalid name";
      return false;
    }
    else{
      return true;
    }
  };
  
  var _validateEmail = function(email){
    var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
    if (email.length == 0){
      messages.email = "Enter your email Id"
      return false;
    }
    else if (!regex.test(email)){
      messages.email = "Invalid email"
      return false;
    }
    else{
      return true;
    }
  };

  var _validatePasswordStrength = function(password){
    if (password.length == 0){
      messages.password = "Enter the password";
      return false;
    }
    else if (password.length < 8){
      messages.password = "Password too short";
      return false;
    }
    else{
      var msgs = ["Weak", "Medium", "Strong"];
      var status = 0;

      if (/[A-Z]/.test(password)){
        status++;
      }
      if (/[0-9]/.test(password)){
        status++;
      }
      if (/[!@#$&*]/.test(password)){
        status++;
      }
      messages.password = msgs[status];
      return true;
    }
  };

  var _validateConfirmPassword = function(confirmPassword){
    if ($("#user_password").val() != confirmPassword){
      messages.confirmPassword = "Doesn't match with password";
      return false;
    }
    else{
      return true;
    }
  };

  return {
    validateName: _validateName,
    validateEmail: _validateEmail,
    validatePasswordStrength: _validatePasswordStrength,
    validateConfirmPassword: _validateConfirmPassword
  };
})();

function signup_warn(element, validatorFunction, messageType) {
  var validationResult = validatorFunction(element.val());
  if (!validationResult){
    element.css("border", "0.165rem solid red")
    .next().attr("class", "feedback-icon fa fa-times")
    .css({"display": "inline", "color": "red"})
    .next().text(messages[messageType]).css({"display": "block", "color": "red"});
  }
  // this is just for password strength check...
  else if (messages[messageType] == "Medium" || messages[messageType] == "Weak"){
    element.css("border", "0.165rem solid orange")
    .next().attr("class", "feedback-icon fa fa-exclamation")
    .css({"display": "inline", "color": "orange"})
    .next().text(messages[messageType]).css({"display": "block", "color": "orange"});
  }
  else{
    element.css("border", "0.165rem solid green")
    .next().attr("class", "feedback-icon fa fa-check")
    .css({"display": "inline", "color": "green"})
    .next().css("display", "none");
  }
}

$(document).on("turbolinks:load", function(){
  /* Getting the image and previewing */
  $("#user_profile_picture").on("change", function(event){
    //console.log("Getting the image..");
    
    $("#upload_profile_pic").attr("src", URL.createObjectURL(event.target.files[0]));
  });
  /* ------------------------------------------------------------------------------------ */



  $("#user_first_name").on("keyup", function(){
    signup_warn($(this), Validator.validateName, "name");
  });
  $("#user_last_name").on("keyup", function(){
    signup_warn($(this), Validator.validateName, "name");
  });

  $("#user_email").on("keyup", function(){
    signup_warn($(this), Validator.validateEmail, "email");
  });

  $("#user_password").on("keyup", function(){
    signup_warn($(this), Validator.validatePasswordStrength, "password");
  });

  $("#user_password_confirmation").on("keyup", function(){
    signup_warn($(this), Validator.validateConfirmPassword, "confirmPassword");
  });

  /* delete profile picture while editing */

  $("#remove_profile_picture").on("click", function(){
    $("#upload_profile_pic").attr("src", "/profile_img.png");
    $("#user_profile_picture").val("");
    $.ajax({
      url: "/deleteprofilepic",
      type: "DELETE"
    });
  });
  /* --------------------------------------------------- */
});
