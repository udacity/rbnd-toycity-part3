class Formatter
  def self.format_dollars(amount)
    amt = format('%.2f', amount)
    amt
  end
end

# customer transactions are managed in this class
class Transaction
  attr_reader :customer, :product, :id, :trans_type, :status, :trans_amt
  @@id_count     = 0
  @@transactions = []

  # note that we are capturing all transactions including
  # those that failed. using that info the store can analyse
  # potential system problems (eg out of stock item problems,
  # or even a case where an item isn't out of stock but is
  # failing with an 'OutOfStockError' anyway).
  def initialize(customer, product, opts = {})
    @@id_count += 1
    @customer  = customer
    @product   = product
    @id        = @@id_count
    @trans_amt = Formatter.format_dollars(0.00)
    if opts[:type] == :prod_return
      begin
        @trans_type = :prod_return
        return_product
        @status = :successful
        @trans_amt = Formatter.format_dollars(@product.price)
        @trans_amt.prepend("-")
      rescue StandardError => e
        @status = e.message
      end
    else
      begin
        @trans_type = :purchase
        buy_product
        @status = :successful
        @trans_amt = Formatter.format_dollars(@product.price)
      rescue StandardError => e
        @status = e.message
      end
    end
    @@transactions << self
  end

  def self.all
    @@transactions
  end

  def self.find(index)
    return nil if index <= 0
    @@transactions[index - 1]
  end

  private

  def buy_product
    begin
      raise OutOfStockError unless product.in_stock?
    rescue OutOfStockError => e
      puts "#{e.message}: '#{@product.title}' is out of stock."
      raise e
    end
    @product.sell_to_customer
  end

  def return_product
    @product.return_to_store
  end

end