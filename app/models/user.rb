class User < ActiveRecord::Base
  acts_as_authentic  
  
  has_many :comments
  has_many :received_comments, :foreign_key => :receiver_id, :class_name => 'Comment'
  
  has_many :friends
  has_many :received_invitations
  has_many :sent_invitations
  
  
  def to_s
    login
  end
  
end
