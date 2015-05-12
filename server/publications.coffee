Meteor.publish 'messages', (limit=3) ->
  Messages.find({}, {limit: limit, sort: {createdAt: -1}})

Meteor.publish 'genres', ->
  Genres.find({})

Meteor.publish 'ipAddresses', ->
  startOfDay = new Date
  startOfDay.setHours(0, 0, 0, 0)
  ip = this.connection.clientAddress
  IpAddresses.find({ip: ip, date: startOfDay})

# Meteor.publish('songs', function() {
#   return Songs.find({}, {fields: {'artist': 1, 'title': 1}});
# })
