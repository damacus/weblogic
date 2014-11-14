#
# Cookbook Name:: weblogic-11g
# Recipe:: default
#
# Copyright 2009-2014 Chef Software, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if node['weblogic']['install_java']
  include_recipe 'java'
end

# Create the weblogic application user
user node['weblogic']['user'] do
  action :create
end

# Create the weblogic application group
group node['weblogic']['group'] do
  members [node['weblogic']['user']]
end

# Create the oraInst.loc file
template '/etc/oraInst.loc' do
  source 'oraInst.loc.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# Create the Weblogic install response file
template "#{Chef::Config[:file_cache_path]}/weblogic_install.rsp" do
  source 'weblogic_install.rsp.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

# Create the silent.xml file
template "#{Chef::Config[:file_cache_path]}/silent.xml" do
  source 'silent.xml.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

if node['weblogic']['version'] == '11g'
  remote_file "#{Chef::Config[:file_cache_path]}/wls1035_generic.jar" do
    owner 'root'
    group 'root'
    mode '0755'
    source node['weblogic']['11g']['installer_download']
    checksum node['weblogic']['11g']['installer_checksum']
  end

  # Install Weblogic
  execute "Install Weblogic" do
    command "java -jar #{Chef::Config[:file_cache_path]}/wls1035_generic.jar -silent_xml=#{Chef::Config[:file_cache_path]}/silent.xml -mode=silent"
    user node['weblogic']['user']
    group node['weblogic']['group']
    creates node['weblogic']['wls_install_dir']
    action :run
  end

  #Change the directory ownership from root to oracle
  bash "chown" do
    code <<-EOH
    chown -R #{node['weblogic']['user']}:#{node['weblogic']['group']} /home/oracle
    EOH
  end
end

if node['weblogic']['version'] == '12c'
  # Download the Universal Installer JAR
  remote_file "#{Chef::Config[:file_cache_path]}/wls_121200.jar" do
    owner 'root'
    group 'root'
    mode '0744'
    source node['weblogic']['12c']['installer_download']
    checksum node['weblogic']['12c']['installer_checksum']
  end

# Install Weblogic
  execute "Install Weblogic" do
    command "java -jar #{Chef::Config[:file_cache_path]}/wls_121200.jar -silent -silent_xml=#{Chef::Config[:file_cache_path]}/silent.xml -responseFile #{Chef::Config[:file_cache_path]}/weblogic_install.rsp -Djava.security.egd=file:/dev/./urandom"
    user node['weblogic']['user']
    group node['weblogic']['group']
    creates node['weblogic']['wls_install_dir']
    action :run
  end
end