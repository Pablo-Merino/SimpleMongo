require "spec_helper"

describe SimpleMongo do
  it "has a VERSION" do
    SimpleMongo::VERSION.should =~ /^[\.\da-z]+$/
  end
end
