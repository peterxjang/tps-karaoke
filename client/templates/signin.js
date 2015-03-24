Template.signin.events({
  'submit #signin-form' : function(e, t) {
    e.preventDefault();
    var username = t.find('#signin-username').value;
    var password = t.find('#signin-password').value;
    username = trimInput(username);
    password = trimInput(password);
    Meteor.loginWithPassword(username, password, function(err) {
      console.log('hi');
      if (err) {
        $('#signin-form').form('add errors', [err.reason]);
        $('#signin-form > div.ui.error.message').show();
      } else {
        $('.ui.modal').modal('hide');
        $('.sidebar').sidebar('toggle');
      }
    });
    return false;
  }
});

var trimInput = function(val) {
  return val.replace(/^\s*|\s*$/g, '');
};
