require 'spec_helper'

describe 'weblogic::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge('weblogic::default') }

  it 'creates the silent.xml template' do
    expect(chef_run).to create_template('/var/chef/cache/silent.xml')
  end
 
end