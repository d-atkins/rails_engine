require 'csv'

class Importer

  def initialize
    @models = [Customer, Merchant, Item, Invoice, InvoiceItem, Transaction]
  end

  def import(path, model)
    print "Importing #{model} records... "
    csv_text = File.read("#{path}#{model.to_s.underscore}s.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      model.create(row.to_hash)
    end
    puts "DONE"
  end

  def destroy_all_records
    @models.reverse.each do |model|
      print "Destroying #{model} records... "
      model.destroy_all
      puts "DONE"
    end
  end

  def reset_pk_sequences
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    puts "PK sequences reset."
  end

  def reset_all_tables(path)
    destroy_all_records
    @models.each { |model| import(path, model) }
    reset_pk_sequences
    puts "Reseed complete!"
  end

end
