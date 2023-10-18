describe command('jf') do
  it { should exist }
end

describe command('jf --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/jf version 2/) }
end

describe user('jfrog') do
  it { should exist }
  its('uid') { should eq 1000 }
  its('gid') { should eq 1000 }
  its('home') { should eq '/bin/bash' }
end

describe directory('/home/jfrog') do
  its('owner') { should eq 1000 }
  its('group') { should eq 1000 }
end
