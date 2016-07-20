class Customer

  attr_reader :name

  @@customers = []

  def initialize(options={})
    @name = options[:name]
    add_to_customers
  end

  def self.all
    @@customers
  end

  def self.find_by_name(search_name)
    @@customers.find {|customer| customer.name == search_name}
  end

  def purchase(purchase_product)
    Transaction.new(@name, purchase_product)
  end

  def return_product(return_product)
    Transaction.new(@name, return_product, "return_product")
  end

  private

  def add_to_customers
    if @@customers.any? {|customer| customer.name == @name}
      begin
        raise DuplicateCustomerError, "\'#{@name}\' already exists."
        rescue => error
        puts error
      end
    else
      @@customers << self
    end
  end
end