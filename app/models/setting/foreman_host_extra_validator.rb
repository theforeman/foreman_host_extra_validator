class Setting
  class ForemanHostExtraValidator < ::Setting
    def self.load_defaults
      # Check the table exists
      return unless super

      self.transaction do
        [
          self.set('host_name_validation_regex', _('Default regex the name of a host is validated against'), '^[a-zA-Z0-9-_]+$')
        ].compact.each { |s| self.create! s.update(:category => 'Setting::ForemanHostExtraValidator') }
      end

      true
    end
  end
end
