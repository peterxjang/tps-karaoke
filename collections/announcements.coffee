@Announcements = new Mongo.Collection('announcements')

Meteor.methods
  createAnnouncement: (text) ->
    if (!Meteor.userId())
      throw new Meteor.Error('not-authorized', 'You must be logged in!')
    Announcements.insert
      text: text
      createdAt: new Date()
  updateAnnouncement: (id, text) ->
    Announcements.update(id, {$set: {text: text}})
  deleteAnnouncement: (id) ->
    Announcements.remove(id)
