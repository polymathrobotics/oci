[
  'cinc-client --version',
  '/opt/cinc/bin/cinc-client --version'
].each do |cinc_client_command|
  describe command(cinc_client_command) do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/Cinc Client:/) }
  end
end
