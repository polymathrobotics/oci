describe command('git') do
  it { should exist }
end

describe os[:family] do
  it { should eq 'debian' }
end

describe os[:name] do
  it { should eq 'ubuntu' }
end

describe os[:release] do
  it { should eq '22.04' }
end
