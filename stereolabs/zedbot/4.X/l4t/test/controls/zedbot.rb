# docker.io/polymathrobotics/nvidia-l4t-ros:humble-ros_base-r35.3.1
# docker.io/polymathrobotics/nvidia-l4t-ros:humble-ros_base-r35.4.1
#
# docker.io/polymathrobotics/nvidia-l4t-ros:humble-desktop-r35.3.1
# docker.io/polymathrobotics/nvidia-l4t-ros:humble-desktop-r35.4.1

control 'l4t-r35.3' do
  only_if('l4t-r35.3') do
    input('test_container_image').include?('r35.4.1')
  end

  describe file('/etc/nv_tegra_release') do
    it { should exist }
    its('content') { should match(/\# R35 \(release\), REVISION: 3\.1/) }
  end
end

control 'l4t-r35.4' do
  only_if('l4t-r35.4') do
    input('test_container_image').include?('r35.4.1')
  end

  describe file('/etc/nv_tegra_release') do
    it { should exist }
    its('content') { should match(/\# R35 \(release\), REVISION: 4\.1/) }
  end
end
