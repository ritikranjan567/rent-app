// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

require('bootstrap')
require('jquery')
require('popper.js')
require('packs/signup')
require('packs/createAsset')
require('packs/rating')
require('packs/bookingRequest')

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(document).on("turbolinks:load", function(){

  /* ------ Animate feeback alert ------------------- */
  if ($("#alert_info").css("display") != "none"){
    $("#content").addClass("mg-tp-sm");
  }
  else{
    $("#content").addClass("mg-tp-reg");
  }

  $("#alert_info").fadeTo(3500, 500).slideUp(500, function(){ $(this).slideUp(500); });
  /* --------------------------------------------------------------------------------- */
  /* ------- Search auto complete Auto complete ---------------- */
  var searchInput = document.getElementById("search");
  searchInput.addEventListener("input", function(){
    $.ajax({
      url: "/search_option",
      type: "get",
      data: {search: searchInput.value},
      success: function(data) { 
        $("#search_options").html(data);
      },
      error: function(error) { console.log("Some error", error) }
    });
  });
  /* -------------------------------------------------------------- */
  /* --------- Displaying date --------------------- */
  if ($(".start-date")){
    var calenderContianer = $(".start-date");
    var dateData = new Date(calenderContianer.attr("datetime"));
    var dateArray = dateData.toDateString().split(" ");
    calenderContianer.find(".day").text(dateArray[0]);
    calenderContianer.find(".month").text(dateArray[1]);
    calenderContianer.find(".date").text(dateArray[2]);
    calenderContianer.find(".year").text(dateArray[3]);
  }
  if ($(".end-date")){
    var calenderContianer = $(".end-date");
    var dateData = new Date(calenderContianer.attr("datetime"));
    var dateArray = dateData.toDateString().split(" ");
    calenderContianer.find(".day").text(dateArray[0]);
    calenderContianer.find(".month").text(dateArray[1]);
    calenderContianer.find(".date").text(dateArray[2]);
    calenderContianer.find(".year").text(dateArray[3]);
  }
  /* -------------------------------------------------------- */
  /* ------------- Filters Radio button ----------------------------- */
  $("input[name='sort_by']").on("click", function(){
    var coords = [];
    var radio_element = $(this);
    var dist = $("#distance_value");
    if (radio_element.val() == "distance"){
      dist.attr("disabled", false);
      if (navigator.geolocation){
        navigator.geolocation.getCurrentPosition(function(position){
          coords.push(Number(position.coords.latitude), Number(position.coords.longitude));
          sendFilterData("distance", coords, dist.val());
          dist.on("input", function(){
            sendFilterData("distance", coords, $(this).val());
          });
        }, function(error){
          if (error.code == error.PERMISSION_DENIED)
            alert("Permission denied. There will be no result");
        });
      }
      else{
        alert("Browser does't support geolocation feature");
      }
    }
    else{
      dist.attr("disabled", true);
      sendFilterData(radio_element.val());
    }
  });
  /* --------------------------------------------------------------------- */
  /* --------------  display number of unviewed notifications ------------------------------- */
  var number_container = $("#unviewed_notifications");
  if (number_container.attr("unviewed_count") > 0){
    number_container.css("display", "block");
    number_container.text(number_container.attr("unviewed_count"));
  }
  else{
    number_container.css("display", "none");
  }
  /* ------------------------------------------------------------------------------ */
});

function sendFilterData(sortBy, coords = [], distanceVal = 0){
  $.ajax({
    url: "/assets/sort_and_filter_assets",
    type: "get",
    data: { sort_by: sortBy, coordinates: coords, distance: distanceVal },
    success: function(data) { 
      var assets_container = $("#show_assets_cards");
      assets_container.children().remove();
      assets_container.append(data);         
    },
    error: function() {  console.log("some error occured"); } 
  });
}