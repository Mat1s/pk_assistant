namespace :import do
  desc "import services from database to elasticsearch"
  task elasticsearch: :environment do
    puts "task run at #{ time = Time.now }"
    ServiceForOrganization.__elasticsearch__.refresh_index!
    ServiceForOrganization.import
    puts "task complete for #{ time - Time.now }"
  end
end