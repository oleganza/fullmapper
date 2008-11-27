module FullMapper
  module Model
    
    # Note: other configuration, extensions, inclusions is defined in configuration.rb-like files.
    #       here we keep statically defined minimal API
    
    module Properties
      def property(name, type, options = {})
      end
    end
    
    module Indices
      def index(fields, options = {})
      end
    end
    Indexes = Indices # i don't want any naming holywars, really.
    
    module Associations
      def belongs_to(name, options = {})
      end
      
      def has_one(name, options = {})
      end
      
      def has_many(name, options = {})
      end
    end
    
    module Finders
      def all(options = {})
      end
      
      # — where's the #first method?
      # — it's inside the Collection, dude.
    end
    
    module Updaters
      def new(attributes = {})
      end
      def create(attributes = {})
      end
    end
        
    include Properties
    include Indices
    include Associations
    include Finders
    include Updaters
    
  end
end
