
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

  private

  def add_to_products
  	isDuplicate=0
  	counter = 0
    @@products.each do |prod|
    	if @title == prod.title
    		puts "MATCH"
    		puts @title
    		puts prod.title
    		raise DuplicateProductError, "#{@title} already exists"
		end
    	counter += 1
  	end

    @@products << self
  end

  #add_to_products
end

