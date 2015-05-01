@Songs = new Mongo.Collection('songs');

Meteor.methods
  'getStaticSongs': ->
    Songs.find({}, {fields: {'artist': 1, 'title': 1}}).fetch()
