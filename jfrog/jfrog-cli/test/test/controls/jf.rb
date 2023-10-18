describe command('jf') do
  it { should exist }
end

describe command('jf --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/jf version 2/) }
end
