require './dbmanager'
class AppRecord < Dbmanager
  def save
    dbmanager = Dbmanager.new
    attributes_hash = self.instance_variables.each_with_object({}) do |var, hash|
      hash[var.to_s.delete("@")] = self.instance_variable_get(var)
    end
    keys = attributes_hash.keys.join(', ')
    values = attributes_hash.values.map { |value| "'#{value}'" }.join(', ')
    insert_query = "INSERT INTO #{self.class.name.downcase.pluralize} (#{keys}) VALUES (#{values});"
    dbmanager.do_query(insert_query)
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
    where_query = "SELECT * FROM #{self.name.downcase.pluralize} WHERE #{key} = '#{value}';"
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
    find_by_query = carrier.do_query("SELECT * FROM #{self.name.downcase.pluralize} WHERE #{key} = '#{value.to_s}' LIMIT 1;")
    self.new(find_by_query.first.transform_keys(&:to_sym))
  end
end