class Transaction
  attr_reader :customer, :product, :id

  @@transactions = []
  @@transaction_id = 1

  def initialize(customer, product, transaction_type="purchase")
    @customer = customer
    @product  = product
    @id       = @@transaction_id
    @transaction_type = transaction_type
    @transaction_type == "purchase" ? purchase_transaction : return_transaction
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions.find {|transaction| transaction.id == id}
  end

  private

  def purchase_transaction
    if @product.stock > 1
      @product.stock -= 1
      @@transaction_id += 1
      @@transactions << self
    else
      begin
        raise OutOfStockError, "\'#{@product.title}\' is out of stock."
        rescue => error
        puts error
      end
    end
  end

  def return_transaction
    @product.stock += 1
    @@transaction_id += 1
    @@transactions << self
  end
end