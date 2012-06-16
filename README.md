# Cellar at [Brewdega](http://brewdega.com)

## Developing

You'll need the following dependencies installed:

- PostgreSQL (for [light-weight searching][texticle]): `brew install
  postgress`. Check this if you need a hand getting [PostgreSQL installed on OS
  X][postgres-setup].


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

[README Driven Development][RDD]. Do it!


[texticle]: http://tenderlove.github.com/texticle/
[postgres-setup]: http://blog.willj.net/2011/05/31/setting-up-postgresql-for-ruby-on-rails-development-on-os-x/
[thoughtbot-css]: http://robots.thoughtbot.com/post/25098505945/style-sheet-swag-architecting-your-applications-styles "Style Sheet Swag: architecting your applications styles"
[RDD]: http://tom.preston-werner.com/2010/08/23/readme-driven-development.html
