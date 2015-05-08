@Songs = new Mongo.Collection('songs')
@Songs.allow
  insert: -> true

Meteor.methods
  getStaticSongs: ->
    Songs.find({}, {fields: {'artist': 1, 'title': 1}}).fetch()
  addSongs: (songs) ->
    if (!Meteor.userId())
      throw new Meteor.Error('not-authorized')
    x = ({artist: song.artist, title: song.title, createdAt: new Date()} for song in songs)
    Songs.batchInsert(x)