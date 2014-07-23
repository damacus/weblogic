require 'spec_helper'

describe 'weblogic::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge('weblogic::default') }

  it 'creates the silent.xml template' do
    expect(chef_run).to create_template('/var/chef/cache/silent.xml')
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
  
end