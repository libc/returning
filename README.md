Hi there,

Returning
=========

It's a simple implementation of the +returning+ for ActiveRecord 3.0 and 3.1.

How to use
----------

Add it to your Gemfile

    gem 'returning'

And then

    # This sends UPDATE objects SET field = 42 WHERE id = 42 RETURNING generation
    object.save(:returning => 'generation') # => #<0xblah Object generation=2>
    # This sends DELETE FROM objects WHERE id = 42 RETURNING generation
    object.destroy(:returning => 'generation') # => #<0xblah Object generation=3>

It returns readonly object with fields that are specified in the returning option.

Cheers