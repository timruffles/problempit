class Authority < ActiveRecord::Base
  ordinal_field :level, ['Interested','Knowledgable','Successful']
end
