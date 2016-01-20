# environment.rb
require 'active_record'
# recursively requires all files in ./lib and down that end in .rb
require_relative 'contact'
require_relative 'phone_number'

# tells AR what db file to use
ActiveRecord::Base.establish_connection(
  :adapter  => 'postgresql',
  :host     => 'localhost',
  :username => 'development',
  :password => 'development',
  :database => 'contact_list',
  :encoding => 'utf8'
)
