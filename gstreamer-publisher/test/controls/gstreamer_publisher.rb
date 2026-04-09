describe command('gstreamer-publisher --help') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/Publish video\/audio from a GStreamer pipeline to LiveKit/) }
end

%w[
  clockoverlay
  decodebin3
  h264parse
  opusenc
  vp9enc
  x264enc
].each do |plugin|
  describe command("gst-inspect-1.0 #{plugin}") do
    its('exit_status') { should eq 0 }
  end
end
