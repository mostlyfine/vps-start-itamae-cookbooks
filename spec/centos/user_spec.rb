require 'spec_helper'

describe user('sawa') do
  it { should exist }
end

describe file('/etc/sudoers') do
  it { should be_mode 440 }
  it { should be_owned_by 'root' }
end
