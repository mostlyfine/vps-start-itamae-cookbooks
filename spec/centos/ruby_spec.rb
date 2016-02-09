require 'spec_helper'
#
# install rbenv
describe command('source /etc/profile.d/rbenv.sh; which rbenv') do
  let(:disable_sudo) { true }
  its(:stdout) { should match('/usr/local/rbenv/bin/rbenv') }
end

# install ruby
describe command("source /etc/profile.d/rbenv.sh; rbenv versions | grep 2.3.0") do
  let(:disable_sudo) { true }
  its(:stdout) { should match(/2\.3\.0/) }
end
