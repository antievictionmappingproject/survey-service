class SurveysResponseRepresentation < Struct.new(:base_url, :surveys)

	def self
		"#{base_url}/surveys"
	end
end