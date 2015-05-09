Router.configure
  layoutTemplate: 'layout'
  # loadingTemplate: 'loading',
  # notFoundTemplate: 'pageNotFound',
  # yieldTemplates: {
      # nav: {to: 'nav'},
      # footer: {to: 'footer'},
  # }

isAdmin = ->
  Meteor.user()?.profile?.facebookEmail is 'peter.jang@yahoo.com'

Router.route(
  '/',
  () -> 
    @render('home')
  , {name: 'home'}
)

Router.route(
  '/admin', 
  -> 
    @render('admin')
  , {name: 'admin'}
)

Router.onBeforeAction(
  ->
    if (isAdmin())
      @redirect('admin')
    else
      @next()
  ,
  {only: ['home']}
)

Router.onBeforeAction(
  ->
    if (isAdmin())
      @next();
    else
      @redirect('home');
  ,
  {only: ['admin']}
)
