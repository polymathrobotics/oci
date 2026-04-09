describe command('gstreamer-publisher --help') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Publish video\/audio from a GStreamer pipeline to LiveKit/) }
end
