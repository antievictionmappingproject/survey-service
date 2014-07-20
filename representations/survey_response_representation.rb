class SurveyResponseRepresentation

	attr_reader :id
	attr_reader :first_name
	attr_reader :last_name
	attr_reader :address_line_1
	attr_reader :address_line_2
	attr_reader :city
	attr_reader :state
	attr_reader :zip_code

	def initialize(id, first_name, last_name, address_line_1, address_line_2, city, state, zip_code)
		@id = id
		@first_name = first_name
		@last_name = last_name
		@address_line_1 = address_line_1
		@address_line_2 = address_line_2
		@city = city
		@state = state
		@zip_code = zip_code
	end
end