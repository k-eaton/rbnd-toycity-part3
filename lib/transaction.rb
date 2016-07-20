class Transaction
  attr_reader :customer, :product, :id, :transaction_type

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

  def self.find_by_product(product, type = "both")
    if @@transactions.any? {|transaction| transaction.product == product}
      if type == "both"
        @@transactions.select {|transaction| transaction.product == product}
      elsif type == "purchase"
        @@transactions.select {|transaction| transaction.product == product && transaction.transaction_type == "purchase"}
      else
        @@transactions.select {|transaction| transaction.product == product && transaction.transaction_type != "purchase"}
      end
    else
      begin
        raise ProductNotFoundError, "No transactions for \'#{product.title}\' can be found."
        rescue => error
        puts error
      end
    end
  end

  private

  def purchase_transaction
    if @product.stock > 0
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