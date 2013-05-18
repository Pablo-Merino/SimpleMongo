module SimpleMongo
  module Errors
    class ValidatesPresenceOfError < StandardError; end
    class ValidatesNumericalityOfError < StandardError; end
    class ValidatesCustomError < StandardError; end
  
    class NoDBSpecifiedException < StandardError; end
    class NotImplementedException < StandardError; end
  
  end
end