require 'rubygems'
require 'test/unit'
require 'active_support'

require 'active_record'
require 'active_record/fixtures'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => ":memory:"
)
require 'db/load_schema'

require 'multi_tenant'
ActiveRecord::Base.send :include, MultiTenant

require 'models/account'
require 'models/property'

# Fixtures
acme_account = Account.create(:name => 'Acme Housing Ltd')
Property.create(:name => '3 Bed House', :account_id => acme_account.id)
Property.create(:name => '4 Bed House', :account_id => acme_account.id)

cardboard_account = Account.create(:name => 'Cardboard Housing Ltd')
Property.create(:name => 'Double Layered Box',    :account_id => cardboard_account.id)
Property.create(:name => 'Corregated Iron Sheet', :account_id => cardboard_account.id)
