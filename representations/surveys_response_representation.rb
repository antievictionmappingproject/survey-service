require './models/self_link' 

class SurveysResponseRepresentation

	def initialize(base_url)
      @base_url = base_url
   	end

	def self
		SelfLink.new(@base_url)
	end

	def next
		SelfLink.new(@base_url)
	end

	def surveys
		[SurveysResponseRepresentation.new()]
	end
end