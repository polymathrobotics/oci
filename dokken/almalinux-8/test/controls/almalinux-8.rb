describe file('/etc/almalinux-release') do
  its('content') { should match(/AlmaLinux release 8/) }
end
