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

  def transaction_history
    table = Terminal::Table.new do |r|
      @transactions.each do |t|
        row = ["#{t.id.to_s}","#{t.trans_type}","#{t.status}","#{t.product.title}", "#{t.product.price}","#{t.trans_amt.to_s}"]
        r << row
      end
    end

    table.title    = "#{@name}'s Transactions"
    table.headings = ['Order ID','Trans Type','Status','Product','Price','Transaction Amount']
    puts table
  end

  def return_item(title)
    begin
      transaction = @transactions.find { |trans| trans.product.title == title}
      raise ProductNotFoundError if transaction.nil?
    rescue ProductNotFoundError => e
      puts "#{title} not found in customer transactions. (#{e.message})"
      return
    end
    @transactions << Transaction.new(self,transaction.product,{type: :prod_return})
  end

end