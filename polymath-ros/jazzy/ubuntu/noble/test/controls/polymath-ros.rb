image_value = input('test_container_image')

describe os do
  its('name') { should eq 'ubuntu' }
  its('release') { should eq '24.04' }
end

describe os_env('ROS_DISTRO') do
  its('content') { should include 'jazzy' }
end

describe command("which python") do
  its('exit_status') { should cmp 0 }
  its('stdout') { should match /\/opt\/venv\/bin\/python/ }
end

describe command('pip list') do
  its('stdout') { should match /setuptools/ }
end

describe command("su --login --command \"source /opt/ros/$ROS_DISTRO/setup.bash && ros2 pkg list | grep rmw_cyclonedds_cpp\"") do
  its('exit_status') { should cmp 0 }
end
