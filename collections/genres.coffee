@Genres = new Mongo.Collection('genres')
@IpAddresses = new Mongo.Collection('ipAddresses')

Meteor.methods
  addGenre: (name) ->
    if not Meteor.userId()
      throw new Meteor.Error('not-authorized')
    Genres.insert
      name: name
      votes: 0
  addVote: (name) ->
    if Meteor.isServer
      startOfDay = new Date
      startOfDay.setHours(0, 0, 0, 0)
      ip = this.connection.clientAddress
      if IpAddresses.findOne({ip: ip, date: startOfDay})
        throw new Meteor.Error(403, 'You already voted!')
      else
        Genres.update({name: name}, {$inc: {votes: 1}})
        IpAddresses.insert({ip: ip, date: startOfDay})
  clearVotes: ->
    Genres.update({}, {$set: {votes: 0}}, {multi: true})