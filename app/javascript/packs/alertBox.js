var module = {};
module.showAlert = function(topic, message){
  var html = '<div class="alert alert-warning alert-dismissible" id="custom_alert">' + 
              '<button type="button" class="close" data-dismiss="alert">&times;</button>' +
              '<span class="fa fa-exclamation-circle"></span> &nbsp;' + '<strong>' + topic + '! ' + '</strong>' + message +
            '</div>';
  $(document.body).append(html);
  setTimeout(function(){ $("#custom_alert").hide(2000); }, 4000);
};
exports.methods = module;