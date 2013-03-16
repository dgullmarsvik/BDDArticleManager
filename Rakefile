require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

task :default => [:features,:spec]

Cucumber::Rake::Task.new(:features) do |t|
	puts 'Starting Cucumber Features...'
	t.cucumber_opts = '--format pretty'
end

RSpec::Core::RakeTask.new(:spec)

#task :test do
#	ruby "test/ts_unittests.rb"
#end