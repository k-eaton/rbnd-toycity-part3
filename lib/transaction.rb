class Transaction
  attr_reader :customer, :product, :id

  @@transactions = []
  @@transaction_id = 1

  def initialize(customer, product)
    @customer = customer
    @product  = product
    @id       = @@transaction_id
    @product.stock -= 1
    @@transaction_id += 1
    @@transactions << self
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions.find {|transaction| transaction.id == id}
  end
end