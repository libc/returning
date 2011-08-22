require 'active_record'

config = {:adapter => 'postgresql', 'database' => 'returning_test', :host => 'localhost', :encoding => 'unicode'}
begin
  ActiveRecord::Base.establish_connection config
  ActiveRecord::Base.connection
rescue
  begin
    ActiveRecord::Base.establish_connection(config.merge('database' => 'postgres', 'schema_search_path' => 'public'))
    ActiveRecord::Base.connection.create_database(config['database'], config.merge('encoding' => 'utf8'))
    ActiveRecord::Base.establish_connection(config)
  rescue => e
    STDERR.puts "**** Couldn't create database returning_test"
    STDERR.puts "#{e.class}: #{e.message}"
    STDERR.puts e.backtrace.join("\n")
    exit 1
  end
end


class Migration < ActiveRecord::Migration
  def self.up
    create_table :posts, :force => true do |t|
      t.string :name, :author
    end
  end

  def self.down
    drop_table :posts
  end
end

Migration.up

class Post < ActiveRecord::Base
end
