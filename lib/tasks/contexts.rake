namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :contexts => :environment do
    # Drop the old db and recreate from scratch
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    # Invoke rake db:migrate to set up db structure based on latest migrations
    Rake::Task['db:migrate'].invoke
    # Set up test database with that same structure
    Rake::Task['db:test:prepare'].invoke

    # Now go get the contexts and run the build all method
    require 'factory_bot_rails'
    require './test/contexts'
    include Contexts
    create_all
    
  end
end
