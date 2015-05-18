Template.announcements.helpers
  announcements: ->
    announcements = Announcements.find({}, sort: {createdAt: -1})
    announcements.map (announcement) ->
      text: announcement.text
      createdAt: moment(announcement.createdAt).fromNow()
  isAdmin: ->
    Meteor.user()?.profile?.isAdmin

Template.announcements.events
  'click #add-announcement': (event) ->
    console.log 'hi'
    # text = $('textarea').val()
    text = $('#new-announcement').html()
    Meteor.call 'addAnnouncement', text

Template.announcements.rendered = ->
  editor = new MediumEditor('.editable',
    {
      placeholder: 'Enter an announcement'
      buttons: ['bold', 'italic', 'underline', 'anchor', 'unorderedlist', 'orderedlist', 'header1', 'header2'],
      targetBlank: true
    }
  )
