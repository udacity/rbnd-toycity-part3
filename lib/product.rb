#require_relative 'errors'

class Product
  attr_reader :title
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
  # to false in ternary ...
  def product_exists?
    @@products.index {|x| x.title == self.title } ? true : false
  end
end