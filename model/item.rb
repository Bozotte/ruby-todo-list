class Item
  attr_accessor :item, :checked
  
  def initialize(args={})
    @item = args[:item]
    @checked = args[:checked]
  end
end
