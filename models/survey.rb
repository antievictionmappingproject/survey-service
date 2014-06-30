require './models/survey'

class Survey
	attr_reader :id
	attr_reader :address

	def initialize(id, address)
		@id = id
		@address = address
	end

	def to_json(*a)
		{
		  "json_class"   => self.class.name,
		  "data"         => {"id" => @id, "address" => @address }
		}.to_json(*a)
	end

	def self.json_create(o)
		new(o["data"]["id"], o["data"]["address"])
	end

	def ==(another_survey)
		self.id == another_survey.id
		self.address == another_survey.address
	end
end