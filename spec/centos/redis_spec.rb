require 'spec_helper'

describe service("redis") do
  it { should be_running }
  it { should be_enabled }
end
