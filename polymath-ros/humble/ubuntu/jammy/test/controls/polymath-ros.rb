image_value = input('test_container_image')

describe command("su --login --command \"source /opt/ros/$ROS_DISTRO/setup.bash && ros2 pkg list | grep rmw_cyclonedds_cpp\"") do
  its('exit_status') { should cmp 0 }
end

describe command("pip show setuptools") do
  its('exit_status') { should cmp 0 }
  its('stdout') { should match(/Version: 58.2.0/) }
end
