class HexValidator < ActiveModel::EachValidator
	def validate_each(object, attribute, value)
    	unless (value =~ /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/i) || value == nil || value == ''
      		object.errors[attribute] << (options[:message] || "must be a valid CSS hex color code")
    	end
  	end
end