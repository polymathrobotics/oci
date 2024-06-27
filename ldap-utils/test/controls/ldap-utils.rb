describe command('ldapsearch') do
  it { should exist }
end

describe command('ldapsearch -VV') do
  its('exit_status') { should eq 0 }
end

describe command('gnutls-cli') do
  it { should exist }
end
