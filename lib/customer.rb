require 'terminal-table'

# this class supports basic methods to support customer transactions
# and history.
class Customer
  @@customers = []

  attr_reader :name, :transactions

  def initialize(options={})
    @transactions = []
    @name         = options[:name]
    add_customer
  end

  def self.all
    @@customers
  end

  def self.find_by_name(name)
    @@customers.find { |x| x.name == name }
  end

  def add_customer
    begin
      raise DuplicateCustomerError if customer_exists?
    rescue DuplicateCustomerError => e
      puts "#{e.message}: #{name} already exists."
      return
    end
    @@customers << self
  end

  def customer_exists?
    @@customers.index { |x| x.name == name } ? true : false
  end

  def purchase(product)
    @transactions << Transaction.new(self, product)
    @transactions.last
  end

  def order_history
    table = Terminal::Table.new do |r|
      @transactions.each do |t|
        row = ["#{t.id.to_s}", "#{t.product.title}", "#{t.product.price}"]
        r << row
      end
    end

    table.title    = "#{self.name}'s Orders"
    table.headings = ['Order ID', 'Product', 'Price']
    puts table
  end

end