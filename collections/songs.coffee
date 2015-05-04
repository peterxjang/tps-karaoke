@Songs = new Mongo.Collection('songs');

Meteor.methods
  getStaticSongs: ->
    Songs.find({}, {fields: {'artist': 1, 'title': 1}}).fetch()
  addSong: (artist, title) ->
    console.log 'adding a song'
    if (!Meteor.userId())
      throw new Meteor.Error('not-authorized')
    Songs.insert
      artist: artist
      title: title
      createdAt: new Date()
