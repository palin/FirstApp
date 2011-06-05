class Comment < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :receiver, :class_name => 'User' 
  
  validates :body, :presence => true, :uniqueness => true
  
end
