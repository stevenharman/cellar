namespace :deploy do

  desc 'deploys to Production Heroku environment'
  task :production do
    puts `git push heroku master`
    puts `heroku pgbackups:capture --expire -a brewdega-cellar`
    puts `heroku run rake db:migrate -a brewdega-cellar`
    puts `heroku restart -a brewdega-cellar`
    puts `curl http://cellar.brewdega.com > /dev/null 2> /dev/null`
  end

  desc 'deploys to Staging Heroku environment'
  task :staging do
    puts `git push staging staging:master`
    puts `heroku run rake db:migrate --app brewdega-cellar-staging`
    puts `heroku restart --app brewdega-cellar-staging`
  end

end

