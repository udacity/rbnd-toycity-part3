class Transaction

  attr_accessor :id, :product, :customer
  @@transactions = []

  def initialize transaction(product, customer)
    @id =
    @product =
    @customer =
    add_to_transactions_list
  end

  def self.all
    @@transactions
  end

  def self.find_by_name(name)
    @@transactions.find { |customer| customer.name == name }
  end

  def find_by_name(id)
    @@transactions.find { |customer| customer.name == name }
  end

  def not_exist_in_list?
    find_by_id(id)==nil
  end






  private

  def add_to_transcations_list
    if not_exist_in_list?
      @@transactions<<self
    else
      raise DuplicateTransactionError, "'#{self.id}' already exists."
    end
  end



end
