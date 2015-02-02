require 'chefspec'
require 'chefspec/berkshelf'
require 'yarjuf'

at_exit { ChefSpec::Coverage.report! }
