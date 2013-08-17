# Cellar at [Brewdega](http://brewdega.com)

## Development

### Getting up and Running

Because installing dependencies is such a pain, we've bootstrapped this baby for you! Just run

```bash
bin/bootstrap
```

being sure to follow any instructions it gives you. After you've done that you
should have `PostgreSQL`, `Redis`, and the `Heroku Toolbelt` installed and
ready to go.

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
  - `WEB_CONCURRENCY`: set the number of [Puma](puma) threads. _(Default =
    `16`)_

### Updating the app

  1.  Update any RubyGem dependencies:

      ```bash
      bundle
      ```
  1.  Update the database schema:

      ```bash
      bin/rake db:migrate test:prepare
      ```
  1.  _(Optional)_ Update your brewery/brew data from BreweryDB.com:

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

### Running the tests

It really is this easy:

```bash
# make sure your database is up to date:
bin/rake db:test:prepare

# run the full spec suite:
bin/rspec
```

#### Development data

You can pull down a copy of production data by running

```bash
bin/import
```

### CSS Structure

Generally we follow [Scalable and Modular Architecture for CSS
(SMACSS)](smacss) for structuring our CSS. We also rely on [Bourbon](bourbon)
and [Bourbon Neat](bourbon-neat) as a [Sass](sass) mixin library and sensible
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

  * [SMACSS and Rails: a Styleguide for the Asset
    Pipeline](http://blog.55minutes.com/2013/01/smacss-and-rails/)
  * [SMACSS website](smacss)
  * [SMACSS intro videos](http://tv.adobe.com/search/?q=smacss)
  * [Bourbon Documentation](http://bourbon.io/docs/)
  * [Bourbon Neat Documentation](http://neat.bourbon.io/docs/)
  * [Bourbon Neat Examples](http://neat.bourbon.io/examples/)
  * [Sass website](sass) also has pretty decent docs, and _a whole lot of useful functions_

## What's missing?

[README Driven Development][rdd]. Do it!


[bourbon-neat]: http://neat.bourbon.io/ "A lightweight semantic grid framework for Sass and Bourbon"
[bourbon]: http://bourbon.io/ "A simple and lightweight mixin library for Sass"
[foreman]: https://devcenter.heroku.com/articles/procfile/
[puma]: http://puma.io/
[rdd]: http://tom.preston-werner.com/2010/08/23/readme-driven-development.html
[sass]: http://sass-lang.com/ "Syntactically Awesome Style Sheets"
[sidekiq]: https://github.com/mperham/sidekiq
[smacss]: http://smacss.com/ "Scalable and Modular Architecture for CSS"
[texticle]: https://tenderlove.github.com/texticle/
