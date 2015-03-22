Template.body.helpers({
  tasks: function() {
    if (Session.get('hideCompleted')) {
      return Tasks.find({checked: {$ne: true}}, {sort: {createdAt: -1}});
    } else {
      return Tasks.find({}, {sort: {createdAt: -1}});
    }
  },
  hideCompleted: function() {
    return Session.get('hideCompleted');
  },
  incompleteCount: function() {
    return Tasks.find({checked: {$ne: true}}).count();
  }
});

Template.body.events({
  'submit .new-task': function(event) {
    var text = event.target.text.value;
    Meteor.call('addTask', text);
    event.target.text.value = '';
    return false;
  },
  'change .hide-completed input': function(event) {
    Session.set('hideCompleted', event.target.checked);
  },
  'click #menu': function(event) {
    $('.sidebar').sidebar('toggle');
  }
});

// Accounts.ui.config({
//   passwordSignupFields: 'USERNAME_ONLY'
// });
