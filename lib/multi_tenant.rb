require 'multi_tenant_controller'
require 'multi_tenant_model'

ActionController::Base.extend MultiTenantController
ActiveRecord::Base.extend MultiTenantModel

