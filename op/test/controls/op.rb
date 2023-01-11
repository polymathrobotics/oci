%w(
  jq
  op
  parallel
).each do |cmd| 
  describe command(cmd) do
    it { should exist }
  end
end

describe command('op --version') do
  its('exit_status') { should eq 0 }
end

describe command('jq --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match (/jq-/) }
end

describe command('parallel --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match (/GNU parallel/) }
end
