namespace :initializing_data do
  desc "initialize database"
  task monthly: :environment do
    sh 'rails db:reset'
  end
end
