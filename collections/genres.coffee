@Genres = new Mongo.Collection('genres')

Meteor.methods
  addGenre: (name) ->
    if not Meteor.userId()
      throw new Meteor.Error('not-authorized')
    Genres.insert
      name: name
      votes: 0