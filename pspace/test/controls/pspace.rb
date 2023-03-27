describe command('/home/paperspace/.paperspace/bin/pspace version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/pspace v/) }
end
