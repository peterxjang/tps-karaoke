Meteor.publish 'tasks', ->
  Tasks.find
    $or: [
      {private: {$ne: true}}
      {owner: this.userId}
    ]

# Meteor.publish('songs', function() {
#   return Songs.find({}, {fields: {'artist': 1, 'title': 1}});
# });

Meteor.publish 'messages', ->
  Messages.find({})
