require 'json'

class SurveyResponseRepresentation < Struct.new(:base_url, :id, :first_name, :last_name, :address_line_1, :address_line_2, :address_city, :address_state, :address_zip_code)

	def self
		"#{base_url}/surveys/#{id}"
	end

	def to_json(*a)
		{
			"base_url" => base_url,
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
		new(hash['base_url'],
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