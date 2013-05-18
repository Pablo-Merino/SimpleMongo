A simple MongoDB adapter. 

**Forks and pull requests with fixes and improvements are really well welcome! This is pretty much beta and not ready for production.**

**Documentation coming soon!**

Install
=======

#### Not in RubyGems yet

Usage
=====
```ruby
class MyTestClass
  include SimpleMongo::Model
  field :test
  
  validations do 
    validates_custom :test do |field|
      field == "something"      
    end
  end
  
  before_save do
    self.test = 'pablo'
  end
end

connection = SimpleMongo::Connection.new(:database => 'test')

model = MyTestClass.new(:test => 'yay')

model.save

puts model.test
```

Author
======
[Pablo Merino](http://pmerino.me)<br/>
pablo@wearemocha.com<br/>
License: MIT<br/>