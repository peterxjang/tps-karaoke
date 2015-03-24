Template.sidebar.onRendered = function() {
  console.log('sidebar rendered');
};

Template.sidebar.events({
  'click #sign-in': function(event) {
    $('#signin-modal').modal({
      detachable: false,
      onHidden: function() {
        $('#signin-form').form('clear');
        $('#signin-form > div.ui.error.message').hide();
      }
    }).modal('show');
  },
  'click #sign-out': function(event) {
    Meteor.logout();
    $('.sidebar').sidebar('toggle');
  }
});
