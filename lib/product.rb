#require_relative 'errors'

class Product
  attr_reader :title,:price,:stock
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
		@@products.find { |x| x.title == title }
	end

	def self.in_stock
		in_stock = []
		@@products.each do |product|
			in_stock << product if product.in_stock?
		end
		in_stock
	end

  def add_to_products
    begin
      raise DuplicateProductError if product_exists?
    rescue DuplicateProductError => e
      puts "#{self.title} already exists. (#{e.message})"
      return
    end
    @@products << self
  end

  # this should always work because index returns nil if not found which evaluates
  # to false in ternary ... plus this is an instance method not a class method
  def product_exists?
    @@products.index { |x| x.title == self.title } ? true : false
	end

	def in_stock?
		@stock > 0 ? true : false
	end
end
