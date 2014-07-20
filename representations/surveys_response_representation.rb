require './models/self_link' 

class SurveysResponseRepresentation
	def self
		SelfLink.new()
	end

	def next
		SelfLink.new()
	end

	def surveys
		[SurveysResponseRepresentation.new()]
	end
end