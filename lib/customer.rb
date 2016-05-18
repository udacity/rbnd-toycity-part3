require 'terminal-table'

class Customer
  @@customers = []

  attr_reader :name, :transactions

	def initialize(options={})
    @transactions = []
    @name = options[:name]
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
			puts "#{e.message}: #{self.name} already exists."
			return
		end
		@@customers << self
	end

	def customer_exists?
		@@customers.index { |x| x.name == self.name } ? true : false
  end

  def purchase(product)
    @transactions << Transaction.new(self,product)
    @transactions.last
  end

  def order_history
    @transactions.each do |transaction|
      print "Order Id: #"
    end
  end

end