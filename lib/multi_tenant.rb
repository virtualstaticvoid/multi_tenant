module MultiTenant
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def multi_tenant_model
      self.class_eval do
        cattr_accessor :current
      end
    end

    def belongs_to_tenant(tenant = :account)
      self.class_eval do
        cattr_accessor :tenant, :tenant_class
      end

      self.tenant       ||= tenant
      self.tenant_class ||= tenant.to_s.capitalize.constantize

      self.class_eval do
        belongs_to tenant

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
end
