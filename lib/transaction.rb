

class Transaction
  attr_accessor :product, :customer, :id, :stock

  @@transactions = []

  def initialize(customer, product)
    @product = product
    @customer = customer
    @id = 0
    add_to_transactions
 	product.reduce_stock

  end

  def self.all
    @@transactions
  end

  def self.find(trans_number)
	return @@transactions[trans_number-1]
	#@@transactions.each do |trans|
	#	print "trans number"
	#	puts trans_number
	#	print "trans id"
	#	puts @@id
	#	print "trans.product: "
	#	puts trans.product.title
	#	holder = trans.product
		#return holder

	 #if trans.id == trans_number
	 #	print "trans equals"
	 #	return trans.product
	 #end
    #end


   end

  private

   def add_to_transactions
  	isDuplicate=0
  	counter = 0
    @@transactions.each do |trans|
    	#if @title == prod.title
    	#	raise DuplicateProductError, "#{@title} already exists"
		#end
    	counter += 1
  	end
  	@id += 1
    @@transactions << self
  end

end