module MultiTenantController
  def subdomain_by_multi_tenant_model(tenant = :account)
    self.class_eval do
      cattr_accessor :tenant, :tenant_class
    end

    self.tenant_class = tenant.to_s.capitalize.constantize

    self.class_eval do
      before_filter :find_account_from_subdomain
      def session
        if tenant_class.current.present?
          request.session[@current_subdomain] ||= {}
        else
          request.session
        end
      end

      def session=(*args)
        if tenant_class.present?
          request.session[@current_subdomain] = args
        else
          request.session = args
        end
      end

      private
      def find_account_from_subdomain
        @current_subdomain = request.host.split(/\./).first
        tenant_class.current = tenant_class.find_by_subdomain!(@current_subdomain)
      end
    end
  end
end
