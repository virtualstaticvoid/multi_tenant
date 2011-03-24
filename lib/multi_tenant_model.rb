module MultiTenantModel

  # adds "current" to the model which represents the tenant
  def multi_tenant_model
    self.class_eval do
      cattr_accessor :current
    end
  end

  # adds multi-tenant support to respective model
  def belongs_to_tenant(tenant = :account, options = {})
    
    self.class_eval do
      cattr_accessor :tenant, :tenant_class
    end

    self.tenant       ||= tenant
    self.tenant_class ||= tenant.to_s.capitalize.constantize

    self.class_eval do
    
      belongs_to tenant, options

      def self.unscoped
        if tenant_class.current
          super.apply_finder_options(:conditions => { "#{tenant}_id" => tenant_class.current.id })
        else
          super
        end
      end

      def initialize(attributes = nil)
        if tenant_class.current
          new_attributes = {"#{tenant}_id" => tenant_class.current.id }
          new_attributes.merge!(attributes) if attributes.is_a?(Hash)
          attributes = new_attributes
        end
        super(attributes)
      end

    end

  end
end

