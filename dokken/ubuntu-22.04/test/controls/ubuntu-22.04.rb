describe command('lsb_release --release') do
  its('stdout') { should match(/22\.04/) }
end

# systemd-timesyncd is no longer automatically installed when
# the systemd package is installed
describe package('systemd-timesyncd') do
  it { should be_installed }
end
