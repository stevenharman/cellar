# pre-load all of the Jobs
Dir[File.join(Rails.root, %w[app models supply_chain job *])].each { |f| require f }
