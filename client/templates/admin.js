Template.admin.helpers({
  messages: function() {
    var messages = Messages.find({}, {limit: 10, sort: {createdAt: -1}});
    return messages.map(function(message) {
      return {
        username: message.username,
        text: message.text,
        createdAt: moment(message.createdAt).fromNow()
      };
    });
  }
//   songs: function() {
//     return Songs.find({}, {limit: 10, skip: 0, sort: {artist: 1}});
//   }
});

Template.admin.rendered = function() {
  $('.menu .item').tab();
};
