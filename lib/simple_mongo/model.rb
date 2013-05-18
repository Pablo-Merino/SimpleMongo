module SimpleMongo
  module Model
  
    def self.included(base)
      base.extend(ClassMethods)
      base.instance_eval do
      
        field :_id, BSON::ObjectId.new unless keys.has_key?(:_id)
      end
    end
  
    def initialize(attributes)
      @coll_name = self.class.name.underscore
      SimpleMongo::connection.collection = SimpleMongo::connection.database[@coll_name]
      attributes.each do |key, value|
        unless !keys.has_key?(key)
          keys[key] = value
        end
      end
    end

    def keys
      self.class.keys
    end
  
    def before_save_callbacks
      self.class.before_save_callbacks
    end
  
    def validations
      self.class.validations_var
    end
      
    def inspect
      puts "#<#{self.class} @keys=#{keys.each {|k,v| "#{k} => #{v}"}}>"
    end

    def save      
      unless before_save_callbacks.empty?
        before_save_callbacks.each do |callback|
          callback.call
        end
      end
    
      unless validations.nil?
        Validations.new(keys, validations)
      end

      SimpleMongo::connection.collection.insert(keys)
    end
  
    module ClassMethods
      def field(name, default_value = nil)
        @keys ||= {}        
        @keys[name.to_sym] = default_value
      
        class_eval <<-EOS, __FILE__, __LINE__
        
          def #{name}
            keys[:#{name.to_s}]
          end

          def #{name}=(value)
            keys[:#{name.to_s}] = value
          end
        EOS
      
        instance_eval <<-EOS, __FILE__, __LINE__
        
          def #{name}
            keys[:#{name.to_s}]
          end

          def #{name}=(value)
            keys[:#{name.to_s}] = value
          end
        EOS
      end
    
      def before_save(&block)
        @before_save_callbacks ||= []
        @before_save_callbacks << block
      end
    
      def keys
        @keys ||= {}
      end
    
      def before_save_callbacks
        @before_save_callbacks ||= []
      end
    
      def validations_var
        @validations_var ||= nil
      end
    
      def find(args)
        @coll_name = self.name.underscore
        SimpleMongo::connection.collection = SimpleMongo::connection.database[@coll_name]
      
        return_array = []
        results = SimpleMongo::connection.collection.find(args)
        results.to_a.each do |element|
          return_array << self.new(element)
        end
        return_array
      end
    
      def validations(&block)
        @validations_var ||= nil
        @validations_var = block      
      end
    end
  end
end