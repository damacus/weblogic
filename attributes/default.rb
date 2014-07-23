default['weblogic']['oracle_base']                             = '/opt/oracle'
default['weblogic']['user']                                    = 'weblogic'
default['weblogic']['home']                                    = '/opt/oracle/middleware12c/wlserver_12.1'
default['weblogic']['mw_home']                                 = '/opt/oracle/middleware12c'
default['weblogic']['version']                                 = 1211
default['weblogic']['orainventory']                            = '/opt/oracle/oraInventory'

default['weblogic']['system_user']                             = 'wls'
default['weblogic']['system_group']                            = 'oracle'
default['weblogic']['instaler_source']                         = 'http://www.example.com/wls_121200.jar'
default['weblogic']['installer_checksum']                      = 'e6efe85f3aec005ce037bd740f512e23c136635c63e20e02589ee0d0c50c065c'
default['weblogic']['jdk_home']                                = '/usr/java/latest'
default['weblogic']['log_dir']                                 = '/var/log/weblogic'

default['weblogic']['domains_dir']                             = '/opt/oracle/wlsdomains/domains'
default['weblogic']['apps_dir']                                = '/opt/oracle/wlsdomains/applications'

default['weblogic']['jsse_enabled']                            = true

default['weblogic']['nodemgr']['port']                         = 5556