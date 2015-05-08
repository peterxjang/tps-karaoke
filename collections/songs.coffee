@Songs = new Mongo.Collection('songs')

Meteor.methods
  getStaticSongs: ->
    Songs.find({}, {fields: {'artist': 1, 'title': 1}}).fetch()
  addSong: (artist, title) ->
    if (!Meteor.userId())
      throw new Meteor.Error('not-authorized')
    this.unblock() if Meteor.isServer
    # Songs.insert {artist: artist, title: title, createdAt: new Date()}, (err, result) -> 
    #   console.log result
    #   console.log 'yo' if Meteor.isClient
    Songs.insert
      artist: artist
      title: title
      createdAt: new Date()
  addSongs: (songs) ->
    if (!Meteor.userId())
      throw new Meteor.Error('not-authorized')
    ids = (Songs.insert artist: song.artist, title: song.title, createdAt: new Date() for song in songs)
    return ids
