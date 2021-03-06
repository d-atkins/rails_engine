require 'csv'
require './lib/helpers/importer'

namespace :csv do
  desc 'Reseeds all tables'
  task reseed: :environment do
    importer = Importer.new
    importer.reset_all_tables('./db/csv_seeds/', true)
  end
end

desc 'Resets all primary key sequences'
task reset_pk_sequences: :environment do
  importer = Importer.new
  importer.reset_pk_sequences
  puts "PK sequences reset."
end
