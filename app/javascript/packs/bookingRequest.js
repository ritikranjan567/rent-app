var msg = {};
var dateSets = [];
var Validator = (function(){
  var _validate_start_date = function(date){
    var input_date = new Date(date);
    var currentDate = new Date();
    
    if (input_date <= currentDate){
      msg.start_date = "Starting date can't be less than or equal to current date";
      return false;
    }
    else if (dateSets.length > 0){
      if (isOverlappingBookedEvent(input_date)){
        msg.start_date = "This place is already booked for given event start date";
        return false;
      }
      else{
        msg.start_date = "ok"; 
        return true;
      }
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
    else if (dateSets.length > 0){
      if (isOverlappingBookedEvent(inputDate)){
        msg.end_date = "This place is already booked for given event end date";
        return false;
      }
      else{
        msg.end_date = "ok"; 
        return true;
      }
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
  if (!validatorFunction(element.val())){
    element.css("border", "0.165rem solid red");
    element.next().css({"display": "block", "color": "red"}).text(msg[messageType]);
  }
  else{
    element.next().text("");
    element.css("border", "0.165rem solid green");
  }
  requestButtonManager();
}

$(document).on("turbolinks:load", function(){
  /* -------- setting event start date as tommorow's date */
  var nextDay = new Date();
  nextDay.setTime(nextDay.getTime() + (24 * 60 * 60 * 1000));
  /* set dateSets variable */
  setDateSets();
  /* --------------------------- */
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

  /* ------------ show user friendly dates and no of days-------------------------- */
  $(".show-date").each(displayDate);
  /* -------------------------------------------------------------------------------- */
  /* --- User friendly Dates and days for booking details ----------------------*/
  $(".booking-info-container").each(setNumberOfDaysAndDate);
  /* ----------------------------------------------------------------------------- */
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

function setDateSets(){
  var startDatesDivs = document.getElementsByClassName('start-date');
  var endDateDivs = document.getElementsByClassName('end-date');

  for (var i = 0; i < startDatesDivs.length; i++){
    dateSets.push([startDatesDivs[i].getAttribute("datetime"), endDateDivs[i].getAttribute("datetime")])
  }
}

function isOverlappingBookedEvent(date){
  var result = dateSets.every(function (pairs) { 
    var startDate = new Date(pairs[0]);
    var endDate = new Date(pairs[1]);
    return (date >= startDate && date <= endDate);
  });

  return result;
}

function displayDate(){
  var startDateContainer = $(this);
  var endDateContainer = startDateContainer.next();
  var startDate = new Date(startDateContainer.attr("date"));
  var endDate = new Date(endDateContainer.attr("date"));

  startDateContainer.html(startDate.toDateString());
  endDateContainer.html(endDate.toDateString());
  var calcNumberOfDays = Math.round((endDate - startDate)/(1000 * 60 * 60 * 24));
  endDateContainer.next().html('(' + putNumberOfDaysWithSuffix(calcNumberOfDays) + ')');
}

function putNumberOfDaysWithSuffix(numberOfDays){
  if (numberOfDays == 0 || numberOfDays == 1){
    return "1 day";
  }
  else if (numberOfDays > 1){
    return numberOfDays + " days";
  }
}

function setNumberOfDaysAndDate(){
  var startDateContainer = $(this).find(".booked-start-date");
  var endDateContainer = $(this).find(".booked-end-date");

  var startDate = new Date(startDateContainer.attr("datetime"));
  var endDate = new Date(endDateContainer.attr("datetime"));

  var startDateArray = startDate.toDateString().split(' ');
  var endDateArray = endDate.toDateString().split(' ');

  startDateContainer.find(".booked-day").html(startDateArray[0]);
  startDateContainer.find(".booked-date").html(startDateArray[2]);
  startDateContainer.find(".booked-month").html(startDateArray[1]);
  startDateContainer.find(".booked-year").html(startDateArray[3]);

  endDateContainer.find(".booked-day").html(endDateArray[0]);
  endDateContainer.find(".booked-date").html(endDateArray[2]);
  endDateContainer.find(".booked-month").html(endDateArray[1]);
  endDateContainer.find(".booked-year").html(endDateArray[3]);

  var calcNumberOfDays = Math.round((endDate - startDate) / (1000 * 60 * 60 * 24));
  $(this).find(".number-of-days").html(putNumberOfDaysWithSuffix(calcNumberOfDays)); 
}