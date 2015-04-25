Template.admin.helpers({
  messages: function() {
    return Messages.find({}, {limit: 10, sort: {createdAt: -1}});
  }
//   songs: function() {
//     return Songs.find({}, {limit: 10, skip: 0, sort: {artist: 1}});
//   }
});

Template.admin.rendered = function() {
  $('.menu .item').tab();
};
