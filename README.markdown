# MultiTenant

MultiTenant is a Rails 3 plugin to help ease the development of web applications
that utilise the database in a multi-tenant manner, and provide each end-user/account
with their own subdomained version of the application.

This plugin is currently work in progess. Managing subdomains still to do..

# Installation
Currently just a regular plugin, typical plugin installation:
    rails plugin install git://github.com/mconnell/multi_tenant.git

Alternatively as a git submodule:
    git submodule add git://github.com/mconnell/multi_tenant.git vendor/plugins/multi_tenant

# How to Use
Add `multi_tenant_model` to the primary model
    class Account < ActiveRecord::Base
      multi_tenant_model
      has_many :properties
    end

Any models that should be explicitly scoped to a `multi_tenant_model` require the `belongs_to_tenant` to be set
    class Property < ActiveRecord::Base
      belongs_to_tenant :account
    end

Property scoping will behave as normal unless a current account has been set:
    Property.all
    #> [#<Property account_id: 1>, #<Property account_id: 2>]
    Account.current = Account.find(1)
    Property.all
    #> [#<Property account_id: 1>]

If the current account is set, instantiating new property records will automatically be assigned to the current account:
    Property.new
    #> <Property account_id: nil>
    
    Account.current = Account.find(25)
    Property.new
    #> <Property account_id: 25>

Copyright (c) 2010 [Mark Connell], released under the MIT license
