require 'test_plugin_helper'

class ForemanPluginTemplateTest < ActiveSupport::TestCase
  setup do
    Setting::HostValidation.load_defaults
    disable_orchestration
    User.current = User.find_by_login 'admin'
  end

  test '#validate_name_regex should return regex from setting when no regex is inherited' do
    regex = '^[0-9]+$'
    Setting[:host_name_validation_regex] = regex
    host = FactoryGirl.build(:host, :managed)
    assert_equal regex, host.validate_name_regex
  end

  test 'host should validate when host name matches regex' do
    regex = '^[0-9]+$'
    Setting[:host_name_validation_regex] = regex
    host = Host.new name: '054354'
    assert host.valid?
  end

  test 'host should not validate when host name does not match regex' do
    regex = '^[0-9]+$'
    Setting[:host_name_validation_regex] = regex
    host = Host.new name: 'invalidhostname'
    refute host.valid?
    assert_includes host.errors[:name], "must match regex /#{regex}/"
  end
end
