describe command('terraform') do
  it { should exist }
end

describe command('/opt/hashicorp/terraform/bin/terraform') do
  it { should exist }
end

describe command('/opt/hashicorp/terraform/bin/terraform --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Terraform v/) }
end
