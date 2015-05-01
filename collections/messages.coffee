@Messages = new Mongo.Collection('messages')

Meteor.methods
  addMessage: (text) ->
    if (!Meteor.userId())
      throw new Meteor.Error('not-authorized', 'You must be logged in!');
    Messages.insert
      text: text
      createdAt: new Date()
      owner: Meteor.userId()
      username: Meteor.user().username
