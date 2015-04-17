Template.sidebar.onRendered = function() {
  console.log('sidebar rendered');
  // $('.sidebar').sidebar('setting', 'transition', 'overlay');
};

Template.sidebar.events({
  'click a': function(event) {
    $('.sidebar').sidebar('toggle');
  },
  'click #sign-out': function(event) {
    Meteor.logout();
    $('.sidebar').sidebar('toggle');
  }
});
