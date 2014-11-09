class Tasks < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :tasksphotos
end
