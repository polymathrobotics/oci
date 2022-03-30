%w(
  dasel
  jq
).each do |cmd| 
  describe command(cmd) do
    it { should exist }
  end
end

describe command('/usr/local/bin/dasel --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/dasel version/) }
end

describe command('jq --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match (/jq-/) }
end
