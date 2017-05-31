require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
#Line below removes logging when uncommented
#ActiveRecord::Base.logger = nil
require_all 'lib'
require_all 'app'
