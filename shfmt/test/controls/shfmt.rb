describe command('shfmt -h') do
  its('exit_status') { should eq 0 }
  its('stderr') { should match(/shfmt/) }
end
