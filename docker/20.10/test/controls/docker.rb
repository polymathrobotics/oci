describe command('docker') do
  it { should exist }
end

describe command('docker --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Docker version/) }
end
