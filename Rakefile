require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "sg-ruby"
    gem.summary = %Q{A SimpleGeo Ruby Client}
    gem.email = "dan@dofter.com"
    gem.homepage = "http://github.com/archfear/sg-ruby"
    gem.authors = ["Dan Dofter"]
    
    gem.add_dependency("oauth", ">= 0.4.0")
    gem.add_dependency("json_pure")

    gem.add_development_dependency "rspec", ">= 1.2.0"
    gem.add_development_dependency("fakeweb", ">= 1.2.0")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "sg-ruby #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
