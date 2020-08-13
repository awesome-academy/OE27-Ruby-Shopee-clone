$(document).on('turbolinks:load', function() {
  this.App = {};

  App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
  connected: function() {
    console.log("connected channel");
  },
  disconnected: function() {
    console.log("disconnected channel");
  },
  received: function(data) {
    alert(data.message);
  }
  })
})
