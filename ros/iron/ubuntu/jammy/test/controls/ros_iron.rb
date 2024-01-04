describe os_env('ROS_DISTRO') do
  its('content') { should eq 'iron' }
end

describe os_env('LANG') do
  its('content') { should eq 'C.UTF-8' }
end

describe file('/ros_entrypoint.sh') do
  it { should exist }
end

describe command("su --login --command \"source /opt/ros/$ROS_DISTRO/setup.bash && ros2 -h\"") do
  its('exit_status') { should cmp 0 }
  its('stdout') { should match(/usage: ros2/) }
end

describe file('/ros_entrypoint.sh') do
  it { should exist }
  its('content') { should match %r{source "/opt/ros/\$ROS_DISTRO/setup\.bash"} }
end

# docker.io/polymathrobotics/ros:iron-ros-core-jammy
control 'ros-core' do
  only_if('ros-core') do
    input('test_container_image').include?('ros:iron-ros-core-jammy')
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

# docker.io/polymathrobotics/ros:iron-ros-base-jammy
control 'ros-base' do
  only_if('ros-base') do
    input('test_container_image').include?('ros:iron-ros-base-jammy')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:iron-perception-jammy
control 'perception' do
  only_if('perception') do
    input('test_container_image').include?('ros:iron-perception-jammy')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:iron-simulation-jammy
control 'simulation' do
  only_if('simulation') do
    input('test_container_image').include?('ros:iron-simulation-jammy')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:iron-desktop-jammy
control 'desktop' do
  only_if('desktop') do
    input('test_container_image').include?('ros:iron-desktop-jammy')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:iron-desktop-full-jammy
control 'desktop-full' do
  only_if('desktop-full') do
    input('test_container_image').include?('ros:iron-desktop-full-jammy')
  end

  describe command('colcon') do
    it { should exist }
  end
end
