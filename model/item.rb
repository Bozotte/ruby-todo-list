class Item
  attr_accessor :item, :checked, :personal, :code

  def initialize(args={})
    @item = args[:item]
    @checked = args[:checked]
    @personal = args[:personal]
    @code = args[:code]
  end
end
