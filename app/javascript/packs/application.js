// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
require("bootstrap")
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// when chatroom page loads, scroll to bottom of messages
function scrollToBottom(){
    if($('#messages').length > 0){
        $('#messages').scrollTop($('#messages')[0].scrollHeight);
    }
}

function submitMessage(event){
    event.preventDefault();
    $('#new_message').submit();
}

//on enter key press, submit message
$(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
    if (event.keyCode == 13) { //keycode 13 for enter key
      submitMessage(event);
    }
});
 
 //on mouse click send, submit message
 $(document).on('click', '[data-send~=message]', function(event) {
    submitMessage(event);
 });

 $(document).on('turbolinks:load', function() {
    $("#new_message").on("ajax:complete", function(e, data, status) {
      $('#message_content').val('');
    })
    scrollToBottom();
});
  