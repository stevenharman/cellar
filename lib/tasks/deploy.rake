namespace :deploy do

  desc "deploys to Production Heroku environment"
  task :production do
    puts `git push heroku master`
    puts `heroku run rake db:migrate --app brewdega-cellar`
    puts `heroku restart --app brewdega-cellar`
  end

  desc "deploys to Staging after uploading assets to S3"
  task :staging do
    puts `git push staging staging:master`
    puts `heroku run rake db:migrate --app brewdega-cellar-staging`
    puts `heroku restart --app brewdega-cellar-staging`
  end

end

