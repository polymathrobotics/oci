describe command('which cinc-client') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(%r{/usr/bin/cinc-client}) }
end

describe command('cinc-client --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Cinc Client:/) }
end
