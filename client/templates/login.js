Template.login.events({
  'submit #login-form' : function(e, t) {
    e.preventDefault();
    var username = t.find('#login-username').value;
    var password = t.find('#login-password').value;
    username = trimInput(username);
    password = trimInput(password);
    Meteor.loginWithPassword(username, password, function(err) {
      if (err) {
        console.log(err.reason);
        $('#login-form').form('add errors', [err.reason]);
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
