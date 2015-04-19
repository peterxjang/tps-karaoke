configureFacebook = function(config) {
    // first, remove configuration entry in case service is already configured
    ServiceConfiguration.configurations.remove({
      service: 'facebook'
    });

    ServiceConfiguration.configurations.insert({
      service: 'facebook',
      appId: config.clientId,
      secret: config.secret
    });
  };

// set the settings object with meteor --settings private/settings-local.json
var facebookConfig = Meteor.settings.facebook;
if (facebookConfig) {
  console.log('Got settings for facebook', facebookConfig);
  configureFacebook(facebookConfig);
} else {
  console.log('No settings found');
}

Accounts.onCreateUser(function(options, user) {
  if (!user.username) {
    if (user.profile) {
      user.username = user.profile.name;
    } else if (user.email) {
      user.username = user.email.split('@')[0];
    } else if (user.emails) {
      user.username = user.emails[0].address.split('@')[0];
    }
  }
  return user;
});
