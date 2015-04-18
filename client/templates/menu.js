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
    return user ? user.username || user.profile.name : '';
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
