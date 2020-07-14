import consumer from "./consumer"

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    $('#messages').append(data['message']);
    $('#message_content').val('');
    scrollToBottom();
  }
});
function scrollToBottom(){
  if($('#messages').length > 0){
      $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
}
$(document).ready(function(){
  scrollToBottom();
})
(function() {
  jQuery(document).on('turbolinks:load', function() {
    scrollToBottom();
  });

})