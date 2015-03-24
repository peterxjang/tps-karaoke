Template.signup.events({
  'submit #signup-form' : function(e, t) {
    e.preventDefault();
    var username = t.find('#signup-username').value;
    var password = t.find('#signup-password').value;
    username = trimInput(username);
    password = trimInput(password);
    Accounts.createUser({username: username, password : password}, function(err) {
      if (err) {
        $('#signup-form').form('add errors', [err.reason]);
        $('#signup-form > div.ui.error.message').show();
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
