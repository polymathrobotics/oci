describe os_env('ROS_DISTRO') do
  its('content') { should eq 'noetic' }
end

describe os_env('LANG') do
  its('content') { should eq 'C.UTF-8' }
end

describe file('/usr/share/keyrings/ros1-latest-archive-keyring.gpg') do
  it { should exist }
end

describe file('/ros_entrypoint.sh') do
  it { should exist }
end

describe command("su --login --command \"source /opt/ros/$ROS_DISTRO/setup.bash && rosrun -h\"") do
  its('exit_status') { should cmp 0 }
  its('stdout') { should match(/Usage: rosrun/) }
end

describe file('/ros_entrypoint.sh') do
  it { should exist }
  its('content') { should match %r{source "/opt/ros/\$ROS_DISTRO/setup\.bash"} }
end

# docker.io/polymathrobotics/ros:noetic-ros-core-jammy
control 'ros-core' do
  only_if('ros-core') do
    input('test_container_image').include?('ros:noetic-ros-core-jammy')
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

# docker.io/polymathrobotics/ros:noetic-ros-base-jammy
control 'ros-base' do
  only_if('ros-base') do
    input('test_container_image').include?('ros:noetic-ros-base-jammy')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:noetic-perception-jammy
control 'perception' do
  only_if('perception') do
    input('test_container_image').include?('ros:noetic-perception-jammy')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:noetic-desktop-jammy
control 'desktop' do
  only_if('desktop') do
    input('test_container_image').include?('ros:noetic-desktop-jammy')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:noetic-desktop-full-jammy
control 'desktop-full' do
  only_if('desktop-full') do
    input('test_container_image').include?('ros:noetic-desktop-full-jammy')
  end

  describe command('colcon') do
    it { should exist }
  end
end
