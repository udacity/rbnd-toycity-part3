# a class that allows managing products in the store
# for a basic product management
class Product
  attr_reader :title, :price, :stock
  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    add_to_products
	rescue DuplicateProductError => e
		puts "#{e.message}: '#{@title}' already exists."
	rescue Exception => e
		puts "#{e.message}"
		raise e
  end

  def self.all
    @@products
  end

  def self.find_by_title(title)
    @@products.find { |product| product.title == title }
  end

  def self.in_stock
    in_stock = []
    @@products.each do |product|
      in_stock << product if product.in_stock?
    end
    in_stock
  end

  def add_to_products
		raise DuplicateProductError if product_exists?
    @@products << self
  end

  # this should always work because index returns nil if not found which evaluates
  # to false in ternary ... plus this is an instance method not a class method
  def product_exists?
    @@products.index { |product| product.title == @title } ? true : false
  end

  def in_stock?
    @stock > 0 ? true : false
  end

  def sell_to_customer
		raise OutOfStockError unless in_stock?
		decrement_stock
  end

  def return_to_store
		raise ProductNotFoundError unless product_exists?
    increment_stock
  end

  private

  def decrement_stock
    @stock -= 1
  end

  def increment_stock
    @stock += 1
  end
end
