require 'test_plugin_helper'

class ForemanHostExtraValidatorTest < ActiveSupport::TestCase
  setup do
    Setting::ForemanHostExtraValidator.load_defaults
    disable_orchestration
    User.current = FactoryBot.build(:user, :admin)
  end

  context 'with validation regex' do
    setup do
      Setting[:host_name_validation_regex] = '^[0-9]+$'
      @host = FactoryBot.build(:host)
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

    test 'host should validate from hostgroup parameter' do
      hostgroup = FactoryBot.create(:hostgroup)
      @host.hostgroup = hostgroup
      FactoryBot.create(:hostgroup_parameter, :name => 'host_name_validation_regex', :value => '^[a-z]+$', :hostgroup => hostgroup)

      assert_equal '^[a-z]+$', @host.send(:validate_name_regex)
      @host.hostname = 'abcdef'
      assert_valid @host

      @host.hostname = '1234'
      refute_valid @host
      assert_includes @host.errors[:name], "must match regex /^[a-z]+$/"
    end

  end
end
