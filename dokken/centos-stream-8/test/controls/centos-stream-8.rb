describe file('/etc/os-release') do
  its('content') { should match(/CentOS Stream 8/) }
end
