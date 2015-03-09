# Cellar at [Brewdega](http://cellar.brewdega.com)

[![Build Status](https://img.shields.io/travis/stevenharman/cellar.svg)](https://travis-ci.org/stevenharman/cellar)
[![Code Climate](http://img.shields.io/codeclimate/github/stevenharman/cellar.svg)](https://codeclimate.com/github/stevenharman/cellar)
[![Code Coverage](http://img.shields.io/codeclimate/coverage/github/stevenharman/cellar.svg)](https://codeclimate.com/github/stevenharman/cellar)
[![Dependency Status](https://img.shields.io/gemnasium/stevenharman/cellar.svg)](https://gemnasium.com/stevenharman/cellar)

## Development

### Getting up and Running

Because installing dependencies is such a pain, we've bootstrapped this baby
for you! Just run

```bash
bin/bootstrap
```

being sure to follow any instructions it gives you. After you've done that you
should have `PostgreSQL`, `Redis`, and the `Heroku Toolbelt` installed and
ready to go.

#### ENV Vars

You can set some _optional_ [ENV Vars][env-vars] to tweak the way the app runs,
or simulate the app running on other platforms. In development and test, you
should configure these via a [`.env` file][dotenv].

  - `AWS_ACCESS_KEY_ID`: Amazon AWS Access Key. _(No default)_
  - `AWS_SECRET_ACCESS_KEY`: Amazon AWS Secret Access Key. _(No default)_
  - `BREWERY_DB_API_KEY`: key to use to connect to [BreweryDB.com][brewerydb].
    _(No default)_
  - `DATABASE_REAP_FREQ`: how often (in seconds) the database connection pool
    should be reaped. _(Default = `10`)_
  - `DATABASE_URL`: set to mimic the behavior of setting the database
    connection on Heroku. _(Default to using `config/database.yml`)_
  - `REDISTOGO_URL`: Redis database to use. _(Default = localhost)_
  - `WORKER_CONCURRENCY`: set the number of [Sidekiq][sidekiq] worker
    processors to run.  _(Default = 25)_
  - `WORKER_DB_POOL_SIZE`: set the size of the [Sidekiq][sidekiq] ActiveRecord
    connection pool. _(Default = `WORKER_CONCURRENCY`)_
  - `WEB_CONCURRENCY`: set the number of [Puma][puma] threads. _(Default =
    `16`)_
  - `WEB_DB_POOL_SIZE`: set the size of the ActiveRecord connection pool for
    the web server. _(Default = `WEB_CONCURRENCY`)_

### Updating the app

  1.  Update any RubyGem dependencies:

      ```bash
      bundle
      ```
  1.  Update the database schema:

      ```bash
      bin/rake db:migrate test:prepare
      ```
  1.  _(Optional)_ Update your brewery/brew data from
      [BreweryDB.com][brewerydb]:

      ``` bash
      bin/rake brewery_db:import
      ```

      Alternatively, you could pull in the latest production data, as
      [mentioned below](#development-data).

### Running the app

We use [Foreman][foreman] to declare and run/stop all of the processes we use.
This includes our Rails web server, a background worker (via
[Sidekiq][sidekiq]), and the Redis server. To fire everything up just run the
following from terminal:

```bash
foreman start
```

You can shut everything down by hitting `^C` _(that's `Control` + `C`)_.

#### Email

In development mode we use [MailCatcher][mailcatcher] to capture all emails
sent from the app. You can access the MailCatcher UI from
<http://localhost:1080>.

#### Development data

You can pull down a copy of production data by running

```bash
bin/import
```

### Running the tests

It really is this easy:

```bash
# make sure your database is up to date:
bin/rake db:test:prepare

# run the full spec suite:
bin/rspec
```

### CSS Structure

Generally we follow [Scalable and Modular Architecture for CSS
(SMACSS)][smacss] for structuring our CSS. We also rely on [Bourbon][bourbon]
and [Bourbon Neat][bourbon-neat] as a [Sass][sass] mixin library and sensible
grid system, respectively.

It is recommended to check out the references listed below to learn more about
SMACSS, Bourbon, etc.

The **TL;DR** is:

  * All global settings and custom mixins belong under the
    `globals/` directory as Sass partials.
  * The base styling of various `HTML` elements is defined in `base.css.scss`,
    which is included as part of the `application.css.scss`
  * Re-usable modules go in `modules/` directory and are full Sass sheets (not
    partials).
    * Modules should `@import '../globals/all'` to get access to variables,
      mixins, etc.
    * Modules in this directory are automagically included in the compiled CSS
      for the whole site.
  * The `application.css.scss` has an **Inbox** and a **Shame** section. Use
    them for fly-by commits, or things your not proud of, respectively. (See
    each section for a better description.)
  * We are trying to avoid page-specific styling, instead preferring to think
    in terms of modules. So, try the module approach... please.

#### Style Guide

We also have a style guide available right in the app. After [starting the
app](#running-the-app), go to
[http://localhost:5000/staff/style_guide](http://localhost:5000/staff/style_guide).
You'll need to be a marked as "staff" to see anything in the `staff/` route.
You can make yourself staff via Rails console:

```ruby
me = User.find_by_username('my_username_here'); me.staff = true; me.save!
```

#### Resources for reference and learning:

  * [SMACSS and Rails: a Styleguide for the Asset Pipeline](http://blog.55minutes.com/2013/01/smacss-and-rails/)
  * [SMACSS website][smacss]
  * [SMACSS intro videos](http://tv.adobe.com/search/?q=smacss)
  * [Bourbon Documentation](http://bourbon.io/docs/)
  * [Bourbon Neat Documentation](http://neat.bourbon.io/docs/)
  * [Bourbon Neat Examples](http://neat.bourbon.io/examples/)
  * [Sass website][sass] also has pretty decent docs, and _a whole lot of useful functions_

## What's missing?

[README Driven Development][rdd]. Do it!

## License

See the [LICENSE file](LICENSE.md).


[bourbon-neat]: http://neat.bourbon.io/ "A lightweight semantic grid framework for Sass and Bourbon"
[bourbon]: http://bourbon.io/ "A simple and lightweight mixin library for Sass"
[brewerydb]: http://brewerydb.com/ "BreweryDB is your database of breweries, beers, beer events and guilds!"
[dotenv]: https://github.com/bkeepers/dotenv "Loads environment variables from `.env`"
[env-vars]: https://devcenter.heroku.com/articles/config-vars "Configuration and Config Vars"
[foreman]: https://devcenter.heroku.com/articles/procfile/
[mailcatcher]: http://mailcatcher.me/ "Catches mail and serves it through a dream."
[puma]: http://puma.io/ "A modern, concurrent web server for Ruby"
[rdd]: http://tom.preston-werner.com/2010/08/23/readme-driven-development.html
[sass]: http://sass-lang.com/ "Syntactically Awesome Style Sheets"
[sidekiq]: https://github.com/mperham/sidekiq
[smacss]: http://smacss.com/ "Scalable and Modular Architecture for CSS"
[texticle]: https://tenderlove.github.com/texticle/
