# https://oss.oetiker.ch/smokeping/doc/smokeping_install.en.html
# rrdtool

describe command('fping --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/fping: Version/) }
end

describe command('echoping') do
  it { should exist }
  its('exit_status') { should eq 1 }
  its('stderr') { should match(/Usage: echoping/) }
end

describe command('curl --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/curl/) }
end

describe command('dig -v') do
  its('exit_status') { should eq 0 }
  its('stderr') { should match(/DiG/) }
end

describe command('ssh') do
  its('exit_status') { should eq 255 }
  its('stderr') { should match(/usage: ssh/) }
end

# Various Perl modules (Optional)
# Socket6 0.11-1
# Net::Telnet
# Net::DNS
# Net::LDAP
# IO::Socket::SSL
# Authen::Radius

# apache webserver
describe command('apache2 -v') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Server version: Apache\/2/) }
end

# perl 5.8.8

# SpeedyCGI

# CGI::Carp

describe command('smokeping -h') do
  its('exit_status') { should eq 1 }
  its('stdout') { should match(/smokeping/) }
end
