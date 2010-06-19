require 'test_helper'

class MultiTenantTest < ActiveSupport::TestCase

  def setup
    acme_account = Account.create(:name => 'Acme Housing Ltd')
    Property.create(:name => '3 Bed House', :account_id => acme_account.id)
    Property.create(:name => '4 Bed House', :account_id => acme_account.id)

    cardboard_account = Account.create(:name => 'Cardboard Housing Ltd')
    Property.create(:name => 'Double Layered Box',    :account_id => cardboard_account.id)
    Property.create(:name => 'Corregated Iron Sheet', :account_id => cardboard_account.id)
  end

  def teardown
    Account.current = nil
    Account.delete_all
    Property.delete_all
  end


  test "Property.all should return all property records when the current account hasn't been set" do
    Account.current = nil
    assert_equal(4, Property.all.count)
  end

  test "Property.all is explicitly scoped to the current account when set" do
    Account.current = Account.find_by_name('Acme Housing Ltd')

    assert_equal(2, Property.all.count)
    Property.all.each do |property|
      assert_equal(Account.current.id, property.account_id)
    end
  end

  test "new property records are not associated to any account when Account.current is unset" do
    Account.current = nil
    assert_nil(Property.new.account_id)
  end

  test "new property records are automatically associated to the current account if set" do
    Account.current = Account.find_by_name('Cardboard Housing Ltd')
    assert_equal(Account.current.id, Property.new.account_id)
  end

  test "no records should be return when attempting to find records belonging to a different account when Account.current is set" do
    Account.current = nil
    assert(Property.find_by_name('4 Bed House'))

    Account.current = Account.find_by_name('Cardboard Housing Ltd')
    assert_nil(Property.find_by_name('4 Bed House'))
  end

  test "find_or_create_by_attribute juju should work as expected" do
    Account.current = nil
    existing_acme_property = Property.find_or_create_by_name('3 Bed House')

    Account.current = Account.find_by_name('Cardboard Housing Ltd')
    new_cardboard_property = Property.find_or_create_by_name('3 Bed House')

    assert(existing_acme_property != new_cardboard_property)
    assert_equal(new_cardboard_property.account_id, Account.current.id)
  end
end
