# taken from the awesome http://elitists.textdriven.com/svn/plugins/acts_as_state_machine/trunk/test/test_helper.rb
$:.unshift(File.dirname(__FILE__) + '/../lib')
RAILS_ROOT = File.dirname(__FILE__)

require 'rubygems'
require 'logger'
require 'test/unit'
require 'active_support'
require 'active_record'

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config['sqlite3'])

load(File.dirname(__FILE__) + "/schema.rb") if 
  File.exist?(File.dirname(__FILE__) + "/schema.rb")