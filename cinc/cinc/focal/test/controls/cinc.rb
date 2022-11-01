describe command('cinc-client --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Cinc Client:/) }
end
