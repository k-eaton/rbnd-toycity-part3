class Product

  attr_reader :title

  @@products = []

  def initialize(options={})
    @title = options[:title]
    add_to_products
  end

  def self.test
    @@products.each {|p| puts p}
  end    

  def self.all
    @@products
  end

  private

  def add_to_products
    if @@products.any? {|product| product.title == @title}
      raise DuplicateProductError, "'#{@title}' already exists."
    else
      @@products << self
    end
  end
end