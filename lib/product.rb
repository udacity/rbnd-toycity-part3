class Product

  attr_accessor :title, :price, :stock
  attr_reader :in_stock
  @@products = []

  def initialize(options={})
    @title = options[:title]
    @price = options[:price]
    @stock = options[:stock]
    @in_stock = is_in_stock?
    add_to_products_list
  end

  def self.all
    @@products
  end

  def find_by_title(title)
    @@products.find { |product| product.title == title }
  end

  def not_exist_in_list?
    find_by_title(title)==nil
  end

  def is_in_stock?
    @stock > 0
  end


  private

  def add_to_products_list
    if not_exist_in_list?
      @@products << self
    else
      puts "already exist"
    end
  end
end
