require 'rubygems'
require 'test/unit'
require 'active_support'

require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => ":memory:"
)
require 'db/load_schema'

require 'multi_tenant_model'
ActiveRecord::Base.extend MultiTenantModel

require 'models/account'
require 'models/property'
