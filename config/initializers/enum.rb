class ActiveRecord::Base
  def self.define_enum field, values
    validates field, "#{field}_is_valid_for_enum?".to_sym
    define_method "#{field}_is_valid_for_enum?" do |record, value|
      record.errors << "#{value} not a valid enum value for #{field}" unless values.include?(value)
    end
    define_method "#{field}_enum_values" do
      values
    end
  end
end