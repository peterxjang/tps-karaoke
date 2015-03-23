Template.login.events({
  'submit #login-form' : function(e, t) {
    e.preventDefault();
    var username = t.find('#login-username').value;
    var password = t.find('#login-password').value;
    username = trimInput(username);
    password = trimInput(password);
    Meteor.loginWithPassword(username, password, function(err) {
      console.log(err);
      if (err) {
        Meteor.logout();
        console.log('Error!');
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
