module Extensions
	module Object
		def is_numeric?
			true if Float(self) rescue false
		end
	end
end

Object.send(:include, Extensions::Object)
