require './models/self_link'

class SurveysResponseRepresentation < Struct.new(:base_url)

	def self
		"#{base_url}/surveys"
	end

	def surveys
		[SurveysResponseRepresentation.new()]
	end
end