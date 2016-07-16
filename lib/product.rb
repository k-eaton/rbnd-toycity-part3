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

  def self.find_by_title(title)
    return @@products.find {|product| product.title == title}
  end

  private

  def add_to_products
    if @@products.any? {|product| product.title == @title}
      begin
        raise DuplicateProductError, "\'#{@title}\' already exists."
        rescue => error
        puts error
      end
    else
      @@products << self
    end
  end
end