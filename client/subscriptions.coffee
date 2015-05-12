Meteor.subscribe('genres')
Meteor.subscribe('ipAddresses')
# Meteor.subscribe('messages')
Session.setDefault('limitMessages', 5)
Deps.autorun ->
  Meteor.subscribe('messages', Session.get('limitMessages'))
