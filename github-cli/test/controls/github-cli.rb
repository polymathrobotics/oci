describe command('gh --help') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/gh version/) }
end
