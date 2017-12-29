describe command 'curl http://localhost:8080' do
  its ('stdout') { should match /Tomcat/ }
end

describe package 'java-1.7.0-openjdk-devel' do
  it { should be_installed }  
end

describe group 'tomcat' do
  it { should exist }
end

describe user 'tomcat' do
  it { should exist }
  it { should belong_to_group 'tomcat' }
  it { should have_home_directory '/opt/tomcat' }
  it { should have_login_shell '/bin/nologin' }
end

# describe file '/tmp/apache-tomcat-8.5.24.tar.gz' do
#   it { should exist }
# end

describe file '/opt/tomcat' do
  it {should be_directory}
end

describe file '/opt/tomcat/conf' do
  it {should exist }
  it {should be_directory}
  it {should be_mode 0750}
end

# %w [ webapps work temp logs ].each do |path|
['webapps', 'work', 'temp', 'logs'].each do |path|
  describe file("/opt/tomcat/#{path}") do
    it {should exist }
    it {should be_owned_by 'tomcat' }
  end
end

