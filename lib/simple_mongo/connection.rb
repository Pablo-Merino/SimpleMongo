module SimpleMongo

  @client = nil
  @database = nil
  @connection = nil
  
  module_function 
 
  def connection; @connection; end
  def connection=(conn); @connection = conn; end
  
  class Connection
    
    attr_accessor :client, :database, :collection
    
    def initialize(options = {})
    
      @opts = {
        host: 'localhost', 
        port: 27017,
        database: nil,
      }.merge(options || {})
    
      if @opts[:database].nil?
        raise Errors::NoDBOrCollectionException, "You must specify a database"
      end
    
      @client = Mongo::MongoClient.new(@opts[:host], @opts[:port])
      @database = @client[@opts[:database]]
      
      SimpleMongo::connection = self
    end
  end
end