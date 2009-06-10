# ValidatesRequired
module ValidatesRequired
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def validates_required( name )
      include InstanceMethods

      validates_presence_of name, :if => "#{name}_required".to_sym

      define_method( "#{name}_required" ) do
        require_attributes.include? name.to_sym
      end

      define_method( "#{name}_required=" ) do |v|
        @require_attributes ||= []
        if v == true
          @require_attributes << name.to_sym
        else
          @require_attributes.delete name.to_sym
        end
      end
    end
  end

  module InstanceMethods
    attr_accessor :require_attributes
    def require_attributes
      @require_attributes ||= []
      @require_attributes.flatten!
      @require_attributes.uniq!
      @require_attributes
    end
  end
end
