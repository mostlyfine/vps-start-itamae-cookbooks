require 'spec_helper'

describe service("mongod") do
  it { should be_running }
  it { should be_enabled }
end

