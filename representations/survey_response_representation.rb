require 'json'

class SurveyResponseRepresentation < Struct.new(:base_url, :survey)

	def self
		"#{base_url}/surveys/#{id}"
	end

	def id
		survey.id
	end

	def first_name
		survey.first_name
	end 

	def last_name
		survey.last_name
	end

	def address_line_1
		survey.street_1
	end

	def address_line_2
		survey.street_2
	end

	def address_city
		survey.city
	end

	def address_state
		survey.state
	end

	def address_zip_code
		survey.zip_code
	end
end