describe command('python3') do
  it { should exist }
end

describe command('python3 --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Python 3.9/) }
end
