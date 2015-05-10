@Genres = new Mongo.Collection('genres')

Meteor.methods
  addGenre: (name) ->
    if not Meteor.userId()
      throw new Meteor.Error('not-authorized')
    Genres.insert
      name: name
      votes: 0
  addVote: (name, inc=1) ->
    Genres.update({name: name}, {$inc: {votes: inc}})
  clearVotes: ->
    Genres.update({}, {$set: {votes: 0}}, {multi: true})