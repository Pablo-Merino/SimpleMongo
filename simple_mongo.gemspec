$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "simple_mongo"
require "#{name}/version"

Gem::Specification.new name, SimpleMongo::VERSION do |s|
	s.summary = "A simple MongoDB adapter"
  s.description = "This is a MongoDB adapter"
	s.authors = ["Pablo Merino"]
	s.email = "pablo@wearemocha.com"
	s.homepage = "http://github.com/pablo-merino/#{name}"
	s.files = Dir['**/*']
	s.license = "MIT"
	s.add_dependency('active_support', ['~> 3.0.0'])
	s.add_dependency("colored", ["~> 1.2"])  
	s.add_dependency("mongo", ["~> 1.8.6"])  
	s.add_dependency("bson_ext", ["~> 1.8.6"])  

end
