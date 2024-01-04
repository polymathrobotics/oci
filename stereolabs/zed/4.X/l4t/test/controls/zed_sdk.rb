# docker.io/polymathrobotics/stereolabs-zed:4.0-devel-l4t-r35.3
# docker.io/polymathrobotics/stereolabs-zed:4.0-devel-l4t-r35.4
#
# docker.io/polymathrobotics/stereolabs-zed:4.0-runtime-l4t-r35.3
# docker.io/polymathrobotics/stereolabs-zed:4.0-runtime-l4t-r35.4
#
# docker.io/polymathrobotics/stereolabs-zed:4.0-tools-devel-l4t-r35.3
# docker.io/polymathrobotics/stereolabs-zed:4.0-tools-devel-l4t-r35.4
#
# docker.io/polymathrobotics/stereolabs-zed:4.0-py-devel-l4t-r35.3
# docker.io/polymathrobotics/stereolabs-zed:4.0-py-devel-l4t-r35.4
#
# docker.io/polymathrobotics/stereolabs-zed:4.0-py-runtime-l4t-r35.3
# docker.io/polymathrobotics/stereolabs-zed:4.0-py-runtime-l4t-r35.4

control 'l4t-r35.3' do
  only_if('l4t-r35.3') do
    input('test_container_image').include?('l4t-r35.3')
  end

  describe file('/etc/nv_tegra_release') do
    it { should exist }
    its('content') { should match(/\# R35 \(release\), REVISION: 3\.1/) }
  end
end

control 'l4t-r35.4' do
  only_if('l4t-r35.4') do
    input('test_container_image').include?('l4t-r35.4')
  end

  describe file('/etc/nv_tegra_release') do
    it { should exist }
    its('content') { should match(/\# R35 \(release\), REVISION: 4\.1/) }
  end
end
