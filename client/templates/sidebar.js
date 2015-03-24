Template.sidebar.onRendered = function() {
  console.log('sidebar rendered');
};

Template.sidebar.events({
  'click #sign-in': function(event) {
    $('.ui.modal').modal({
      detachable: false,
      onHidden: function() {
        $('#login-form').form('clear');
        $('#login-form > div.ui.error.message').hide();
      }
    }).modal('show');
  },
  'click #sign-out': function(event) {
    Meteor.logout();
    $('.sidebar').sidebar('toggle');
  }
});
