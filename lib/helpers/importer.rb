require 'csv'

class Importer

  def initialize
    @models = [Customer, Merchant, Item, Invoice, InvoiceItem, Transaction]
  end

  def import(path, model, print)
    print "Importing #{model} records... " if print
    csv_text = File.read("#{path}#{model.to_s.underscore}s.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      model.create(row.to_hash)
    end
    puts "DONE" if print
  end

  def destroy_all_records(print)
    @models.reverse.each do |model|
      print "Destroying #{model} records... " if print
      model.destroy_all
      puts "DONE" if print
    end
  end

  def reset_pk_sequences(print)
    ActiveRecord::Base.connection.tables.each do |t|
      ActiveRecord::Base.connection.reset_pk_sequence!(t)
    end
    puts "PK sequences reset." if print
  end

  def reset_all_tables(path, print = false)
    destroy_all_records(print)
    @models.each { |model| import(path, model, print) }
    reset_pk_sequences(print)
    puts "Reseed complete!" if print
  end

end
