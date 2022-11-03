module ForemanHostExtraValidator
  class Engine < ::Rails::Engine
    engine_name 'foreman_host_extra_validator'

    config.autoload_paths += Dir["#{config.root}/app/models/concerns"]

    # Add any db migrations
    initializer 'foreman_host_extra_validator.load_app_instance_data' do |app|
      ForemanHostExtraValidator::Engine.paths['db/migrate'].existent.each do |path|
        app.config.paths['db/migrate'] << path
      end
    end

    initializer 'foreman_host_extra_validator.register_plugin', :before => :finisher_hook do |_app|
      Foreman::Plugin.register :foreman_host_extra_validator do
        requires_foreman '>= 3.0.0'

        settings do
          category(:host_extra_validator, N_('Host Extra Validator')) do
            setting('host_name_validation_regex',
                    description:  N_('Default regex the name of a host is validated against'),
                    type: :string,
                    default: '^[a-zA-Z0-9\-_]+$',
                    full_name: N_('Regular expresssion'))
          end
        end
      end
    end

    config.to_prepare do
      Host::Managed.include ForemanHostExtraValidator::HostExtensions
    rescue => e
      Rails.logger.warn "ForemanHostExtraValidator: skipping engine hook (#{e})\n#{e.backtrace}"
    end

    initializer 'foreman_host_extra_validator.register_gettext', after: :load_config_initializers do |_app|
      locale_dir = File.join(File.expand_path('../..', __dir__), 'locale')
      locale_domain = 'foreman_host_extra_validator'
      Foreman::Gettext::Support.add_text_domain locale_domain, locale_dir
    end
  end
end
