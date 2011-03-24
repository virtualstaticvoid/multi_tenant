module MultiTenantController
  
  # adds multi-tenant support to respective controller
  def multi_tenant_model(tenant = :account)
    self.class_eval do
      cattr_accessor :tenant, :tenant_class
    end

    self.tenant_class = tenant.to_s.capitalize.constantize
  end

  # adds multi-tenant support to respective controller based on the current subdomain
  def subdomain_by_multi_tenant_model(tenant = :account)
    multi_tenant_model(tenant)
    self.class_eval do
      attr_accessor :current_subdomain
      before_filter :find_account_from_subdomain

      private
      def find_account_from_subdomain

        # TODO: ensure "subdomain" isn't www or the actual domain
        # consider using request.subdomain (rails 3 feature)        

        self.current_subdomain = request.host.split(/\./).first
        tenant_class.current = tenant_class.find_by_subdomain!(current_subdomain)
      end
    end
  end

end

