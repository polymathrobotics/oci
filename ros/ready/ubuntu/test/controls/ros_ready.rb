
describe os_env('LANG') do
  its('content') { should eq 'C.UTF-8' }
end

describe os_env('ROSDISTRO_PKGS_SYNC_DATE') do
  its('content') { should match /^\d{4}-\d{2}-\d{2}$/ }
end

describe file('/usr/share/keyrings/ros2-latest-archive-keyring.gpg') do
  it { should exist }
end

DISTROS = {
  'humble'  => { release: '22.04', codename: 'jammy' },
  'jazzy'   => { release: '24.04', codename: 'noble' },
  'kilted'  => { release: '24.04', codename: 'noble' },
  'rolling' => { release: '26.04', codename: 'resolute' },
}.freeze

DISTROS.each do |distro, info|
  # docker.io/polymathrobotics/ros:#{distro}-ready-ubuntu
  control "#{distro}-ready" do
    only_if("#{distro}-ready") do
      input('test_container_image').include?("ros:#{distro}-ready-ubuntu")
    end
    describe os do
      its('name') { should eq 'ubuntu' }
      its('release') { should eq info[:release] }
    end
    describe os_env('ROS_DISTRO') do
      its('content') { should eq distro }
    end
    describe file('/etc/apt/sources.list.d/ros2-latest.list') do
      it { should exist }
      its('content') { should match %r{#{info[:codename]} main} }
    end
    %w(colcon rosdep).each do |cmd|
      describe command(cmd) do
        it { should_not exist }
      end
    end
  end

  # docker.io/polymathrobotics/ros:#{distro}-builder-ubuntu
  control "#{distro}-builder" do
    only_if("#{distro}-builder") do
      input('test_container_image').include?("ros:#{distro}-builder-ubuntu")
    end
    describe os do
      its('name') { should eq 'ubuntu' }
      its('release') { should eq info[:release] }
    end
    describe os_env('ROS_DISTRO') do
      its('content') { should eq distro }
    end
    %w(colcon rosdep).each do |cmd|
      describe command(cmd) do
        it { should exist }
      end
    end
    describe file('/usr/local/bin/gather-rosdeps') do
      it { should exist }
    end
  end
end
