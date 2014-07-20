class SurveyResponseRepresentation < Struct.new(:base_url, :id, :first_name, :last_name, :address_line_1, :address_line_2, :city, :state, :zip_code)

	def self
		"#{base_url}/surveys/#{id}"
	end
end