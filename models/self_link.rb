class SelfLink

	def initialize(base_url)
      @base_url = base_url
   	end

	def href
		"#{@base_url}/surveys"
	end
end