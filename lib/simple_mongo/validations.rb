module SimpleMongo
  module Model

    class Validations

      def initialize(keys, proc)
        @keys = keys      
        instance_eval &proc
      end

      def validates_presence_of(field)
        if @keys[field.to_sym].nil?
          raise Errors::ValidatesPresenceOfError, "#{field.to_s.capitalize} is nil!"
        end
      end

      def validates_numericality_of(field)
        if @keys[field.to_sym].nil?
          raise Errors::ValidatesPresenceOfError, "#{field.to_s.capitalize} is nil!"
        else
          if !@keys[field.to_sym].is_a? Numeric
            raise Errors::ValidatesNumericalityOfError, "#{field.to_s.capitalize} is not a number!"
          end
        end
      end

      def validates_custom(field, &block)
        if !block.call(@keys[field.to_sym])
          raise Errors::ValidatesCustomError, "#{field.to_s.capitalize} failed custom validation!"
        end
      end
    end
  end
end