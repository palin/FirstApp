class CreateReceivedInvitations < ActiveRecord::Migration
  def self.up
    create_table :received_invitations do |t|
    	t.integer :user_id, :null => false
			t.integer :friend_id, :null => false
			
      t.timestamps
    end
  end

  def self.down
    drop_table :received_invitations
  end
end
