class Transaction

  attr_accessor :id, :customer, :product
  @@transactions = []
  @@transaction_count = 0

  def initialize transaction(options={})
    @id = @@transaction_count + 1
    @product = options[:product]
    @customer = options[:customer]
    add_to_transactions_list
  end

  def self.all
    @@transactions
  end

  def self.find_by_name(name)
    @@transactions.find { |customer| customer.name == name }
  end

  def find_by_id(id)
    @@transactions.find { |transaction| transaction.id == id }
  end

  def not_exist_in_list?
    find_by_id(id)==nil
  end

  private

  def add_to_transcations_list
    @@transactions<<self
    #if not_exist_in_list?
    #  @@transactions<<self
    #else
    #  raise DuplicateTransactionError, "'#{self.id}' already exists."
    #end
  end



end
