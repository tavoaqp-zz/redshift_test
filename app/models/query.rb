class Query < ActiveRecord::Base
	belongs_to :user
	belongs_to :workspace
	has_paper_trail
end
