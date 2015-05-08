@Songs = new Mongo.Collection('songs')
@Songs.allow
  insert: -> true


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
    # ids = (Songs.insert artist: song.artist, title: song.title, createdAt: new Date() for song in songs)
    # return ids
    # return if Meteor.isClient
    # x = ({artist: song.artist, title: song.title, createdAt: new Date()} for song in songs)
    # console.log x
    # console.log bulkCollectionUpdate
    # bulkCollectionUpdate(Songs, x, {callback: -> console.log 'complete'})
    # return x
    x = ({artist: song.artist, title: song.title, createdAt: new Date()} for song in songs)
    Songs.batchInsert(x)