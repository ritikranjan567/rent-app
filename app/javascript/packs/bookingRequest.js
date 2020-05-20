var msg = {};
var Validator = (function(){
  var _validate_start_date = function(date){
    var input_date = new Date(date);
    var currentDate = new Date();
    if (input_date <= currentDate){
      msg.start_date = "Starting date can't be less than or equal to current date"
      return false;
    }
    else{
      msg.start_date = "ok"
      return true;
    }
  };

  var _validate_end_date = function(date){
    var startDate = new Date($("#request_event_start_date").val());
    var inputDate = new Date(date);
    if (startDate > inputDate){
      msg.end_date = "End date can't be less than start date";
      return false;
    }
    else{
      msg.end_date = "ok";
      return true;
    }
  };

  var _validate_event_description = function(description){
    if (description.length < 20){
      msg.event_description = "Description is too short";
      return false;
    }
    else{
      msg.event_description = "ok";
      return true;
    }
  };

  return {
    validates_start_date: _validate_start_date,
    validates_end_date: _validate_end_date,
    validates_event_description: _validate_event_description
  };
})();

function requestWarn(element, validatorFunction, messageType){
  requestButtonManager();
  if (!validatorFunction(element.val())){
    element.css("border", "0.165rem solid red");
    element.next().css({"display": "block", "color": "red"}).text(msg[messageType]);
  }
  else{
    element.next().text("");
    element.css("border", "0.165rem solid green");
  }
}

$(document).on("turbolinks:load", function(){
  /* -------- setting event start date as tommorow's date */
  var nextDay = new Date();
  nextDay.setTime(nextDay.getTime() + (24 * 60 * 60 * 1000));
  
  if (document.getElementById("request_event_start_date")){
    document.getElementById("request_event_start_date").value = nextDay.getFullYear() + '-' + ('0' +
    (nextDay.getMonth() + 1)).slice(-2) + '-' + ('0' + nextDay.getDate()).slice(-2);
  }
  /* ------------------------------------------------------------- */
  $("#request_event_description").on("keyup", function(){
    requestWarn($(this), Validator.validates_event_description, "event_description");
  });
  $("#request_event_start_date").on("change", function(){
    requestWarn($(this), Validator.validates_start_date, "start_date");
  });
  $("#request_event_end_date").on("change", function(){
    requestWarn($(this), Validator.validates_end_date, "end_date"); 
  });
});

function requestButtonManager(){
  var request_btn = $("#request_btn");
  for (const prop in msg){
    if (msg[prop] != "ok"){
      request_btn.attr("disabled", true);
      return;
    }
  }
  request_btn.removeAttr("disabled");
}
