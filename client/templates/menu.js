Template.menu.toggleSearchMenu = function() {
  $('#search').toggle();
  $('#search-clicked').toggle();
  $('#username').toggle();
  $('#menu').toggle();
  $('#back').toggle();
};

Template.menu.helpers({
  username: function() {
    var user = Meteor.user();
    // var username = user ? user.username : '';
    // var profilename = user && user.profile ? user.profile.name : '';
    // var email = user && user.emails ? user.emails[0].address : '';
    // // return username || profilename || email.split('@')[0];
    // return email;
    return user ? user.username : '';
  }
});

Template.menu.events({
  'click #menu': function(event) {
    $('.sidebar').sidebar('toggle');
  },
  'click #search': function(event) {
    Template.menu.toggleSearchMenu();
    $('#search-clicked input').focus();
  },
  'click #back': function(event) {
    Template.menu.toggleSearchMenu();
  }
});
