class Workspace < ActiveRecord::Base
	belongs_to :project
        belongs_to :user
	has_paper_trail
end
