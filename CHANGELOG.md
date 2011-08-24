0.0.4 - 2011-08-24
* Save returning in an instance variable of the model, instead of connection. Previous approach failed when you tried to load an association inside a callback.

0.0.3 - 2011-08-22
-----
* Pass parameters down on save. This makes update_attribute work.

0.0.2 - 2011-08-22
-----
* Add support for ActiveRecord::ConnectionAdapters::QueryCache