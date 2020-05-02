$(document).on("turbolinks:load", function(){
  /* setting default date to today's */
  var today = new Date();
  document.getElementById("request_event_start_date").value = today.getFullYear() + '-' + ('0' +
  (today.getMonth() + 1)).slice(-2) + '-' + ('0' + today.getDate()).slice(-2);
  /* ------------------------------------------------------------- */

});