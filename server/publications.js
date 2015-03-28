Meteor.publish('tasks', function() {
  return Tasks.find({
    $or: [
      {private: {$ne: true}},
      {owner: this.userId}
    ]
  });
});

Meteor.publish('songs', function() {
  return Songs.find({}, {limit: 10});
});
