describe command('certbot --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/certbot/) }
end
