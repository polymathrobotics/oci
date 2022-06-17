describe command('/opt/github-actions-runner/run.sh --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Runner listener/) }
end

describe file('/entrypoint.sh') do
  it { should exist }
  its('mode') { should cmp '0755' }
end
