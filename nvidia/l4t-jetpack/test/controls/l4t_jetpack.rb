describe os_env('CUDA_HOME') do
  its('content') { should eq '/usr/local/cuda' }
end

describe os_env('PATH') do
  its('content') { should match(%r{/usr/local/cuda/bin}) }
end

describe os_env('LD_LIBRARY_PATH') do
  its('content') { should match(%r{/usr/local/cuda/lib64}) }
end
