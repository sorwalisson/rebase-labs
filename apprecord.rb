require './dbmanager'
require 'active_support/inflector'
class AppRecord < Dbmanager
  def save
    dbmanager = Dbmanager.new
    attributes_hash = self.instance_variables.each_with_object({}) do |var, hash|
      hash[var.to_s.delete("@")] = self.instance_variable_get(var)
    end
    attributes_hash.delete('id')
    keys = attributes_hash.keys.join(', ')
    values = attributes_hash.values.map { |value| "'#{value}'" }.join(', ')
    insert_query = "INSERT INTO #{self.class.name.downcase.pluralize} (#{keys}) VALUES (#{values});"
    result = dbmanager.do_query(insert_query)
  end

  def self.array_save(obj_array)
    carrier = Dbmanager.new
    obj_array.each {|obj| obj.save}
  end

  def self.count
    carrier = Dbmanager.new
    count_query = "SELECT COUNT(*) FROM #{self.name.downcase.pluralize};"
    query_result = carrier.do_query(count_query)
    query_result.values.first.first.to_i
  end

  def self.where(arg)
    carrier = Dbmanager.new
    key = arg.keys.first.to_s
    value = arg[arg.keys.first]
    if value.is_a?(String)
      where_query = "SELECT * FROM #{self.name.downcase.pluralize} WHERE #{key} = '#{value}';"
    else
      where_query = "SELECT * FROM #{self.name.downcase.pluralize} WHERE #{key} = #{value};"
    end
    query_result = carrier.do_query(where_query)
    obj_array = Array.new
    query_result.each {|obj| obj_array << self.new(obj.transform_keys(&:to_sym))}
    obj_array
  end

  def self.first
    carrier = Dbmanager.new
    first_query = carrier.do_query("SELECT * FROM #{self.name.downcase.pluralize} ORDER BY id LIMIT 1;")
    self.new(first_query.first.transform_keys(&:to_sym))
  end

  def self.find_by(arg)
    carrier = Dbmanager.new
    key = arg.keys.first.to_s
    value = arg[arg.keys.first]
    if value.is_a?(String)
      find_by_query = carrier.do_query("SELECT * FROM #{self.name.downcase.pluralize} WHERE #{key} = '#{value}' LIMIT 1;")
    else
      find_by_query = carrier.do_query("SELECT * FROM #{self.name.downcase.pluralize} WHERE #{key} = #{value} LIMIT 1;")
    end
    return nil if find_by_query.first.nil?
    self.new(find_by_query.first.transform_keys(&:to_sym))
  end

  def self.all
    carrier = Dbmanager.new
    all_query = "SELECT * FROM #{self.name.downcase.pluralize};"
    query_result = carrier.do_query(all_query)
    obj_array = Array.new
    query_result.each {|obj| obj_array << self.new(obj.transform_keys(&:to_sym))}
    obj_array
  end

  def to_hash
    hash = {}
    self.instance_variables.each do |var|
      var_name = var.to_s.gsub('@', '')
      hash[var_name] = self.instance_variable_get(var)
    end
    hash
  end
end