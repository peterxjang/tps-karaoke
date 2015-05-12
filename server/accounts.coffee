configureFacebook = (config) ->
  # first, remove configuration entry in case service is already configured
  ServiceConfiguration.configurations.remove
    service: 'facebook'
  ServiceConfiguration.configurations.insert
    service: 'facebook'
    appId: config.clientId
    secret: config.secret

# set the settings object with meteor --settings private/settings-local.json
facebookConfig = Meteor.settings.facebook
if (facebookConfig)
  configureFacebook(facebookConfig)


Accounts.onCreateUser (options, user) ->
  console.log(user)
  user.profile = options.profile or {}
  if (!user.username)
    # if ((user.profile || {}).name)
    if (user.profile?.name)
      user.username = user.profile.name
    else if (user.emails)
      user.username = user.emails[0].address #.split('@')[0]
    else if (user.services)
      if (user.services.facebook)
        user.username = user.services.facebook.name
        user.email = user.services.facebook.email
  # user.profile.facebookEmail = ((user.services || {}).facebook || {}).email
  user.profile.facebookEmail = user.services?.facebook?.email
  user.profile.isAdmin = user.profile.facebookEmail is 'peter.jang@yahoo.com'
  user

Meteor.users.deny
  update: -> true
