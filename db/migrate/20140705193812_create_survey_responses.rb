require 'activeuuid'

class CreateSurveyResponses < ActiveRecord::Migration
	def up
		create_table :survey_responses, :id => false do |t|
			t.uuid :id, :primary_key => true
			t.string :first_name
			t.string :last_name
			t.string :street_1
			t.string :street_2
			t.string :city
			t.string :state
			t.string :zip_code
		end
	end

	def down
		drop_table :survey_responses
	end
end
