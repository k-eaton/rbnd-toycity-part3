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
  end

  def self.all
    @@transactions
  end

end