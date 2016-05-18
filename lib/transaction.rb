class Transaction
  attr_reader :customer, :product, :id
  @@id_count = 0
  @@transactions = []

  def initialize(customer,product)
    @@id_count += 1
    @customer = customer
    @product = product
    @id = @@id_count
    buy_product
    @@transactions << self
  end

  def self.all
    @@transactions
  end

  def self.find(index)
    return nil if index <= 0
    @@transactions[index-1]
  end

  private
  def buy_product
    begin
      raise OutOfStockError unless product.in_stock?
    rescue OutOfStockError => e
      puts e.message
      return
    end
    @product.sell_to_customer
  end

end