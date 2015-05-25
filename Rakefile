require 'rake'
require 'rspec/core/rake_task'

task :spec    => 'spec:all'
task :default => :spec

namespace :spec do
  targets = []
  Dir.glob('./spec/*').each do |dir|
    next unless File.directory?(dir)
    target = File.basename(dir)
    target = "_#{target}" if target == "default"
    targets << target
  end

  task :all     => targets
  task :default => :all

  targets.each do |target|
    original_target = target == "_default" ? target[1..-1] : target
    desc "Run serverspec tests to #{original_target}"
    RSpec::Core::RakeTask.new(target.to_sym) do |t|
      ENV['TARGET_HOST'] = original_target
      t.pattern = "spec/#{original_target}/*_spec.rb"
    end
  end
end

desc "Execute itamae cookbook"
task :itamae, :role do |t, args|
  user = ENV['USER'] || 'vagrant'
  host = ENV['HOST'] || 'vagrant'
  role = args[:role] || ENV['ROLE'] || 'development'
  sh "bundle exec itamae ssh -u #{user} -h #{host} -y roles/#{role}.yml #{ENV['COOKBOOK']}"
end
