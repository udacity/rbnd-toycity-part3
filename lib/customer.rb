

class Customer
  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    add_to_customers
    #find_by_name
  end

  def self.all
    @@customers
  end

  def purchase
  	puts 333
  end

#  def find_by_name
#	@@customers.each do |cust|
#		puts cust.name
#	end
 # end

   def self.find_by_name(name)
	@@customers.each do |cust|
	 if cust.name == name
	 	return cust
	 end
    end
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