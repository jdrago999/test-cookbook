require 'serverspec'
set :backend, :exec

describe package('apt') do
  it { should be_installed }
end

