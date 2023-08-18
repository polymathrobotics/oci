describe command('lego') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/lego - Let's Encrypt client written in Go/) }
end
