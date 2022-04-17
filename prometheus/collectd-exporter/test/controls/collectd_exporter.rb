describe command('collectd_exporter') do
  it { should exist }
end

describe command('collectd_exporter -h') do
  its('exit_status') { should eq 0 }
  its('stderr') { should match(/usage: collectd_exporter/) }
end
