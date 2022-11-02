describe file('/etc/almalinux-release') do
  its('content') { should match(/AlmaLinux release 9/) }
end
