

class Customer
  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    add_to_customers
  end

  def self.all
    @@customers
  end

  def find_by_name(input_name)


  end


  private

  def add_to_customers
  	isDuplicate=0
  	counter = 0
    @@customers.each do |cust|
    	if @name == cust.name
    		raise DuplicateCustomerError, "#{@name} already exists"
		end
    	counter += 1
  	end

  	@@customers << self
  end

end