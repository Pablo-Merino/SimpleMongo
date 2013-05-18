require "spec_helper"

describe SimpleMongo do
  it "has a VERSION" do
    SimpleMongo::VERSION.should =~ /^[\.\da-z]+$/
  end
  
  it "fails without db info" do
    expect { SimpleMongo::Connection.new }.to raise_error(SimpleMongo::Errors::NoDBSpecifiedException)
  end
  
end
