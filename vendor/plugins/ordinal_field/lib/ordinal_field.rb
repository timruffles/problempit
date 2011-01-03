module OrdinalField
  def self.included(base)
    base.send :extend, ClassMethods
  end
  module ClassMethods
    def ordinals
      (@ordinals ||= {})
    end
    def ordinal_field field, values_labels
      ordinals[field] = values_labels
      values = values_labels.map(&:last)
      validates_inclusion_of field, 
                            :in => values, 
                            :message => "#{field} must be one of #{ordinal_labels(field).join(', ')}."
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