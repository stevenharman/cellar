# Cellar at [Brewdega](http://brewdega.com)

## Development

### Getting up and Running

You'll need the following dependencies installed:

#### PostgreSQL (for [light-weight searching][texticle])
  1.  Download, install, and run [Postgres.app][postgres.app]
  1.  If you've already installed the `pg` gem (we do this
      to ensure we've built against the right version of PostgreSQL):

      ```bash
      gem uninstall pg
      ```
  1.  Install the `pg` gem:

      ```bash
      bundle install
      ```
  1.  Setup the database:

      ```bash
      bundle exec rake db:create db:schema:load
      ```

**NOTE:** Be sure to open the Postgres.app app to start your PostgreSQL server.
Quitting the app will also stop the server.

#### Redis (for [background jobs][sidekiq])
  1.  `brew install redis`
  1.  _That's it!_ We start a redis server via `foreman`.

#### ENV Vars

You'll need a few environment variables set in order to start all of the
processes. From terminal:

```bash
echo "SIDEKIQ_CONCURRENCY=25" > .env
```

Other _optional_ ENV Vars you can set include:

  - `BREWERY_DB_API_KEY`: key to use to connect to BreweryDB.com. _(Default to
    our dev key)_
  - `DATABASE_POOL_SIZE`: set the size of the Sidekiq ActiveRecord connection
    pool. _(Default = `SIDEKIQ_CONCURRENCY`)_
  - `DATABASE_REAP_FREQ`: how often (in seconds) the database connection pool
    should be reaped. _(Default = `10`)_
  - `DATABASE_URL`: set to mimic the behavior of setting the database
    connection on Heroku. _(Default to using `config/database.yml`)_
  - `REDISTOGO_URL`: Redis database to use. _(Default to localhost)_
  - `UNICORN_BACKLOG`: [tune Unicorn, making Herkou retry other
    dynos](ttm-unicorn) rather than timing out. _(Default = `200`)_
  - `WEB_CONCURRENCY`: set the number of [Unicorn](unicorn) worker processes.
    _(Defaults = `3`)_

### Updating the app

  1.  Update any RubyGem dependencies:

      ```bash
      bundle
      ```
  1.  Update the database schema:

      ```bash
      bundle exec rake db:migrate test:prepare
      ```
  1.  _(Optional)_ Update your brewery/brew data from BreweryDB.com:

      ``` bash
      bundle exec rake brewery_db:import
      ```

### Running the app

We use [Foreman][foreman] to declare and run/stop all of the processes we use.
This includes our Rails web server, a background worker (via
[Sidekiq][sidekiq]), and the Redis server. To fire everything up just run the
following from terminal:

```bash
foreman start
```

You can shut everything down by hitting `^C` _(that's `Control` + `C`)_.

#### Development data

You can pull down a copy of production data by running

```bash
bin/import
```

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

## What's missing?

[README Driven Development][rdd]. Do it!


[foreman]: https://devcenter.heroku.com/articles/procfile/
[postgres.app]: http://postgresapp.com/
[rdd]: http://tom.preston-werner.com/2010/08/23/readme-driven-development.html
[sidekiq]: https://github.com/mperham/sidekiq
[texticle]: https://tenderlove.github.com/texticle/
[thoughtbot-css]: http://robots.thoughtbot.com/post/25098505945/style-sheet-swag-architecting-your-applications-styles "Style Sheet Swag: architecting your applications styles"
[ttm-unicorn]: http://devblog.thinkthroughmath.com/blog/2013/02/27/managing-request-queuing-with-rails-on-heroku/
[unicorn]: http://unicorn.bogomips.org/
