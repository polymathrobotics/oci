describe command('clang-format --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/clang-format version/) }
end
