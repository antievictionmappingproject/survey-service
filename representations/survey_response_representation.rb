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

	def to_json(*a)
		{
			"id" => id,
			"first_name" => first_name,
			"last_name" => last_name,
			"address_line_1" => address_line_1,
			"address_line_2" => address_line_2,
			"address_city" => address_city,
			"address_state" => address_state,
			"address_zip_code" => address_zip_code
		}.to_json(*a)
	end

	def self.from_json(json)
		hash = JSON.parse(json)
		new('',
			hash['id'],
			hash['first_name'],
			hash['last_name'],
			hash['address_line_1'],
			hash['address_line_2'],
			hash['address_city'],
			hash['address_state'],
			hash['address_zip_code'])
	end
end