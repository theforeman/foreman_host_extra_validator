# Tests
namespace :test do
  desc 'Test ForemanHostExtraValidator'
  Rake::TestTask.new(:foreman_host_extra_validator) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
  end
end

namespace :foreman_host_extra_validator do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_host_extra_validator) do |task|
        task.patterns = ["#{ForemanHostExtraValidator::Engine.root}/app/**/*.rb",
                         "#{ForemanHostExtraValidator::Engine.root}/lib/**/*.rb",
                         "#{ForemanHostExtraValidator::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_host_extra_validator'].invoke
  end
end

Rake::Task[:test].enhance do
  Rake::Task['test:foreman_host_extra_validator'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance do
    Rake::Task['test:foreman_host_extra_validator'].invoke
    Rake::Task['foreman_host_extra_validator:rubocop'].invoke
  end
end
