describe command('clang-tidy --help') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/clang-tidy/) }
end
