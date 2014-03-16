namespace :deploy do

  desc 'deploys to Production Heroku environment'
  task :production do
    Bundler.clean_system 'heroku pgbackups:capture DATABASE_URL --expire -a brewdega-cellar'
    puts `git push production master`
    Bundler.clean_system 'heroku run rake db:migrate -a brewdega-cellar'
    Bundler.clean_system 'heroku restart -a brewdega-cellar'
    puts '==> Ping the app to spin up dynos. <=='
    puts `curl http://cellar.brewdega.com > /dev/null 2> /dev/null`
  end

  desc 'deploys to Staging Heroku environment'
  task :staging do
    puts `git push staging staging:master`
    Bundler.clean_system 'heroku run rake db:migrate -a brewdega-cellar-staging'
    Bundler.clean_system 'heroku restart -a brewdega-cellar-staging'
    puts '==> Ping the app to spin up dynos. <=='
    puts `curl http://cellar-staging.brewdega.com > /dev/null 2> /dev/null`
  end

end

