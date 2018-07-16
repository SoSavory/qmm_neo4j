// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function getPaginationSplines(url, successCallback, failureCallback){
  $.ajax({
    method: "GET",
    url: url,
    success: function( response ){
      successCallback(response);
    },
    error: function( response ){
      failureCallback();
    }
  })
}
// Action needs to somehow interpret, as well as the link content
function populatePagination(target, mode, count, spline_size, action){
  if (mode == "links"){
    for (let i = 0; i < Math.ceil(count/spline_size); i++){
      $('#'+target+'').append(
        '<a class="pagination_link" onclick="event.preventDefault();'+action+'(' + i + ');">' + String(i+1) + '</a>'
      )
    }
  }
}
