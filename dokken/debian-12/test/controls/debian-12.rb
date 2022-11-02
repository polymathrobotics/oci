describe file('/etc/os-release') do
  its('content') { should match(/bookworm/) }
end
