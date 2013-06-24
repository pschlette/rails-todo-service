class Todo < ActiveRecord::Base
  attr_accessible :content, :priority, :user_id
end
