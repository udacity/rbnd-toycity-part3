
class Product
  attr_reader :title, :price, :stock

  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
	@@products.each do |prod|
	 if prod.title == title
	 	return prod
	 end
    end
   end

   def in_stock?
   	@stock > 0
   end

   def self.in_stock
   	stock_array = []
   	@@products.each do |prod|
   		if prod.stock != 0
   			stock_array.push(prod)
		end
	end
	return stock_array
   end

   def reduce_stock
   	@stock -= 1
   end

   def low_stock_warning

	   if @stock < 10
	   	"Low Stock!"
	   end

   end

  private

  def add_to_products
  	isDuplicate=0
  	counter = 0
    @@products.each do |prod|
    	if @title == prod.title
    		raise DuplicateProductError, "#{@title} already exists"
		end
    	counter += 1
  	end
    @@products << self
  end
end

