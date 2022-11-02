describe command('lsb_release --release') do
  its('stdout') { should match(/12/) }
end
