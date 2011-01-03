module OrdinalField
  def self.included(base)
    base.send :extend, ClassMethods
  end
  def self.add_ordinals_to_labels(labels)
    with_values = []
    labels.each_index {|index| with_values << [labels[index], index]}
    with_values
  end
  module ClassMethods
    def ordinals
      (@ordinals ||= {})
    end
    def ordinal_field field, values_labels
      values_labels = OrdinalField.add_ordinals_to_labels(values_labels) if String === values_labels.first
      ordinals[field] = values_labels
      validates_inclusion_of field, 
                            :in => ordinal_values(field), 
                            :message => "#{field} must be one of #{ordinal_labels(field).join(', ')}."
      values_labels.each do |label, value|
        const_set("#{field}_#{label}".upcase, value)
      end
    end
    def ordinal_values field
      ordinals[field].map(&:last)
    end
    def ordinal_labels field
      ordinals[field].map(&:first)
    end
  end
end
 
ActiveRecord::Base.send :include, OrdinalField