require 'test_helper'

class RoleFactoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'it should exist in the factory ' do


    assert_raises(RoleFactoryException) { RoleFactory.create_role(:role).must_raise }


  end

  test 'it should make the object with the name' do

    instance = RoleFactory.create_role(:super_admin)
    expected = :super_admin.to_s.classify.constantize
    assert instance.nil? == false, 'instance should not be nil'
    assert instance.class.eql?(expected), "classes #{instance.class} and #{expected} should be the same"

  end


  test 'should have the correct subclass name' do
    role = RoleFactory.create_role(:pixel_admin)
    expected = 'pixel_admin'
    assert role.name.eql?(expected), "role names is #{role.name} and expected was #{expected}"
    assert role.name.to_sym == :pixel_admin, "role is: #{role.name} expected #{expected}"
  end

end
