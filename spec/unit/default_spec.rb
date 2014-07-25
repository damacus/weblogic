require 'spec_helper'

describe 'weblogic::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'cteates the weblogic_install response file' do
    expect(chef_run).to create_template("#{Chef::Config[:file_cache_path]}/weblogic_install.rsp")
  end

  it 'creates the silent.xml template' do
    expect(chef_run).to create_template("#{Chef::Config[:file_cache_path]}/silent.xml")
  end
 
  it 'creates the weblogic application user' do
    expect(chef_run).to create_user('oracle')
  end

  it 'creates the weblogic application group' do
    expect(chef_run).to create_group('oracle')
  end

  it 'creates the oraInst.loc file' do
    expect(chef_run).to create_template('/etc/oraInst.loc')
  end

  it 'Downloads the weblogic jar' do
    expect(chef_run).to create_remote_file("#{Chef::Config[:file_cache_path]}/wls_121200.jar")
  end

  it 'executes the weblogic jar to do the install' do
    expect(chef_run).to run_execute("java -jar #{Chef::Config[:file_cache_path]}/wls_121200.jar -silent -silent_xml=#{Chef::Config[:file_cache_path]}/silent.xml -responseFile #{Chef::Config[:file_cache_path]}/weblogic_install.rsp -Djava.security.egd=file:/dev/./urandom")
  end

end

describe "weblogic::create_domain" do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  domain_home= '/home/oracle/oracle_mw/domain_home'
  it 'creates domain_home dir' do
    expect(chef_run).to create_directory("#{domain_home}")
  end

  it 'creates domain_home/example_name dir' do
    expect(chef_run).to create_directory("#{domain_home}/example_name")
  end

  it 'creates the create_example_name_domain.py template' do
      expect(chef_run).to create_template("#{domain_home}/create_example_name_domain.py")
  end

  it 'creates domain dir' do
    expect(chef_run).to create_directory("#{domain_home}/example_name")
  end

  it 'executes the domain creation through wlst.sh' do
    expect(chef_run).to run_execute("/home/oracle/oracle_mw/wlserver/common/bin/wlst.sh #{domain_home}/create_example_name_domain.py")
  end

  it 'templates weblogic init script' do
      expect(chef_run).to create_template("/etc/init.d/weblogic")
  end

  it 'enables weblogic service' do
      expect(chef_run).to enable_service("weblogic")
  end 
end
