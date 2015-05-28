require 'spec_helper'

describe service("nginx") do
  it { should be_running }
  it { should be_enabled }
end

