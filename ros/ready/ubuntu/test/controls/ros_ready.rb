
describe os_env('LANG') do
  its('content') { should eq 'C.UTF-8' }
end

describe os_env('ROSDISTRO_PKGS_SYNC_DATE') do
  its('content') { should match /^\d{4}-\d{2}-\d{2}$/ }
end

describe file('/usr/share/keyrings/ros2-latest-archive-keyring.gpg') do
  it { should exist }
end

# docker.io/polymathrobotics/ros:humble-ready-ubuntu
control 'humble-ready' do
  only_if('humble-ready') do
    input('test_container_image').include?('ros:humble-ready-ubuntu')
  end
  describe os do
    its('name') { should eq 'ubuntu' }
    its('release') { should eq '22.04' }
  end
  describe os_env('ROS_DISTRO') do
    its('content') { should eq 'humble' }
  end
  describe file('/etc/apt/sources.list.d/ros2-latest.list') do
      it { should exist }
      its('content') { should match %r{jammy main} }
  end
  %w(
    colcon
    rosdep
  ).each do |cmd|
    describe command(cmd) do
      it { should_not exist }
    end
  end
end

# docker.io/polymathrobotics/ros:humble-builder-ubuntu
control 'humble-builder' do
  only_if('humble-builder') do
    input('test_container_image').include?('ros:humble-builder-ubuntu')
  end
  describe os do
    its('name') { should eq 'ubuntu' }
    its('release') { should eq '22.04' }
  end
  describe os_env('ROS_DISTRO') do
    its('content') { should eq 'humble' }
  end
  %w(
    colcon
    rosdep
  ).each do |cmd|
    describe command(cmd) do
      it { should exist }
    end
  end
  describe file('/usr/local/bin/gather-rosdeps') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:jazzy-ready-ubuntu
control 'jazzy-ready' do
  only_if('jazzy-ready') do
    input('test_container_image').include?('ros:jazzy-ready-ubuntu')
  end
  describe os do
    its('name') { should eq 'ubuntu' }
    its('release') { should eq '24.04' }
  end
  describe os_env('ROS_DISTRO') do
    its('content') { should eq 'jazzy' }
  end
  describe file('/etc/apt/sources.list.d/ros2-latest.list') do
      it { should exist }
      its('content') { should match %r{noble main} }
  end
  %w(
    colcon
    rosdep
  ).each do |cmd|
    describe command(cmd) do
      it { should_not exist }
    end
  end
end

# docker.io/polymathrobotics/ros:jazzy-builder-ubuntu
control 'jazzy-builder' do
  only_if('jazzy-builder') do
    input('test_container_image').include?('ros:jazzy-builder-ubuntu')
  end
  describe os do
    its('name') { should eq 'ubuntu' }
    its('release') { should eq '24.04' }
  end
  describe os_env('ROS_DISTRO') do
    its('content') { should eq 'jazzy' }
  end
  %w(
    colcon
    rosdep
  ).each do |cmd|
    describe command(cmd) do
      it { should exist }
    end
  end
  describe file('/usr/local/bin/gather-rosdeps') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:kilted-ready-ubuntu
control 'kilted-ready' do
  only_if('kilted-ready') do
    input('test_container_image').include?('ros:kilted-ready-ubuntu')
  end
  describe os do
    its('name') { should eq 'ubuntu' }
    its('release') { should eq '24.04' }
  end
  describe os_env('ROS_DISTRO') do
    its('content') { should eq 'kilted' }
  end
  describe file('/etc/apt/sources.list.d/ros2-latest.list') do
      it { should exist }
      its('content') { should match %r{noble main} }
  end
  %w(
    colcon
    rosdep
  ).each do |cmd|
    describe command(cmd) do
      it { should_not exist }
    end
  end
end

# docker.io/polymathrobotics/ros:kilted-builder-ubuntu
control 'kilted-builder' do
  only_if('kilted-builder') do
    input('test_container_image').include?('ros:kilted-builder-ubuntu')
  end
  describe os do
    its('name') { should eq 'ubuntu' }
    its('release') { should eq '24.04' }
  end
  describe os_env('ROS_DISTRO') do
    its('content') { should eq 'kilted' }
  end
  %w(
    colcon
    rosdep
  ).each do |cmd|
    describe command(cmd) do
      it { should exist }
    end
  end
  describe file('/usr/local/bin/gather-rosdeps') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:rolling-ready-ubuntu
control 'rolling-ready' do
  only_if('rolling-ready') do
    input('test_container_image').include?('ros:rolling-ready-ubuntu')
  end
  describe os do
    its('name') { should eq 'ubuntu' }
    its('release') { should eq '24.04' }
  end
  describe os_env('ROS_DISTRO') do
    its('content') { should eq 'rolling' }
  end
  describe file('/etc/apt/sources.list.d/ros2-latest.list') do
      it { should exist }
      its('content') { should match %r{noble main} }
  end
  %w(
    colcon
    rosdep
  ).each do |cmd|
    describe command(cmd) do
      it { should_not exist }
    end
  end
end

# docker.io/polymathrobotics/ros:rolling-builder-ubuntu
control 'rolling-builder' do
  only_if('rolling-builder') do
    input('test_container_image').include?('ros:rolling-builder-ubuntu')
  end
  describe os do
    its('name') { should eq 'ubuntu' }
    its('release') { should eq '24.04' }
  end
  describe os_env('ROS_DISTRO') do
    its('content') { should eq 'rolling' }
  end
  %w(
    colcon
    rosdep
  ).each do |cmd|
    describe command(cmd) do
      it { should exist }
    end
  end
  describe file('/usr/local/bin/gather-rosdeps') do
    it { should exist }
  end
end
