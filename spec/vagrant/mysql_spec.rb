require 'spec_helper'

describe service("mysqld") do
  it { should be_running }
  it { should be_enabled }
end

