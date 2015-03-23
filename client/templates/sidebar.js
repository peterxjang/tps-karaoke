Template.sidebar.onRendered = function() {
  console.log('sidebar rendered');
};

Template.sidebar.events({
  'click #sign-in': function(event) {
    $('.ui.modal').modal({
      detachable: false,
      onHidden: function() {
        // console.log('hidden');
        $('#login-form').form('clear');
      }
    }).modal('show');
  },
  'click #sign-out': function(event) {
    Meteor.logout();
    $('.sidebar').sidebar('toggle');
  }
});
