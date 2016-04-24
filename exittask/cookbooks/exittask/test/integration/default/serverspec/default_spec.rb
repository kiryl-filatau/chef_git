require 'serverspec'

describe 'nginx package installation' do
  describe package('nginx') do
    it { should be_installed }
  end
end

describe 'nginx service' do
  describe 'nginx should be listening on port 8080' do
    describe port(8080) do
      it { should be_listening.with('tcp') }
    end
  end
end

describe 'jenkins package installation' do
  describe package('jenkins') do
    it { should be_installed }
  end
end

describe file('/etc/init.d/tomcat') do
  it { should exist }
end

describe file('/var/lib/jenkins') do
  it { should be_mode 755 }
end

