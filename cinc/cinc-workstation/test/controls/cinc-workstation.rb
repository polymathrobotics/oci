describe command('which ruby') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(%r{/opt/cinc-workstation/embedded/bin/ruby}) }
end

describe command('which cinc') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(%r{/opt/cinc-workstation/bin/cinc}) }
end

describe command('cinc --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Cinc Workstation version:/) }
done
