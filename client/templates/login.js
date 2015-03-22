Template.login.events({
  'submit #login-form' : function(e, t) {
    e.preventDefault();
    // retrieve the input field values
    var username = t.find('#login-username').value;
    var password = t.find('#login-password').value;
    // Trim and validate your fields here....
    username = trimInput(username);
    password = trimInput(password);
    // If validation passes, supply the appropriate fields to the
    // Meteor.loginWithPassword() function.
    Meteor.loginWithPassword(username, password, function(err) {
      if (err) {
        console.log(err);
        // The user might not have been found, or their passwword
        // could be incorrect. Inform the user that their
        // login attempt has failed.
      } else {
        // The user has been logged in.
        $('.ui.modal').modal('hide');
      }
    });
    return false;
  }
});

var trimInput = function(val) {
  return val.replace(/^\s*|\s*$/g, '');
};
