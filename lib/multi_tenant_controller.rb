module MultiTenantController
  def subdomain_by_multi_tenant_model(tenant = :account)
    self.class_eval do
      before_filter :find_account_from_subdomain
      def session
        if @current_subdomain.present?
          request.session[@current_subdomain] ||= {}
        else
          request.session
        end
      end

      def session=(*args)
        if @current_subdomain.present?
          request.session[@current_subdomain] = args
        else
          request.session = args
        end
      end

      private
      def find_account_from_subdomain
        @current_subdomain = request.host.split(/\./).first
        Account.current = Account.find_by_subdomain!(@current_subdomain)
      end
    end
  end
end
