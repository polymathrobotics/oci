describe command('/opt/hashicorp/terraform/terraform --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Terraform v/) }
end
