class Property < ActiveRecord::Base
  belongs_to_tenant :account
end
