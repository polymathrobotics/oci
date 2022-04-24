describe command('lsb_release --release') do
  its('stdout') { should match(/11/) }
end
