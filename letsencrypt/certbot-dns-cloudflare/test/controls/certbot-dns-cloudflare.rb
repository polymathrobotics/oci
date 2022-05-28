describe command('certbot plugins') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/dns-cloudflare/) }
end
