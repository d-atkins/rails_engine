require 'csv'

namespace :csv do
  desc 'Seeds table from CSV to database'
  task :import, [:model_name] => [:environment] do |t, args|
    csv_text = File.read("./db/csv_seeds/#{args[:model_name]}s.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      args[:model_name].camelize.constantize.create(row.to_hash)
    end
    puts args[:model_name].camelize + " imported."
  end
end

desc 'Destroys all records'
task destroy_all_records: :enviroment do
  models = ['customer', 'merchant', 'item', 'invoice', 'invoice_item', 'transaction']
  models.reverse.each do |model|
    model.camelize.constantize.destroy_all
    puts model.camelize + " records destroyed."
  end
end

desc 'Resets all primary key sequences'
task reset_pk_sequences: :environment do
  ActiveRecord::Base.connection.tables.each do |t|
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
  end
  puts "PK sequences reset."
end

desc 'Reseeds all tables'
task reseed: :environment do
  Rake::Task['destroy_all_records'].execute
  models = ['customer', 'merchant', 'item', 'invoice', 'invoice_item', 'transaction']
  models.each do |model|
    Rake::Task['csv:import'].invoke(model)
    Rake::Task['csv:import'].reenable
  end
  Rake::Task['reset_pk_sequences'].execute
  puts "Reseed complete!"
end
