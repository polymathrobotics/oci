describe command('grafana-server') do
  it { should exist }
end

describe command('grafana-server -v') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Version/) }
end

describe file('/run.sh') do
  it { should exist }
  its('mode') { should cmp '0755' }
end
