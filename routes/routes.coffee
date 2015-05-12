Router.configure
  layoutTemplate: 'layout'
  # loadingTemplate: 'loading',
  # notFoundTemplate: 'pageNotFound',
  # yieldTemplates: {
      # nav: {to: 'nav'},
      # footer: {to: 'footer'},
  # }

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
    if Meteor.user()?.profile?.isAdmin
      @redirect('admin')
    else
      @next()
  ,
  {only: ['home']}
)

Router.onBeforeAction(
  ->
    if Meteor.user()?.profile?.isAdmin
      @next();
    else
      @redirect('home');
  ,
  {only: ['admin']}
)
