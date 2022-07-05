describe command('http --help') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/HTTPie/) }
end
