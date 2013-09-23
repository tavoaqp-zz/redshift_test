class Project < ActiveRecord::Base
	has_many :workspaces
	has_paper_trail
end
