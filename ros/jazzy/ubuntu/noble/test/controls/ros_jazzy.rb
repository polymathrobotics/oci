image_value = input('test_container_image')
puts "MISCHA: #{image_value}"

describe os_env('ROS_DISTRO') do
  its('content') { should eq 'jazzy' }
end

describe os_env('LANG') do
  its('content') { should eq 'C.UTF-8' }
end

describe os_env('ROSDISTRO_PKGS_SYNC_DATE') do
  its('content') { should match /^\d{4}-\d{2}-\d{2}$/ }
end

describe file('/usr/share/keyrings/ros2-latest-archive-keyring.gpg') do
  it { should exist }
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

# docker.io/polymathrobotics/ros:jazzy-ros-core-humble
control 'ros-core' do
  only_if('ros-core') do
    input('test_container_image').include?('ros:jazzy-ros-core-humble')
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

# docker.io/polymathrobotics/ros:jazzy-ros-base-noble
control 'ros-base' do
  only_if('ros-base') do
    input('test_container_image').include?('ros:jazzy-ros-base-noble')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:jazzy-perception-noble
control 'perception' do
  only_if('perception') do
    input('test_container_image').include?('ros:jazzy-perception-noble')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:jazzy-simulation-noble
control 'simulation' do
  only_if('simulation') do
    input('test_container_image').include?('ros:jazzy-simulation-noble')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:jazzy-desktop-noble
control 'desktop' do
  only_if('desktop') do
    input('test_container_image').include?('ros:jazzy-desktop-noble')
  end

  describe command('colcon') do
    it { should exist }
  end
end

# docker.io/polymathrobotics/ros:jazzy-desktop-full-noble
control 'desktop-full' do
  only_if('desktop-full') do
    input('test_container_image').include?('ros:jazzy-desktop-full-noble')
  end

  describe command('colcon') do
    it { should exist }
  end
end
