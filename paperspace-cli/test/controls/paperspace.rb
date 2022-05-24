describe command('paperspace') do
  it { should exist }
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/paperspace-cli/) }
end
