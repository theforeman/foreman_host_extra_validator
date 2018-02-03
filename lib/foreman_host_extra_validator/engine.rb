module ForemanHostExtraValidator
  class Engine < ::Rails::Engine
    engine_name 'foreman_host_extra_validator'

    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]

    initializer 'foreman_host_extra_validator.load_default_settings', :before => :load_config_initializers do |_app|
      require_dependency File.expand_path('../../../app/models/setting/foreman_host_extra_validator.rb', __FILE__) if begin
                                                                                                                         Setting.table_exists?
                                                                                                                       rescue
                                                                                                                         (false)
                                                                                                                       end
    end

    initializer 'foreman_host_extra_validator.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_host_extra_validator do
        requires_foreman '>= 1.18'
      end
    end

    config.to_prepare do
      begin
        Host::Managed.send(:include, ForemanHostExtraValidator::HostExtensions)
      rescue => e
        Rails.logger.warn "ForemanHostExtraValidator: skipping engine hook (#{e})\n#{e.backtrace}"
      end
    end

    initializer 'foreman_host_extra_validator.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../../..', __FILE__), 'locale')
      locale_domain = 'foreman_host_extra_validator'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
