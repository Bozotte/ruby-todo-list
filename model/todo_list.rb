require_relative 'item'
require 'csv'
require 'date'

class TodoList
  attr_reader :list
  def initialize
    @list = []
    parse_csv_list
  end

  def parse_csv_list
    CSV.foreach('todo_list_data.csv', headers: true, header_converters: :symbol) do |row|
      @list << Item.new(row)
    end
  end

  def add(item)
    @list << Item.new(item: item)
    save
  end

  def add_multiple(array)
    array.each{|item| add(item)}
    save
  end

  def delete(item)
    @list.delete_if{|name| name.item == item}
    save
  end

  def check_off(item)
    item = item.split[0]
    @list.map! do |el|
      el.checked = "X" if el.item.downcase.include?(item)
      el
    end
    save
  end

  def check_off_all(items)
    @list.map!{|item| item.checked = "X"; item}
    save
  end

  def uncheck_all(items)
    @list.map!{|item| item.checked = nil; item}
    save
  end

  def delete_all(items)
    @list = []
    save
  end

  def tag(tag_array)
    item = tag_array[0].downcase.split[0]
    tag = tag_array[1]
    @list.map! do |el|
      el.send("#{tag}=", tag) if el.item.downcase.include?(item)
      el
    end
    save
  end

  def untag(tag_array)
    item = tag_array[0].downcase.split[0]
    tag = tag_array[1]
    @list.map! do |el|
      el.send("#{tag}=", nil) if el.item.downcase.include?(item)
      el
    end
    save
  end

  def save
    CSV.open('todo_list_data.csv', 'w') do |file|
      file << ["item", "checked", "personal", "code"]
      list.each{|item| file << [item.item, item.checked, item.personal, item.code]}
    end
  end

  def export_all_to_txt
    export_to_txt(list)
  end

  def export_unchecked_to_txt
    array = list.select{|item| item.checked == nil }
    export_to_txt(array)
  end

  def export_to_txt(array)
    File.open('todays_list.txt', 'w') do |file|
      file << "My list for #{Date.today}:\n\n"
      array.each do |item|
        checked = item.checked ? item.checked : " "
        tags = ""
        tags << "[#{item.personal}]" if item.personal
        tags << "[#{item.code}]" if item.code
        file << "[#{checked}] #{item.item} #{tags}\n"
      end
    end
  end
end
