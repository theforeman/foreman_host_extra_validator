class Setting
  class HostValidation < ::Setting
    def self.load_defaults
      return unless ActiveRecord::Base.connection.table_exists?('settings')
      return unless super

      Setting.transaction do
        [
          set('host_name_validation_regex', _('Default regex the name of a host is validated against'), '^[a-zA-Z0-9-_]+$')
        ].compact.each { |s| create s.update(:category => 'Setting::HostValidation') }
      end
    end
  end
end
