module MultiTenantController
  def subdomain_by_multi_tenant_model(tenant = :account)
    self.class_eval do
      cattr_accessor :tenant, :tenant_class
      attr_accessor :current_subdomain
    end

    self.tenant_class = tenant.to_s.capitalize.constantize

    self.class_eval do
      before_filter :find_account_from_subdomain

      private
      def find_account_from_subdomain
        self.current_subdomain = request.host.split(/\./).first
        tenant_class.current = tenant_class.find_by_subdomain!(current_subdomain)
      end
    end
  end
end
