describe os_env('NVIDIA_VISIBLE_DEVICES') do
  its('content') { should eq 'all' }
end

describe os_env('NVIDIA_DRIVER_CAPABILITIES') do
  its('content') { should eq 'all' }
end

describe file('/etc/jetson-ota-public.key') do
  it { should exist }
end

describe file('/etc/ld.so.conf.d/nvidia-tegra.conf') do
  it { should exist }
  its('content') { should match(%r{/usr/lib/aarch64-linux-gnu/tegra}) }
  its('content') { should match(%r{/usr/lib/aarch64-linux-gnu/tegra-egl}) }
end

describe file('/usr/share/glvnd/egl_vendor.d/10_nvidia.json') do
  it { should exist }
  its('content') { should match(%r{"library_path" : "libEGL_nvidia.so.0"}) }
end

describe file('/usr/share/egl/egl_external_platform.d/nvidia_wayland.json') do
  it { should exist }
  its('content') { should match(%r{"library_path" : "libnvidia-egl-wayland.so.1"}) }
end

control 'l4t-base 35.3.1' do
  only_if('l4t-base 35.3.1') do
    input('test_container_image').include?('35.3.1')
  end

  describe file('/etc/apt/sources.list') do
    it { should exist }
    its('content') { should match(%r{deb https://repo.download.nvidia.com/jetson/common r35.3 main}) }
  end
end

control 'l4t-base 35.4.1' do
  only_if('l4t-base 35.4.1') do
    input('test_container_image').include?('35.4.1')
  end

  describe file('/etc/apt/sources.list') do
    it { should exist }
    its('content') { should match(%r{deb https://repo.download.nvidia.com/jetson/common r35.4 main}) }
  end
end
