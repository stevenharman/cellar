# Cellar at [Brewdega](http://brewdega.com)

## Developing

You'll need the following dependencies installed:

#### PostgreSQL (for [light-weight searching][texticle])
  1. `brew install postgres` (Pay attention to instructions for
     starting/stopping PostgreSQL)
  1. `brew doctor` (This may tell you to fix your `PATH`, so do that.)
  1. If you've already installed the `pg` gem: `gem uninstall pg` (we do this
     to ensure we've built against the right version of PostgreSQL)
  1. Install the `pg` gem: `bundle install`
  1. `bundle exec rake db:create db:schema:load`

#### Redis (for [background jobs][sidekiq])
  1. `brew install redis`
  1. _That's it!_ We start a redis server via `foreman`.

### Running

We use [Foreman][foreman] to declare and run/stop all of the processes we use.
This includes our Rails web server, a background worker (via
[Sidekiq][sidekiq]), and the Redis server. To fire everything up just run the
following from terminal:

```bash
$ foreman start
```

You can shut everything down by hitting `^C` _(that's `Control` + `C`)_.

### CSS Structure

Generally we follow the structure outlined by [thoughtbot][thoughtbot-css].

  * Page-specific styles should be organized by the controller and action (i.e.
    `<controller>/_<action>.scss`) the same way the rails views are organized.
  * Base variables, mixins, and default styles go in `base/_variables.scss`,
    `base/_mixins.scss`, `base/_defaults.scss`, etc.
  * Shared components go in `shared/_header.scss`, `shared/_footer.scss`,
    `shared/_navbar.scss`, etc.

Please read the above-mentioned article from thoughtbot for more explaination
of this convention.

### Development data

If you want some sample data, `rake openbeerdb:import`. Temporary, but it is
useful.

## What's missing?

[README Driven Development][rdd]. Do it!


[foreman]: https://devcenter.heroku.com/articles/procfile/
[postgres-setup]: http://blog.willj.net/2011/05/31/setting-up-postgresql-for-ruby-on-rails-development-on-os-x/
[rdd]: http://tom.preston-werner.com/2010/08/23/readme-driven-development.html
[sidekiq]: https://github.com/mperham/sidekiq
[texticle]: https://tenderlove.github.com/texticle/
[thoughtbot-css]: http://robots.thoughtbot.com/post/25098505945/style-sheet-swag-architecting-your-applications-styles "Style Sheet Swag: architecting your applications styles"
