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
    create_table :tags, :force => true do |t|
      t.string :tag
      t.references :post
    end
  end

  def self.down
    drop_table :posts
    drop_table :tags
  end
end

Migration.up

class Post < ActiveRecord::Base
  has_many :tags

  accepts_nested_attributes_for :tags, :allow_destroy => true
end

class Tag < ActiveRecord::Base
  belongs_to :post
end

class PostQueryCache < ActiveRecord::Base
  set_table_name :posts
  include ActiveRecord::ConnectionAdapters::QueryCache
end

class PostWithValidation < ActiveRecord::Base
  set_table_name :posts
  validates_presence_of :author
end
