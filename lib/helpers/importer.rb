require 'csv'

class Importer

  def initialize
    @models = [Customer, Merchant, Invoice, Transaction, Item, InvoiceItem]
  end

  def import(path, model)
    csv_text = File.read("#{path}#{model.to_s.underscore}s.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      model.create(row.to_hash)
    end
  end

  def destroy_records(model)
      model.destroy_all
  end

  def reset_pk_sequences
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
  end

  def reset_all_tables(path, print = false)
    @models.reverse.each do |model|
      print "Destroying #{model} records... " if print
      destroy_records(model)
      puts "DONE" if print
    end
    @models.each do |model|
      print "Importing #{model} records... " if print
      import(path, model)
      puts "DONE" if print
    end
    reset_pk_sequences
    puts "PK sequences reset." if print
    puts "Reseed complete!" if print
  end

end
