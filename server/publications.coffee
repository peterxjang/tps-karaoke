Meteor.publish 'tasks', ->
  Tasks.find
    $or: [
      {private: {$ne: true}}
      {owner: this.userId}
    ]

Meteor.publish 'messages', ->
  Messages.find({})

Meteor.publish 'genres', ->
  Genres.find({})

# Meteor.publish('songs', function() {
#   return Songs.find({}, {fields: {'artist': 1, 'title': 1}});
# })
