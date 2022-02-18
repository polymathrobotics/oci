describe command('op') do
  it { should exist }
end

describe command('op --version') do
  its('exit_status') { should eq 0 }
end
