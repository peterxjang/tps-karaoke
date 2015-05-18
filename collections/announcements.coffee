@Announcements = new Mongo.Collection('announcements')

Meteor.methods
  addAnnouncement: (text) ->
    if (!Meteor.userId())
      throw new Meteor.Error('not-authorized', 'You must be logged in!')
    Announcements.insert
      text: text
      createdAt: new Date()
