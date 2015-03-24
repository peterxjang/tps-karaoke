Template.signin.events({
  'submit #signin-form' : function(e, t) {
    e.preventDefault();
    var username = t.find('#signin-username').value;
    var password = t.find('#signin-password').value;
    username = trimInput(username);
    password = trimInput(password);
    Meteor.loginWithPassword(username, password, function(err) {
      if (err) {
        $('#signin-form').form('add errors', [err.reason]);
        $('#signin-form > div.ui.error.message').show();
      } else {
        $('#signin-modal').modal('hide');
        $('.sidebar').sidebar('toggle');
      }
    });
    return false;
  },
  'click #signup-button' : function(e) {
    e.preventDefault();
    $('#signup-modal').modal({
      detachable: false,
      onHidden: function() {
        $('#signup-form').form('clear');
        $('#signup-form > div.ui.error.message').hide();
      }
    }).modal('show');
  }
});

var trimInput = function(val) {
  return val.replace(/^\s*|\s*$/g, '');
};
