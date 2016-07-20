require 'test_plugin_helper'

class ForemanHostExtraValidatorTest < ActiveSupport::TestCase
  setup do
    Setting::ForemanHostExtraValidator.load_defaults
    disable_orchestration
    User.current = User.find_by_login 'admin'
  end

  context 'with validation regex' do
    setup do
      Setting[:host_name_validation_regex] = '^[0-9]+$'
      @host = FactoryGirl.build(:host)
    end

    test 'host should validate from settings' do
      @host.name = '054354'
      assert_valid @host
    end

    test 'host should not validate when host name does not match regex' do
      @host.name = 'invalidhostname'
      refute_valid @host
      assert_includes @host.errors[:name], "must match regex /#{Setting[:host_name_validation_regex]}/"
    end
  end
end
