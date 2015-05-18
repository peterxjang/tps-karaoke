Template.announcements.helpers
  announcements: ->
    announcements = Announcements.find({}, sort: {createdAt: -1})
    announcements.map (announcement) ->
      _id: announcement._id
      text: announcement.text
      createdAt: moment(announcement.createdAt).fromNow()
  isAdmin: ->
    Meteor.user()?.profile?.isAdmin

Template.announcements.events
  'click #create-announcement': (event) ->
    text = $('#new-announcement').html()
    Meteor.call 'createAnnouncement', text
  'click .update-announcement': (event) ->
    text = $(event.target).parent().parent().find('.text.editable').html()
    Meteor.call 'updateAnnouncement', this._id, text
  'click .delete-announcement': (event) ->
    Meteor.call 'deleteAnnouncement', this._id

Template.announcements.rendered = ->
  editor = new MediumEditor '.editable',
      placeholder: 'Enter an announcement'
      buttons: ['bold', 'italic', 'underline', 'anchor', 'unorderedlist', 'orderedlist', 'header1', 'header2'],
      targetBlank: true
