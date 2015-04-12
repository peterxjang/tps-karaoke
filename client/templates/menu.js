Template.menu.helpers({
  username: function() {
    var user = Meteor.user();
    return user ? user.username : '';
  }
//   songs: function() {
//     return Songs.find().fetch().map(function(it){ return it.title; });
//   }
});

Template.menu.events({
  'click #menu': function(event) {
    $('.sidebar').sidebar('toggle');
  },
  'click #search': function(event) {
    console.log('hi');
  }
});
