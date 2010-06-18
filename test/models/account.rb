class Account < ActiveRecord::Base
  multi_tenant_model
  has_many :properties
end
