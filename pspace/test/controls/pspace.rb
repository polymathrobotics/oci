describe command('pspace') do
  it { should exist }
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/A CLI for using the Paperspace API/) }
end
