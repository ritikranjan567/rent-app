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

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

//only for alert messages-------------------------------
$(document).on("turbolinks:load", function(){
  if ($("#alert_info").css("display") != "none"){
    $("#content").css("margin-top", "0.5rem;");
  }
  else{
    $("#content").css("margin-top", "3.3rem;");
  }

  $("#alert_info").fadeTo(3500, 500).slideUp(500, function(){ $(this).slideUp(500); });


  var searchInput = document.getElementById("search");
  searchInput.addEventListener("input", function(){
    $.ajax({
      url: "/searchoption",
      type: "get",
      data: {search: searchInput.value},
      success: function(data) { 
        $("#search_options").children().remove()
        $("#search_options").append(data); 
      },
      error: function() { console.log("search ajax error") }
    });
  });

});
//-----------------------------------------------------
